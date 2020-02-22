module MUX_BUS (input logic [15:0] A,B,C,D,
		  input logic GateALU, GatePC,GateMARMUX,GateMDR,
		  output logic [15:0] Z)
		  
	always_comb
	begin
	logic [3,0] S;
	s = {GateALU, GatePC,GateMARMUX, GATEMDR};
	case (S)
		4'b1000		: Z = A;			//Passs GateALU
		4'b0100		: Z = B;			//Pass GatePC
		4'b0010		: Z = C;			//Pass GateMARMUX
		4'b0001		: Z = D;			//Pass GateMDR
		default	: Z = 4'bZZZZ;		// Else set to high impedence
		;
	end

endmodule
