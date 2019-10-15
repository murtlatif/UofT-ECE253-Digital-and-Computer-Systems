module part2(SW, KEY, LEDR);

	input [9:0] SW;
	output [9:0] LEDR;
	input [1:0] KEY;
	wire resetn, w;
	assign resetn = SW[0];
	assign w = SW[1];
	parameter A = 4'b 0000;
	parameter B = 4'b 0001;
	parameter C = 4'b 0010;
	parameter D = 4'b 0011;
	parameter E = 4'b 0100;
	parameter F = 4'b 0101;
	parameter G = 4'b 0110;
	parameter H = 4'b 0111;
	parameter I = 4'b 1000;
	reg[3:0] ps, ns;
	reg z;
	
// y_Q represents current state was presented by ps, Y_D represents next state - ns
	always@(*)
		begin
			case (ps)
				A:if(!w) ns = B;
				  else ns = F;
				B:if(!w) ns = C;
				  else ns = F;
				C:if(!w) ns = D;
				  else ns = F;
				D:if(!w) ns = E;
				  else ns = F;
				E:if(!w) ns = E;
				  else ns = F;
				F:if(!w) ns = B;
				  else ns = G;
				G:if(!w) ns = B;
				  else ns = H;
				H:if(!w) ns = B;
				  else ns = I;
				I:if(!w) ns = B;
				  else ns = I;
			   default: ns = 4'bxxxx;
			endcase
		end
		
	always@(posedge KEY[0] or negedge resetn)
	
		if (!resetn) ps<=A;
		else ps<=ns;
		
	always@(*)
		if((ps==E)|(ps==I)) z = 1'b 1;
		else z = 1'b 0;
		
	assign LEDR[9] = z;
	assign LEDR[3:0] = ps;
	assign LEDR[7:4] = ns;
	
endmodule