`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paul Mumby
// 
// Create Date:    11:42:54 03/16/2012 
// Design Name: 
// Module Name:    VoodooSHACore 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//Some defines to make the code a bit more readable:

//Array indexer (for 32bit words)
`define INDEX(x) (((x+1)*(32))-1):((x)*(32))
// INDEX(0) = 31:0
// INDEX(1) = 63:32
// INDEX(9) = 319:288
// INDEX(14) = 479:448
// INDEX(15) = 511:480

//S0 function from extender in SHA256 Spec: s0 := (w[i-15] rightrotate 7) xor (w[i-15] rightrotate 18) xor (w[i-15] rightshift 3)
`define S0(x) ({{x}[6:0],{x}[31:7]}^{{x}[17:0],{x}[31:18]}^({x}>>3))

//S1 function from extender in SHA256 Spec: s1 := (w[i-2] rightrotate 17) xor (w[i-2] rightrotate 19) xor (w[i-2] rightshift 10)
`define S1(x) ({{x}[16:0],{x}[31:17]}^{{x}[18:0],{x}[31:19]}^({x}>>10))

module VoodooSHACore(
	input en,
	input clk,
	input reset,
	input [511:0] data,
	input [255:0] midstate,
	input midstate_en,
	output reg [255:0] hash,
	output reg busy
	);
	
	parameter STAGES = 64;
	//parameter S0_a = {{wbuf[63:32]}[6:0],{wbuf[63:32]}[31:7]}^{{wbuf[63:32]}[17:0],{wbuf[63:32]}[31:18]}^({wbuf[63:32]}>>3);
	//parameter S1_a = {{wbuf[479:448]}[16:0],{wbuf[479:448]}[31:17]}^{{wbuf[479:448]}[18:0],{wbuf[479:448]}[31:19]}^({wbuf[479:448]}>>10);
		
	//Precalc H Values
	localparam Hval = {
		32'h6a09e667,
		32'hbb67ae85,
		32'h3c6ef372,
		32'ha54ff53a,
		32'h510e527f,
		32'h9b05688c,
		32'h1f83d9ab,
		32'h5be0cd19		
	};
	
	//K Value Function
	localparam Kval = { 
		32'h428a2f98, 32'h71374491, 32'hb5c0fbcf, 32'he9b5dba5, 32'h3956c25b, 32'h59f111f1, 32'h923f82a4, 32'hab1c5ed5,
		32'hd807aa98, 32'h12835b01, 32'h243185be, 32'h550c7dc3, 32'h72be5d74, 32'h80deb1fe, 32'h9bdc06a7, 32'hc19bf174,
		32'he49b69c1, 32'hefbe4786, 32'h0fc19dc6, 32'h240ca1cc, 32'h2de92c6f, 32'h4a7484aa, 32'h5cb0a9dc, 32'h76f988da,
		32'h983e5152, 32'ha831c66d, 32'hb00327c8, 32'hbf597fc7, 32'hc6e00bf3, 32'hd5a79147, 32'h06ca6351, 32'h14292967,
		32'h27b70a85, 32'h2e1b2138, 32'h4d2c6dfc, 32'h53380d13, 32'h650a7354, 32'h766a0abb, 32'h81c2c92e, 32'h92722c85,
		32'ha2bfe8a1, 32'ha81a664b, 32'hc24b8b70, 32'hc76c51a3, 32'hd192e819, 32'hd6990624, 32'hf40e3585, 32'h106aa070,
		32'h19a4c116, 32'h1e376c08, 32'h2748774c, 32'h34b0bcb5, 32'h391c0cb3, 32'h4ed8aa4a, 32'h5b9cca4f, 32'h682e6ff3,
		32'h748f82ee, 32'h78a5636f, 32'h84c87814, 32'h8cc70208, 32'h90befffa, 32'ha4506ceb, 32'hbef9a3f7, 32'hc67178f2
	};
						
	reg [511:0] wbuf;
	reg [31:0] kfrag;
	reg [255:0] frag_input;
	reg [6:0] stage;

	wire [255:0] frag_output;
	
	//The main sha fragment (one stage of the SHA-2 Iterative Function)
	VoodooSHAFragment SHAFRAG (
		.en(en),
		.stage(stage),
		.w(wbuf[511:480]),
		.k(kfrag),
		.in(frag_input),
		.out(frag_output)
	);

    //assign kfrag = Kval(stage);

    // Stage Counter
    // If EN and BUSY are high, count stage
    // Else if Reset is low, reset stage
    always @(posedge clk or negedge reset) begin
        if(en && busy) stage <= stage + 1;
        else if(!reset) begin
            //If reset driven low, then initialize values:
            stage <= 0;
            wbuf <= 0;
            busy <= 1;
            hash <= 0;
        end
        if(!busy && stage == STAGES-1) begin
            hash <= frag_output;
        end        
    end
    
	//On rising edge of clock, do basic control logic, and pass output of previous fragment to input of next fragment.
	always @ (data or stage or midstate_en or en) begin
			//Fetch the K Value for this stage
			kfrag <= Kval[stage];
			if(stage == 0) begin
				//If it's the first stage, initialize the input
				if(midstate_en) begin
				    //If we have a midstate (not first block) pass the midstate (output of previous block) in to prime the input
				    frag_input <= midstate;
				end else begin
				    //Otherwise initialize from H Values
				    frag_input <= Hval;
				end
				frag_input <= Hval;
			end else begin
				//Otherwise, pass output of previous stage to this stage
				frag_input <= frag_output;
			end
			
			//W Buffer Logic
			if(stage < 16) begin
				//First 16 Stages read W directly from input data.
				if(stage == 0) begin
					//On first stage, load data into W Buffer. And roll the first data index to the end of the buffer
					wbuf <= {data[511:32],data[31:0]};
				end else begin
					//On next 15 stages, rotate the W Buffer, moving the first entry to the end
					wbuf <= {wbuf[511:32],wbuf[31:0]};
				end
			end else begin
				//After the first 16 stages, the W Buffer should continue to rotate left.
				//But now the end record is calculated using S0 and S1 according to SHA algorithm.
				wbuf <= {wbuf[511:32],((wbuf[31:0]) + ((wbuf[63:32]>>7)^(wbuf[63:32]>>18)^(wbuf[63:32]>>3)) + (wbuf[319:288]) + ((wbuf[479:448]>>17)^(wbuf[479:448]>>19)^(wbuf[479:448]>>10)))};
			end
			//At any given stage, the last record of the W Buffer should contain the appropriate W value for that stage.
			
			//If we're finished the last stage, send the stage output to the hash output of this module. And signal busy = low;
			if(stage >= STAGES-1) begin
				busy <= 0;				
			end
	end 

endmodule
