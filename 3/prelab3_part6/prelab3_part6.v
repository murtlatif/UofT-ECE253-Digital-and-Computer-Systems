module prelab3_part6(SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [9:0] SW;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire [1:0] M0, M1, M2, M3, M4, M5;
	
	mux_2bit_6to1 U5 (SW[9:7], 3, 3, 3, SW[5:4], SW[3:2], SW[1:0], M5);
	mux_2bit_6to1 U4 (SW[9:7], 3, 3, SW[5:4], SW[3:2], SW[1:0], 3, M4);
	mux_2bit_6to1 U3 (SW[9:7], 3, SW[5:4], SW[3:2], SW[1:0], 3, 3, M3);
	mux_2bit_6to1 U2 (SW[9:7], SW[5:4], SW[3:2], SW[1:0], 3, 3, 3, M2);
	mux_2bit_6to1 U1 (SW[9:7], SW[3:2], SW[1:0], 3, 3, 3, SW[5:4], M1);
	mux_2bit_6to1 U0 (SW[9:7], SW[1:0], 3, 3, 3, SW[5:4], SW[3:2], M0);
	
	char_7seg H5 (M5, HEX5);
	char_7seg H4 (M4, HEX4);
	char_7seg H3 (M3, HEX3);
	char_7seg H2 (M2, HEX2);
	char_7seg H1 (M1, HEX1);
	char_7seg H0 (M0, HEX0);
	
endmodule

module char_7seg(C, Display);
	input [1:0] C;
	output [6:0] Display;
	
	assign Display[0] = ~(C[0] & ~C[1]);
	assign Display[1] = ~(~C[0]);
	assign Display[2] = ~(~C[0]);
	assign Display[3] = ~(~C[1]);
	assign Display[4] = ~(~C[1]);
	assign Display[5] = ~(C[0] & ~C[1]);
	assign Display[6] = ~(~C[1]);
	
endmodule

module mux_2bit_6to1(S, A, B, C, D, E, F, M);
	input [2:0] S;
	input [1:0] U, V, W;
	output [1:0] M;
	
	assign M[0] = (~S[0] & ~S[1] & ~S[2] & A[0]) | (~S[0] & ~S[1] & S[2] & B[0]) | (~S[0] & S[1] & ~S[2] & C[0]) | (~S[0] & S[1] & S[2] & D[0]) | (S[0] & ~S[1] & ~S[2] & E[0]) | (S[0] & ~S[1] & S[2] & F[0]);
	assign M[1] = (~S[0] & ~S[1] & ~S[2] & A[1]) | (~S[0] & ~S[1] & S[2] & B[1]) | (~S[0] & S[1] & ~S[2] & C[1]) | (~S[0] & S[1] & S[2] & D[1]) | (S[0] & ~S[1] & ~S[2] & E[1]) | (S[0] & ~S[1] & S[2] & F[1]);
	
endmodule


module mux_2bit_3to1(S, U, V, W, M);

	input [1:0] S, U, V, W;
	output [1:0] M;
	
	assign M[0] = (~S[0] & ~S[1] & U[0]) | (S[0] & ~S[1] & V[0]) | (S[1] & W[0]);
	assign M[1] = (~S[0] & ~S[1] & U[1]) | (S[0] & ~S[1] & V[1]) | (S[1] & W[1]);
	
endmodule