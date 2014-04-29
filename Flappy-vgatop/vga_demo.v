`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA verilog template
// Author:  Da Cheng
//////////////////////////////////////////////////////////////////////////////////
module vga_demo(ClkPort, vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b, Sw0, Sw1, BtnL, BtnU, BtnD, BtnR, BtnC,
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	Ld7, Ld6, Ld5, Ld4, Ld3, Ld2, Ld1, Ld0,);
	
	input ClkPort, Sw0, BtnL, BtnR, BtnC, BtnU, BtnD, Sw0, Sw1;
	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	output An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
	output 	Ld0, Ld1, Ld2, Ld3, Ld4, Ld5, Ld6, Ld7;
	reg vga_r, vga_g, vga_b;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/*  LOCAL SIGNALS */
	wire	reset, start, ClkPort, board_clk, clk, button_clk;
	
	// Inputs to the core design
	wire Start, Ack;
	wire [1:0] X_Index; // index of pipe to read
	// Outputs from the core design
	wire [9:0] X_Edge;
	wire [9:0] Y_Edge;
	
	wire [9:0] X_Edge_O1;
	wire [9:0] Y_Edge_O1;
	
	wire [9:0] X_Edge_O2;
	wire [9:0] Y_Edge_O2;
	
	wire [9:0] X_Edge_O3;
	wire [9:0] Y_Edge_O3;
	
	wire Done;
	wire q_Initial, q_Check, q_Lose; // Dunno if we need these
	wire Lose, Check;
	wire [3:0]	Score;
	
	wire signed [9:0] Bird_X;
	wire signed [9:0] Bird_Y;
	wire BtnC_Pulse, BtnL_Pulse, BtnD_Pulse, BtnR_Pulse, BtnU_Pulse;
	wire Jump;
	wire [9:0] VertSpeed;
	
	
	assign Start = BtnL_Pulse;
	assign Ack = BtnD_Pulse;
	
	BUF BUF1 (board_clk, ClkPort); 	
	BUF BUF2 (reset, Sw0);
	BUF BUF3 (start, Sw1);
	
	reg [27:0]	DIV_CLK;
	always @ (posedge board_clk, posedge reset)  
	begin : CLOCK_DIVIDER
      if (reset)
			DIV_CLK <= 0;
      else
			DIV_CLK <= DIV_CLK + 1'b1;
	end	

	assign	button_clk = DIV_CLK[18];
	assign	clk = DIV_CLK[1];
	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;
	
	assign Reset = BtnR;
	
	hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
	
	/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////
	reg [9:0] position;
	
	//always @(posedge DIV_CLK[21])
	//	begin
	//		if(reset)
//				position<=240;
	//		else if(btnD && ~btnU)
	//			position<=position+2;
	//		else if(btnU && ~btnD)
	//			position<=position-2;	
	//	end

	wire R = 
		CounterY>=(Bird_Y-10) && CounterY<=(Bird_Y+10) && 
		CounterX>=(Bird_X-10) && CounterX<=(Bird_X+10);
	//green = pipes
	wire G = 
		CounterX>=X_Edge_O1 && CounterX<=X_Edge_O1+80 && CounterY>=Y_Edge_O1 && CounterY<=Y_Edge_O1-100 ||
		CounterX>=X_Edge_O2 && CounterX<=X_Edge_O2+80 && CounterY>=Y_Edge_O2 && CounterY<=Y_Edge_O2-100 ||
		CounterX>=X_Edge_O3 && CounterX<=X_Edge_O3+80 && CounterY>=Y_Edge_O3 && CounterY<=Y_Edge_O3-100 ||
		CounterX>=X_Edge && CounterX<=X_Edge+80 && CounterY>=Y_Edge && CounterY<=Y_Edge-100;
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
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	`define QI 			2'b00
	`define QGAME_1 	2'b01
	`define QGAME_2 	2'b10
	`define QDONE 		2'b11
	
	reg [3:0] p2_score;
	reg [3:0] p1_score;
	reg [1:0] state;
	//wire LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	
	assign Ld7 = sys_clk;	
	//assign Ld6 = Sw7 & Sw6 & Sw5 & Sw4 & Sw3; // Just to combine unused inputs and outputs so that we can use the UCF
	                                          //  file with all basic I/O resources uniformly with all our designs 
	assign Ld5 = Done; // show the DONE signal on Ld5
	assign Ld4 = BtnL; // Start
	assign Ld3 = BtnU;
	assign Ld2 = BtnR; // Ack
	assign Ld1 = BtnD; // Reset
	assign Ld0 = BtnC; // Jump
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control ends here 	 	////////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	reg 	[3:0]	SSD;
	wire 	[3:0]	SSD0, SSD1, SSD2, SSD3;
	wire 	[1:0] ssdscan_clk;
	
	assign SSD3 = 4'b1111;
	assign SSD2 = 4'b1111;
	assign SSD1 = 4'b1111;
	assign SSD0 = position[3:0];
	
	// need a scan clk for the seven segment display 
	// 191Hz (50MHz / 2^18) works well
	assign ssdscan_clk = DIV_CLK[19:18];	
	assign An0	= !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
	assign An1	= !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
	assign An2	= !( (ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
	assign An3	= !( (ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11
	
	always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
	begin : SSD_SCAN_OUT
		case (ssdscan_clk) 
			2'b00:
					SSD = SSD0;
			2'b01:
					SSD = SSD1;
			2'b10:
					SSD = SSD2;
			2'b11:
					SSD = SSD3;
		endcase 
	end	

	// and finally convert SSD_num to ssd
	reg [6:0]  SSD_CATHODES;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES, 1'b1};
	// Following is Hex-to-SSD conversion
	always @ (SSD) 
	begin : HEX_TO_SSD
		case (SSD)		
			4'b1111: SSD_CATHODES = 7'b1111111 ; //Nothing 
			4'b0000: SSD_CATHODES = 7'b0000001 ; //0
			4'b0001: SSD_CATHODES = 7'b1001111 ; //1
			4'b0010: SSD_CATHODES = 7'b0010010 ; //2
			4'b0011: SSD_CATHODES = 7'b0000110 ; //3
			4'b0100: SSD_CATHODES = 7'b1001100 ; //4
			4'b0101: SSD_CATHODES = 7'b0100100 ; //5
			4'b0110: SSD_CATHODES = 7'b0100000 ; //6
			4'b0111: SSD_CATHODES = 7'b0001111 ; //7
			4'b1000: SSD_CATHODES = 7'b0000000 ; //8
			4'b1001: SSD_CATHODES = 7'b0000100 ; //9
			4'b1010: SSD_CATHODES = 7'b0001000 ; //10 or A
			default: SSD_CATHODES = 7'bXXXXXXX ; // default is not needed as we covered all cases
		endcase
	end
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	
	ee201_debouncer db1(.CLK(sys_clk), .RESET(Reset), .PB(BtnC), .DPB(), .SCEN(BtnC_Pulse), .MCEN(), .CCEN());
	ee201_debouncer db2(.CLK(sys_clk), .RESET(Reset), .PB(BtnL), .DPB(), .SCEN(BtnL_Pulse), .MCEN(), .CCEN());
	ee201_debouncer db3(.CLK(sys_clk), .RESET(Reset), .PB(BtnD), .DPB(), .SCEN(BtnD_Pulse), .MCEN(), .CCEN());
	
		// TODO update the initializer lists. I changed the modules but I didn't add new variables or update these lists.
	X_RAM_NOREAD x_ram(.clk(sys_clk),.reset(Reset),.count_EN(Check),.Output(X_Edge), .out_pipe(X_Index), 
		.Score(Score), .Lose(Lose), 	.X_Edge_O1(X_Edge_O1),
		.X_Edge_O2(X_Edge_O2),
		.X_Edge_O3(X_Edge_O3));	
		
	Y_ROM y_rom(.I(X_Index),.Output(Y_Edge), .Y_Edge_O1(Y_Edge_O1),
		.Y_Edge_O2(Y_Edge_O2),
		.Y_Edge_O3(Y_Edge_O3));
	
	obstacle_logic obs_log(.Clk(sys_clk),.reset(Reset),.Q_Initial(q_Initial),.Q_Check(q_Check),.Q_Lose(q_Lose),
		.Lose(Lose), .Check(Check),.Start(Start), .Ack(Ack), .X_Edge(X_Edge),
			.Y_Edge(Y_Edge), .Bird_X(Bird_X), .Bird_Y(Bird_Y));
	
	flight_physics flight_phys(.Clk(sys_clk), .reset(Reset), .Start(Start), .Ack(Ack), 
		.BtnPress(BtnC_Pulse), .Bird_X(Bird_X), .Bird_Y(Bird_Y));
endmodule
