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
		identify
	);

	//Parameters:
	//================================================
	parameter MAXIMUM_MULTIPLIER = 88;
	parameter INITIAL_MULTIPLIER = 60;

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
	output identify;
	
	//Register/Wire Definitions:
	//================================================
	reg dcm_prog_data;
	reg dcm_prog_en;
	wire cmd_trigger_timestamp;
	wire cmd_trigger;
	wire [7:0] cmd_prefix;
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
	wire [7:0] dcm_divider_s1;
	wire [7:0] dcm_multiplier_s1;
	reg dcm_prog_ready_b;
	wire dcm_prog_busy;
	reg dcm_prog_busy_b;
	reg [7:0] dcm_multiplier_b;
	reg identify;
	
	//Assignments:
	//================================================
	assign cmd_trigger_timestamp = data2[63:32];
	assign cmd_prefix = data2[231:224];		//data2 byte 29 should always be 10110111 results in xor against 01011010 with id/data
	assign cmd_id = data2[239:232];			//data2 byte 30
	assign cmd_data = data2[247:240];		//data2 byte 31
	assign cmd_validator = data2[255:248];	//data2 byte 32
	assign cmd_trigger = (cmd_trigger_timestamp == 32'hffffffff) && (midstate == 256'd0);
	assign cmd_valid = cmd_validator == (cmd_prefix ^ cmd_id ^ cmd_data ^ 8'b01101101);
	assign dcm_prog_busy = (dcm_progstate != 5'd31);
	assign dcm_divider_s1 = 8'd7;
	assign dcm_multiplier_s1 = dcm_multiplier_b - 8'd1;
	
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
			else if(busy)
				begin
					//We're busy, so lets handle our command:
					if(cmd_latch_id==8'd0 && dcm_progstate == 5'd31) //Set Clock
						begin
							if(cmd_latch_data > MAXIMUM_MULTIPLIER)
								dcm_multiplier <= MAXIMUM_MULTIPLIER;
							else if(cmd_latch_data < 2)
								dcm_multiplier <= 8'd2;
							else
								dcm_multiplier <= cmd_latch_data;
							dcm_prog_ready <= 1;
							busy <= 0;
						end
					if(cmd_latch_id==8'd1) //Set Identify Mode
						begin
							//Set identify flag to first bit of command data byte.
							identify <= cmd_latch_data[0];
						end
				end
			else
				begin
					dcm_prog_busy_b <= dcm_prog_busy; //clock crossing buffer
					if(dcm_prog_busy_b)
						dcm_prog_ready <= 0; //stop asserting prog_ready, the programmer has grabbed it by now.
				end
		end

	//DCM Programming logic
	//Mostly copied from https://github.com/progranism/Open-Source-FPGA-Bitcoin-Miner
	//Adapted to our specific setup
	always @(posedge dcm_prog_clk)
		begin
			//Clock crossing buffers:
			dcm_prog_ready_b <= dcm_prog_ready;
			dcm_multiplier_b <= dcm_multiplier;
			
			if (dcm_multiplier_b != current_dcm_multiplier && dcm_progstate == 5'd31 && dcm_prog_ready_b)
			begin
				current_dcm_multiplier <= dcm_multiplier_b;
				dcm_progstate <= 5'd0;
				// DCM expects D-1 and M-1
				dcm_data <= {dcm_multiplier_s1, dcm_divider_s1};
			end

			if (dcm_progstate == 5'd0) {dcm_prog_en, dcm_prog_data} <= 2'b11;
			if (dcm_progstate == 5'd1) {dcm_prog_en, dcm_prog_data} <= 2'b10;
			if ((dcm_progstate >= 5'd2 && dcm_progstate <= 5'd9) || (dcm_progstate >= 5'd15 && dcm_progstate <= 5'd22))
			begin
				dcm_prog_data <= dcm_data[0];
				dcm_data <= {1'b0, dcm_data[15:1]};
			end

			if (dcm_progstate == 5'd10) {dcm_prog_en, dcm_prog_data} <= 2'b00;
			if (dcm_progstate == 5'd11) {dcm_prog_en, dcm_prog_data} <= 2'b00;
			if (dcm_progstate == 5'd12) {dcm_prog_en, dcm_prog_data} <= 2'b00;

			if (dcm_progstate == 5'd13) {dcm_prog_en, dcm_prog_data} <= 2'b11;
			if (dcm_progstate == 5'd14) {dcm_prog_en, dcm_prog_data} <= 2'b11;

			if (dcm_progstate == 5'd23) {dcm_prog_en, dcm_prog_data} <= 2'b00;
			if (dcm_progstate == 5'd24) {dcm_prog_en, dcm_prog_data} <= 2'b00;
			if (dcm_progstate == 5'd25) {dcm_prog_en, dcm_prog_data} <= 2'b10;
			if (dcm_progstate == 5'd26) {dcm_prog_en, dcm_prog_data} <= 2'b00;

			if (dcm_progstate <= 5'd25) dcm_progstate <= dcm_progstate + 5'd1;

			if (dcm_progstate == 5'd26 && dcm_prog_done)
				dcm_progstate <= 5'd31;
		end
endmodule
