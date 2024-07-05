/***
    Name: Main Decoder
    Description: This unit generates the control signals from the 7 bit opcode.
    Determines the type of instruction
***/

module maindec(
    input  logic [6:0]  op       ,
    output logic [1:0]  ResultSrc,
    output logic        MemWrite ,
    output logic        Branch   , 
    output logic        ALUSrcA  , 
    output logic [1:0]  ALUSrcB  ,
    output logic        RegWrite , 
    output logic        Jump     ,
    output logic [2:0]  ImmSrc   ,
    output logic [1:0]  ALUOp
);
    
logic [13:0] controls;
assign {RegWrite, ImmSrc, ALUSrcA, ALUSrcB, MemWrite, ResultSrc, Branch, ALUOp, Jump} = controls;

always_comb
    case(op)
    // RegWrite_ImmSrc_ALUSrcA_ALUSrcB_MemWrite_ResultSrc_Branch_ALUOp_Jump
        7'b0000011: controls = 14'b1_000_0_01_0_01_0_00_0; // lw
        7'b0100011: controls = 14'b0_001_0_01_1_00_0_00_0; // sw
        7'b0110011: controls = 14'b1_xxx_0_00_0_00_0_10_0; // R–type
        7'b1100011: controls = 14'b0_010_0_00_0_00_1_01_0; // B-type
        7'b0010011: controls = 14'b1_000_0_01_0_00_0_10_0; // I–type ALU
        7'b1101111: controls = 14'b1_011_0_00_0_10_0_00_1; // jal
        7'b0010111: controls = 14'b1_100_1_10_0_00_0_00_0; // auipc // PC Target for SrcB
        7'b0110111: controls = 14'b1_100_1_01_0_00_0_00_0; // lui
        7'b1100111: controls = 14'b1_000_0_01_0_10_0_00_1; // jalr
        7'b0000000: controls = 14'b0_000_0_00_0_00_0_00_0; // for default values on reset
        
        default:  controls = 14'bx_xxx_x_xx_x_xx_x_xx_x; // instruction not implemented
    endcase
    
endmodule