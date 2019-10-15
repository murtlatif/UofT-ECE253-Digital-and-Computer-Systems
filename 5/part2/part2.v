module part2(SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY0, KEY1);
	input [7:0] SW;
	input KEY0, KEY1;
	output [0:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	reg [7:0] A, B;
	reg [8:0] Sum;
	
	always @(posedge KEY1 or negedge KEY0)
		begin
			if (~KEY0)
				begin
					A = 8'b0000_0000;
					B = 8'b0000_0000;
				end
			else
				if (KEY1)
					A = SW;
				else
					B = SW;
			
			Sum = A + B;
		end
	
	
	assign LEDR[0] = Sum[8];
	numberDisplay(HEX3, HEX2, A);
	numberDisplay(HEX1, HEX0, B);
	numberDisplay(HEX5, HEX4, Sum[7:0]);
	
endmodule

module numberDisplay(Display1, Display2, num);
	input [7:0] num;
	output [6:0] Display1, Display2;
	
	hexadecimalDisplay(Display1, num[7:4]);
	hexadecimalDisplay(Display2, num[3:0]);
	
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
	assign Display[6] = ((~c[3] & ~c[2] & ~c[1]) | (~c[3] & c[2] & c[1] & c[0]) | (c[3] & ~c[2] & c[1] & c[0]));

endmodule