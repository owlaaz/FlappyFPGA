`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:00:56 04/30/2014
// Design Name:   Y_ROM
// Module Name:   /home/david/ee201/FlappyFPGA/Flappy-VGA/y_rom_tb.v
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

module y_rom_tb;

	// Inputs
	reg [1:0] I;

	// Outputs
	wire [9:0] YEdge1T;
	wire [9:0] YEdge1B;
	wire [9:0] YEdge2T;
	wire [9:0] YEdge2B;
	wire [9:0] YEdge3T;
	wire [9:0] YEdge3B;
	wire [9:0] YEdge4T;
	wire [9:0] YEdge4B;

	// Instantiate the Unit Under Test (UUT)
	Y_ROM uut (
		.I(I), 
		.YEdge1T(YEdge1T), 
		.YEdge1B(YEdge1B), 
		.YEdge2T(YEdge2T), 
		.YEdge2B(YEdge2B), 
		.YEdge3T(YEdge3T), 
		.YEdge3B(YEdge3B), 
		.YEdge4T(YEdge4T), 
		.YEdge4B(YEdge4B)
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

