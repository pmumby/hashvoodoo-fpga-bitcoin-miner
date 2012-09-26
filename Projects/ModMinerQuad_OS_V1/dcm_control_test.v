`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// DCM Controller Test Module
// Paul Mumby 2012
//////////////////////////////////////////////////////////////////////////////////
module dcm_control_test;

	// Inputs
	reg clk;
	reg [255:0] data2;
	reg [255:0] midstate;
	reg start;
	reg dcm_prog_clk;
	reg dcm_prog_done;

	// Outputs
	wire dcm_prog_data;
	wire dcm_prog_en;
	wire identify;

	// Instantiate the Unit Under Test (UUT)
	dcm_controller uut (
		.clk(clk), 
		.data2(data2), 
		.midstate(midstate), 
		.start(start), 
		.dcm_prog_data(dcm_prog_data), 
		.dcm_prog_clk(dcm_prog_clk), 
		.dcm_prog_done(dcm_prog_done), 
		.dcm_prog_en(dcm_prog_en), 
		.identify(identify)
	);

	always begin
		#20;
		clk = ~clk;
		dcm_prog_clk = clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		data2 = 0;
		midstate = 0;
		start = 0;
		dcm_prog_clk = 0;
		dcm_prog_done = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		//Timestamp
		data2[63:32] = 32'hFFFFFFFF;
		
		//Prefix
		data2[231:224] = 8'b10110111;
		
		//Id
		data2[239:232] = 8'b00000000;
		
		//Data
		data2[247:240] = 8'd70;
		
		//Validator
		data2[255:248] = (data2[231:224] ^ data2[239:232] ^ data2[247:240] ^ 8'b01101101);

		midstate = 256'h0000000000000000000000000000000000000000000000000000000000000000;
		
		#100;
		start = 1;
		#100;
		start = 0;		
		
	end
      
endmodule

