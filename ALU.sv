module ALU(input logic [1:0] ALUK,
			  input logic [15:0] IR, SR1,SR2,
			  input logic SR2MUX,
			  output logic [15:0] OUT);
			  
		logic [15:0] B;
			  
	// (00 ADD)(01 AND)(11 NOT)
	always_comb
	begin
		
	
		case (SR2MUX)										
			default	: B = SR2 ;
			1'b1		: B = { {11{IR[4]}}, IR[4:0]};
		endcase
	
		case (ALUK)
			2'b00			: OUT=SR1+B;
			2'b01			: OUT=SR1&B;
			2'b11			: OUT=~SR1;
			default		: OUT=SR1;
		endcase


	end

endmodule
