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
	reg count_EN;

	// Outputs
	wire [9:0] Output;
	wire [1:0] out_pipe;
	wire [3:0] Score;

	// Instantiate the Unit Under Test (UUT)
	X_RAM_NOREAD uut (
		.clk(clk), 
		.reset(reset), 
		.count_EN(count_EN), 
		.Output(Output), 
		.out_pipe(out_pipe), 
		.Score(Score)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		count_EN = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 1;
		#20;
		reset = 0;
		#20;
      count_EN = 1;
		
		// Add stimulus here
		
	end
      always begin #10; clk = ~ clk; end
endmodule

