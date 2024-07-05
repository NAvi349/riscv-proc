// Name: Data Memory

module dmem(
	input logic clk, we, 
	input logic [31:0] addr, wdata, 
	output logic [31:0] rdata
);
		
	logic [31:0] RAM [1023:0];
	assign rdata = RAM[addr[31:2]];
	
	// 6 bit address enough to address the 64 locations in data memory
	always_ff @(posedge clk)
		if (we) RAM[addr[31:2]] <= wdata;

endmodule
