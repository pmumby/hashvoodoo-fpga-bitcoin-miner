`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// HashVoodoo Top Module
// Paul Mumby 2012
// Ported for Compatability with MMQ
// HEAVILY based on source from:
// https://github.com/progranism/Open-Source-FPGA-Bitcoin-Miner
// (for backwards compatability with MMQ protocol)
//////////////////////////////////////////////////////////////////////////////////

module HASHVOODOO (
		clk, 
	);

	//Parameters:
	//================================================
	parameter INPUT_CLOCK_FREQUENCY = 100;	//Input Clock Frequency
	parameter SYNTHESIS_FREQUENCY = 200;	//Target Synthesis Frequency (PAR will try to close timing to this)
	parameter BOOTUP_FREQUENCY = 50;			//Initial Safe Bootup Frequency
	parameter MAXIMUM_FREQUENCY = 250;		//Max Overclock Allowed (hard limit)

	//IO Definitions:
	//================================================
	input clk;										//Input clock source

	//Register/Wire Definitions:
	//================================================
	wire clkin_100MHZ;
	reg [255:0] midstate = 0;
	reg [95:0] data = 0;
	reg [31:0] nonce = 32'd253, nonce2 = 32'd0;
	wire hash_clk;
	wire dcm_progdata, dcm_progen, dcm_progdone;
	wire core_got_ticket;
	wire [31:0] core_golden_nonce;
	wire comm_new_work;
	wire [255:0] comm_midstate;
	wire [95:0] comm_data;
	reg is_golden_ticket = 1'b0;
	reg [31:0] golden_nonce;
	reg [3:0] golden_ticket_buf = 4'b0;
	reg [127:0] golden_nonce_buf;

	//Assignments:
	//================================================
	
	//Module Instatiation:
	//================================================
	
	//Input Clock Buffer
	IBUFG clkin1_buf (
		.I (clk), 
		.O (clkin_100MHZ)
	);

	//Dynamic Clock Module (DCM/PLL using Xilinx DCM_CLKGEN)
	dynamic_clock # (
		.INPUT_FREQUENCY (INPUT_CLOCK_FREQUENCY),
		.SYNTHESIS_FREQUENCY (SYNTHESIS_FREQUENCY)
	) DYNAMIC_CLOCK (
		.CLK_IN1 (clkin_100MHZ),
		.CLK_OUT1 (hash_clk),
		.PROGCLK (clkin_100MHZ),
		.PROGDATA (dcm_progdata),
		.PROGEN (dcm_progen),
		.PROGDONE (dcm_progdone)
	);

	//JTAG Communication Module
	jtag_comm # (
		.INPUT_FREQUENCY (INPUT_CLOCK_FREQUENCY),
		.MAXIMUM_FREQUENCY (MAXIMUM_FREQUENCY),
		.INITIAL_FREQUENCY (BOOTUP_FREQUENCY)
	) JTAG_COMM (
		.rx_hash_clk (hash_clk),
		.rx_new_nonce (golden_ticket_buf[3]),
		.rx_golden_nonce (golden_nonce_buf[127:96]),

		.tx_new_work (comm_new_work),
		.tx_midstate (comm_midstate),
		.tx_data (comm_data),

		.rx_dcm_progclk (clkin_100MHZ),
		.tx_dcm_progdata (dcm_progdata),
		.tx_dcm_progen (dcm_progen),
		.rx_dcm_progdone (dcm_progdone)
	);

	//Hashing Core
	sha256_top HASHING_CORE (
		.clk(hash_clk),
		.rst(0),
		.midstate(midstate),
		.data2(data),
		.golden_nonce(core_golden_nonce),
		.got_ticket(core_got_ticket),
		.miner_busy(),
		.start_mining(comm_new_work)
	);
	
	//Toplevel Logic:
	//================================================
	always @ (posedge hash_clk)
	begin
		// Give new data to the hasher
		midstate <= comm_midstate;
		data <= comm_data[95:0];

		is_golden_ticket <= core_got_ticket;
		golden_nonce <= core_golden_nonce;

		golden_ticket_buf <= {golden_ticket_buf[2:0], is_golden_ticket};
		golden_nonce_buf <= {golden_nonce_buf[95:0], golden_nonce};
	end
	
endmodule
