/*
	Name: Hazard Unit
	Description: Handles both Data Hazards and Control Hazards	
*/


module hazardunit(input logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E,
                input logic [4:0] RdE, RdM, RdW,
                input logic RegWriteM, RegWriteW,
				    input logic ResultSrcE0, PCSrcE,
                output logic [1:0] ForwardAE, ForwardBE,
                output logic StallD, StallF, FlushD, FlushE);
					 
// RAW					 
// Whenever source register (Rs1E, Rs2E) in execution stage matchces with the destination register (RdM, RdW)
// of a previous instruction's Memory or WriteBack stage forward the ALUResultM or ResultW
// And also only when RegWrite is asserted

logic lwStall;
    always_comb begin
	    ForwardAE = 2'b00;
		 ForwardBE = 2'b00;
        if ((Rs1E == RdM) & (RegWriteM) & (Rs1E != 0)) // higher priority - most recent
            ForwardAE = 2'b10; // for forwarding ALU Result in Memory Stage
        else if ((Rs1E == RdW) & (RegWriteW) & (Rs1E != 0))
            ForwardAE = 2'b01; // for forwarding WriteBack Stage Result

        if ((Rs2E == RdM) & (RegWriteM) & (Rs2E != 0))
            ForwardBE = 2'b10; // for forwarding ALU Result in Memory Stage

        else if ((Rs2E == RdW) & (RegWriteW) & (Rs2E != 0))
            ForwardBE = 2'b01; // for forwarding WriteBack Stage Result
     
	  end
	  
// For Load Word Dependency result does not appear until end of Data Memory Access Stage
// if Destination register in EXE stage is equal to souce register in decode stage
// stall previous instructions until the the load word is avialbe at the writeback stage
// Introduce One cycle latency for subsequent instructions after load word 
// There is two cycle difference between Memory Access and the immediate next instruction

   assign lwStall = (ResultSrcE0 == 1) & ((RdE == Rs1D) | (RdE == Rs2D));
//   assign FlushE = lwStall;
	assign StallF = lwStall;
	assign StallD = lwStall;
	
// control hazard
// whenever branch has been taken, we flush the following two instructions from decode and execute pip reg
	assign FlushE = lwStall | PCSrcE;
	assign FlushD = PCSrcE;

endmodule



    

