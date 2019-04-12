`timescale 1ns / 1ns
module PC(
	input clk ,
	input rst ,
	input[9:0] load_in ,
	output reg[9:0] pc_cur
);
	always @(negedge clk , posedge rst) begin
		if ( rst )
			pc_cur <= 16'd0 ;
		else
			pc_cur <= load_in ;
	end
endmodule
