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
	wire [9:0] Bird_X_L;
	wire [9:0] Bird_Y_T;
	wire [9:0] Bird_X_R;
	wire [9:0] Bird_Y_B;
	wire [9:0] PositiveSpeed;
	wire [9:0] NegativeSpeed;
	wire q_Initial, q_Flight, q_Stop;


	// Instantiate the Unit Under Test (UUT)
	flight_physics uut (
		.Clk(Clk), 
		.reset(reset), 
		.Start(Start), 
		.Ack(Ack), 
		.BtnPress(BtnPress), 
		.Bird_X_L(Bird_X_L), .Bird_X_R(Bird_X_R), 
		.Bird_Y_T(Bird_Y_T), .Bird_Y_B(Bird_Y_B),
		 .q_Initial(q_Initial), .q_Flight(q_Flight), .q_Stop(q_Stop),
		 .PositiveSpeed(PositiveSpeed), .NegativeSpeed(NegativeSpeed)
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
		Start = 1;
		#50;
		Start = 0;
		#100;
		BtnPress = 1;
		#50;
		BtnPress = 0;
		#500;
		BtnPress = 1;
		#50;
		BtnPress = 0;
		#100;
		// Add stimulus here

	end
      always begin #10; Clk = ~ Clk; end
endmodule

