/*
	Name: Pipeline register between Memory Access and WriteBack Stage
*/

module IMem_IW (input logic clk, reset,
                input logic [31:0] ALUResultM, ReadDataM,  
                input logic [4:0] RdM, 
                input logic [31:0] PCPlus4M,
                output logic [31:0] ALUResultW, ReadDataW,
                output logic [4:0] RdW, 
                output logic [31:0] PCPlus4W);

always_ff @( posedge clk, posedge reset ) begin 
    if (reset) begin
        ALUResultW <= 0;
        ReadDataW <= 0;
        
        RdW <= 0; 
        PCPlus4W <= 0;
    end

    else begin
        ALUResultW <= ALUResultM;
        ReadDataW <= ReadDataM;
        
        RdW <= RdM; 
        PCPlus4W <= PCPlus4M;        
    end
    
end

endmodule