module part4(SW, HEX0, HEX1, HEX2, HEX3, KEY0);
	input [9:0] SW;
	input KEY0;
	
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	
	reg [15:0] Count = 0;
	
	
	always @(posedge SW[1] or negedge SW[0])
		begin
			if (~SW[0])
				Count = 16'b0;
			else
				Count = Count + 1'b1;
		end
	
	numberDisplay(HEX0, HEX1, HEX2, HEX3, Count);
	
endmodule
		
		
module numberDisplay(Display1, Display2, Display3, Display4, num);
	input [15:0] num;
	output [6:0] Display1, Display2, Display3, Display4;
	
	hexadecimalDisplay(Display1, num[3:0]);
	hexadecimalDisplay(Display2, num[7:4]);
	hexadecimalDisplay(Display3, num[11:8]);
	hexadecimalDisplay(Display4, num[15:12]);
	
endmodule

module hexadecimalDisplay(Display, c);
	input [3:0] c;
	output [6:0] Display;
	
	assign Display[0] = ((~c[3] & ~c[2] & ~c[1] & c[0]) | (~c[3] & c[2] & ~c[1] & ~c[0]) | (c[3] & ~c[2] & c[1] & c[0]) | (c[3] & c[2] & ~c[1] & c[0]));
	assign Display[1] = ((c[2] & c[1] & ~c[0]) | (c[3] & c[1] & c[0]) | (c[3] & c[2] & ~c[0]) | (~c[3] & c[2] & ~c[1] & c[0]));
	assign Display[2] = ((c[3] & c[2] & ~c[0]) | (c[3] & c[2] &c[1]) | (~c[3] & ~c[2] & c[1] & ~c[0]));
	assign Display[3] = ((~c[2] &~c[1] & c[0]) | (c[2] & c[1] & c[0]) | (~c[3] & c[2] & ~c[1] & ~c[0]) | (c[3] & ~c[2] & c[1] & ~c[0]));
	assign Display[4] = ((~c[3] & c[0]) | (~c[2] & ~c[1] & c[0]) | (~c[3] & c[2] & ~c[1]));
	assign Display[5] = ((~c[3] & ~c[2] & c[0]) | (~c[3] & ~c[2] & c[1]) | (~c[3] & c[1] & c[0]) | (c[3] & c[2] & ~c[1] & c[0]));
	assign Display[6] = ((~c[3] & ~c[2] & ~c[1]) | (~c[3] & c[2] & c[1] & c[0]) | (c[3] & c[2] & ~c[1] & ~c[0]));

endmodule