`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:32:02 04/24/2014
// Design Name:   flappy_top
// Module Name:   C:/Users/Lorraine/Documents/Flappy/top_tb.v
// Project Name:  Flappy
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: flappy_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_tb;

	// Inputs
	reg ClkPort;
	reg BtnL;
	reg BtnU;
	reg BtnD;
	reg BtnR;
	reg BtnC;
	reg Sw7;
	reg Sw6;
	reg Sw5;
	reg Sw4;
	reg Sw3;
	reg Sw2;
	reg Sw1;
	reg Sw0;

	// Outputs
	wire MemOE;
	wire MemWR;
	wire RamCS;
	wire FlashCS;
	wire QuadSpiFlashCS;
	wire Ld7;
	wire Ld6;
	wire Ld5;
	wire Ld4;
	wire Ld3;
	wire Ld2;
	wire Ld1;
	wire Ld0;
	wire An3;
	wire An2;
	wire An1;
	wire An0;
	wire Ca;
	wire Cb;
	wire Cc;
	wire Cd;
	wire Ce;
	wire Cf;
	wire Cg;
	wire Dp;
	wire vga_h_sync;
	wire vga_v_sync;
	wire vga_r;
	wire vga_g;
	wire vga_b;

	// Instantiate the Unit Under Test (UUT)
	flappy_top uut (
		.MemOE(MemOE), 
		.MemWR(MemWR), 
		.RamCS(RamCS), 
		.FlashCS(FlashCS), 
		.QuadSpiFlashCS(QuadSpiFlashCS), 
		.ClkPort(ClkPort), 
		.BtnL(BtnL), 
		.BtnU(BtnU), 
		.BtnD(BtnD), 
		.BtnR(BtnR), 
		.BtnC(BtnC), 
		.Sw7(Sw7), 
		.Sw6(Sw6), 
		.Sw5(Sw5), 
		.Sw4(Sw4), 
		.Sw3(Sw3), 
		.Sw2(Sw2), 
		.Sw1(Sw1), 
		.Sw0(Sw0), 
		.Ld7(Ld7), 
		.Ld6(Ld6), 
		.Ld5(Ld5), 
		.Ld4(Ld4), 
		.Ld3(Ld3), 
		.Ld2(Ld2), 
		.Ld1(Ld1), 
		.Ld0(Ld0), 
		.An3(An3), 
		.An2(An2), 
		.An1(An1), 
		.An0(An0), 
		.Ca(Ca), 
		.Cb(Cb), 
		.Cc(Cc), 
		.Cd(Cd), 
		.Ce(Ce), 
		.Cf(Cf), 
		.Cg(Cg), 
		.Dp(Dp), 
		.vga_h_sync(vga_h_sync), 
		.vga_v_sync(vga_v_sync), 
		.vga_r(vga_r), 
		.vga_g(vga_g), 
		.vga_b(vga_b)
	);

	initial begin
		// Initialize Inputs
		ClkPort = 0;
		BtnL = 0;
		BtnU = 0;
		BtnD = 0;
		BtnR = 0;
		BtnC = 0;
		Sw7 = 0;
		Sw6 = 0;
		Sw5 = 0;
		Sw4 = 0;
		Sw3 = 0;
		Sw2 = 0;
		Sw1 = 0;
		Sw0 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		BtnD = 1;
		#100;
		
        
		// Add stimulus here

	end
      
endmodule

