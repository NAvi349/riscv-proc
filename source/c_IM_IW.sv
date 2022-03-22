/*
	Name: Control Unit Pipeline Register for Memory Access - WriteBack Stage
	
*/


module c_IM_IW (input logic clk, reset, 
                input logic RegWriteM, 
                input logic [1:0] ResultSrcM, 
                output logic RegWriteW, 
                output logic [1:0] ResultSrcW);

    always_ff @( posedge clk, posedge reset ) begin
        if (reset) begin
            RegWriteW <= 0;
            ResultSrcW <= 0;           
        end

        else begin
            RegWriteW <= RegWriteM;
            ResultSrcW <= ResultSrcM; // lol this wasted 1 hour
        end

    end

endmodule