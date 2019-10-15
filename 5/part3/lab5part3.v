module lab5part3(SW, HEX0, HEX1, KEY0);
	input [9:0] SW;
	input KEY0;
	
	output [6:0] HEX0, HEX1;
	
	wire [7:0] Count;
	
	t_flipflop(SW[1], KEY0, SW[0], Count[0]);
	t_flipflop(SW[1] & Count[0], KEY0, SW[0], Count[1]);
	t_flipflop(SW[1] & Count[0] & Count[1], KEY0, SW[0], Count[2]); 
	t_flipflop(SW[1] & Count[0] & Count[1] & Count[2], KEY0, SW[0], Count[3]);
	t_flipflop(SW[1] & Count[0] & Count[1] & Count[2] & Count[3], KEY0, SW[0], Count[4]);
	t_flipflop(SW[1] & Count[0] & Count[1] & Count[2] & Count[3] & Count[4], KEY0, SW[0], Count[5]);
	t_flipflop(SW[1] & Count[0] & Count[1] & Count[2] & Count[3] & Count[4] & Count[5], KEY0, SW[0], Count[6]);
	t_flipflop(SW[1] & Count[0] & Count[1] & Count[2] & Count[3] & Count[4] & Count[5] & Count[6] , KEY0, SW[0], Count[7]);
	
	numberDisplay(HEX1, HEX0, Count);
	
endmodule


module t_flipflop(T, Clk, Clr, Q);
	input T;
	input Clk, Clr;
	output reg Q;
	
	always@(posedge Clk, negedge Clr)
    begin
        if(~Clr)
            Q <= 1'b0;
        else
            Q <= Q ^ T;
    end

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
	assign Display[6] = ((~c[3] & ~c[2] & ~c[1]) | (~c[3] & c[2] & c[1] & c[0]) | (c[3] & c[2] & ~c[1] & ~c[0]));

endmodule