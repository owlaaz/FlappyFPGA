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
	X_Edge,
	vga_h_sync, vga_v_sync, 
	vga_r, vga_g, vga_b, 
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar
	);
	
	input ClkPort, reset;
	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	reg vga_r, vga_g, vga_b; 
	
	input [9:0] BirdXdraw;
	input [9:0] BirdYdraw;
	input [9:0] X_Edge;
	
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
	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};
	
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
		CounterX>=(BirdXdraw-10) && CounterX<=(BirdXDraw+10);
	//green = pipes
	wire G = 
		CounterX>=Pipe1left && CounterX<=Pipe1right && CounterY>=Pipe1top && CounterY<=Pipe1bottom &&
		CounterX>=Pipe2left && CounterX<=Pipe2right && CounterY>=Pipe2top && CounterY<=Pipe2bottom &&
		CounterX>=Pipe3left && CounterX<=Pipe3right && CounterY>=Pipe3top && CounterY<=Pipe3bottom &&
		CounterX>=Pipe4left && CounterX<=Pipe4right && CounterY>=Pipe4top && CounterY<=Pipe4bottom;
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
