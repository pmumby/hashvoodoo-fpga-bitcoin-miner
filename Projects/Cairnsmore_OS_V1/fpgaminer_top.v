`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// FPGA Miner Top, Ported from icarus source from ngzhang
// Paul Mumby 2012
//////////////////////////////////////////////////////////////////////////////////
module fpgaminer_top (
		hash_clk_p, 
		hash_clk_n, 
		comm_clk, 
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
	parameter COMM_CLOCK_RATE = 25000000;			//Communications Clock Output from Controller in Hz
	parameter DCM_DIVIDER = 10;						//Starting point for DCM divider (25Mhz / 10 = 2.5Mhz increments)
	parameter DCM_MULTIPLIER_START = 60;			//Starting point for DCM multiplier (2.5Mhz x 60 = 150Mhz)
	parameter DCM_MULTIPLIER_CAP = 88;				//Max Point Allowed for DCM multiplier (Safety ceiling)
	parameter UART_BAUD_RATE = 115200;				//Baud Rate to use for UART (BPS)
	parameter UART_SAMPLE_POINT = 8;					//Point in the oversampled wave to sample the bit state for the UART (6-12 should be valid)
	parameter CLOCK_FLASH_BITS = 26;					//Number of bits for divider of flasher. (28bit = approx 67M Divider)
	
	//IO Definitions:
	//================================================
   input hash_clk_p;		//Input Hash Clock From Controller (P signal of diff pair)
   input hash_clk_n;		//Input Hash Clock From Controller (N signal of diff pair)
   input comm_clk;		//Input UART Clock From Controller
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
	wire hash_clk_buf,comm_clk_buf;	//Actually Used Clock Signals
	wire hash_clk_dcm;					//Output of hash clock DCM
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
	
	//Assignments:
	//================================================
	assign new_nonces = new_ticket;					//TODO: Cleanup
	assign led[0] = led_nonce_fade;					//LED0 (Green): New Nonce Beacon (fader)
	assign led[1] = (clock_flash || ~dcm_valid);	//LED1 (Red): Clock Heartbeat (blinks to indicate working input clock)
																//		Off = no clock
																//		On Solid = dcm invalid.
	assign led[2] = (~TxD || ~RxD);					//LED2 (Blue): UART Activity (blinks on either rx or tx)
	assign led[3] = ~miner_busy;						//LED3 (Amber): Idle Indicator. Lights when miner has nothing to do.

	//Module Instantiation:
	//================================================
	
	//Clock Input BUFG
	BUFG clk_comm_bufg (
			.I(comm_clk), 
			.O(comm_clk_buf)
		);

	//LVDS Clock Buffer
	IBUFGDS #(
			.DIFF_TERM("TRUE"),
			.IOSTANDARD("DEFAULT")
		) ibufgds_hash_clk (
			.O(hash_clk_buf),
			.I(hash_clk_p),	//Diff_p clock input
			.IB(hash_clk_n)	//Diff_n clock input
		);
	
	//Dynamically Programmable Hash Clock DCM
	main_dcm #(
			.DCM_DIVIDER(DCM_DIVIDER),
			.DCM_MULTIPLIER(DCM_MULTIPLIER_START)
		) MINDCM(
			.RESET(dcm_reset),
			.CLK_VALID(dcm_valid),
			.CLK_OSC(hash_clk_buf), 
			.CLK_HASH(hash_clk_dcm),
			.PROGCLK(comm_clk_buf),
			.PROGDATA(dcm_prog_data),
			.PROGEN(dcm_prog_en),
			.PROGDONE(dcm_prog_done)
		);
	
	//DCM Controller Core (controls dcm clock based on special (malformed) icarus work packets which act as "command" packets
	dcm_controller #(
			.MAXIMUM_MULTIPLIER(DCM_MULTIPLIER_CAP),
			.INITIAL_MULTIPLIER(DCM_MULTIPLIER_START)
		) DCM_CONTROL (
			.clk(comm_clk_buf),
			.data2(data2),
			.midstate(midstate),
			.start(start_mining),
			.dcm_prog_clk(comm_clk_buf),
			.dcm_prog_en(dcm_prog_en),
			.dcm_prog_data(dcm_prog_data),
			.dcm_prog_done(dcm_prog_done)
		);
	
	//Hub core, this is a holdover from Icarus. This should be cleaned up and ported back to core logic, since miners are now "solo".
	//TODO: Cleanup old icarus stuff
   hub_core #(
			.SLAVES(1)
		) hc (
			.hash_clk(comm_clk_buf), 
			.new_nonces(new_nonces), 
			.golden_nonce(golden_nonce), 
			.serial_send(serial_send), 
			.serial_busy(serial_busy), 
			.slave_nonces(slave_nonces)
		);
	
	//New Serial Core. Handles all communications in and out to the host.
	serial_core #(
			.CLOCK(COMM_CLOCK_RATE),
			.BAUD(UART_BAUD_RATE),
			.SAMPLE_POINT(UART_SAMPLE_POINT)
		) SERIAL_COMM (
			.clk(comm_clk_buf),
			.rx(RxD),
			.tx(TxD),
			.rx_ready(start_mining),
			.tx_ready(serial_send),
			.midstate(midstate),
			.data2(data2),
			.word(golden_nonce),
			.tx_busy(serial_busy)
		);
		
	//Main Hashing Core, This does all the work
	sha256_top M (
			.clk(hash_clk_dcm), 
			.rst(0), //Tied low for now, to weed out bugs.
			.midstate(midstate), 
			.data2(data2), 
			.golden_nonce(slave_nonces[31:0]), 
			.got_ticket(got_ticket), 
			.miner_busy(miner_busy),  
			.start_mining(start_mining)
		);
	
	//Flasher, this handles dividing down the comm clock by 24bits to blink the clock status LED
	flasher #(
			.BITS(CLOCK_FLASH_BITS)
		) CLK_FLASH (
			.clk(hash_clk_dcm),
			.flash(clock_flash)
		);
	
	//Nonce PWM Fader core. This triggers on a new nonce found, flashes to full brightness, then fades out for nonce found LED.
	pwm_fade pwm_fade_nonce (
			.clk(comm_clk_buf), 
			.trigger(|new_nonces), 
			.drive(led_nonce_fade)
		);	

	//Serial PWM Fader core. This triggers on a new nonce found, flashes to full brightness, then fades out for nonce found LED.
	pwm_fade pwm_fade_serial (
			.clk(comm_clk_buf), 
			.trigger(~TxD || ~RxD), 
			.drive(led_serial_fade)
		);	
	
	//Toplevel Logic:
	//================================================

	//Reset handling code. Handles location specific reset signals
	always@ (reset_select or reset_a or reset_b)
		begin
			if(reset_select)
				reset <= reset_a;
			else
				reset <= reset_b;
		end

	//Clock Domain Buffering of ticket signal (I believe) TODO: Identify & Cleanup
	always@ (posedge comm_clk_buf)
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
	always@ (posedge comm_clk_buf)
		begin
			new_ticket <= (ticket_CS == 4'b0100);
		end

endmodule

