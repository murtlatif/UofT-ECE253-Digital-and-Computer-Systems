module part1(SW, HEX0, HEX1);
	input [9:0] SW;
	output [6:0] HEX0, HEX1;
	
	wire [3:0] c, d;
	assign c = SW[3:0];
	assign d = SW[7:4]; 

	displayNum hex0Display(HEX0, c);
	displayNum hex1Display(HEX1, d);

endmodule

module displayNum(Display, num);

	assign Display[0] = (~num[3] & ~num[1]) & ((~num[2] & num[0]) + (num[2] & ~num[0]));
	assign Display[1] = (~num[3] & num[2]) & (num[2] & ~num[0] | ~num[1] & num[0]);
	assign Display[2] = (~num[3] & ~num[2] & num[1] & ~num[0]);
	assign Display[3] = (~num[2] & ~num[1] & num[0]) | ((~num[3] & num[2]) & (~num[1] & ~num[0] | num[1] & num[0]));
	assign Display[4] = (~num[3] & num[0]) | (~num[3] & num[2] & ~num[1]) | (~num[2] & ~num[1] & num[0]);
	assign Display[5] = (~num[3]) & (~num[2] & num[0] | ~num[2] & num[1] | num[1] & num[0]);
	assign Display[6] = (~num[3]) & (~num[2] & ~num[1] | num[2] & num[1] & num[0]);
	
endmodule