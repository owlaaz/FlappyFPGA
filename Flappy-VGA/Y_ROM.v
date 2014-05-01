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
	YEdge0T, YEdge0B,
	YEdge1T, YEdge1B,
	YEdge2T, YEdge2B,
	YEdge3T, YEdge3B,
	YEdge4T, YEdge4B
	);
	
	parameter E0 = 210;
	parameter E1 = 272;
	parameter E2 = 100;
	parameter E3 = 143;
	parameter E4 = 314;
	
	input [2:0] I;
	
	output [9:0] YEdge0T;
	output [9:0] YEdge0B;
	
	output [9:0] YEdge1T;
	output [9:0] YEdge1B;
	
	output [9:0] YEdge2T;
	output [9:0] YEdge2B;
	
	output [9:0] YEdge3T;
	output [9:0] YEdge3B;
	
	output [9:0] YEdge4T;
	output [9:0] YEdge4B;

	reg [9:0] YEdge0T;
	reg [9:0] YEdge0B;
	
	reg [9:0] YEdge1T;
	reg [9:0] YEdge1B;
	
	reg [9:0] YEdge2T;
	reg [9:0] YEdge2B;
	
	reg [9:0] YEdge3T;
	reg [9:0] YEdge3B;
	
	reg [9:0] YEdge4T;
	reg [9:0] YEdge4B;	
 
   always @(I) //instead of always@(I)
         case (I)
            3'b000: 
				begin 
					YEdge0T <= E0;
					YEdge0B <= E0 + 100;
					YEdge1T <= E1;
					YEdge1B <= E1 + 100;
					YEdge2T <= E2;
					YEdge2B <= E2 + 100;
					YEdge3T <= E3;
					YEdge3B <= E3 + 100;
					YEdge4T <= E4;
					YEdge4B <= E4 + 100;
				end
            3'b001:
				begin 
					YEdge0T <= E1;
					YEdge0B <= E1 + 100;
					YEdge1T <= E2;
					YEdge1B <= E2 + 100;
					YEdge2T <= E3;
					YEdge2B <= E3 + 100;
					YEdge3T <= E4;
					YEdge3B <= E4 + 100;
					YEdge4T <= E0;
					YEdge4B <= E0 + 100;
				end
            3'b010:
				begin 
					YEdge0T <= E2;
					YEdge0B <= E2 + 100;
					YEdge1T <= E3;
					YEdge1B <= E3 + 100;
					YEdge2T <= E4;
					YEdge2B <= E4 + 100;
					YEdge3T <= E0;
					YEdge3B <= E0 + 100;
					YEdge4T <= E1;
					YEdge4B <= E1 + 100;
				end
            3'b011:
				begin 
					YEdge0T <= E3;
					YEdge0B <= E3 + 100;
					YEdge1T <= E4;
					YEdge1B <= E4 + 100;
					YEdge2T <= E0;
					YEdge2B <= E0 + 100;
					YEdge3T <= E1;
					YEdge3B <= E1 + 100;
					YEdge4T <= E2;
					YEdge4B <= E2 + 100;
				end
			3'b100:
				begin
					YEdge0T <= E4;
					YEdge0B <= E4 + 100;
					YEdge1T <= E0;
					YEdge1B <= E0 + 100;
					YEdge2T <= E1;
					YEdge2B <= E1 + 100;
					YEdge3T <= E2;
					YEdge3B <= E2 + 100;
					YEdge4T <= E3;
					YEdge4B <= E3 + 100;
				end
            default:
				begin 
					YEdge0T <= 10'bXXXXXXXXXX;
					YEdge0B <= 10'bXXXXXXXXXX;
					YEdge1T <= 10'bXXXXXXXXXX;
					YEdge1B <= 10'bXXXXXXXXXX;
					YEdge2T <= 10'bXXXXXXXXXX;
					YEdge2B <= 10'bXXXXXXXXXX;
					YEdge3T <= 10'bXXXXXXXXXX;
					YEdge3B <= 10'bXXXXXXXXXX;
					YEdge4T <= 10'bXXXXXXXXXX;
					YEdge4B <= 10'bXXXXXXXXXX;
				end
         endcase	 

endmodule
