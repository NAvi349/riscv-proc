/*
    Name: 5 stage pipelined Datapath
    Description: Datapath with 5 stages
    Refer the microarchitecture in the images folder for reference
*/

module datapath(
    input logic clk, reset,
    input logic [1:0] ResultSrcW,
    input logic PCJalSrcE, PCSrcE, ALUSrcAE, 
    input logic [1:0] ALUSrcBE,
    input logic RegWriteW,
    input logic [2:0] ImmSrcD,
    input logic [3:0] ALUControlE,
    output logic ZeroE,
    output logic SignE,
    output logic [31:0] PCF,
    input logic [31:0] InstrF,
    output logic [31:0] InstrD,
    output logic [31:0] ALUResultM, WriteDataM,
    input logic [31:0] ReadDataM,
    input logic [1:0] ForwardAE, ForwardBE,
    output logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E,
    output logic [4:0] RdE, RdM, RdW,
    input logic StallD, StallF, FlushD, FlushE
);

    logic [31:0] PCD, PCE, ALUResultE, ALUResultW, ReadDataW;
    logic [31:0] PCNextF, PCPlus4F, PCPlus4D, PCPlus4E, PCPlus4M, PCPlus4W, PCTargetE, BranJumpTargetE;
    logic [31:0] WriteDataE;
    logic [31:0] ImmExtD, ImmExtE;
    logic [31:0] SrcAEfor, SrcAE, SrcBE, RD1D, RD2D, RD1E, RD2E;
    logic [31:0] ResultW;
    logic [4:0] RdD; // destination register address

    // Fetch Stage
    mux2 jal_r(PCTargetE, ALUResultE, PCJalSrcE, BranJumpTargetE);
    mux2 pcmux(PCPlus4F, BranJumpTargetE, PCSrcE, PCNextF);
    flopenr IF(clk, reset, ~StallF, PCNextF, PCF);
    adder pcadd4(PCF, 32'd4, PCPlus4F);
    
    // Instruction Fetch - Decode Pipeline Register	
    IF_ID pipreg0 (clk, reset, FlushD, ~StallD, InstrF, PCF, PCPlus4F, InstrD, PCD, PCPlus4D);
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    regfile u_rf (clk, RegWriteW, Rs1D, Rs2D, RdW, ResultW, RD1D, RD2D);	
    assign RdD = InstrD[11:7];
    extend ext(InstrD[31:7], ImmSrcD, ImmExtD);
    
    // Decode - Execute Pipeline Register	
    ID_IEx pipreg1 (clk, reset, FlushE, RD1D, RD2D, PCD, Rs1D, Rs2D, RdD, ImmExtD, PCPlus4D, RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E);
    mux3 forwardMuxA (RD1E, ResultW, ALUResultM, ForwardAE, SrcAEfor);
    mux2 srcamux(SrcAEfor, 32'b0, ALUSrcAE, SrcAE); // for lui
    mux3 forwardMuxB (RD2E, ResultW, ALUResultM, ForwardBE, WriteDataE);
    mux3 srcbmux(WriteDataE, ImmExtE, PCTargetE, ALUSrcBE, SrcBE); 
    adder pcaddbranch(PCE, ImmExtE, PCTargetE); // Next PC for jump and branch instructions
    alu alu(SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE, SignE);
    
    // Execute - Memory Access Pipeline Register
    IEx_IMem pipreg2 (clk, reset, ALUResultE, WriteDataE, RdE, PCPlus4E, ALUResultM, WriteDataM, RdM, PCPlus4M);
    
    // Memory - Register Write Back Stage
    IMem_IW pipreg3 (clk, reset, ALUResultM, ReadDataM, RdM, PCPlus4M, ALUResultW, ReadDataW, RdW, PCPlus4W);
    mux3 resultmux( ALUResultW, ReadDataW, PCPlus4W, ResultSrcW, ResultW);

endmodule
