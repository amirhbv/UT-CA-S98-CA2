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
		if (write_enable) begin
			mem[address] <= write_data ;
			$display("%b\n", write_data);
		end
	end
	assign read_data = mem[address] ;
	initial begin
		// for (integer i = 0 ; i < 1024 ; i = i + 1)
		// 	mem[i] <= 16'd0 ;

		mem[500] = 1;
		mem[501] = 2;
		mem[502] = 3;
		mem[503] = 4;
		mem[504] = 5;
		mem[505] = 6;
		mem[506] = 7;
		mem[507] = 8;
		mem[508] = 9;
		mem[509] = 10;
	end
endmodule
