module part1(SW, KEY0, LEDR);

	/* assignments
	|
	| SW[0] = active-low asynchronous reset
	| SW[1] = input w
	|
	| KEY0 = manual clock input
	|
	| LEDR[9] = output z
	| LEDR[8:0] = flip flop outputs
	|
	*/
	
	input [9:0] SW;
	input KEY0;
	
	output [9:0] LEDR;
	
	wire [8:0] D, Q;
	
	wire W;
	assign W = SW[1];
	
	assign LEDR[8:0] = Q;
	
	flip_flop_with_reset out1(D, Q, KEY0, SW[0]);
	make_state_update out2(Q, W, LEDR[9], D);

endmodule

module flip_flop_with_reset(D, Q, clock, reset);

	input clock, reset;
	input [8:0] D;
	output reg [8:0] Q;
	
	always @ (posedge clock or negedge reset)
		begin
			if (~reset)
				Q <= 9'b000000001;
			else
				Q <= D;
		end

endmodule

module make_state_update(Q, W, Z, Y);

	/* 
	|	Output 1 when four consecutive clock inputs of the same W value.
	|	Overlapping sequences are allowed 
	| 	(e.g. having 9 consecutive clock inputs means Z = 1 from the 4th-9th clock inputs
	*/
	
	input W;
	input [8:0] Q;
	
	output Z;
	output [8:0] Y;
	
	/* States
	|	A/0 = state[0] - Reset State
	|
	|	W = 0 states
	|	B/0 = state[1]
	|	C/0 = state[2]
	|	D/0 = state[3]
	|	E/1 = state[4]
	|	
	|	W = 1 states
	|	F/0 = state[5]
	|	G/0 = state[6]
	|	H/0 = state[7]
	| 	I/1 = state[8]
	*/
	
	assign Y[0] = 0;
	
	// W = 0 states
	assign Y[1] = ~W & (Q[0] | Q[5] | Q[6] | Q[7] | Q[8]);
	assign Y[2] = ~W & (Q[1]);
	assign Y[3] = ~W & (Q[2]);
	assign Y[4] = ~W & (Q[3] | Q[4]);
	
	// W = 1 states
	assign Y[5] = W & (Q[0] | Q[1] | Q[2] | Q[3] | Q[4]);
	assign Y[6] = W & (Q[5]);
	assign Y[7] = W & (Q[6]);
	assign Y[8] = W & (Q[7] | Q[8]);
	
	assign Z = (Q[4] | Q[8]);

endmodule

