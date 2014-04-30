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
module Y_ROM(I,
	YEdge1T, YEdge1B,
	YEdge2T, YEdge2B,
	YEdge3T, YEdge3B,
	YEdge4T, YEdge4B
	)
	
	parameter E0 = 100;
	parameter E1 = 150;
	parameter E2 = 200;
	parameter E3 = 250;
	
	input [1:0] I;
	
	output [9:0] YEdge1T;
	output [9:0] YEdge1B,
	output [9:0] YEdge2T;
	output [9:0] YEdge2B,
	output [9:0] YEdge3T;
	output [9:0] YEdge3B,
	output [9:0] YEdge4T;
	output [9:0] YEdge4B;
	
	reg [9:0] YEdge1T;
	reg [9:0] YEdge1B,
	reg [9:0] YEdge2T;
	reg [9:0] YEdge2B,
	reg [9:0] YEdge3T;
	reg [9:0] YEdge3B,
	reg [9:0] YEdge4T;
	reg [9:0] YEdge4B;	
 
   always @(I) //instead of always@(I)
         case (I)
            2'b00: 
				begin 
					YEdge1T <= E0;
					YEdge1B <= E0 + 100;
					YEdge2T <= E1;
					YEdge2B <= E1 + 100;
					YEdge3T <= E2;
					YEdge3B <= E2 + 100;
					YEdge4T <= E3;
					YEdge4B <= E3 + 100;
				end
            2'b01:
				begin 
					YEdge1T <= E1;
					YEdge1B <= E1 + 100;
					YEdge2T <= E2;
					YEdge2B <= E2 + 100;
					YEdge3T <= E3;
					YEdge3B <= E3 + 100;
					YEdge4T <= E0;
					YEdge4B <= E0 + 100;
				end
            2'b10:
				begin 
					YEdge1T <= E2;
					YEdge1B <= E2 + 100;
					YEdge2T <= E3;
					YEdge2B <= E3 + 100;
					YEdge3T <= E0;
					YEdge3B <= E0 + 100;
					YEdge4T <= E1;
					YEdge4B <= E1 + 100;
				end
            2'b11:
				begin 
					YEdge1T <= E3;
					YEdge1B <= E3 + 100;
					YEdge2T <= E0;
					YEdge2B <= E0 + 100;
					YEdge3T <= E1;
					YEdge3B <= E1 + 100;
					YEdge4T <= E2;
					YEdge4B <= E2 + 100;
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
