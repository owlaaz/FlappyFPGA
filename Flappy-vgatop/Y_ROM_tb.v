`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:42:21 04/24/2014
// Design Name:   Y_ROM
// Module Name:   C:/Users/Lorraine/Documents/Flappy/Y_ROM_tb.v
// Project Name:  Flappy
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Y_ROM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Y_ROM_tb;

	// Inputs
	reg [1:0] I;

	// Outputs
	wire [9:0] Output;
	wire [9:0] Y_Edge_O1;
	wire [9:0] Y_Edge_O2;
	wire [9:0] Y_Edge_O3;

	// Instantiate the Unit Under Test (UUT)
	Y_ROM uut (
		.I(I), 
		.Output(Output), 
		.Y_Edge_O1(Y_Edge_O1), 
		.Y_Edge_O2(Y_Edge_O2), 
		.Y_Edge_O3(Y_Edge_O3)
	);

	initial begin
		// Initialize Inputs
		I = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here

		I = 1;
		#100;
		I = 2;
		#100;
		I = 3;
		#100;
		I = 0;
		#100;
	end
      
endmodule

