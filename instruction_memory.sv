`timescale 1ns / 1ns
module Inst_memory(
	input [9 :0] address,
	output[15:0] inst
);
	reg [15:0] mem[0:1023] ;
	initial begin
		for (integer i = 0 ; i < 1024 ; i = i + 1)
			mem[i] <= 16'd0 ;
	end
endmodule
