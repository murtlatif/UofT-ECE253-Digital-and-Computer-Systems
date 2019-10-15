module part4(SW, LEDR, HEX0, HEX1, HEX3, HEX5);
	input [9:0] SW;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX3, HEX5;
	
	wire [4:0] V;
	wire [3:0] X, Y, A, M;
	wire cin, z, errorX, errorY;
	
	assign X = SW[7:4];
	assign Y = SW[3:0];
	assign cin = SW[8];
	
	fourbit_full_adder out1(X, Y, cin, V);
	fourbit_full_adder out2(X, Y, cin, LEDR[4:0]);
	
	comparator out3(V, z);
	convertV out4(V, A);
	fiveBitMult out5(V, A, z, M);
	displayNum out6(M, HEX0);
	
	assign HEX1[0] = z;
	assign HEX1[1] = 1'b0;
	assign HEX1[2] = 1'b0;
	assign HEX1[3] = z;
	assign HEX1[4] = z;
	assign HEX1[5] = z;
	assign HEX1[6] = 1'b1;

	displayNum out7(X, HEX5);
	displayNum out8(Y, HEX3);
	
	fourbit_comparator out9(X, errorX);
	fourbit_comparator out10(Y, errorY);
	
	assign LEDR[9] = errorX | errorY;
	
endmodule

module onebit_full_adder(x, y, cin, cout, s);
	input x, y, cin;
	output s, cout;
	
	assign s = cin ^ (x ^ y);
	assign cout = (~(x ^ y) & y) | ((x ^ y) & cin);	
	
endmodule

module fourbit_full_adder(X, Y, cin, M);
	input [3:0] X, Y, cin;
	output [4:0] M;
	wire c1, c2, c3;
	
	onebit_full_adder out1(X[0], Y[0], cin, c1, M[0]);
	onebit_full_adder out2(X[1], Y[1], c1, c2, M[1]);
	onebit_full_adder out3(X[2], Y[2], c2, c3, M[2]);
	onebit_full_adder out4(X[3], Y[3], c3, M[4], M[3]);
	
endmodule

module comparator(X, Z);

	input [4:0] X;
	output Z;	
	assign Z = X[4] | (X[3] & X[2]) | (X[3] & X[1]);
	
endmodule

module fourbit_comparator(X, Z);

	input [3:0] X;
	output Z;
	assign Z = (X[3] & X[2]) | (X[3] & X[1]);
	
endmodule

module convertV(V, A);

	input [4:0] V;
	output [3:0] A;

	assign A[3] = V[4] & V[1];
	assign A[2] = (V[3] & V[2] & V[1]) | (V[4] & ~V[1]);
	assign A[1] = ~V[1];
	assign A[0] = V[0];
	
endmodule

module displayNum(num, Display);

	input [3:0] num;
	output [6:0] Display;
	assign Display[0] = (~num[3] & ~num[1]) & ((~num[2] & num[0]) + (num[2] & ~num[0]));
	assign Display[1] = (~num[3] & num[2]) & (num[2] & ~num[0] | ~num[1] & num[0]);
	assign Display[2] = (~num[3] & ~num[2] & num[1] & ~num[0]);
	assign Display[3] = (~num[2] & ~num[1] & num[0]) | ((~num[3] & num[2]) & (~num[1] & ~num[0] | num[1] & num[0]));
	assign Display[4] = (~num[3] & num[0]) | (~num[3] & num[2] & ~num[1]) | (~num[2] & ~num[1] & num[0]);
	assign Display[5] = (~num[3]) & (~num[2] & num[0] | ~num[2] & num[1] | num[1] & num[0]);
	assign Display[6] = (~num[3]) & (~num[2] & ~num[1] | num[2] & num[1] & num[0]);
	
endmodule

module fiveBitMult(V, A, z, M);
	// input V, A, switch z, output M
	input [4:0] V;
	input [3:0] A;
	input z;
	output [3:0] M;
	
	assign M[0] = (~z & V[0]) | (z & A[0]);
	assign M[1] = (~z & V[1]) | (z & A[1]);
	assign M[2] = (~z & V[2]) | (z & A[2]);
	assign M[3] = (~z & V[3]) | (z & A[3]);
	
endmodule
