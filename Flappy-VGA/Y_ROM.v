`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:03 04/10/2014 
// Design Name: 
// Module Name:    Y_ROM 
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
// This holds default heights (Y coordinates) for pipe obstacles.
// Coordinate is the top edge of the pipe. Bottom edge is calculated in obstacle logic.
//////////////////////////////////////////////////////////////////////////////////
module Y_ROM(I,Output, 	Y_Edge_O1,
	Y_Edge_O2,
	Y_Edge_O3);
	
	parameter E0 = 100;
	parameter E1 = 150;
	parameter E2 = 200;
	parameter E3 = 250;
	
	input [1:0] I;
	output [9:0] Output;
	output [9:0] Y_Edge_O1;
	output [9:0] Y_Edge_O2;
	output [9:0] Y_Edge_O3;
	
	reg [9:0] Output;
	reg [9:0] Y_Edge_O1;
	reg [9:0] Y_Edge_O2;
	reg [9:0] Y_Edge_O3;
 
   always @(I) //instead of always@(I)
         case (I)
            2'b00: 
				begin 
					Output <= E0;
					Y_Edge_O1 <= E1;
					Y_Edge_O2 <= E2;
					Y_Edge_O3 <= E3;
				end
            2'b01:
				begin 
					Output <= E1;
					Y_Edge_O1 <= E2;
					Y_Edge_O2 <= E3;
					Y_Edge_O3 <= E0;
				end
            2'b10:
				begin 
					Output <= E2;
					Y_Edge_O1 <= E3;
					Y_Edge_O2 <= E0;
					Y_Edge_O3 <= E1;
				end
            2'b11:
				begin 
					Output <= E3;
					Y_Edge_O1 <= E0;
					Y_Edge_O2 <= E1;
					Y_Edge_O3 <= E2;
				end
            default:
				begin 
					Output <= 10'bXXXXXXXXXX;
					Y_Edge_O1 <= 10'bXXXXXXXXXX;
					Y_Edge_O2 <= 10'bXXXXXXXXXX;
					Y_Edge_O3 <= 10'bXXXXXXXXXX;
				end
         endcase	 

endmodule
