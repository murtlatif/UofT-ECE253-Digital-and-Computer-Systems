//module part1(D, Clock, Qa, Qb, Qc);
//	input D, Clock;
//	output reg Qa, Qb, Qc;
//	
//	always @ (Clock, D)
//	begin
//		if (Clock)
//			Qa <= D;
//	end
//	
//	always @ (posedge Clock)
//		Qb <= D;
//	
//	always @ (negedge Clock)
//		Qc <= D;
//	
//endmodule


module part1(D, Clock, Qa, Qb, Qc);
	input D, Clock;
	output Qa, Qb, Qc;
	
	gated_D_latch(D, Clock, Qa);
	pos_edge_d_flipflop(D, Clock, Qb);
	neg_edge_d_flipflop(D, Clock, Qc);
	
endmodule

// D Latch
module gated_D_latch(D, Clk, Q);
	input D, Clk;
	output reg Q;
	
	always @(D, Clk)
		if(Clk == 1'b1)
			Q = D;
			

endmodule
	
// Positive Edge Triggered D Flip Flop
module pos_edge_d_flipflop(D, Clock, Q);
	input D, Clock;
	output reg Q;
	
	always @ (posedge Clock)
		Q <= D;
		
endmodule

// Negative Edge Triggered D Flip Flop
module neg_edge_d_flipflop(D, Clock, Q);
	input D, Clock;
	output reg Q;
	
	always @ (negedge Clock)
		Q <= D;
		
endmodule

