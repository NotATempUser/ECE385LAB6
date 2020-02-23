module Reg_File (input logic SR1, DR, LD.REG, Clk, Reset,
					  input logic [2:0] SR2,
					  input logic [15,0] IR, BUS,
					  output logic [15,0] SR1_OUT, SR2_OUT);
	
	
	
	
//need control logic/mux to pick a desitination regster
	always_comb
		case(DR)
		
	
	
	end
	
	
// 	Declaring the 8 main registers	
	reg_16 R0(.*, .Load(LD.REG), .D(BUS), .Data_Out(A));
	reg_16 R1(.*, .Load(LD.REG), .D(BUS), .Data_Out(A));
	reg_16 R2(.*, .Load(LD.REG), .D(BUS), .Data_Out(A));
	reg_16 R3(.*, .Load(LD.REG), .D(BUS), .Data_Out(A));
	reg_16 R4(.*, .Load(LD.REG), .D(BUS), .Data_Out(A));
	reg_16 R5(.*, .Load(LD.REG), .D(BUS), .Data_Out(A));
	reg_16 R6(.*, .Load(LD.REG), .D(BUS), .Data_Out(A));
	reg_16 R7(.*, .Load(LD.REG), .D(BUS), .Data_Out(A));
	
	
endmodule
