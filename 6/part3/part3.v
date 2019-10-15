module part3(CLOCK_50,SW, KEY, LEDR);
	input CLOCK_50;
	input [3:0] KEY;
	input [9:0] SW; //[2:0]
	output [0:0] LEDR;
	
	wire f, E, Ln, z, bit0;
	half_sec_clock U0 (CLOCK_50,f, KEY[0]);
	ShiftReg4 U1 (SW[2:0],Ln, E, f,bit0, KEY[0]);
	DownCount U3 (SW[2:0],E,Ln, f, z, KEY[0]);
	MorseCode_FSM U4 (KEY[1:0], z, bit0, f, LEDR[0], E, Ln);
	
endmodule
	
	
module half_sec_clock(Clock, f, ResetN);
	input Clock, ResetN;
	output reg f;
	reg [0:24] z;

	always @ (posedge Clock, negedge ResetN)
	begin
		if (!ResetN)
			z <= 25'b0;
		else if (z == 1)  //25000000
		begin
			f <= 1'b1;
			z <= 25'b0;
		end
		else 
		begin	
			f <= 1'b0;
			z <= z + 1;
		end
	end
endmodule

module muxdff(D0, D1, Sel , E, Clock, Q, ResetN);
	input D0, D1, Sel, Clock,E,ResetN;
	output reg Q;
	wire D;
	assign D = Sel ? D1 : D0;
	always @ (posedge Clock, negedge ResetN)
	begin
		if (!ResetN)
			Q <= 1'b0;
		else if (E)
			Q <= D;
	end
endmodule 

module ShiftReg4(S, Ln, E, Clock, bit0, K); //KEY[0] //D is value of mc
	input Ln, Clock, K,E;
	input [2:0] S;
	output bit0;
	reg [0:3] D;
	wire [0:3] Q;
	always @ (S[2:0])
		if (S[2:0] == 3'b000)
			D = 4'b0010;
		else if (S[2:0] == 3'b001)
			D = 4'b0001;
		else if (S[2:0] == 3'b010)
			D = 4'b0101;
		else if (S[2:0] == 3'b011)
			D = 4'b0001;
		else if (S[2:0] == 3'b100)
			D = 4'b0000;
		else if (S[2:0] == 3'b101)
			D = 4'b0100;
		else if (S[2:0] == 3'b110)
			D = 4'b0011;
		else if (S[2:0] == 3'b111)
			D = 4'b0000;

	muxdff U0 (D[0], 1'b0, Ln, E, Clock, Q[0], K);
	muxdff U1 (D[1], Q[0], Ln, E, Clock, Q[1], K);
	muxdff U2 (D[2], Q[1], Ln, E, Clock, Q[2], K);
	muxdff U3 (D[3], Q[2], Ln, E, Clock, Q[3], K);
	assign bit0 = Q[3];
endmodule 

module DownCount (S,E, Ln, Clock, z,ResetN); //D is length of morse code
	input [2:0] S;
	input E, Ln, Clock,ResetN;
	output reg z;
	reg [2:0] D, Q;
	always @ (S[2:0])
	begin
		if (S[2:0] == 3'b000)
			D = 2;
		else if (S[2:0] == 3'b001)
			D = 4;
		else if (S[2:0] == 3'b010)
			D = 4;
		else if (S[2:0] == 3'b011)
			D = 3;
		else if (S[2:0] == 3'b100)
			D = 1;
		else if (S[2:0] == 3'b101)
			D = 4;
		else if (S[2:0] == 3'b110)
			D = 3;
		else if (S[2:0] == 3'b111)
			D = 4;
	end
// Up-Counter
	always @ (posedge Clock, negedge ResetN)
	begin
		z = (Q == D);
		if (!ResetN)
			Q <= 1'b0;
		else if (E & Ln)
			Q <= Q + 1;
	end


/*always @ (posedge Clock, negedge ResetN)
	begin
		z = (Q == 0);
		if (!ResetN)
			Q <= D;
		else if (E & Ln)
			Q <= Q - 1;
	end
	*/
// Down-Counter

endmodule 


module MorseCode_FSM(K, z, bit0, half_sec, LEDR, E, Ln);
	input [1:0] K;
	input z, bit0, half_sec;
	output [0:0] LEDR;
	output E, Ln;

	reg [2:0] y, Y;
 
	parameter Idle  = 3'b000;
	parameter Load = 3'b001;
	parameter Dot1 = 3'b010;
	parameter Dash1 = 3'b011;
	parameter Dash2 = 3'b100;
	parameter Dash3 = 3'b101;
	parameter Blank = 3'b110;
	parameter Done = 3'b111;

	always @ (z, bit0, K[1],y)
	begin
		case(y)
			Idle: if (!K[1]) Y = Load;
				else Y = Idle;
			Load: if (z) Y = Done;
					else if (bit0 == 1'b0) Y = Dot1;
					else Y = Dash1;
				
			Dot1: Y = Blank;
			Dash1: Y = Dash2;
			Dash2: Y = Dash3;
			Dash3: Y = Blank;
			Blank: if (z) Y = Done;
				else if (bit0 == 1'b0) Y = Dot1;
				else Y = Dash1;
			Done: Y = Done;
		endcase
	end

	always @ (posedge half_sec, negedge K[0])
	begin
		if (!K[0])
			y <= Idle;
		else
			y <= Y;
	end


	
	assign E = (y == Dot1 | y == Idle | y == Dash3);
	assign Ln = ~(y == Idle);
	assign LEDR[0] = ( y== Dot1 | y== Dash1 | y== Dash2 | y== Dash3);

endmodule 