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
module flight_physics(Clk, reset, Start, Ack, Stop, BtnPress, Bird_X_L, Bird_X_R, Bird_Y_T, Bird_Y_B,
   q_Initial, q_Flight, q_Stop, PositiveSpeed, NegativeSpeed );

input 	Clk, reset, Start, Ack, Stop;
input 	BtnPress;

//output signed [9:0]	VertSpeed; // some amount of pixels per clock
output [9:0] Bird_X_L;
output [9:0] Bird_X_R;
output [9:0] Bird_Y_T;
output [9:0] Bird_Y_B;
output [9:0] PositiveSpeed;
output [9:0] NegativeSpeed;
output q_Initial, q_Flight, q_Stop;

reg [2:0] state;
assign {q_Stop, q_Flight, q_Initial} = state;

reg [9:0] PositiveSpeed;
reg[9:0] pos_temp;
reg [9:0] NegativeSpeed;

reg [9:0] Bird_X_L;
reg [9:0] Bird_X_R;
reg [9:0] Bird_Y_T;
reg [9:0] Bird_Y_B;

localparam
			QInitial = 3'b001,
			QFlight	= 3'b010,
			QStop 	= 3'b100,
			UNK		= 3'bXXX;

parameter JUMP_VELOCITY = 10; // some amount of pixels per clock
parameter GRAVITY = 9; // change to some number of pixels per clock

always @ (posedge Clk, posedge reset)
begin

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
					state <= QFlight;
					
				PositiveSpeed <= 10'd0;
				NegativeSpeed <= 10'd0;
				Bird_X_L <= 10'd20; //10'd300;
				Bird_X_R <= 10'd40; //10'd300;
				Bird_Y_T <= 10'd20;//10'd240;
				Bird_Y_B <= 10'd40; //10'd300;
			end	
			
			QFlight:
			begin
				if(Stop)
					state <= QStop;
					
				if(BtnPress)
				begin
					PositiveSpeed <= JUMP_VELOCITY;
					NegativeSpeed <= 0;
				end
				
				else 
				begin
					// BIRD POSITIONING LOGIC 
					if(PositiveSpeed > 0 && NegativeSpeed == 0)
					begin
						Bird_Y_T <= Bird_Y_T - PositiveSpeed; // minus because Y should become smaller for bird to rise
						Bird_Y_B <= Bird_Y_B - PositiveSpeed; 
						// if bird rises too much
						if(Bird_Y_T > PositiveSpeed || Bird_Y_B > PositiveSpeed)
						begin
							Bird_Y_T <= 10'd0;
							Bird_Y_B <= 10'd20;
						end
					end
					else if(NegativeSpeed > 0 && PositiveSpeed == 0)
					begin
						Bird_Y_T <= Bird_Y_T + NegativeSpeed;
						Bird_Y_B <= Bird_Y_B + NegativeSpeed;
						// going off bottom of screen
						if((Bird_Y_T + NegativeSpeed) > 480 || (Bird_Y_B + NegativeSpeed) > 480)
						begin
							Bird_Y_T <= 10'd460;
							Bird_Y_B <= 10'd480;
						end
					end
					
					// VELOCITY LOGIC 
						pos_temp = PositiveSpeed - 10'd9; // temp
						
					// if the bird is not yet falling, but is about to start falling
					// positivespeed = 0 (no longer flying up) and negativespeed gets a value (bird starts falling)
					if(PositiveSpeed < (pos_temp)) // minus because rising slower and slower
							//&& NegativeSpeed == 0)
					begin
						PositiveSpeed <= 0;
						NegativeSpeed <= 10'd9 - PositiveSpeed; 
					end
					else
					begin
						PositiveSpeed <= pos_temp;
						NegativeSpeed <=0;
					end
					// bird is already falling
					if(PositiveSpeed == 0)//&& NegativeSpeed > 0)
					begin
						NegativeSpeed <= NegativeSpeed + 10'd9; // plus because falling faster and faster, gravity
						if((NegativeSpeed) > 10'd300)
							NegativeSpeed <= 10'd300; // terminal velocity sort of
					end
				end
			end	
			
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

endmodule
