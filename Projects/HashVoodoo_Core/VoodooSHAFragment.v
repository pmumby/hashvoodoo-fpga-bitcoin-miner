`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paul Mumby
// 
// Create Date:    11:42:39 03/16/2012 
// Design Name: 
// Module Name:    VoodooSHAFragment 
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
`define INDEX(x) (((x)+1)*(32)-1):((x)*(32))

//Macro for T1:
//s1 := (e rightrotate 6) xor (e rightrotate 11) xor (e rightrotate 25)
//ch := (e and f) xor ((not e) and g)
//t1 := h + s1 + ch + k[i] + w[i]
`define E1 ( {in[5+128:0+128],in[31+128:6+128]} ^ {in[10+128:0+128],in[31+128:11+128]} ^ {in[24+128:0+128],in[31+128:25+128]} )
`define CH ( ( in[`INDEX(4)] && in[`INDEX(5)] ) ^ ( ( !in[`INDEX(4)] ) && in[`INDEX(6)] ) )
`define T1 ( in[`INDEX(7)] + `E1 + `CH + k + w )

//Macro for T2: 
//s0 := (a rightrotate 2) xor (a rightrotate 13) xor (a rightrotate 22)
//maj := (a and b) xor (a and c) xor (b and c)
//t2 := s0 + maj
`define E0 ( {in[1:0],in[31:2]} ^ {in[12:0],in[31:13]} ^ {in[21:0],in[31:22]} )
`define MAJ (( in[`INDEX(0)] && in[`INDEX(1)] ) ^ ( in[`INDEX(0)] && in[`INDEX(2)] ) ^ ( in[`INDEX(1)] && in[`INDEX(2)] ))
`define T2 ( `E0 + `MAJ )

module VoodooSHAFragment(
	input en, 
	input [6:0] stage,
	input [31:0] w,
	input [31:0] k,
	input [255:0] in,
	output reg [255:0] out
   );
	
	//Primary SHA2 Loop Block
	always @ (in or stage or en) begin
		if(en) begin		
			//h := g
			//g := f
			//f := e
			//e := d + t1
			//d := c
			//c := b
			//b := a
			//a := t1 + t2
			out[`INDEX(7)] <= in[`INDEX(6)];
			out[`INDEX(6)] <= in[`INDEX(5)];
			out[`INDEX(5)] <= in[`INDEX(4)];
			out[`INDEX(4)] <= in[`INDEX(3)] + `T1;
			out[`INDEX(3)] <= in[`INDEX(2)];
			out[`INDEX(2)] <= in[`INDEX(1)];
			out[`INDEX(1)] <= in[`INDEX(0)];
			out[`INDEX(0)] <= `T1 + `T2;
		end
	end

endmodule
