`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// HashVoodoo Top Module
// Paul Mumby 2012
//////////////////////////////////////////////////////////////////////////////////
module HASHVOODOO (
		clk, 
		RxD, 
		TxD, 
		led, 
		dip, 
		reset_a, 
		reset_b, 
		reset_select
	);

	//Parameters:
	//================================================
	parameter CLOCK_RATE = 100000000;				//Input Clock Output from Controller in Hz
	parameter DCM_DIVIDER = 50;						//Starting point for DCM divider (100Mhz / 50 = 2Mhz increments)
	parameter DCM_MULTIPLIER_START = 75;			//Starting point for DCM multiplier (2Mhz x 75 = 150Mhz)
	parameter DCM_MULTIPLIER_CAP = 110;				//Max Point Allowed for DCM multiplier (Safety ceiling)
	parameter DCM_MULTIPLIER_MIN = 25;				//Minimum Allowed for DCM multiplier (If it falls below this something is seriously wrong)
	parameter UART_BAUD_RATE = 115200;				//Baud Rate to use for UART (BPS)
	parameter UART_SAMPLE_POINT = 8;					//Point in the oversampled wave to sample the bit state for the UART (6-12 should be valid)
	parameter CLOCK_FLASH_BITS = 26;					//Number of bits for divider of flasher. (28bit = approx 67M Divider)
	
	//IO Definitions:
	//================================================
   input clk;				//Input Clock
   input RxD;				//UART RX Pin (From Controller)
   output TxD;				//UART TX Pin  (To Controller)
   output [3:0] led;		//LED Array
	input [3:0]dip;		//DIP Switch Array
	input reset_a;			//Reset Signal A (position dependant) from Controller
	input reset_b;			//Reset Signal B (position dependant) from Controller
	input reset_select;	//Reset Selector (hard wired based on position)

	//Register/Wire Definitions:
	//================================================
	reg reset;								//Actual Reset Signal
	wire clk_buf;							//Actually Used Clock Signals
	wire clk_dcm;							//Output of hash clock DCM
	wire clk_comm_buf;					//Output of comm clock DCM
	wire clock_flash;						//Flasher output (24bit divider of clock)
	wire miner_busy;						//Miner Busy Flag
   wire [32:0] slave_nonces;			//Nonce found by worker TODO: Rename/Cleanup (this is a holdover from the icarus pair code)
   wire new_nonces;						//Flag indicating new nonces found
   wire serial_send;						//Serial Send flag, Triggers UART to begin sending what's in it's buffer
   wire serial_busy;						//Serial Busy flag, Indicates the UART is currently working
   wire [31:0] golden_nonce;			//Overall Found Golden Nonce TODO: Cleanup along with previous holdovers from icarus code
   wire [255:0] midstate, data2;		//Mistate and Data2, the main payload for a new job.
	wire start_mining;					//Start Mining flag. This flag going high will trigger the worker to begin hashing on it's buffer
	wire got_ticket;						//Got Ticket flag indicates the local worker found a new nonce. TODO: Again, cleanup
	wire led_nonce_fade;					//This is the output from the fader, jumps to full power when nonce found and fades out
	wire led_serial_fade;				//Output from fader for serial activity.
	reg new_ticket;						//Related to got_ticket TODO: Cleanup old icarus stuff
	reg [3:0]ticket_CS = 4'b0001;		//Again... Cleanup
	reg [3:0]ticket_NS;					//Again... Cleanup
	wire dcm_prog_en;
	wire dcm_prog_data;
	wire dcm_prog_done;
	wire dcm_valid;
	wire dcm_reset;
	wire identify_flag;
	wire identify_flasher;
	
	//Assignments:
	//================================================
	assign new_nonces = new_ticket;												//TODO: Cleanup
	assign led[0] = (led_nonce_fade || identify_flasher);					//LED0 (Green): New Nonce Beacon (fader)
	assign led[1] = (clock_flash || ~dcm_valid || identify_flasher);	//LED1 (Red): Clock Heartbeat (blinks to indicate working input clock)
																							//		Off = no clock
																							//		On Solid = dcm invalid.
	assign led[2] = (led_serial_fade || identify_flasher);				//LED2 (Blue): UART Activity (blinks and fades on either rx or tx)
	assign led[3] = (~miner_busy || identify_flasher);						//LED3 (Amber): Idle Indicator. Lights when miner has nothing to do.
	assign identify_flasher = (clock_flash && identify_flag);			//Identify Mode (ALL LEDs flash with heartbeat)
	
	//Module Instantiation:
	//================================================
	
	//Clock Buffer
	IBUFG IBUFG_CLK_BUF (
			.O(clk_buf),
			.I(clk),		//Clock input
		);
	
	//Dynamically Programmable Hash Clock DCM
	main_dcm #(
			.DCM_DIVIDER(DCM_DIVIDER),
			.DCM_MULTIPLIER(DCM_MULTIPLIER_START)
		) MAINDCM(
			.RESET(dcm_reset),
			.CLK_VALID(dcm_valid),
			.CLK_OSC(clk_buf), 
			.CLK_HASH(clk_dcm),
			.PROGCLK(clk_buf),
			.PROGDATA(dcm_prog_data),
			.PROGEN(dcm_prog_en),
			.PROGDONE(dcm_prog_done)
		);
	
	//DCM Controller Core (controls dcm clock based on special (malformed) icarus work packets which act as "command" packets
	dcm_controller #(
			.MAXIMUM_MULTIPLIER(DCM_MULTIPLIER_CAP),
			.MINIMUM_MULTIPLIER(DCM_MULTIPLIER_MIN),
			.INITIAL_MULTIPLIER(DCM_MULTIPLIER_START),
			.INITIAL_DIVIDER(DCM_DIVIDER)
		) DCM_CONTROL (
			.clk(clk_dcm),
			.data2(data2),
			.midstate(midstate),
			.start(start_mining),
			.dcm_prog_clk(clk_buf),
			.dcm_prog_en(dcm_prog_en),
			.dcm_prog_data(dcm_prog_data),
			.dcm_prog_done(dcm_prog_done),
			.identify(identify_flag)
		);
	
	//Hub core, this is a holdover from Icarus. This should be cleaned up and ported back to core logic, since miners are now "solo".
	//TODO: Cleanup old icarus stuff
   hub_core #(
			.SLAVES(1)
		) HUBCORE (
			.hash_clk(clk_dcm), 
			.new_nonces(new_nonces), 
			.golden_nonce(golden_nonce), 
			.serial_send(serial_send), 
			.serial_busy(serial_busy), 
			.slave_nonces(slave_nonces)
		);
	
	//JTAG Comm Core. Handles all communications in and out to the host.
	jtag_core JTAG_COMM (
			.clk(clk_dcm),
			.new_nonce(),
			.midstate_out(midstate),
			.data_out(data2),
			.word(golden_nonce),
			.new_work()
		);
	
	//Main Hashing Core, This does all the work
	sha256_top M (
			.clk(clk_dcm), 
			.rst(0), //Tied low for now, to weed out bugs.
			.midstate(midstate), 
			.data2(data2), 
			.golden_nonce(slave_nonces[31:0]), 
			.got_ticket(got_ticket), 
			.miner_busy(miner_busy),  
			.start_mining(start_mining)
		);
	
	/*
	//Flasher, this handles dividing down the comm clock by 24bits to blink the clock status LED
	flasher #(
			.BITS(CLOCK_FLASH_BITS)
		) CLK_FLASH (
			.clk(clk_dcm),
			.flash(clock_flash)
		);
	
	//Nonce PWM Fader core. This triggers on a new nonce found, flashes to full brightness, then fades out for nonce found LED.
	pwm_fade PWM_FADE_NONCE (
			.clk(clk_comm_buf), 
			.trigger(|new_nonces), 
			.drive(led_nonce_fade)
		);	

	//Serial PWM Fader core. This triggers on a new nonce found, flashes to full brightness, then fades out for nonce found LED.
	pwm_fade PWM_FADE_COMM (
			.clk(clk_comm_buf), 
			.trigger(~TxD || ~RxD), 
			.drive(led_serial_fade)
		);	
	
	*/
	
	//Toplevel Logic:
	//================================================

	//Clock Domain Buffering of ticket signal (I believe) TODO: Identify & Cleanup
	always@ (posedge clk_buf)
		begin
			ticket_CS <= ticket_NS;
		end

	//Primary Ticket Logic TODO: Cleanup
	always@ (*)
		begin
			case(ticket_CS)
				4'b0001: if (got_ticket) ticket_NS = 4'b0010; else ticket_NS = ticket_CS;
				4'b0010: ticket_NS = 4'b0100;
				4'b0100: ticket_NS = 4'b1000;
				4'b1000: if (!got_ticket) ticket_NS = 4'b0001; else ticket_NS = ticket_CS;
				default: ticket_NS = 4'b0001;
			endcase
		end

	//Communications Clock Domain Ticket Processing code TODO: Cleanup
	always@ (posedge clk_buf)
		begin
			new_ticket <= (ticket_CS == 4'b0100);
		end

endmodule

