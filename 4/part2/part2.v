module part2(SW, HEX0, HEX1);
	input [9:0] SW;
	output [6:0] HEX0, HEX1;
	
	wire [3:0] V, A, M;
	wire z;
	
	assign V = SW[3:0];
	
	comparator OUT1(V, z);
	convertV OUT2(V, A);
	fourBitMult OUT3(V, A, z, M);
	displayNum OUT4(M, HEX0);
	
	assign HEX1[0] = z;
	assign HEX1[1] = 1'b0;
	assign HEX1[2] = 1'b0;
	assign HEX1[3] = z;
	assign HEX1[4] = z;
	assign HEX1[5] = z;
	assign HEX1[6] = 1'b1;
	
endmodule

module comparator(X, Z);

	input [3:0] X;
	output Z;	
	assign Z = (X[3] & X[2]) | (X[3] & X[1]);
	
endmodule

module convertV(V, A);

	input [3:0] V;
	output [3:0] A;
	
	assign A[3] = 0;
	assign A[2] = V[2] & V[1];
	assign A[1] = ~V[1];
	assign A[0] = V[0];
	
endmodule

module fourBitMult(V, A, z, M);
	// input V, A, switch Z, output M
	input [3:0] V, A;
	input z;
	output [3:0] M;
	
	assign M[0] = (~z & V[0]) | (z & A[0]);
	assign M[1] = (~z & V[1]) | (z & A[1]);
	assign M[2] = (~z & V[2]) | (z & A[2]);
	assign M[3] = (~z & V[3]) | (z & A[3]);
	
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

