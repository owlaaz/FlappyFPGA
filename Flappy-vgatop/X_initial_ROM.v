`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:47:14 03/27/2008 
// Design Name: 
// Module Name:    array_P_ROM 
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
// This holds initial positions of each pipe obstacle.
//////////////////////////////////////////////////////////////////////////////////
module X_initial_ROM(I,DOUT);
	
	input [1:0] I;
	output [9:0] DOUT;
	reg [9:0] DOUT;
 
   always @(I)
         case (I)
            2'b00: DOUT <= 0;
            2'b01: DOUT <= 160;
            2'b10: DOUT <= 320;
            2'b11: DOUT <= 480;
            default:  DOUT <= 4'bx;
         endcase	 

endmodule
