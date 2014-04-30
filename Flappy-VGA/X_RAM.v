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
module X_RAM_NOREAD(clk,reset,Start, Stop, Ack, Output, out_pipe, Score,
	X_Edge_O1,
	X_Edge_O2,
	X_Edge_O3,
	Q_Initial,
	Q_Count,
	Q_Stop);

	parameter X0_init = 0;
	parameter X1_init = 160;
	parameter X2_init = 320;
	parameter X3_init = 480;

 input clk,reset;
 input Start, Stop, Ack;
 
 output [9:0] Output;
 output [9:0] X_Edge_O1;
 output [9:0] X_Edge_O2;
 output [9:0] X_Edge_O3;
 output	[1:0] out_pipe;
 output	[3:0] Score;
 output 	Q_Initial, Q_Count, Q_Stop;
 
 reg [9:0] array_X [3:0]; // 2D array X to store four 10 bit pipes
 reg [1:0] out_pipe;
 reg [3:0] Score;
 
 reg[2:0] state;
 
 localparam
			QInitial = 3'b001,
			QCount	= 3'b010,
			QStop = 3'b100,
			UNK		= 3'bXXX;
	
	assign {Q_Stop, Q_Count,
			Q_Initial } = state;

//integer i;
 always @ (posedge clk, posedge reset)
	begin  : X_RAM_logic
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
						state <= QCount;
					
						Score <= 0;
						array_X[0] <= X0_init;
						array_X[1] <= X1_init;
						array_X[2] <= X2_init;
						array_X[3] <= X3_init;
						out_pipe <= 2; // The first pipe in scope is 2 because that's just to the right of the bird.
				end	
			
				QCount:
				begin
					if(Stop)
					begin
						state <= QStop;
					end
						
						//for(i = 0; i < 4; i = i + 1) // Then we shift each pipe by 1 pixel
						//begin
							array_X[0] <= array_X[0]-10'd1;
							array_X[1] <= array_X[1]-10'd1;
							array_X[2] <= array_X[2]-10'd1;
							array_X[3] <= array_X[3]-10'd1;
						//end
				
						if(array_X[out_pipe] < 240) // if current pipe is going out of scope (240 because 320-width of 80)
						begin // move on to the next pipe
							out_pipe <= out_pipe + 1;
							if(out_pipe == 3)
								out_pipe <= 0;
						
							Score <= Score + 4'd1; // increment score once a pipe passes the bird
						end
				
				end // COUNT_EN
			
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

 
 assign Output = array_X[out_pipe];
 assign X_Edge_O1 = array_X[out_pipe-1];
 assign X_Edge_O2 = array_X[out_pipe-2];
 assign X_Edge_O3 = array_X[out_pipe-3];
 
endmodule
