module MUX_BUS (input logic [15:0] A,B,C,D,
		  input logic GateALU, GatePC,GateMARMUX,GateMDR,
		  output logic [15:0] Z);
		  
	always_comb			//used to impiment effecgtivly a tristate buffer for the bus
	begin
	logic [3:0] S;
	S[0] = GateALU;
	S[1] = GatePC;
	S[2] = GateMARMUX;
	S[3] = GateMDR;
		case (S)
			default			: Z = 16'bzzzzzzzzzzzzzzzz;		// Else set to high impedence
			4'b0001			: Z = A;				//Passs GateALU
			4'b0010			: Z = B;				//Pass GatePC
			4'b0100			: Z = C;				//Pass GateMARMUX
			4'b1000			: Z = D;				//Pass GateMDR
			
		endcase
	end

endmodule
