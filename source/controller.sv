/*
    Name: Controller or Control Unit
    Description: 5 stage pipelined Control Unit
*/

module controller(input logic clk, reset,
                        input logic [6:0] op,
                        input logic [2:0] funct3,
                        input logic funct7b5,
                        input logic ZeroE,
                        input logic SignE,
                        input logic FlushE,
                        output logic ResultSrcE0,
                        output logic [1:0] ResultSrcW,
                        output logic MemWriteM,
                        output logic PCJalSrcE, PCSrcE, ALUSrcAE, 
                        output logic [1:0] ALUSrcBE,
                        output logic RegWriteM, RegWriteW,
                        output logic [2:0] ImmSrcD,
                        output logic [3:0] ALUControlE);

logic [1:0] ALUOpD;
logic [1:0] ResultSrcD, ResultSrcE, ResultSrcM;
logic [3:0] ALUControlD;
logic BranchD, BranchE, MemWriteD, MemWriteE, JumpD, JumpE;
logic ALUSrcAD, RegWriteD, RegWriteE;
logic [1:0] ALUSrcBD;
logic ZeroOpE, SignOpE, BranchOpE;
logic [2:0] funct3D,funct3E;
logic [6:0] opD, opE;

assign funct3D = funct3;
assign opD = op;

// main decoder
maindec u_maindec(
    .op       (op        ),
    .ResultSrc(ResultSrcD),
    .MemWrite (MemWriteD ),
    .Branch   (BranchD   ),
    .ALUSrcA  (ALUSrcAD  ),
    .ALUSrcB  (ALUSrcBD  ),
    .RegWrite (RegWriteD ),
    .Jump     (JumpD     ),
    .ImmSrc   (ImmSrcD   ),
    .ALUOp	  (ALUOpD    )
);

// alu decoder
aludec ad(op[5], funct3, funct7b5, ALUOpD, ALUControlD);

c_ID_IEx c_pipreg0(clk, reset, FlushE, 
    RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcAD, ALUSrcBD, ResultSrcD, ALUControlD, funct3D, opD,
    RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcAE, ALUSrcBE, ResultSrcE, ALUControlE, funct3E, opE
);
assign ResultSrcE0 = ResultSrcE[0];

c_IEx_IM c_pipreg1(clk, reset, 
    RegWriteE, MemWriteE, ResultSrcE, 
    RegWriteM, MemWriteM, ResultSrcM
);
c_IM_IW c_pipreg2 (clk, reset, 
    RegWriteM, ResultSrcM, 
    RegWriteW, ResultSrcW
);

// Branch Insts
assign ZeroOpE = ZeroE ^ funct3E[0]; // Complements Zero flag for BNE Instruction
assign SignOpE = (SignE ^ funct3E[0]) ; // Complements Sign for BGE
assign BranchOpE = funct3E[2] ? (SignOpE) : (ZeroOpE);
assign PCSrcE = (BranchE & BranchOpE) | JumpE;
assign PCJalSrcE = (opE == 7'b1100111) ? 1 : 0; // jalr

endmodule
