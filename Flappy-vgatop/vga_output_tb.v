`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:51:20 04/28/2014
// Design Name:   vga_output
// Module Name:   C:/Users/Lorraine/Documents/Flappy/vga_output_tb.v
// Project Name:  Flappy
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_output
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_output_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [9:0] BirdXdraw;
	reg [9:0] BirdYdraw;
	
	reg [9:0] X_Edge_O1;
	reg [9:0] X_Edge_O2;
	reg [9:0] X_Edge_O3;
	reg [9:0] X_Edge_O4;
	
	reg [9:0] Y_Edge_O1;
	reg [9:0] Y_Edge_O2;
	reg [9:0] Y_Edge_O3;
	reg [9:0] Y_Edge_O4;

	// Outputs
	wire vga_h_sync;
	wire vga_v_sync;
	wire vga_r;
	wire vga_g;
	wire vga_b;
	wire [9:0] CounterX_out;
	wire [9:0] CounterY_out;

	// Instantiate the Unit Under Test (UUT)
	vga_output uut (
		.clk(clk), 
		.reset(reset), 
		.BirdXdraw(BirdXdraw), 
		.BirdYdraw(BirdYdraw), 
		.X_Edge_O1(X_Edge_O1), 
		.X_Edge_O2(X_Edge_O2), 
		.X_Edge_O3(X_Edge_O3), 
		.X_Edge_O4(X_Edge_O4), 
		.Y_Edge_O1(Y_Edge_O1), 
		.Y_Edge_O2(Y_Edge_O2), 
		.Y_Edge_O3(Y_Edge_O3), 
		.Y_Edge_O4(Y_Edge_O4), 
		.vga_h_sync(vga_h_sync), 
		.vga_v_sync(vga_v_sync), 
		.vga_r(vga_r), 
		.vga_g(vga_g), 
		.vga_b(vga_b),
		.CounterX_out(CounterX_out),
		.CounterY_out(CounterY_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		BirdXdraw = 0;
		BirdYdraw = 0;
		X_Edge_O1 = 0;
		X_Edge_O2 = 0;
		X_Edge_O3 = 0;
		X_Edge_O4 = 0;
		Y_Edge_O1 = 0;
		Y_Edge_O2 = 0;
		Y_Edge_O3 = 0;
		Y_Edge_O4 = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 1;
		#20;
		reset = 0;
		#20;
		
		BirdXdraw = 320;
		BirdYdraw = 240;
		
		X_Edge_O1 = 10;
		X_Edge_O2 = 100;
		X_Edge_O3 = 200;
		X_Edge_O4 = 300;
		Y_Edge_O1 = 10;
		Y_Edge_O2 = 100;
		Y_Edge_O3 = 200;
		Y_Edge_O4 = 300;
		
		#100;
		// Add stimulus here

	end
      always begin #10; clk = ~ clk; end
endmodule

