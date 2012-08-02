`timescale 1ps/1ps
//////////////////////////////////////////////////////////////////////////////////
// New Parametric DCM
// For Enterpoint Cairnsmore1 Icarus Derived Bitstream
// By Paul Mumby
// Licensed Under GNU GPL V3
//////////////////////////////////////////////////////////////////////////////////
module dcm_param (
		CLK_OSC,
		CLK_HASH,
		CLK_COMM,
		RESET,
		CLK_VALID
	);

	//Parameters:
	//================================================
	
	//Input Parameters:
	//NOTE: output clocks must be in incriments OSC_CLOCK_RATE
	//Also: Comm clock will always be equal to OSC_CLOCK_RATE
	parameter OSC_CLOCK_RATE = 25000000;	//Hz
	parameter HASH_CLOCK_RATE = 200000000;	//Hz
	
	//Derived Parameters:
	parameter CLOCK_OSC_PERIOD = 1000000000 / OSC_CLOCK_RATE;
	parameter CLOCK_HASH_MULTIPLIER = HASH_CLOCK_RATE / OSC_CLOCK_RATE;
	
	//IO Definitions:
	//================================================
	input CLK_OSC;
	output CLK_HASH;
	output CLK_COMM;
	input RESET;
	output CLK_VALID;

	//Register/Wire Definitions:
	//================================================
	wire psdone_unused;
	wire locked_int;
	wire [7:0] status_int;
	wire clkfb;
	wire clk0;
	wire clkfx;

	//Input Buffering:
	//================================================
	IBUFG clkin1_buf (
			.O (clkin1),
			.I (CLK_OSC)
		);

	//Output Buffering:
	//================================================

	//Hash Clock Output Buffer
	BUFG clkout1_buf (
			.O(CLK_HASH),
			.I(clkfx)
		);

	//Comm Clock Output Buffer
	BUFG clkout2_buf (
			.O(CLK_COMM),
			.I(clk0)
		);
	
	//Assignments:
	//================================================
	assign CLK_VALID = ( ( locked_int == 1'b 1 ) && ( status_int[2:1] == 2'b 0 ) );
	assign clkfb = CLK_COMM;

	//DCM Primitive:
	//================================================
	DCM_SP #(
			.CLKDV_DIVIDE          (2.000),
			.CLKFX_DIVIDE          (1),
			.CLKFX_MULTIPLY        (CLOCK_HASH_MULTIPLIER),
			.CLKIN_DIVIDE_BY_2     ("FALSE"),
			.CLKIN_PERIOD          (CLOCK_OSC_PERIOD),
			.CLKOUT_PHASE_SHIFT    ("NONE"),
			.CLK_FEEDBACK          ("1X"),
			.DESKEW_ADJUST         ("SYSTEM_SYNCHRONOUS"),
			.PHASE_SHIFT           (0),
			.STARTUP_WAIT          ("FALSE")
		) dcm_sp_inst (
			// Input clock
			.CLKIN                 (clkin1),
			.CLKFB                 (clkfb),
			// Output clocks
			.CLK0                  (clk0),
			.CLK90                 (),
			.CLK180                (),
			.CLK270                (),
			.CLK2X                 (),
			.CLK2X180              (),
			.CLKFX                 (clkfx),
			.CLKFX180              (),
			.CLKDV                 (),
			// Ports for dynamic phase shift
			.PSCLK                 (1'b0),
			.PSEN                  (1'b0),
			.PSINCDEC              (1'b0),
			.PSDONE                (),
			// Other control and status signals
			.LOCKED                (locked_int),
			.STATUS                (status_int),

			.RST                   (RESET),
			// Unused pin- tie low
			.DSSEN                 (1'b0)
		);

	

	//Toplevel Logic:
	//================================================



  // Clocking primitive
  //------------------------------------

  // Instantiation of the DCM primitive
  //    * Unused inputs are tied off
  //    * Unused outputs are labeled unused






endmodule
