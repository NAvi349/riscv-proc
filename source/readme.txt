Original Repository: https://github.com/NAvi349/riscv-proc

Modified By: exaithrg

Major Changes:

A critical issue was identified in the handling of Branch instructions (such as BGE, JALR, etc.) within the controller.sv file. Certain signals were being used as operands without undergoing the necessary latch delay through flip-flops, leading to malfunctions in the majority of cases where instructions like BGE and RET were executed. This bug has been rectified by exaithrg.

Original Code in controller.sv:
assign ZeroOp = ZeroE ^ funct3[0]; // Complements Zero flag for BNE Instruction
assign SignOp = (SignE ^ funct3[0]) ; //Complements Sign for BGE
//mux2 BranchSrc (ZeroOp, SignOp, funct3[2], BranchOp); // fix this later
assign BranchOp = funct3[2] ? (SignOp) : (ZeroOp); 
assign PCSrcE = (BranchE & BranchOp) | JumpE;
assign PCJalSrcE = (op == 7'b1100111) ? 1 : 0; // jalr

Revised Code:
assign ZeroOpE = ZeroE ^ funct3E[0]; // Complements Zero flag for BNE Instruction
assign SignOpE = (SignE ^ funct3E[0]) ; // Complements Sign for BGE
assign BranchOpE = funct3E[2] ? (SignOpE) : (ZeroOpE);
assign PCSrcE = (BranchE & BranchOpE) | JumpE;
assign PCJalSrcE = (opE == 7'b1100111) ? 1 : 0; // jalr
