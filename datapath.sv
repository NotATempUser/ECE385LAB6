module datapath(

		input
		logic  LD_PC, LD_IR, LD_MAR, LD_MDR, LD_BEN, LD_CC, GateALU, GatePC, GateMARMUX, GateMDR, Reset_ah, Clk, ADDR1MUX, MIO_EN, BEN,LD_REG,SR1MUX,DRMUX,
		input
		logic [1:0] PCMUX, ADDR2MUX, ALUK,
		input
		logic [15:0] MDR_In,
		output
		logic [15:0]IR, PC, MAR, MDR
		);


		logic [15:0]  BUS, PCin, PCand1, MDRin, ALUout, ADDERout, ADDERin1, ADDERin2, SR1_OUT, MDR_INT, SR2MUX, SR2_OUT;	//making DRMUX input
		logic [15:0]  SEXT11;
		logic [15:0]  SEXT9;
		logic [15:0]  SEXT6;
		logic N, Z, P, N_out, Z_out, P_out, BEN_in;
		
		
		reg_16 PC1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_PC), .D(PCin), .Data_Out(PC));
		reg_16 IR1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_IR), .D(BUS), .Data_Out(IR));
		reg_16 MDR1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_MDR), .D(MDR_INT), .Data_Out(MDR));
		reg_16 MAR1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_MAR), .D(BUS), .Data_Out(MAR));
		
		always_ff @(posedge Clk)
			begin
			
				PCand1 = PC + 1;
				
			end
		
		MUX_BUS B1 (.A(ALUout), .B(PC), .C(MAR), .D(MDR), .GateALU(GateALU), .GatePC(GatePC), .GateMARMUX(GateMARMUX), .GateMDR(GateMDR), .Z(BUS));
		MUX_64to16 PCMUX1 (.A(BUS), .B(ADDERout), .C(PCand1), .D(16'bzzzzzzzzzzzzzzzz), .S(PCMUX), .Z(PCin));															//look at case of high Z out, most likly doesnt occur
		MUX_64to16 ADDR2MUX1 (.A(SEXT11), .B(SEXT9), .C(SEXT6), .D(16'b0000000000000000), .S(ADDR2MUX), .Z(ADDERin1));
		MUX_32to16 ADDR1MUX1 (.A(SR1_OUT), .B(PC), .S(ADDR1MUX), .Z(ADDERin2));
		Reg_File Reg1 (.SR1(SR1MUX), .DR(DRMUX), .LD_REG(LD_REG), .Clk(Clk), .Reset(Reset_ah), .SR2(IR[2:0]), .IR(IR), .BUS(BUS), .SR1_OUT(SR1_OUT), .SR2_OUT(SR2_OUT));		
		ALU ALU1 (.ALUK(ALUK), .IR(IR), .SR1(SR1_OUT), .SR2(SR2_OUT), .SR2MUX(SR2MUX), .OUT(ALUout));
		
		MUX_32to16 MIO_EN1 (.A(BUS), .B(MDR_In), .S(MIO_EN), .Z(MDR_INT));
		
		reg_1 N1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_CC), .D(N), .Data_Out(N_out));
		reg_1 Z1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_CC), .D(Z), .Data_Out(Z_out));
		reg_1 P1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_CC), .D(P), .Data_Out(P_out));
		
		reg_1 BEN1( .Clk(Clk), .Reset(Reset_ah), .Load(LD_BEN), .D(BEN_in), .Data_Out(BEN));
		
	assign BEN_in = IR[11] & N_out + IR[10] & Z_out + IR[9] & P_out;
		
		always_comb
			begin
			
				SEXT11 = { {5{IR[10]}}, IR[10:0]};					// { {10{IR[5]}}, IR[5:0]} Same implication as the ALU
		
				SEXT9 =  { {7{IR[8]}}, IR[8:0]};
		
				SEXT6 =  { {10{IR[5]}}, IR[5:0]};
				
				ADDERout = ADDERin1 + ADDERin2;
				
		//		BEN_in = IR[11] & N_out + IR[10] & Z_out + IR[9] & P_out;
				
				if(BUS == 16'b0000000000000000)
					Z = 1'b1;
				else
					Z = 1'b0;
		
				N = BUS[15];
				P = !BUS[15] & !Z;
		
			end 
		
		endmodule
