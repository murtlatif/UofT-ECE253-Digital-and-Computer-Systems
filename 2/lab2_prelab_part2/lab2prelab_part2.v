module lab2prelab_part2 (SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire X;
	wire Y;
	wire s;
	wire M;
	assign X = SW[3:0];
	assign Y = SW[7:4];
	assign s = SW[9];
	assign M = s ? X : Y;
	
	assign LEDR = M;
endmodule

