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
module X_RAM_NOREAD(clk,reset,Start, Stop, Ack, out_pipe, Score,
	X_Edge_OO_L,
	X_Edge_O1_L,
	X_Edge_O2_L,
	X_Edge_O3_L,
	X_Edge_OO_R,
	X_Edge_O1_R,
	X_Edge_O2_R,
	X_Edge_O3_R,
	Q_Initial,
	Q_Count,
	Q_Stop);

 input clk,reset;
 input Start, Stop, Ack;
 
 output [9:0] X_Edge_OO_L;
 output [9:0] X_Edge_O1_L;
 output [9:0] X_Edge_O2_L;
 output [9:0] X_Edge_O3_L;
 output [9:0] X_Edge_OO_R;
 output [9:0] X_Edge_O1_R;
 output [9:0] X_Edge_O2_R;
 output [9:0] X_Edge_O3_R;
 output	[1:0] out_pipe;
 output	[3:0] Score;
 output 	Q_Initial, Q_Count, Q_Stop;
 
 reg [9:0] array_X_Left [3:0]; // 2D array X to store four 10 bit pipes
 reg [9:0] array_X_Right [3:0]; // 2D array X to store four 10 bit pipes
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
			
	parameter X0_init = 0;
	parameter X1_init = 160;
	parameter X2_init = 320;
	parameter X3_init = 480;
	
	parameter X0_init_2 = 80;
	parameter X1_init_2 = 240;
	parameter X2_init_2 = 400;
	parameter X3_init_2 = 560;
	
	//reg [1:0] out_temp_0;
	reg [1:0] out_temp_1;
	reg [1:0] out_temp_2;
	reg [1:0] out_temp_3;


integer i;
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
				
						Score <= 0;
						array_X_Left[0] <= X0_init;
						array_X_Left[1] <= X1_init;
						array_X_Left[2] <= X2_init;
						array_X_Left[3] <= X3_init;
						
						array_X_Right[0] <= X0_init_2;
						array_X_Right[1] <= X1_init_2;
						array_X_Right[2] <= X2_init_2;
						array_X_Right[3] <= X3_init_2;
						out_pipe <= 2; // The first pipe in scope is 2 because that's just to the right of the bird.
						out_temp_1 <= 3;
						out_temp_2 <= 0;
						out_temp_3 <= 1;
					if(Start) // we're startin' folks
						state <= QCount;
				end	
			
				QCount:
				begin
					if(Stop)
					begin
						state <= QStop;
					end
						for(i = 0; i < 4; i = i + 1) // Then we shift each pipe by 1 pixel
						begin
							array_X_Left[i] <= array_X_Left[i]-10'd1;
							if(array_X_Left[i] == 0)
							begin
								array_X_Left[i] <= 0;
							end
								
							array_X_Right[i] <= array_X_Right[i]-10'd1;
							if(array_X_Right[i] == 0)
							begin
								array_X_Left[i] <= 10'd640;
								array_X_Right[i] <= 10'd720;
							end
						end
				
						if(array_X_Right[out_pipe] < 320) // if current pipe is going out of scope (240 because 320-width of 80)
						begin // move on to the next pipe
							out_pipe <= out_pipe + 1;
							if(out_pipe == 3)
								out_pipe <= 0;
							
							out_temp_1 <= out_temp_1 + 1;
							if(out_temp_1 == 3)
								out_temp_1 <= 0;
								
							out_temp_2 <= out_temp_2 + 1;
							if(out_temp_2 == 3)
								out_temp_2 <= 0;
								
							out_temp_3 <= out_temp_3 + 1;
							if(out_temp_3 == 3)
								out_temp_3 <= 0;
							
							if(~Stop) Score <= Score + 4'd1; // increment score once a pipe passes the bird
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

 
 assign X_Edge_OO_L = array_X_Left[out_pipe];
 assign X_Edge_O1_L = array_X_Left[out_temp_1];
 assign X_Edge_O2_L = array_X_Left[out_temp_2];
 assign X_Edge_O3_L = array_X_Left[out_temp_3];
 
 assign X_Edge_OO_R = array_X_Right[out_pipe];
 assign X_Edge_O1_R = array_X_Right[out_temp_1];
 assign X_Edge_O2_R = array_X_Right[out_temp_2];
 assign X_Edge_O3_R = array_X_Right[out_temp_3];
 
endmodule
