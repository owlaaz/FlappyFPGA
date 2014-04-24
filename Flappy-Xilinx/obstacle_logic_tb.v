`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:59:07 04/23/2014
// Design Name:   obstacle_logic
// Module Name:   C:/Users/Lorraine/Documents/Flappy_repo/FlappyFPGA/Flappy-Xilinx/obstacle_logic_tb.v
// Project Name:  Flappy
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: obstacle_logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module obstacle_logic_tb;

	// Inputs
	reg Clk;
	reg reset;
	reg Score;
	reg Start;
	reg Ack;
	reg [9:0] X_Edge;
	reg [9:0] Y_Edge;
	reg [9:0] Bird_X;
	reg [9:0] Bird_Y;

	// Outputs
	wire Q_Initial;
	wire Q_Check;
	wire Q_Lose;
	wire Lose;
	wire Check;
	//wire [3:0] Score;
	wire [9:0] X_left_edge;
	wire [9:0] X_right_edge;
	wire [9:0] Y_top_edge;
	wire [9:0] Y_bottom_edge;

	// Instantiate the Unit Under Test (UUT)
	obstacle_logic uut (
		.Clk(Clk), 
		.reset(reset), 
		.Q_Initial(Q_Initial), 
		.Q_Check(Q_Check), 
		.Q_Lose(Q_Lose), 
		.Lose(Lose), 
		.Check(Check), 
		//.Score(Score), 
		.Start(Start), 
		.Ack(Ack), 
		.X_Edge(X_Edge), 
		.Y_Edge(Y_Edge), 
		.Bird_X(Bird_X), 
		.Bird_Y(Bird_Y),
		.X_left_edge(X_left_edge),
		.X_right_edge(X_right_edge),
		.Y_top_edge(Y_top_edge),
		.Y_bottom_edge(Y_bottom_edge)
	);

	initial begin
		// Initialize Inputs
		Clk = 0;
		reset = 0;
		Score = 0;
		Start = 0;
		Ack = 0;
		X_Edge = 350;
		Y_Edge = 270;
		Bird_X = 320;
		Bird_Y = 240;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 1;
		#100;
		reset = 0;
		#10;
		Start = 1;
		#30;
		Start = 0;
		#1000;
		// Add stimulus here

	end
      always begin #10; Clk = ~ Clk; end
		always @ (posedge Clk)
			begin
				X_Edge <= X_Edge-1;
			end
endmodule

