`timescale 1ns / 1ns
module Memory(
	input clk ,
	input write_enable,
	input [ 9:0] address,
	input [15:0] write_data,
	output[15:0] read_data
);
	reg [15:0] mem[0:1023];
	always @(negedge clk) begin
		if (write_enable)
			mem[address] <= write_data ;
	end
	assign read_data = mem[address] ;
	initial begin
		for (integer i = 0 ; i < 1024 ; i = i + 1)
			mem[i] <= 16'd0 ;
	end
endmodule
