`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:28:43 04/15/2014 
// Design Name: 
// Module Name:    flight_physics 
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
//
//////////////////////////////////////////////////////////////////////////////////
module flight_physics(Clk, reset, Start, Ack, Stop, BtnPress, Bird_X, Bird_Y, //vertspeed
   q_Initial, q_Flight, q_Stop );

input 	Clk, reset, Start, Ack, Stop;
input 	BtnPress;

//output signed [9:0]	VertSpeed; // some amount of pixels per clock
output signed [9:0] Bird_X;
output signed [9:0] Bird_Y;
output q_Initial, q_Flight, q_Stop;

reg [2:0] state;
assign {q_Stop, q_Flight, q_Initial} = state;

reg signed [9:0] VertSpeed;
reg signed [9:0] Bird_X;
reg signed [9:0] Bird_Y;

localparam
			QInitial = 3'b001,
			QFlight	= 3'b010,
			QStop 	= 3'b100,
			UNK		= 3'bXXX;

parameter JUMP_VELOCITY = 10; // some amount of pixels per clock
parameter GRAVITY = -9; // change to some number of pixels per clock

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
					state <= QFlight;
					
				VertSpeed <= 10'd0;
				Bird_X <= 10'd10; //10'd300;
				Bird_Y <= 10'd10;//10'd240;
			end	
			
			QFlight:
			begin
				if(Stop)
					state <= QStop;
					
				if(BtnPress)
				begin
					VertSpeed <= JUMP_VELOCITY;
				end
				
				else 
				begin
					Bird_Y <= Bird_Y + VertSpeed;
					VertSpeed <= VertSpeed + GRAVITY;
				end
			end	
			
			QStop:
			begin
				if(Ack)
					state <= QInitial;
			end

			default:
				state <= UNK;
		endcase
	end
end

endmodule
