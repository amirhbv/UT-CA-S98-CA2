
module Processor(
	input clk,
	input rst
);
	wire setWindow ;
	wire jump ;
	wire mem_write ;
	wire immdSel ;
	wire memOrALU ;
	wire toWrite ;
	wire[6:0] ALUop ;
	wire[3:0] opcode ;
	wire[7:0] func ;
	Datapath dp(
		.clk(clk),
		.rst(rst),
		.setWindow(setWindow),
		.jump(jump),
		.mem_write(mem_write),
		.immdSel(immdSel),
		.memOrALU(memOrALU),
		.toWrite(toWrite),
		.ALUop(ALUop),
		.opcode(opcode),
		.func(func)
	);
	Controller cntrlr(
		.clk(clk),
		.rst(rst),
		.opcode(opcode),
		.func(func),

		.setWindow(setWindow),
		.jump(jump),
		.mem_write(mem_write),
		.immdSel(immdSel),
		.memOrALU(memOrALU),
		.toWrite(toWrite),
		.ALUop(ALUop)
  	);
endmodule
