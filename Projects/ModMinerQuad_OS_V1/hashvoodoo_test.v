`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// HashVoodoo Test Module
// Paul Mumby 2012
//////////////////////////////////////////////////////////////////////////////////
module hashvoodoo_test;

	// Inputs
	reg clk_p;
	reg clk_n;
	reg comm_clk;
	reg RxD;
	reg [3:0] dip;
	reg reset_a;
	reg reset_b;
	reg reset_select;

	// Outputs
	wire TxD;
	wire [3:0] led;

	// Instantiate the Unit Under Test (UUT)
	HASHVOODOO uut (
		.clk_p(hash_clk_p), 
		.clk_n(hash_clk_n), 
		.RxD(RxD), 
		.TxD(TxD), 
		.led(led), 
		.dip(dip), 
		.reset_a(reset_a), 
		.reset_b(reset_b), 
		.reset_select(reset_select)
	);

	//Clock Control
	always begin
		#20;
		clk_p = ~clk_p;
		clk_n = ~clk_n;
	end
		
	initial begin
		// Initialize Inputs
		clk_p = 1;
		clk_n = 0;
		RxD = 0;
		dip = 0;
		reset_a = 0;
		reset_b = 0;
		reset_select = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

