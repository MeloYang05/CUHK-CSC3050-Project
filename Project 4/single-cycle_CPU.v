`timescale 1ns / 1ps

module CPU(
    input wire clock,
    input wire start,
    input [31:0] i_datain,
    input wire [31:0] d_datain,
    output wire [31:0] d_dataout
    );

    reg [31:0]gr[31:0];
    reg [15:0]pc = 16'h0000;

    reg [31:0]reg_A;
    reg [31:0]reg_B;
    reg [31:0]reg_C;
    reg [31:0]reg_C1;
    reg [31:0]saveword;

    reg [5:0]opcode;
    reg [5:0]functcode;
    reg [31:0]instruction;

    reg overflow;

always @(start)
    begin
        gr[0] = 32'h0000_0000;
    end

always @(posedge clock)
	begin
        overflow=1'b0;
        //control unit
        opcode = i_datain[31:26];
        functcode = i_datain[5:0];

        //reg_A and reg_B
        //lw,sw,addi,addiu
        if (opcode==6'b100011 || opcode==6'b101011 || opcode==6'b001000 ||opcode==6'b001001)
        begin
            reg_A=gr[i_datain[25:21]];
            reg_B={{16{i_datain[15]}},i_datain[15:0]};
        end
        //andi,ori
        else if (opcode==6'b001100 || opcode==6'b001101)
        begin
            reg_A=gr[i_datain[25:21]];
            reg_B={16'b0,i_datain[15:0]};
        end
        //beq,bne
        else if (opcode==6'b000100 || opcode==6'b000101)
        begin
            reg_A=gr[i_datain[25:21]];
            reg_B=gr[i_datain[20:16]];
        end
        //R_type
        else if (opcode == 6'b000000)
        begin
            reg_A = gr[i_datain[25:21]];
            reg_B = gr[i_datain[20:16]];
        end

        //reg_C
        //lw, sw
        if (opcode==6'b100011 || opcode==6'b101011)
            reg_C=reg_A +reg_B;
        //addi
        else if (opcode==001000)
        begin
            reg_C=$signed(reg_A)+$signed(reg_B);
            if ((reg_A[31]==reg_B[31]) && (reg_A[31]!=reg_C[31]))
                overflow=1'b1;
            else overflow=1'b0;
        end
        //addiu
        else if (opcode==001001)
            reg_C=$unsigned(reg_A)+$unsigned(reg_B);
        //andi
        else if (opcode==001100)
            reg_C=reg_A&reg_B;
        //ori
        else if (opcode==001101)
            reg_C=reg_A|reg_B;
        //beq
        else if (opcode==000100)
        begin
            if (reg_A==reg_B)
                reg_C=i_datain[15:0];
        end
        //bne
        else if (opcode==000101)
        begin
            if (reg_A!=reg_B)
                reg_C=i_datain[15:0];
        end
        //R_type
        else if (opcode == 6'b000000)
        begin
            //add
            if (functcode==6'b100000)
            begin
                reg_C=$signed(reg_A)+$signed(reg_B);
                if ((reg_A[31]==reg_B[31]) && (reg_A[31]!=reg_C[31]))
                    overflow=1'b1;
                else overflow=1'b0;
            end
            //addu
            else if (functcode==6'b100001)
                reg_C=$unsigned(reg_A)+$unsigned(reg_B);
            //sub
            else if (functcode==6'b100010)
            begin
                reg_C=$signed(reg_A)-$signed(reg_B);
                if ((reg_A[31]==reg_B[31]) && (reg_A[31]!=reg_C[31]))
                    overflow=1'b1;
                else overflow=1'b0;
            end
            //subu
            else if (functcode==6'b100011)
                reg_C=$unsigned(reg_A)-$unsigned(reg_B);
            //and
            else if (functcode==6'b100100)
                reg_C=reg_A & reg_B;
            //or
            else if (functcode==6'b100101)
                reg_C=reg_A | reg_B;
            //xor
            else if (functcode==6'b100110)
                reg_C=reg_A ^ reg_B;
            //nor
            else if (functcode==6'b100111)
                reg_C=~(reg_A | reg_B);
            //slt
            else if (functcode==6'b101010)
            begin
                if ($signed(reg_A)<$signed(reg_B))
                    reg_C=32'b1;
                else reg_C=32'b0;
            end
            //jr
            else if (functcode==6'b001000)
                reg_C=gr[i_datain[25:21]];
        end

        //reg_C1(Result)
        //lw
        if (opcode == 6'b100011)
        begin
            reg_C1 = d_datain[31:0];
        end
        //sw
        else if (opcode==6'b101011)
            reg_C1=gr[i_datain[20:16]];
        //R_type,addi,addiu,andi,ori
        else if (opcode==6'b000000 || opcode==6'b001000 || opcode==6'b001001 || opcode==6'b001100 || opcode==6'b001101)
            reg_C1=reg_C;
        
        //write back to general registers
        //lw
        if (opcode == 6'b100011)
            gr[i_datain[20:16]] = reg_C1;
        //sw
        else if (opcode==6'b101011)
            saveword=reg_C1;
        //addi,addiu,andi,ori
        else if (opcode==6'b001000 || opcode==6'b001001 || opcode==6'b001100 || opcode==6'b001101)
            gr[i_datain[25:21]]=reg_C1;
        //R_type
        else if (opcode == 6'b000000 && functcode!=6'b001000)
            gr[i_datain[15:11]]=reg_C1;

        //pc
        //jr
        if (opcode==6'b001000)
            pc<=pc+4+reg_C*4;
        //j
        else if (opcode==6'b000010)
            pc<=pc+4+i_datain[25:0]*4;
        //jal
        else if (opcode==6'b000011)
        begin
            gr[31]=pc+4;
            pc<=pc+4+i_datain[25:0]*4;
        end
        //beq
        else if (opcode==000100)
        begin
            if (reg_A==reg_B)
                pc<=pc+4+reg_C*4;
        end
        //bne
        else if (opcode==000101)
        begin
            if (reg_A!=reg_B)
                pc<=pc+4+reg_C*4;
        end
        else pc <= pc + 16'h0004;
    end
    assign d_dataout=saveword;
endmodule