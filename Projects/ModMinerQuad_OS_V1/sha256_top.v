/*!
   btcminer
   Copyright 2011 ngzhang & lee
   ngzhang1983@msn.com

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License version 3 as
   published by the Free Software Foundation.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, see http://www.gnu.org/licenses/.
!*/


`timescale 1ns/1ps

module sha256_top (
    clk,
    rst,
    midstate,
    data2,
    miner_busy,
    got_ticket,
    golden_nonce,
	 start_mining
);

parameter NONCE_CT = 31'd256;

input           clk;
input           rst;
input start_mining;

input   [255:0] midstate;
input   [95:0]  data2;

output          miner_busy;
output          got_ticket;
output  [31:0]  golden_nonce;

endmodule

