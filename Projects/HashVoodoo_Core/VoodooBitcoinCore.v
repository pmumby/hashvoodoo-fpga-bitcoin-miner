`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:11:08 07/27/2012 
// Design Name: 
// Module Name:    VoodooBitcoinCore 
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
module VoodooBitcoinCore(
		clock,
		reset,
		midstate,
		data2,
		nonce_start,
		nonce_end,
		busy,
		found_nonce,
		nonce,
		start_mining
	);

	// IO Definitions
	////////////////////////////////////////////////////////////////
	input clock;
	input reset;
	input [255:0] midstate;
	input [95:0] data2;
	input [31:0] nonce_start;
	input [31:0] nonce_end;	
	input start_mining;
	output busy;
	output found_nonce;
	output [31:0] nonce_buf;
	
	// Register/Wire Definitions
	////////////////////////////////////////////////////////////////
	reg shacore_reset = 1;
	reg [511:0] shacore_data;
	reg [31:0] current_nonce;
	wire [255:0] shacore_hash;
	wire shacore_busy;
	reg current_hash;
	reg shacore_midstate_en;
	reg hash1_start;
	reg hash2_start;
	reg [31:0] nonce;
	
	// Assignments
	////////////////////////////////////////////////////////////////

	// Module Instatiation
	////////////////////////////////////////////////////////////////
	VoodooSHACore SHACORE (
		.en(1),
		.clk(clock),
		.reset(shacore_reset),
		.data(shacore_data),
		.midstate(midstate),
		.midstate_en(shacore_midstate_en),
		.hash(shacore_hash),	
		.busy(shacore_busy)
	);
	
	// Logic
	////////////////////////////////////////////////////////////////
	always @(posedge clock)
		begin
			//Is reset flag high?
			if(reset)
				//Yes, so reset
				begin

				end
			else
				//No, so execute as normal
				begin
					//Is a hash start flag raised?
					if(hash1_start || hash2_start)
						begin
							//Hash1?
							if(hash1_start)
								//Yup, so setup first hash
								begin
									//Drop the hash1_start flag
									hash1_start <= 0;
									//Setup data for first hash
									shacore_data <= {384'h000002800000000000000000000000000000000000000000000000000000000000000000000000000000000080000000, nonce, data2};
									//Setup Midstate
									shacore_midstate_en <= 1;
									//Indicate we're on the first hash currently
									current_hash <= 0;
									//Reset the hashing core to start it working
									shacore_reset <= 0;
								end
							else
								//Nope, so setup second hash
								begin
									//Drop the hash1_start flag
									hash2_start <= 0;
									//Setup data for first hash
									shacore_data <= {};
									//Disable Midstate
									shacore_midstate_en <= 0;
									//Indicate we're on the first hash currently
									current_hash <= 1;
									//Reset the hashing core to start it working
									shacore_reset <= 0;
								end
						end
					else
						//No hash flag, so continue with other logic
						begin
							//If I'm not busy working already, and the start_mining flag goes high
							//Then start mining a new batch job
							if(!busy && start_mining)
								//Yup, time to get busy
								begin
									//Raise busy flag
									busy <= 1;
									//Initialize the nonce to the beginning of our range:
									nonce <= nonce_start;
									//Raise flag to start first hash
									hash1_start <= 1;
								end
							else
								//Nope
								begin
									//Am I currently working on a job?
									if(busy)
										//Yup, so lets keep doing that
										begin
											//Release active reset on the core to let it work
											shacore_reset <= 1;
											//Is the hashing core currently busy?
											if(!shacore_busy)
												//Nope
												begin
													//Are we in the first hash? or second hash?
													if(current_hash)
														//Second hash
														begin
															//Ok, so in that case does the output hash fall in target range?
															if(1)
																//Woohoo! it does, let's send it out to the host!
																begin
																	found_nonce <= 1;
																end
															//Either way, are we at the end of our nonce range?
															if(nonce==nonce_end)
																//Yes, we're at the end of our range, so we're done this job!
																begin
																	//Drop the busy flag
																	busy <= 0;
																end
															else
																//Nope, not at the end, so time to move onto the next nonce
																begin
																	//Increment Nonce
																	nonce <= nonce + 1;
																	//Raise flag to start first hash
																	hash1_start <= 1;																	
																end
														end
													else
														//First hash
														begin
															//Raise flag to move onto second hash
															hash2_start <= 1;
														end
												end
										end
									else
										//Nope, so just update status for idle
										begin
										
										end
								end
						end
				end
			
		end

endmodule
