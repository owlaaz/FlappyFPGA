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
	wire [9:0] X_Edge;

	wire [9:0] Y_Edge_01_Top;
	wire [9:0] Y_Edge_01_Bottom;
	
	wire [9:0] X_Edge_O1;
	
	wire [9:0] Y_Edge_02_Top;
	wire [9:0] Y_Edge_02_Bottom;
	
	wire [9:0] X_Edge_O2;
	
	wire [9:0] Y_Edge_03_Top;
	wire [9:0] Y_Edge_03_Bottom;
	
	wire [9:0] X_Edge_O3;
	
	wire [9:0] Y_Edge_04_Top;
	wire [9:0] Y_Edge_04_Bottom;
	
	wire Done;
	wire q_Initial, q_Check, q_Lose;
	wire q_InitialX, q_Count, q_Stop;
	wire q_InitialF, q_Flight, q_StopF;
	wire [3:0]	Score;
	
	wire signed [9:0] Bird_X;
	wire signed [9:0] Bird_Y;
	wire BtnC_Pulse, BtnL_Pulse, BtnD_Pulse, BtnR_Pulse, BtnU_Pulse;
	wire Jump;
	reg [9:0] VertSpeed;
	
	reg [9:0] Bird_X_in;
	reg [9:0] Bird_Y_in;
	reg [9:0] VertSpeed_in;
	reg [1:0] X_Index_in;
	reg [9:0] X_Edge_in;
	reg [9:0] Y_Edge_in;
	reg [9:0] X_Edge_O1_in;
	reg [9:0] Y_Edge_O1_in;
	reg [9:0] X_Edge_O2_in;
	reg [9:0] Y_Edge_O2_in;
	reg [9:0] X_Edge_O3_in;
	reg [9:0] Y_Edge_O3_in;
	
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
	
	hvsync_generator syncgen(.clk(DIV_CLK[25]), .reset(BtnR),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
	
	/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////
	
	reg R;
	
	reg [9:0] Bird_L; reg [9:0] Bird_R;
	reg [9:0]	Bird_T;
	reg [9:0]	Bird_B;
	reg [9:0] Bird_L_temp; reg [9:0] Bird_R_temp; reg [9:0] Bird_T_temp; reg [9:0] Bird_B_temp;
	
	always @ (DIV_CLK[25])
		begin
			Bird_L_temp = Bird_X-10;
			Bird_R_temp = Bird_X+10;
			Bird_T_temp = Bird_Y-10;
			Bird_B_temp = Bird_Y+10;
			if (Bird_L_temp > Bird_X)
				Bird_L_temp = 0;
			if (Bird_R_temp < Bird_X)
				Bird_R_temp = 640;
				
			if (Bird_T_temp > Bird_Y)
				Bird_T_temp = 0;
			if (Bird_B_temp < Bird_Y)
				Bird_B_temp = 480;
			
			Bird_L <= Bird_L_temp;
			Bird_R <= Bird_R_temp;
			Bird_T <= Bird_T_temp;
			Bird_B <= Bird_B_temp;
		end
		
	reg X0draw, X1draw, X2draw, X3draw;
	reg X_Edge_temp, X_Edge_01_temp, X_Edge_02_temp, X_Edge_03_temp; 
	
	always @ (X_Edge, X_Edge_O1, X_Edge_O2, X_Edge_O3)
		begin
			X_Edge_temp = X_Edge+80;
			X_Edge_01_temp = X_Edge_O1+80;
			X_Edge_02_temp = X_Edge_O2+80;
			X_Edge_03_temp = X_Edge_O3+80;
			
			if (X_Edge_temp < X_Edge)
				X_Edge_temp = 640;
				
			if (X_Edge_01_temp < X_Edge_O1)
				X_Edge_01_temp = 640;
				
			if (X_Edge_02_temp < X_Edge_O2)
				X_Edge_02_temp = 640;
				
			if (X_Edge_03_temp < X_Edge_O3)
				X_Edge_03_temp = 640;
				
			X0draw <= X_Edge_temp;
			X1draw <= X_Edge_01_temp;
			X2draw <= X_Edge_02_temp;
			X3draw <= X_Edge_03_temp;
		end
	
	always @ (posedge DIV_CLK[25])//, posedge Reset)//, Bird_Y, Bird_X, CounterY, CounterX)
	begin
		if(Reset) R <= 0;
		
		//R <= ~R;
		R <= (CounterY>=(Bird_T) && CounterY<=(Bird_B) && 
		CounterX>=(Bird_L) && CounterX<=(Bird_R));
	end

	//wire R = 
		//CounterY>=(Bird_T) && CounterY<=(Bird_B) && 
		//CounterX>=(Bird_L) && CounterX<=(Bird_R);
	//green = pipes
	wire G = 
		CounterX>=X_Edge_O1 && CounterX<=X1draw && CounterY<=Y_Edge_01_Top && CounterY>=Y_Edge_01_Bottom ||
		CounterX>=X_Edge_O2 && CounterX<=X2draw && CounterY<=Y_Edge_02_Top && CounterY>=Y_Edge_02_Bottom ||
		CounterX>=X_Edge_O3 && CounterX<=X3draw && CounterY<=Y_Edge_03_Top && CounterY>=Y_Edge_03_Bottom ||
		CounterX>=X_Edge && CounterX<=X0draw && CounterY<=Y_Edge_04_Top && CounterY>=Y_Edge_04_Bottom;
	wire B = 0;
	
	always @(posedge sys_clk)
	begin
		vga_r <= R & inDisplayArea;
		//vga_r <= 1;
		vga_g <= G & inDisplayArea;
		vga_b <= B & inDisplayArea;
	end
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  VGA control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	
	reg clock_led;
	always @ (posedge sys_clk)
	begin
		clock_led = sys_clk;
	end
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
	
	`define QI_NUM			2'b00
	`define QCHECK_NUM		2'b01 // or count
	`define QLOSE_NUM		2'b10 // or lose
	
	/* TO VIEW OBSTACLE LOGIC STATE SSD */
	always @ ( q_Initial, q_Check, q_Lose )
	begin : ONE_HOT_TO_HEX
		(* full_case, parallel_case *) // to avoid prioritization (Verilog 2001 standard)
		case ( {q_Initial, q_Check, q_Lose} )	
			3'b100: state_num = `QI_NUM;
			3'b010: state_num = `QCHECK_NUM;
			3'b001: state_num = `QLOSE_NUM;
			default:		state_num = 3'bXXX;
		endcase
	end
	
	/* TO VIEW X RAM STATE SSD */
	always @ ( q_InitialF, q_Flight, q_StopF )
	begin : ONE_HOT_TO_HEX_2
		(* full_case, parallel_case *) // to avoid prioritization (Verilog 2001 standard)
		case ( {q_InitialF, q_Flight, q_StopF} )	
			3'b100: state_num_2 = `QI_NUM;
			3'b010: state_num_2 = `QCHECK_NUM;
			3'b001: state_num_2 = `QLOSE_NUM;
			default:		state_num_2 = 3'bXXX;
		endcase
	end
	
	reg [3:0] state_num_3;
		/* TO VIEW X RAM STATE SSD */
	always @ ( q_InitialX, q_Count, q_Stop )
	begin : ONE_HOT_TO_HEX_3
		(* full_case, parallel_case *) // to avoid prioritization (Verilog 2001 standard)
		case ( {q_InitialX, q_Count, q_Stop} )	
			3'b100: state_num_3 = `QI_NUM;
			3'b010: state_num_3 = `QCHECK_NUM;
			3'b001: state_num_3 = `QLOSE_NUM;
			default:		state_num_3 = 3'bXXX;
		endcase
	end
	
	/* TO VIEW OUTPUT PIPE INDEX SSD */
	reg [3:0] x_index;
	always @ (X_Index)
	begin : Pipe_Index
		x_index <= {0, 0, X_Index};
	end
	
	
	reg red;
	always @ (R)
	begin
		red <= R;
	end
	
	reg [9:0] counterx;
	always @ (CounterX)
	begin
		counterx <= CounterX;
	end
	
	/*
	assign SSD0 = counterx[3:0];
	assign SSD1 = counterx[7:4];
	assign SSD2 = red;
	assign SSD3 = state_num;
	*/	
	
	reg [3:0] bird_y;
	always @ (Bird_Y)
	begin
		bird_y <= Bird_L;
	end
	
	assign SSD0 = red; // pipe index
	assign SSD1 =  counterx[3:0]; //in check state
	assign SSD2 = 	counterx[7:4]; //x rom
	//assign SSD3 =  {0,0,counterx[9:8]}; // obstacle logic 
	assign SSD3 = Bird_X[3:0];
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
	
	/* BtnC is the Jump signal */
	ee201_debouncer #(.N_dc(28)) db1(.CLK(sys_clk), .RESET(Reset), .PB(BtnC), .DPB(), .SCEN(Jump), .MCEN(), .CCEN());
	// BtnU is the Start signal 
	ee201_debouncer #(.N_dc(28)) db2(.CLK(sys_clk), .RESET(Reset), .PB(BtnU), .DPB(), .SCEN(Start), .MCEN(), .CCEN());
	// BtnD is the Ack signal 
	ee201_debouncer #(.N_dc(28)) db3(.CLK(sys_clk), .RESET(Reset), .PB(BtnD), .DPB(), .SCEN(Ack), .MCEN(), .CCEN());
	
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
	X_RAM_NOREAD x_ram(.clk(DIV_CLK[21]),.reset(BtnR),.Start(BtnU), .Stop(q_Lose), .Ack(BtnD),.Output(X_Edge), .out_pipe(X_Index), 
		.Score(Score), .X_Edge_O1(X_Edge_O1), .X_Edge_O2(X_Edge_O2), .X_Edge_O3(X_Edge_O3), .Q_Initial(q_InitialX),
	 .Q_Count(q_Count), .Q_Stop(q_Stop));	
	
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
		.Start(BtnU), .Ack(BtnD), .X_Edge(X_Edge),
			.Y_Edge(Y_Edge), .Bird_X(Bird_X), .Bird_Y(Bird_Y));
			
	/*	flight_physics
	*	INPUTS:		Clk
	*				reset
	*				Start
	*				Ack
	*				BtnPress - jump signal
	*	OUTPUTS:	Bird_X
	*				Bird_Y
	*/
	flight_physics flight_phys(.Clk(DIV_CLK[21]), .reset(BtnR), .Start(BtnU), .Ack(BtnD), .Stop(q_Lose),
		.BtnPress(BtnC), .Bird_X(Bird_X), .Bird_Y(Bird_Y), .q_Initial(q_InitialF), .q_Flight(q_Flight), .q_Stop(q_StopF));
endmodule
