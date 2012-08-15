`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Dynamic DCM Controller. Derived from sources from TheSeven at:
// https://github.com/progranism/Open-Source-FPGA-Bitcoin-Miner
// Paul Mumby 2012
//////////////////////////////////////////////////////////////////////////////////
module dcm_controller (
		clk,
		data2,
		midstate,
		start,
		dcm_prog_data,
		dcm_prog_clk,
		dcm_prog_done,
		dcm_prog_en,
	);

	//Parameters:
	//================================================
	parameter MAXIMUM_MULTIPLIER = 64;
	parameter INITIAL_MULTIPLIER = 16;

	//IO Definitions:
	//================================================
	input clk;
   input [255:0] midstate;
	input [255:0] data2;
	input start;
	input dcm_prog_clk;
	output dcm_prog_data;
	output dcm_prog_en;
	input dcm_prog_done;
	
	//Register/Wire Definitions:
	//================================================
	reg dcm_prog_data;
	reg dcm_prog_en;
	wire cmd_trigger_timestamp;
	wire cmd_trigger;
	wire [7:0] cmd_id;
	wire [7:0] cmd_data;
	wire cmd_validator;
	wire cmd_valid;
	reg busy;
	reg [7:0] cmd_latch_id;
	reg [7:0] cmd_latch_data;
	reg dcm_prog_ready;
	reg [7:0] dcm_multiplier = INITIAL_MULTIPLIER;
	reg [7:0] current_dcm_multiplier = 8'd0;
	reg [4:0] dcm_progstate = 5'd31;
	reg [15:0] dcm_data;
	wire [7:0] dcm_divider_s1 = 7'd8;
	wire [7:0] dcm_multiplier_s1 = dcm_multiplier - 8'd1;
	
	//Assignments:
	//================================================
	assign cmd_trigger_timestamp = data2[63:32];
	assign cmd_id = data2[71:64];
	assign cmd_data = data2[79:72];
	assign cmd_validator = data2[87:80];
	assign cmd_trigger = (cmd_trigger_timestamp == 32'hffffffff) && (midstate == 256'd0);
	assign cmd_valid = cmd_validator == (cmd_id ^ cmd_data);
	
	//Toplevel Logic:
	//================================================
	
	//Main command processor logic
	//And command validation
	always @(posedge clk)
		begin
			if(start && cmd_trigger && cmd_valid && ~busy)
				begin
					//We're not busy, and We've received the start (data in from uart) 
					//and trigger (appropriate malformed packet)
					//And the command passes it's simple validation check
					//So lets decode it, latch the data, and flag busy to handle the command
					cmd_latch_id <= cmd_id;
					cmd_latch_data <= cmd_data;
					busy <= 1; //Flag we're busy										
				end
			if(busy)
				begin
					//We're busy, so lets handle our command:
					if(cmd_latch_id==8'd0 && dcm_progstate == 5'd31) //Set Clock
						begin
							dcm_multiplier <= cmd_latch_data;
							dcm_prog_ready <= 1;
						end
				end
		end
	
	//DCM Programming logic
	//Mostly copied from https://github.com/progranism/Open-Source-FPGA-Bitcoin-Miner
	//Adapted to our specific setup
	always @ (posedge clk)
		begin
			if (dcm_multiplier > MAXIMUM_MULTIPLIER)
						dcm_multiplier <= MAXIMUM_MULTIPLIER;
			else if (dcm_multiplier < 2)
				dcm_multiplier <= 8'd2;

			if (dcm_multiplier != current_dcm_multiplier && dcm_progstate == 5'd31 && dcm_prog_ready)
			begin
				current_dcm_multiplier <= dcm_multiplier;
				dcm_progstate <= 5'd0;
				// DCM expects D-1 and M-1
				dcm_data <= {dcm_multiplier_s1, dcm_divider_s1};
				dcm_prog_ready <= 0;
			end

			if (dcm_progstate == 5'd0) {tx_dcm_progen, tx_dcm_progdata} <= 2'b11;
			if (dcm_progstate == 5'd1) {tx_dcm_progen, tx_dcm_progdata} <= 2'b10;
			if ((dcm_progstate >= 5'd2 && dcm_progstate <= 5'd9) || (dcm_progstate >= 5'd15 && dcm_progstate <= 5'd22))
			begin
				tx_dcm_progdata <= dcm_data[0];
				dcm_data <= {1'b0, dcm_data[15:1]};
			end

			if (dcm_progstate == 5'd10) {tx_dcm_progen, tx_dcm_progdata} <= 2'b00;
			if (dcm_progstate == 5'd11) {tx_dcm_progen, tx_dcm_progdata} <= 2'b00;
			if (dcm_progstate == 5'd12) {tx_dcm_progen, tx_dcm_progdata} <= 2'b00;

			if (dcm_progstate == 5'd13) {tx_dcm_progen, tx_dcm_progdata} <= 2'b11;
			if (dcm_progstate == 5'd14) {tx_dcm_progen, tx_dcm_progdata} <= 2'b11;

			if (dcm_progstate == 5'd23) {tx_dcm_progen, tx_dcm_progdata} <= 2'b00;
			if (dcm_progstate == 5'd24) {tx_dcm_progen, tx_dcm_progdata} <= 2'b00;
			if (dcm_progstate == 5'd25) {tx_dcm_progen, tx_dcm_progdata} <= 2'b10;
			if (dcm_progstate == 5'd26) {tx_dcm_progen, tx_dcm_progdata} <= 2'b00;

			if (dcm_progstate <= 5'd25) dcm_progstate <= dcm_progstate + 5'd1;

			if (dcm_progstate == 5'd26 && rx_dcm_progdone)
				begin
					dcm_progstate <= 5'd31;
					busy <= 0;
				end

		end	
	
endmodule
