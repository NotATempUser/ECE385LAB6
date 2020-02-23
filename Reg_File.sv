module Reg_File (input logic SR1, DR, LD.REG, Clk, Reset,
					  input logic [2:0] SR2,
					  input logic [15,0] IR, BUS,
					  output logic [15,0] SR1_OUT, SR2_OUT);
	
	logic DR_Select, SR1_Select;
	logic [7:0] LD;
	
	
//need control logic/mux to pick a desitination regster
	always_comb
		case(DR)
		1'b0		: DR_Select = IR[11:9];
		default	: DR_Select = 3'b111;
		endcase
		
		
		case(SR1)
		1'b0		: SR1_Select = IR[8:6];
		default	: SR1_Select = IR[11:9];
		endcase
		
		
		if(LD.REG)
			case(DR_Select)
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
		end
		
	end
	
	
// 	Declaring the 8 main registers	
	reg_16 R0(.*, .Load(LD[0]), .D(BUS), .Data_Out(A));
	reg_16 R1(.*, .Load(LD[1]), .D(BUS), .Data_Out(A));
	reg_16 R2(.*, .Load(LD[2]), .D(BUS), .Data_Out(A));
	reg_16 R3(.*, .Load(LD[3]), .D(BUS), .Data_Out(A));
	reg_16 R4(.*, .Load(LD[4]), .D(BUS), .Data_Out(A));
	reg_16 R5(.*, .Load(LD[5]), .D(BUS), .Data_Out(A));
	reg_16 R6(.*, .Load(LD[6]), .D(BUS), .Data_Out(A));
	reg_16 R7(.*, .Load(LD[7]), .D(BUS), .Data_Out(A));
	
	
endmodule
