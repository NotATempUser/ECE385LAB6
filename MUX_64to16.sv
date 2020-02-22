module MUX_64to16 (input logic [15:0] A,B,C,D,
						 input logic [1:0] S,
						 output logic [15:0] Z)
		  
	always_comb
	begin
	case (S)
		2'b00		: Z = A;
		2'b01		: Z = B;
		2'b10		: Z = C;
		default	: Z = D;
	end

endmodule
