module datapath(

		input
		logic  LD_PC, LD_IR, LD_MAR, LD_MDR, GateALU, GatePC, GateMARMUX, GateMDR, Reset_ah, Clk,
		input
		logic [1:0] PCMUX, ADDR2MUX, ALUK,
		output
		logic [15:0]IR, PC, MAR, MDR
		);


		logic [15:0]  BUS, PCin, PCand1, MDRin, ALUout, ADDERout;
		
		
		reg_16 PC1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_PC), .D(PCin), .Data_Out(PC));
		reg_16 IR1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_IR), .D(BUS), .Data_Out(IR));
		reg_16 MDR1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_MDR), .D(MDRin), .Data_Out(MDR));
		reg_16 MAR1 (.Clk(Clk), .Reset(Reset_ah), .Load(LD_MAR), .D(BUS), .Data_Out(MAR));
		
		always_ff @(posedge Clk)
			begin
			
				PCand1 = PC + 1;
				
			end
		
		MUX_BUS B1 (.A(ALUout), .B(PC), .C(MAR), .D(MDR), .GateALU(GateALU), .GatePC(GatePC), .GateMARMUX(GateMARMUX), .GateMDR(GateMDR), .Z(BUS));
		MUX_64to16 PCMUX1 (.A(BUS), .B(ADDERout), .C(PCand1), .D(16'bzzzzzzzzzzzzzzzz), .S(PCMUX));
		
		endmodule
