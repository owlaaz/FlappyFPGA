`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA verilog template
// Author:  Da Cheng
//////////////////////////////////////////////////////////////////////////////////
module vga_top(ClkPort, vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b, 
	Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,
	BtnL, BtnU, BtnD, BtnR, BtnC,
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	An0, An1, An2, An3, 
	Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	Ld7, Ld6, Ld5, Ld4, Ld3, Ld2, Ld1, Ld0);
	
	
		/*  INPUTS */
	input 	ClkPort;
	input	Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;
	input 	BtnL, BtnR, BtnC, BtnU, BtnD;
	
	output 	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output 	vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	output 	An0, An1, An2, An3;
	output	Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
	output 	Ld0, Ld1, Ld2, Ld3, Ld4, Ld5, Ld6, Ld7;
	
	reg 	vga_r, vga_g, vga_b;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	/*  LOCAL SIGNALS */
	wire	Reset, ClkPort, board_clk, sys_clk;
	
	// Inputs to the core design
	wire Start, Ack;
	wire [1:0] X_Index; // index of pipe to read
	// Outputs from the core design
	wire [9:0] X_Edge_OO_L;
	wire [9:0] X_Edge_OO_R;
	
	wire [9:0] X_Edge_O1_L;
	wire [9:0] X_Edge_O1_R;
	
	wire [9:0] X_Edge_O2_L;
	wire [9:0] X_Edge_O2_R;
	
	wire [9:0] X_Edge_O3_L;
	wire [9:0] X_Edge_O3_R;

	wire [9:0] Y_Edge_01_Top;
	wire [9:0] Y_Edge_01_Bottom;
		
	wire [9:0] Y_Edge_02_Top;
	wire [9:0] Y_Edge_02_Bottom;
		
	wire [9:0] Y_Edge_03_Top;
	wire [9:0] Y_Edge_03_Bottom;
		
	wire [9:0] Y_Edge_04_Top;
	wire [9:0] Y_Edge_04_Bottom;
	
	wire Done;
	wire q_Initial, q_Check, q_Lose;
	wire q_InitialX, q_Count, q_Stop;
	wire q_InitialF, q_Flight, q_StopF;
	wire [3:0]	Score;
	
	wire [9:0] Bird_X_L;
	wire [9:0] Bird_Y_T;
	wire [9:0] Bird_X_R;
	wire [9:0] Bird_Y_B;
	wire BtnC_Pulse, BtnL_Pulse, BtnD_Pulse, BtnR_Pulse, BtnU_Pulse;
	wire Jump;
	wire [9:0] PositiveSpeed;
	wire [9:0] NegativeSpeed;
	
	wire [1:0] 	ssdscan_clk;
	reg [1:0] state_num;
	reg[1:0] state_num_2;
	
	BUF BUF1 (board_clk, ClkPort); 	
	//BUF BUF2 (Reset, Sw0);
	//BUF BUF3 (Start, Sw1);
	
	reg [27:0]	DIV_CLK;
	always @ (posedge board_clk, posedge Reset)  
	begin : CLOCK_DIVIDER
      if (Reset)
			DIV_CLK <= 0;
      else
			DIV_CLK <= DIV_CLK + 1'b1;
	end	

	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;
	
	assign sys_clk = board_clk;
	
	hvsync_generator syncgen(.clk(DIV_CLK[1]), .reset(BtnR),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
	
	/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////

	wire R = 
		CounterY>=(Bird_Y_T) && CounterY<=(Bird_Y_B) && 
		CounterX>=(Bird_X_L) && CounterX<=(Bird_X_R);
	//green = pipes
	wire G = 
		((CounterX>=X_Edge_O1_L && CounterX<=X_Edge_O1_R && (CounterY<=Y_Edge_02_Top || CounterY>=Y_Edge_02_Bottom)) ||
		(CounterX>=X_Edge_O2_L && CounterX<=X_Edge_O2_R && (CounterY<=Y_Edge_03_Top || CounterY>=Y_Edge_03_Bottom)) ||
		(CounterX>=X_Edge_O3_L && CounterX<=X_Edge_O3_R && (CounterY<=Y_Edge_04_Top || CounterY>=Y_Edge_04_Bottom)) ||
		(CounterX>=X_Edge_OO_L && CounterX<=X_Edge_OO_R && (CounterY<=Y_Edge_01_Top || CounterY>=Y_Edge_01_Bottom))) && 
		~(CounterY>=(Bird_Y_T) && CounterY<=(Bird_Y_B) && 
		CounterX>=(Bird_X_L) && CounterX<=(Bird_X_R));
	wire B = 0;
	
	always @(posedge sys_clk)
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
	

	//assign Ld7 = clock_led;
	assign {Ld7, Ld6, Ld5} = {vga_r, vga_g, vga_b}; // r, g, b
//	assign {Ld7, Ld6, Ld5} = {clock_led, 0, 0};
	assign {Ld4, Ld3, Ld2, Ld1, Ld0} = {BtnL, BtnR, BtnU, BtnD, BtnC}; 
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control ends here 	 	////////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	reg 	[3:0]	SSD;
	wire 	[3:0]	SSD0, SSD1, SSD2, SSD3;
	
	assign SSD0 = Score[3:0]; // pipe index
	//assign SSD1 = X_Edge_OO_L[3:0];
	assign SSD1 =  X_Index; //in check state
	//assign SSD2 = 	CounterX[7:4]; //x rom
	//assign SSD2 = X_Edge_OO_L[3:0];
	assign SSD2 = q_Check;
	//assign SSD3 =  {0,0,counterx[9:8]}; // obstacle logic 
	assign SSD3 = q_Lose;
	
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
				  2'b00: SSD =     SSD0 ;	// ****** TODO  in Part 2 ******
				  2'b01: SSD =     SSD1;  	// Complete the four lines
				  2'b10: SSD =     SSD2;
				  2'b11: SSD =     SSD3;
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
	
	/* BUTTON SIGNAL ASSIGNMENT */
	assign Reset = BtnR;
	//assign Start = BtnU_Pulse;
	//assign Ack = BtnD_Pulse;
	//assign Jump = BtnC_Pulse;
	
	
	/*	X_RAM
	*	INPUTS:		clk
	*				reset
	*				count_EN - signal from obstacle_logic, whether or not the pipes should be moving
	*				Lose - signal from obstacle_logic, whether or not the player has lost
	*	OUTPUTS:  	Output - the left X edge of the pipe in scope
	*				X_Edge_O1 
	*				X_Edge_O2
	* 				X_Edge_O3
	*				out_pipe - index of the pipe in scope, used to pass into Y_ROM
	*				Score - player's score, which increments when an edge leaves scope and a new one enters
	*/
	X_RAM_NOREAD x_ram(.clk(DIV_CLK[19]),.reset(BtnR),.Start(BtnD), .Stop(q_Lose), .Ack(BtnD), .out_pipe(X_Index), 
		.Score(Score),.X_Edge_OO_L(X_Edge_OO_L), .X_Edge_O1_L(X_Edge_O1_L), .X_Edge_O2_L(X_Edge_O2_L), .X_Edge_O3_L(X_Edge_O3_L), 
		.X_Edge_OO_R(X_Edge_OO_R), .X_Edge_O1_R(X_Edge_O1_R), .X_Edge_O2_R(X_Edge_O2_R), .X_Edge_O3_R(X_Edge_O3_R), 
		.Q_Initial(q_InitialX), .Q_Count(q_Count), .Q_Stop(q_Stop));	
	
	/*	Y_ROM
	*	INPUTS:		I - signal from X_RAM, the index of the pipe in scope
	*	OUTPUTS: 	Output - the Y edge of the top portion of the pipe in scope
	*				Y_Edge_O1
	*				Y_Edge_O2
	*				Y_Edge_O3
	*/
	Y_ROM y_rom(.I(X_Index),
		.YEdge1T(Y_Edge_01_Top), 
		.YEdge1B(Y_Edge_01_Bottom),
		.YEdge2T(Y_Edge_02_Top),
		.YEdge2B(Y_Edge_02_Bottom),
		.YEdge3T(Y_Edge_03_Top),
		.YEdge3B(Y_Edge_03_Bottom),
		.YEdge4T(Y_Edge_04_Top),
		.YEdge4B(Y_Edge_04_Bottom)
		);
	/* 	obstacle_logic
	* 	INPUTS:		Clk
	*				reset	
	*				Start
	*				Ack
	*				Bird_X - flappy's x
	*				Bird_Y - flappy's y
	*				X_Edge - 10-bit x edge of current pipe (left edge)
	*				Y_Edge - 10 bit y edge of current pipe (top edge)
	*	OUTPUTS:	Q_Initial
	*				Q_Check
	*				Q_Lose
	*				Lose
	*				Check
	*/
	obstacle_logic obs_log(.Clk(DIV_CLK[1]),.reset(BtnR),.Q_Initial(q_Initial),.Q_Check(q_Check),.Q_Lose(q_Lose),
		.Start(BtnD), .Ack(BtnD), 
		.X_Edge_Left(X_Edge_OO_L),
		.X_Edge_Right(X_Edge_OO_R),
		.Y_Edge_Top(Y_Edge_01_Top),
		.Y_Edge_Bottom(Y_Edge_01_Bottom),
		.Bird_X_L(Bird_X_L), .Bird_X_R(Bird_X_R), .Bird_Y_T(Bird_Y_T), .Bird_Y_B(Bird_Y_B));
			
	/*	flight_physics
	*	INPUTS:		Clk
	*				reset
	*				Start
	*				Ack
	*				BtnPress - jump signal
	*	OUTPUTS:	Bird_X
	*				Bird_Y
	*/
	flight_physics flight_phys(.Clk(DIV_CLK[20]), .reset(BtnR), .Start(BtnD), .Ack(BtnD), .Stop(q_Lose),
		.BtnPress(BtnC), .Bird_X_L(Bird_X_L),  .Bird_X_R(Bird_X_R), .Bird_Y_T(Bird_Y_T),  .Bird_Y_B(Bird_Y_B),
		.q_Initial(q_InitialF), .q_Flight(q_Flight), .q_Stop(q_StopF), .PositiveSpeed(PositiveSpeed), .NegativeSpeed(NegativeSpeed));
endmodule
