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
	Q_Lose, Lose, Check,// Score,
	Start, Ack, 
	X_Edge, // 10-bit x edges of pipes
	Y_Edge, // 10 bit y edges
	Bird_X, Bird_Y
	);

// INPUTS //
input 	Clk, reset, Start, Ack;
input	signed [9:0] Bird_X; // flappy's x
input	signed [9:0] Bird_Y; // flappy's y
input	[9:0] X_Edge; // 10-bit x edge of current pipe (left edge)
input	[9:0] Y_Edge; // 10 bit y edge of current pipe (top edge)

// OUTPUTS //
output 	Q_Initial,
			Q_Check, Q_Lose, Lose, Check;
				
reg 	Lose;		
reg	Check;	
reg [2:0] state;

// local variables to use to edges I guess
wire [9:0] X_left_edge;
wire [9:0] X_right_edge;
wire [9:0] Y_top_edge;
wire [9:0] Y_bottom_edge;

//reg timer_out;
//reg [3:0] count;

assign {Q_Lose, Q_Check,
			Q_Initial } = state;

// Assigning local edge
assign X_left_edge = X_Edge;
assign X_right_edge = {X_Edge + 10'd80};
assign Y_top_edge = Y_Edge;
assign Y_bottom_edge = {Y_Edge + 10'd100};

localparam
			QInitial = 2'b00,
			QCheck	= 2'b01,
			QLose 	= 2'b10,
			UNK		= 2'bXX;
			
always @ (posedge Clk, posedge reset)
begin
	if(reset)
	begin
		state <= QInitial;
		Lose <= 0;
		Check <=0;
	end
	else
	
	begin
		case(state)
		
			QInitial:
				if(Start) // we're startin' folks
					state <= QCheck;
					
					
			QCheck:
			begin
			// if (Bird is below the bottom part of pipe OR above the top part of pipe
			//			AND Bird is inside of the pipe X-wise) Then the player loses
				if( (Bird_Y >= Y_bottom_edge || Bird_Y <= Y_top_edge)
					&& (X_left_edge < Bird_X && X_right_edge > Bird_Y) )
					state <= QLose;
					Check <= 1;
			end	
			
			QLose:
			begin
				if(Ack)
					state <= QInitial;
				Lose <= 1'b1;
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
