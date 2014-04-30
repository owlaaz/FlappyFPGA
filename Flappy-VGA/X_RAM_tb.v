`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:18:41 04/23/2014
// Design Name:   X_RAM_NOREAD
// Module Name:   C:/Users/Lorraine/Documents/Flappy_repo/FlappyFPGA/Flappy-Xilinx/X_RAM_tb.v
// Project Name:  Flappy
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: X_RAM_NOREAD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module X_RAM_tb;

	// Inputs
	reg clk;
	reg reset;
	reg Start;
	reg Ack;

	// Outputs
	wire [1:0] out_pipe;
	wire [3:0] Score;
	
	wire [9:0] X_Edge_OO_L;
	wire [9:0] X_Edge_O1_L;
	wire [9:0] X_Edge_O2_L;
	wire [9:0] X_Edge_O3_L;
	
	wire [9:0] X_Edge_OO_R;
	wire [9:0] X_Edge_O1_R;
	wire [9:0] X_Edge_O2_R;
	wire [9:0] X_Edge_O3_R;
	wire 	Q_Initial, Q_Count, Q_Stop;

	// Instantiate the Unit Under Test (UUT)
	X_RAM_NOREAD uut (
		.clk(clk), 
		.reset(reset), 
		.Start(Start),
		.Ack(Ack),
		.out_pipe(out_pipe), 
		.Score(Score),
		.X_Edge_OO_L(X_Edge_OO_L),
		.X_Edge_O1_L(X_Edge_O1_L),
		.X_Edge_O2_L(X_Edge_O2_L),
		.X_Edge_O3_L(X_Edge_O3_L),
		
		.X_Edge_OO_R(X_Edge_OO_R),
		.X_Edge_O1_R(X_Edge_O1_R),
		.X_Edge_O2_R(X_Edge_O2_R),
		.X_Edge_O3_R(X_Edge_O3_R),
		
		.Q_Initial,
		.Q_Count,
		.Q_Stop
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		Start = 0;
		Ack = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 1;
		#20;
		reset = 0;
		#20;
		Start = 1;
		#50;
		Start = 0;
		#500;
		Ack = 1;
		#50;
		Ack = 0;
		#50;
		
		// Add stimulus here
		
	end
      always begin #20; clk = ~ clk; end
endmodule

