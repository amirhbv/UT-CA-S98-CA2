`timescale 1ns / 1ns
module Datapath(
	input clk,
	input rst,
	input setWindow,
	input jump,
	input mem_write,
	input immdSel,
	input memOrALU,
	input toWrite,
	input [6:0] ALUop,
	output[3:0] opcode,
	output[7:0] func
);
	//pc
	wire [9:0] PC_in ;
	wire [9:0] PC_out;
	wire [9:0] PC_first ;
	//instruction memory
	wire[15:0] inst_out;
	//memreg
	wire[15:0] data_i ;
	wire[15:0] data_j ;
	wire[15:0] write_data;
	//ALU
	wire equalForBranch;
	wire [15:0] ALUout ;
	wire [15:0] ALUin ;
	//MEMORY
	wire [15:0] read_data;

	ALU alu(
		data_i,
		ALUin,
		ALUop,
		ALUout,
		equalForBranch
	);
	assign ALUin = immdSel ? inst_out[7:0] : data_j ;

	Memory memory(
		.clk(clk),
		.write_enable(mem_write),
		.address(inst_out[9:0]),
		.write_data(data_i),
		.read_data(read_data)
	);

	PC pc(
		.clk(clk),
		.rst(rst),
		.load_in(PC_in),
		.pc_cur(PC_out)
	);

	assign PC_first = equalForBranch ? inst_out[7:0] : PC_out + 2 ;
	assign PC_in    = jump ? inst_out[9:0] : PC_first ;

	Inst_memory inst_mem(
		.address(PC_out),
		.inst(inst_out)
	);

	Reg_memory reg_mem(
		.clk(clk),
		.rst(rst),
		.R_i(inst_out[11:10]),
		.R_j(inst_out[ 9:8]),
		.wnd(inst_out[ 1:0]),
		.write_data(write_data),
		.setWindow(setWindow),
		.toWrite(toWrite),
		.data_i(data_i),
		.data_j(data_j)
	);
	assign write_data = memOrALU ? ALUout : read_data ;
endmodule
