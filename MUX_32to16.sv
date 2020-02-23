module MUX_32to16 (input logic [15:0] A,B,
		  input logic S,
		  output logic [15:0] Z);
		  
	always_comb
	begin
	case (S)
		1'b0		: Z = A;
		default	: Z = B;
	end

endmodule
