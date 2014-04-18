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
input		Bird_X[9:0];
input		Bird_Y[9:0];

output	VertSpeed; // some amount of pixels per clock
output	Bird_X[9:0];
output	Bird_Y[9:0];

integer JUMP_VELOCITY = 10; // some amount of pixels per clock
integer GRAVITY = -9.8; // change to some number of pixels per clock

always @ (posedge Clk, posedge reset)
begin
	if(reset)
	begin
		VertSpeed <= 0;
		Bird_X <= 10'd320;
		Bird_Y <= 10'd240;
	end
	
	else if(BtnPress)
	begin
		VertSpeed <= JUMP_VELOCITY;
	end
	
	// always pulled by gravity
	Bird_Y <= Bird_Y + VertSpeed;
	VertSpeed <= VertSpeed - GRAVITY;
end

endmodule
