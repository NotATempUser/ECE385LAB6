module MUX_32to16 (input logic [15:0] A,B,
		  input logic S,
		  output logic [15:0] Z);
		  
	always_comb		//another generic mux for data control
	begin
	case (S)
		1'b0		: Z = A;
		1'b1		: Z = B;
	endcase
	end
	
endmodule
