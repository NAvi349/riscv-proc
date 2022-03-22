module testbench();
	logic clk, reset, MemWrite;
	logic [31:0] WriteData, DataAdr;

	top dut(clk, reset, WriteData, DataAdr, MemWrite);
	
	initial
		begin
			reset <= 1; 
			# 100; 
			reset <= 0;
			
			$display("Simulation starts!");
			$monitor("Value of ALU = %d", DataAdr);
		end
	


	always
		begin
			clk <= 1; 
			# 5; clk <= 0; # 5;
		end
		 
	

endmodule