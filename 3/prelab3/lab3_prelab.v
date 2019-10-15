module lab3_prelab_part4(SW, HEX0);
	input [4:0] SW;
	output [6:0] HEX0;
	
	wire c0, c1;
	assign c0 = SW[0];
	assign c1 = SW[1];
	
	assign HEX0[0] = (c0 & ~c1);
	assign HEX0[1] = (~c0);
	assign HEX0[2] = (~c0);
	assign HEX0[3] = (~c1);
	assign HEX0[4] = (~c1);
	assign HEX0[5] = (c0 & ~c1);
	assign HEX0[6] = (~c1);
	
endmodule


module lab3_prelab(SW, LEDR, HEX0, HEX1, HEX2);

	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0, HEX1, HEX2;
	
	wire [1:0] M0, M1, M2, M3;
	
	mux_2bit_3to1 U0 (SW[9:8], SW[5:4], SW[3:2], SW[1:0], M0);
	mux_2bit_3to1 U1 (SW[9:8], SW[3:2], SW[1:0], SW[5:4], M1);
	mux_2bit_3to1 U2 (SW[9:8], SW[1:0], SW[5:4], SW[3:2], M2);
	mux_2bit_3to1 U3 (SW[9:8], SW[5:4], SW[3:2], SW[1:0], M3);
	
	char_7seg H0 (M0, HEX0);
	char_7seg H1 (M1, HEX1);
	char_7seg H2 (M2, HEX2);
	char_7seg H3 (M3, HEX3);

endmodule
	

module char_7seg(C, Display);
	input [1:0] C;
	output [0:6] Display;
	
	assign Display[0] = (C[0] & ~C[1]);
	assign Display[1] = (~C[0]);
	assign Display[2] = (~C[0]);
	assign Display[3] = (~C[1]);
	assign Display[4] = (~C[1]);
	assign Display[5] = (C[0] & ~C[1]);
	assign Display[6] = (~C[1]);
	
endmodule
	
module mux_2bit_3to1(S, U, V, W, M);

	input [1:0] S, U, V, W;
	output [1:0] M;
	
	assign M[0] = (~S[0] & ~S[1] & U[0]) | (S[0] & ~S[1] & V[0]) | (S[1] & W[0]);
	assign M[1] = (~S[0] & ~S[1] & U[1]) | (S[0] & ~S[1] & V[1]) | (S[1] & W[1]);
	
endmodule
