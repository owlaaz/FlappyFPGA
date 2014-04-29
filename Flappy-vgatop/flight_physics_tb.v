`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:33:31 04/24/2014
// Design Name:   flight_physics
// Module Name:   C:/Users/Lorraine/Documents/Flappy_repo/FlappyFPGA/Flappy-Xilinx/flight_physics_tb.v
// Project Name:  Flappy
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: flight_physics
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module flight_physics_tb;

	// Inputs
	reg Clk;
	reg reset;
	reg Start;
	reg Ack;
	reg BtnPress;

	// Outputs
	wire [9:0] VertSpeed;
	wire [9:0] Bird_X;
	wire [9:0] Bird_Y;


	// Instantiate the Unit Under Test (UUT)
	flight_physics uut (
		.Clk(Clk), 
		.reset(reset), 
		.Start(Start), 
		.Ack(Ack), 
		.BtnPress(BtnPress), 
		.VertSpeed(VertSpeed), 
		.Bird_X(Bird_X), 
		.Bird_Y(Bird_Y)
	);

	initial begin
		// Initialize Inputs
		Clk = 0;
		reset = 0;
		Start = 0;
		Ack = 0;
		BtnPress = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 1;
		#100;
		reset = 0;
		#30;
		BtnPress = 1;
		#20;
		BtnPress = 0;
		#50;
		BtnPress = 1;
		#50;
		BtnPress = 0;
		#100;
		// Add stimulus here

	end
      always begin #10; Clk = ~ Clk; end
endmodule

