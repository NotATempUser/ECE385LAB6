module MUX_BUS (input logic [15:0] A,B,C,D,
		  input logic GateALU, GatePC,GateMARMUX,GateMDR,
		  output logic [15:0] Z);
		  
	always_comb
	begin
	logic [3:0] S;
	S = {GateALU, GatePC,GateMARMUX, GateMDR};
		case (S)
	
			GateALU			: Z = A;				//Passs GateALU
			GatePC			: Z = B;				//Pass GatePC
			GateMARMUX		: Z = C;				//Pass GateMARMUX
			GateMDR			: Z = D;				//Pass GateMDR
			default			: Z = 4'bZZZZ;		// Else set to high impedence
		endcase
	end

endmodule
