`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:41:34 04/10/2014 
// Design Name: 
// Module Name:    flappy 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//	Handles the logic of game states (whether flappy hits a pole).
//////////////////////////////////////////////////////////////////////////////////
module obstacle_logic(
	Clk,reset,
	Q_Initial,
	Q_Check,
	Q_Lose, 
	Start, Ack, 
	X_Edge_Left,
	X_Edge_Right,
	Y_Edge_Top,
	Y_Edge_Bottom,
	Bird_X_L, Bird_X_R, Bird_Y_T, Bird_Y_B
	);

// INPUTS //
input 	Clk, reset, Start, Ack;
input [9:0] Bird_X_L; // flappy's x
input [9:0] Bird_Y_T; // flappy's y
input [9:0] Bird_X_R; // flappy's x
input [9:0] Bird_Y_B; // flappy's y
input	[9:0] X_Edge_Left; // 10-bit x edge of current pipe (left edge)
input	[9:0] X_Edge_Right; // 10-bit x edge of current pipe (right edge)
input	[9:0] Y_Edge_Top; // 10 bit y edge of current pipe (top edge)
input	[9:0] Y_Edge_Bottom; // 10 bit y edge of current pipe (bottom edge)


// OUTPUTS //
output 	Q_Initial,
			Q_Check, Q_Lose;
				
reg 	Lose;		
reg	Check;	
reg 	Initial;
reg [2:0] state;

//reg timer_out;
//reg [3:0] count;

assign {Q_Lose, Q_Check,
			Q_Initial } = state;

localparam
			QInitial = 3'b001,
			QCheck	= 3'b010,
			QLose 	= 3'b100,
			UNK		= 3'bXXX;
			
always @ (posedge Clk, posedge reset)
begin
	if(reset)
	begin
		state <= QInitial;
	end
	else
	
	begin
		case(state)
		
			QInitial:
			begin
				if(Start) // we're startin' folks
					state <= QCheck;
			end	
			
			QCheck:
			begin
			// if (Bird is below the bottom part of pipe OR above the top part of pipe
			//			AND Bird is inside of the pipe X-wise) Then the player loses
				if( (Bird_Y_T >= Y_Edge_Bottom || Bird_Y_B <= Y_Edge_Top)
					&& (Bird_X_L > X_Edge_Left && Bird_X_R < X_Edge_Right) )
					begin
						state <= QLose;
					end
			end	
			
			QLose:
			begin
				if(Ack)
					state <= QInitial;
			end

			default:
				state <= UNK;
		endcase
	end
end

// TODO work out how to keep score as the bird passes pipes. 
// Still need to work out logic to move from one pipe in scope to the next. That logic should go in the same place as the score so we know that when we increment the pipe,
// we should increment the score.

endmodule
