module testbench();

	logic clk, reset;

	top u_top(clk, reset);
	
	initial begin
		clk = 1;
		reset <= 1; 
		# 100; 
		reset <= 0;
	end

	always #5 clk = ~clk;
	
endmodule
