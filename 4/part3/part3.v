module part3(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire [3:0] A, B;
	wire cin, c1, c2, c3;
	
	assign A = SW[7:4];
	assign B = SW[3:0];
	assign cin = SW[8];
	
	full_adder out1(A[0], B[0], cin, c1, LEDR[0]);
	full_adder out2(A[1], B[1], c1, c2, LEDR[1]);
	full_adder out3(A[2], B[2], c2, c3, LEDR[2]);
	full_adder out4(A[3], B[3], c3, LEDR[4], LEDR[3]);
	
endmodule

module full_adder(a, b, cin, cout, s);
	input a, b, cin;
	output s, cout;
	
	assign s = cin ^ (a ^ b);
	assign cout = (~(a ^ b) & b) | ((a ^ b) & cin);	
	
endmodule