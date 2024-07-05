module top (
    input   logic           clk       , 
    input   logic           reset
);

    logic [31:0]    WriteDataM;
    logic [31:0]    DataAdrM  ;
    logic           MemWriteM ;
    logic [31:0]    PCF       ;
    logic [31:0]    InstrF    ;
    logic [31:0]    ReadDataM ;
    
    // Only implements 27 instructions in RV32I
    riscv_pip_27 u_riscv_pip_27(
        .clk       (clk       ),
        .reset     (reset     ),
        .PCF       (PCF       ),
        .InstrF    (InstrF    ),
        .MemWriteM (MemWriteM ),
        .ALUResultM(DataAdrM  ),
        .WriteDataM(WriteDataM),
        .ReadDataM (ReadDataM )
    );

    imem u_imem (
        .addr(PCF), 
        .rdata(InstrF)
    );
    
    dmem u_dmem (
        .clk(clk), 
        .we(MemWriteM), 
        .addr(DataAdrM), 
        .wdata(WriteDataM), 
        .rdata(ReadDataM)
    );
    
endmodule
