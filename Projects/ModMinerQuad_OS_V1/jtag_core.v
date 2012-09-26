`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// New JTAG Core
// Based heavily on https://github.com/progranism/Open-Source-FPGA-Bitcoin-Miner
// By Paul Mumby
// Licensed Under GNU GPL V3
//////////////////////////////////////////////////////////////////////////////////
module jtag_core (
	clk,
	new_nonce,
	midstate_out,
	data_out,
	word,
	new_work
	);
	
	//Parameters:
	//================================================
	parameter VERSION = 1;				//Input Clock Output from Controller in Hz	
	
	// IO Declaration
	//===================================================
	input clk;
	input new_nonce;
   output [255:0] midstate_out;
   output [255:0] data_out;
	input [31:0] word;
	output new_work;
	
	//Wire & Register Declaration
	//===================================================
	reg new_work = 1'b0;
	reg [255:0] midstate_out = 256'd0;
	reg [255:0] data_out = 256'd0;
	reg [255:0] midstate = 256'd0;
	reg [255:0] data = 256'd0;
	// JTAG
	wire jt_capture, jt_drck, jt_reset, jt_sel, jt_shift, jt_tck, jt_tdi, jt_update;
	wire jt_tdo;
	reg [3:0] addr = 4'hF;
	reg fifo_data_valid = 1'b0;
	reg [37:0] dr;
	reg checksum;
	wire checksum_valid = ~checksum;
	// Golden Nonce FIFO: from rx_hash_clk to TCK
	wire [31:0] tck_golden_nonce;
	wire fifo_empty, fifo_full;
	wire fifo_we = new_nonce & (rx_golden_nonce != 32'hFFFFFFFF) & ~fifo_full;
	wire fifo_rd = checksum_valid & jt_update & ~jtag_we & (jtag_addr == 4'hE) & ~fifo_empty & ~jt_reset;
	wire jtag_we = dr[36];
	wire [3:0] jtag_addr = dr[35:32];
	reg [511:0] tx_buffer = 512'd0;
	reg [511:0] current_job = 512'd0;
	reg [2:0] tx_work_flag = 3'b0;
	reg new_work_flag = 1'b0;
	
	//Module Instantiation
	//===================================================
	BSCAN_SPARTAN6 # (
			.JTAG_CHAIN(1)
		) jtag_blk (
			.CAPTURE(jt_capture),
			.DRCK(jt_drck),
			.RESET(jt_reset),
			.RUNTEST(),
			.SEL(jt_sel),
			.SHIFT(jt_shift),
			.TCK(jt_tck),
			.TDI(jt_tdi),
			.TDO(jt_tdo),
			.TMS(),
			.UPDATE(jt_update)
		);

	golden_nonce_fifo rx_clk_to_tck_blk (
			.wr_clk(rx_hash_clk),
			.rd_clk(jt_tck),
			.din(rx_golden_nonce),
			.wr_en(fifo_we),
			.rd_en(fifo_rd),
			.dout(tck_golden_nonce),
			.full(fifo_full),
			.empty(fifo_empty)
		);

	//Assignments
	//===================================================
	assign jt_tdo = dr[0];

	//Logic
	//===================================================

	//Main JTAG Logic
	always @ (posedge jt_tck or posedge jt_reset)
		begin
			if (jt_reset == 1'b1)
			begin
				dr <= 38'd0;
			end
			else if (jt_capture == 1'b1)
			begin
				// Capture-DR
				checksum <= 1'b1;
				dr[37:32] <= 6'd0;
				addr <= 4'hF;
				fifo_data_valid <= 1'b0;

				case (addr)
					4'h0: dr[31:0] <= VERSION;
					4'h1: dr[31:0] <= fifo_data_valid ? tck_golden_nonce : 32'hFFFFFFFF;
					4'h2: dr[31:0] <= 32'hFFFFFFFF;
					4'h3: dr[31:0] <= 32'hFFFFFFFF;
					4'h4: dr[31:0] <= 32'hFFFFFFFF;
					4'h5: dr[31:0] <= 32'hFFFFFFFF;
					4'h6: dr[31:0] <= 32'hFFFFFFFF;
					4'h7: dr[31:0] <= 32'hFFFFFFFF;
					4'h8: dr[31:0] <= 32'hFFFFFFFF;
					4'h9: dr[31:0] <= 32'hFFFFFFFF;
					4'hA: dr[31:0] <= 32'hFFFFFFFF;
					4'hB: dr[31:0] <= 32'hFFFFFFFF;
					4'hC: dr[31:0] <= 32'hFFFFFFFF;
					4'hD: dr[31:0] <= 32'hFFFFFFFF;
					4'hE: dr[31:0] <= 32'hFFFFFFFF;
					4'hF: dr[31:0] <= 32'hFFFFFFFF;
				endcase
			end
			else if (jt_shift == 1'b1)
			begin
				dr <= {jt_tdi, dr[37:1]};
				checksum <= checksum ^ jt_tdi;
			end
			else if (jt_update & checksum_valid)
			begin
				addr <= jtag_addr;
				fifo_data_valid <= fifo_rd;
				if (jtag_we)
				begin
					case (jtag_addr)
						4'h0: midstate[31:0] <= dr[31:0];
						4'h1: midstate[63:32] <= dr[31:0];
						4'h2: midstate[95:64] <= dr[31:0];
						4'h3: midstate[127:96] <= dr[31:0];
						4'h4: midstate[159:128] <= dr[31:0];
						4'h5: midstate[191:160] <= dr[31:0];
						4'h6: midstate[223:192] <= dr[31:0];
						4'h7: midstate[255:224] <= dr[31:0];
						4'h8: data[31:0] <= dr[31:0];
						4'h9: data[63:32] <= dr[31:0];
						4'hA: data[95:64] <= dr[31:0];
						4'hB: data[127:96] <= dr[31:0];
						4'hC: data[159:128] <= dr[31:0];
						4'hD: data[191:160] <= dr[31:0];
						4'hE: data[223:192] <= dr[31:0];
						4'hF: data[255:224] <= dr[31:0];
					endcase
				end

				// Latch new work
				if (jtag_we && jtag_addr == 4'hF)
				begin
					current_job <= {dr[31:0], data[223:0], midstate};
					new_work_flag <= ~new_work_flag;
				end
			end
		end

	// Output Metastability Protection
	// This should be sufficient for the midstate and data signals,
	// because they rarely (relative to the clock) change and come
	// from a slower clock domain (rx_hash_clk is assumed to be fast).
	always @ (posedge clk)
		begin
			tx_buffer <= current_job;
			{data_out, midstate_out} <= tx_buffer;
			tx_work_flag <= {tx_work_flag[1:0], new_work_flag};
			new_work <= tx_work_flag[2] ^ tx_work_flag[1];
		end

endmodule
