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
module Y_ROM(I,DOUT);
	
	input [1:0] I;
	output [3:0] DOUT;
	reg [3:0] DOUT;
 
   always @(I) //instead of always@(I)
         case (I)
            2'b00: DOUT <= 100;
            2'b01: DOUT <= 150;
            2'b10: DOUT <= 200;
            2'b11: DOUT <= 250;
            default:  DOUT <= 4'bx;
         endcase	 

endmodule
