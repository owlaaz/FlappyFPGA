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
module flight_physics(Clk, reset, Start, Ack, BtnPress, VertSpeed, Bird_X, Bird_Y
    );

input 	Clk, reset, Start, Ack;
input 	BtnPress;

output signed [9:0]	VertSpeed; // some amount of pixels per clock
output signed [9:0] Bird_X;
output signed [9:0] Bird_Y;

reg signed [9:0] VertSpeed;
reg signed [9:0] Bird_X;
reg signed [9:0] Bird_Y;

integer JUMP_VELOCITY = 10; // some amount of pixels per clock
integer GRAVITY = -9; // change to some number of pixels per clock

always @ (posedge Clk)
begin
	if(reset)
	begin
		VertSpeed <= 10'd0;
		Bird_X <= 10'd300;
		Bird_Y <= 10'd240;
	end
	
	else if(BtnPress)
	begin
		VertSpeed <= JUMP_VELOCITY;
	end
	
	// always pulled by gravity
	else if(~BtnPress)
	begin
		Bird_Y <= Bird_Y + VertSpeed;
		VertSpeed <= VertSpeed + GRAVITY;
	end
end

endmodule
