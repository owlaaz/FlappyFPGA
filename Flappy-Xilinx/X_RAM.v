`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:05 04/10/2014 
// Design Name: 
// Module Name:    X_RAM 
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
// This manages the storage of the moving pipe X coordinates. Pipes are preprogrammed.
//	Outputs the address of the current pipe in scope, so that the corresponding Y coordinates can be read
// from Y_ROM.
// I guess the clock would be at whatever rate ... not sure actually;
// Coordinate is the left edge of the pipe. Right edge is calculated in obstacle logic.
//////////////////////////////////////////////////////////////////////////////////
module X_RAM_NOREAD(clk,reset,count_EN,Output, out_pipe, Score, Lose);

 input clk,reset;
 input count_EN;
 input Lose; // signal from obstacle logic
 
 output [9:0] Output;
 output	out_pipe[1:0];
 output	Score[3:0];
 
 reg [9:0] array_X [3:0]; // 2D array X to store four 10 bit pipes
 reg out_pipe[1:0];

 always @ (posedge clk)
	 begin  : X_RAM_logic
	 
		if(reset) // On reset we set the starting positions of the pipes.
		begin
			Score <= 0;
			array_X[0] <= 0;
			array_X[1] <= 160;
			array_X[2] <= 320;
			array_X[3] <= 480;
			out_pipe <= 2; // The first pipe in scope is 2 because that's just to the right of the bird.
		end
		else if (count_EN) // If signalled to count (the whole gameplay basically)
			begin
				integer i;
				for(i = 0; i < 4; i = i + 1) // Then we shift each pipe by 1 pixel
				begin
					array_X[i] <= array_X[i]-1;
				end
				
				if(array_X[out_pipe] < 240) // if current pipe is going out of scope (240 because 320-width of 80)
				begin // move on to the next pipe
					if(out_pipe == 3)
						out_pipe <= 0;
					else out_pipe <= out_pipe + 1;
					
					if(~Lose) Score <= Score + 1; // increment score once a pipe passes the bird
				end
			end
	 end
 
 assign Output = array_X[out_pipe];
 
endmodule
