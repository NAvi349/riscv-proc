// Name: Instruction Memory

module imem(
    input logic [31:0] addr, 
    output logic [31:0] rdata
);
                
    logic [7:0] ROM [1023:0];
    assign rdata = {ROM[addr+3], ROM[addr+2], ROM[addr+1], ROM[addr+0]};

    // follow little-endian: LSB corresponds to lowest order memory address
    initial begin
        // Instruction: 00f00093
        ROM[0] = 8'h93;
        ROM[1] = 8'h00;
        ROM[2] = 8'hf0;
        ROM[3] = 8'h00;
        // Instruction: 01600113
        ROM[4] = 8'h13;
        ROM[5] = 8'h01;
        ROM[6] = 8'h60;
        ROM[7] = 8'h01;
        // Instruction: 002081b3
        ROM[8] = 8'hb3;
        ROM[9] = 8'h81;
        ROM[10] = 8'h20;
        ROM[11] = 8'h00;
        // Instruction: 0021e233
        ROM[12] = 8'h33;
        ROM[13] = 8'he2;
        ROM[14] = 8'h21;
        ROM[15] = 8'h00;
        // Instruction: 0041c2b3
        ROM[16] = 8'hb3;
        ROM[17] = 8'hc2;
        ROM[18] = 8'h41;
        ROM[19] = 8'h00;
        // Instruction: 00428333
        ROM[20] = 8'h33;
        ROM[21] = 8'h83;
        ROM[22] = 8'h42;
        ROM[23] = 8'h00;
        // Instruction: 02628863
        ROM[24] = 8'h63;
        ROM[25] = 8'h88;
        ROM[26] = 8'h62;
        ROM[27] = 8'h02;
        // Instruction: 0041a233
        ROM[28] = 8'h33;
        ROM[29] = 8'ha2;
        ROM[30] = 8'h41;
        ROM[31] = 8'h00;
        // Instruction: 00020463
        ROM[32] = 8'h63;
        ROM[33] = 8'h04;
        ROM[34] = 8'h02;
        ROM[35] = 8'h00;
        // Instruction: 00000313
        ROM[36] = 8'h13;
        ROM[37] = 8'h03;
        ROM[38] = 8'h00;
        ROM[39] = 8'h00;
        // Instruction: 0032a233
        ROM[40] = 8'h33;
        ROM[41] = 8'ha2;
        ROM[42] = 8'h32;
        ROM[43] = 8'h00;
        // Instruction: 00520333
        ROM[44] = 8'h33;
        ROM[45] = 8'h03;
        ROM[46] = 8'h52;
        ROM[47] = 8'h00;
        // Instruction: 40118133
        ROM[48] = 8'h33;
        ROM[49] = 8'h81;
        ROM[50] = 8'h11;
        ROM[51] = 8'h40;
        // Instruction: 0411aa23
        ROM[52] = 8'h23;
        ROM[53] = 8'haa;
        ROM[54] = 8'h11;
        ROM[55] = 8'h04;
        // Instruction: 0541a083
        ROM[56] = 8'h83;
        ROM[57] = 8'ha0;
        ROM[58] = 8'h41;
        ROM[59] = 8'h05;
        // Instruction: 00008093
        ROM[60] = 8'h93;
        ROM[61] = 8'h80;
        ROM[62] = 8'h00;
        ROM[63] = 8'h00;
        // Instruction: 003103b3
        ROM[64] = 8'hb3;
        ROM[65] = 8'h03;
        ROM[66] = 8'h31;
        ROM[67] = 8'h00;
        // Instruction: 004001ef
        ROM[68] = 8'hef;
        ROM[69] = 8'h01;
        ROM[70] = 8'h40;
        ROM[71] = 8'h00;
        // Instruction: 00910133
        ROM[72] = 8'h33;
        ROM[73] = 8'h01;
        ROM[74] = 8'h91;
        ROM[75] = 8'h00;
        // Instruction: 00100213
        ROM[76] = 8'h13;
        ROM[77] = 8'h02;
        ROM[78] = 8'h10;
        ROM[79] = 8'h00;
        // Instruction: 00108063
        ROM[80] = 8'h63;
        ROM[81] = 8'h80;
        ROM[82] = 8'h10;
        ROM[83] = 8'h00;
    end
    
endmodule
