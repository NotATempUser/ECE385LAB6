module Reg_File (input logic SR1, DR, LD_REG, Clk, Reset,		//NOTE: Reset and LD_REG Are active high for this module
					  input logic [2:0] SR2,
					  input logic [15:0] IR, BUS,
					  output logic [15:0] SR1_OUT, SR2_OUT);
	
	logic [3:0] DR_Select, SR1_Select;
	logic [7:0] LD;
	logic [15:0] A,B,C,D,E,F,G,H;
	
	
//need control logic/mux to pick a desitination regster
	always_comb
	begin
		case (DR)										//DRMUX
		1'b0		: DR_Select = IR[11:9];
		default	: DR_Select = 3'b111;
		endcase
		
		
		case (SR1)										//SR1MUX
		1'b0		: SR1_Select = IR[8:6];
		default	: SR1_Select = IR[11:9];
		endcase
		
		
		if(LD_REG)										// Load funtionality of Reg file
			case(DR_Select)							// selects which register to save to
			3'b000		: LD=8'b00000001;
			3'b001		: LD=8'b00000010;
			3'b010		: LD=8'b00000100;
			3'b011		: LD=8'b00001000;
			3'b100		: LD=8'b00010000;
			3'b101		: LD=8'b00100000;
			3'b110		: LD=8'b01000000;
			default		: LD=8'b10000000;
		
			endcase
		else
			begin
				LD=8'b00000000;
			end
	
		case (SR1_Select)								// Selecting which register to read from for sr1 output
			3'b000		: SR1_OUT=A;
			3'b001		: SR1_OUT=B;
			3'b010		: SR1_OUT=C;
			3'b011		: SR1_OUT=D;
			3'b100		: SR1_OUT=E;
			3'b101		: SR1_OUT=F;
			3'b110		: SR1_OUT=G;
			default		: SR1_OUT=H;
		
		endcase
		
		case (SR2)										// Selecting which register to read from for sr2 output
			3'b000		: SR2_OUT=A;
			3'b001		: SR2_OUT=B;
			3'b010		: SR2_OUT=C;
			3'b011		: SR2_OUT=D;
			3'b100		: SR2_OUT=E;
			3'b101		: SR2_OUT=F;
			3'b110		: SR2_OUT=G;
			default		: SR2_OUT=H;
		
		endcase
		
		
	end
	
	
// 	Declaring the 8 main registers	
	reg_16 R0(.*, .Load(LD[0]), .D(BUS), .Data_Out(A));
	reg_16 R1(.*, .Load(LD[1]), .D(BUS), .Data_Out(B));
	reg_16 R2(.*, .Load(LD[2]), .D(BUS), .Data_Out(C));
	reg_16 R3(.*, .Load(LD[3]), .D(BUS), .Data_Out(D));
	reg_16 R4(.*, .Load(LD[4]), .D(BUS), .Data_Out(E));
	reg_16 R5(.*, .Load(LD[5]), .D(BUS), .Data_Out(F));
	reg_16 R6(.*, .Load(LD[6]), .D(BUS), .Data_Out(G));
	reg_16 R7(.*, .Load(LD[7]), .D(BUS), .Data_Out(H));
	
	
endmodule
