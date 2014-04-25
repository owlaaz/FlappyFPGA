`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA verilog template
// Based on module by:  Da Cheng
// Modified by: David Carr
//////////////////////////////////////////////////////////////////////////////////
module vga_output(
	ClkPort, 
	reset,
	BirdXdraw,
	BirdYdraw,
	X_Edge_O1,
	X_Edge_O2,
	X_Edge_O3,
	X_Edge_O4,
	Y_Edge_O1,
	Y_Edge_O2,
	Y_Edge_O3,
	Y_Edge_O4,
	vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b
	);
	
	input ClkPort, reset;
	output vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	reg vga_r, vga_g, vga_b;
	
	input signed [9:0] BirdXdraw;
	input signed [9:0] BirdYdraw;
	input signed [9:0] X_Edge_O1;
	input signed [9:0] X_Edge_O2;
	input signed [9:0] X_Edge_O3;
	input signed [9:0] X_Edge_O4;
	input signed [9:0] Y_Edge_O1;
	input signed [9:0] Y_Edge_O2;
	input signed [9:0] Y_Edge_O3;
	input signed [9:0] Y_Edge_O4;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/*  LOCAL SIGNALS */
	wire	board_clk, clk;
	
	BUF BUF1 (board_clk, ClkPort); 	
	
	reg [27:0]	DIV_CLK;
	always @ (posedge board_clk, posedge reset)  
	begin : CLOCK_DIVIDER
      if (reset)
			DIV_CLK <= 0;
      else
			DIV_CLK <= DIV_CLK + 1'b1;
	end	

	assign	clk = DIV_CLK[1];
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;

	hvsync_generator syncgen(
		.clk(clk), .reset(reset),
		.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), 
		.inDisplayArea(inDisplayArea), 
		.CounterX(CounterX), .CounterY(CounterY));
	
	/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////


	//red = bird
	wire R = 
		CounterY>=(BirdYdraw-10) && CounterY<=(BirdYdraw+10) && 
		CounterX>=(BirdXdraw-10) && CounterX<=(BirdXdraw+10);
	//green = pipes
	wire G = 
		CounterX>=X_Edge_O1 && CounterX<=X_Edge_O1+80 && CounterY>=Y_Edge_O1 && CounterY<=Y_Edge_O1-100 &&
		CounterX>=X_Edge_O2 && CounterX<=X_Edge_O2+80 && CounterY>=Y_Edge_O2 && CounterY<=Y_Edge_O2-100 &&
		CounterX>=X_Edge_O3 && CounterX<=X_Edge_O3+80 && CounterY>=Y_Edge_O3 && CounterY<=Y_Edge_O3-100 &&
		CounterX>=X_Edge_O4 && CounterX<=X_Edge_O4+80 && CounterY>=Y_Edge_O4 && CounterY<=Y_Edge_O4-100;
	wire B = 0;
	
	always @(posedge clk)
	begin
		vga_r <= R & inDisplayArea;
		vga_g <= G & inDisplayArea;
		vga_b <= B & inDisplayArea;
	end
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  VGA control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	
endmodule
