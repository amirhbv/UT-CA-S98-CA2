`timescale 1ns / 1ns
module TB();
	reg clk = 1 , rst;
	Processor cpu(clk, rst);
	always #100 clk = ~clk;
	initial begin
		rst = 1;
		#200;
		rst = 0;
		#5000;
		$stop;
	end
endmodule
