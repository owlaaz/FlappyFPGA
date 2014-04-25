`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:34:55 04/24/2014
// Design Name:   vga_output
// Module Name:   /home/david/ee201/FlappyFPGA/Flappy-Xilinx/vga_output_tb.v
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
	reg ClkPort;
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

	// Instantiate the Unit Under Test (UUT)
	vga_output uut (
		.ClkPort(ClkPort), 
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
		.vga_b(vga_b)
	);

	initial begin
		// Initialize Inputs
		ClkPort = 0;
		BirdXdraw = 200;
		BirdYdraw = 200;
		X_Edge_O1 = 10;
		X_Edge_O2 = 20;
		X_Edge_O3 = 30;
		X_Edge_O4 = 40;
		Y_Edge_O1 = 50;
		Y_Edge_O2 = 60;
		Y_Edge_O3 = 70;
		Y_Edge_O4 = 80;
		reset = 0;
		#45
		reset = 1;
		#45;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin #10; ClkPort = ~ ClkPort; end
      
endmodule

