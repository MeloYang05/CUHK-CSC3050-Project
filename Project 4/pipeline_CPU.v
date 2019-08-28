`timescale 1ns / 1ps
module CPU (clock,start,in_instruction);
    input wire clock;
    input wire start;
    input [319:0] in_instruction;

    reg [31:0]gr[31:0];
    reg [32:0]PC = 32'h0000_0000;
    reg [7:0] instruction_memory[1023:0];
    reg [7:0] data_memory[1023:0];

    reg [31:0]instruction;

    reg [5:0]opcode;
    reg [5:0]functcode;

    reg Regdst;
    reg RegWrite;
    reg ALUgate;
    reg ALUSrc;
    reg MemRead;
    reg MemWrite;
    reg MemtoReg;
    reg PC_Control=1'b1;

    reg[31:0] ALU_reg1;
    reg[31:0] ALU_reg2;
    reg[31:0] ALU_result;

    reg[31:0] address;
    reg[31:0] load_data; 

    reg [63:0] IF_ID;
    reg [129:0] ID_EX;
    reg [53:0] EX_MEM;
    reg [78:0] MEM_WB;

    reg overflow;

always @(start)
    begin
        gr[0] = 32'h0000_0000;
        instruction_memory[0]=in_instruction[319:312];
        instruction_memory[1]=in_instruction[311:304];
        instruction_memory[2]=in_instruction[303:296];
        instruction_memory[3]=in_instruction[295:288];
        instruction_memory[4]=in_instruction[287:280];
        instruction_memory[5]=in_instruction[279:272];
        instruction_memory[6]=in_instruction[271:264];
        instruction_memory[7]=in_instruction[263:256];
        instruction_memory[8]=in_instruction[255:248];
        instruction_memory[9]=in_instruction[247:240];
        instruction_memory[10]=in_instruction[239:232];
        instruction_memory[11]=in_instruction[231:224];
        instruction_memory[12]=in_instruction[223:216];
        instruction_memory[13]=in_instruction[215:208];
        instruction_memory[14]=in_instruction[207:200];
        instruction_memory[15]=in_instruction[199:192];
        instruction_memory[16]=in_instruction[191:184];
        instruction_memory[17]=in_instruction[183:176];
        instruction_memory[18]=in_instruction[175:168];
        instruction_memory[19]=in_instruction[167:160];
        instruction_memory[20]=in_instruction[159:152];
        instruction_memory[21]=in_instruction[151:144];
        instruction_memory[22]=in_instruction[143:136];
        instruction_memory[23]=in_instruction[135:128];
        instruction_memory[24]=in_instruction[127:120];
        instruction_memory[25]=in_instruction[119:112];
        instruction_memory[26]=in_instruction[111:104];
        instruction_memory[27]=in_instruction[103:96];
        instruction_memory[28]=in_instruction[95:88];
        instruction_memory[29]=in_instruction[87:80];
        instruction_memory[30]=in_instruction[79:72];
        instruction_memory[31]=in_instruction[71:64];
        instruction_memory[32]=in_instruction[63:56];
        instruction_memory[33]=in_instruction[55:48];
        instruction_memory[34]=in_instruction[47:40];
        instruction_memory[35]=in_instruction[39:32];
        instruction_memory[36]=in_instruction[31:24];
        instruction_memory[37]=in_instruction[23:16];
        instruction_memory[38]=in_instruction[15:8];
        instruction_memory[39]=in_instruction[7:0];
    end

//Instruction Fetch
always @(posedge clock)
	begin
    if (PC_Control!=1'b0)
    begin
        instruction={instruction_memory[PC],instruction_memory[PC+1],instruction_memory[PC+2],instruction_memory[PC+3]};
        if (instruction[31:26]==6'b000010)
            PC<=PC+4+instruction[25:0]*4;
        else if (instruction[31:26]==6'b000011)
        begin
            gr[31]<=PC+4;
            PC<=PC+4+instruction[25:0]*4;
        end
        else if (instruction[31:26]==6'b000000 && instruction[5:0]==6'b001000)
            PC<=PC+4+gr[instruction[25:21]]*4;
        else if (instruction[31:26]==6'b000100)
        begin
            if (instruction[25:21]==instruction[20:16])
                PC<=PC+4+instruction[15:0]*4;
        end
        else if (instruction[31:26]==6'b000101)
        begin
            if (instruction[25:21]!=instruction[20:16])
                PC<=PC+4+instruction[15:0]*4;
        end
        else PC<=PC+4;
        IF_ID[31:0]<=instruction;
        IF_ID[63:32]<=PC;
    end
    else
    begin
    instruction={instruction_memory[PC-8],instruction_memory[PC-7],instruction_memory[PC-6],instruction_memory[PC-5]};
    PC<=PC-4;
    IF_ID[31:0]<=instruction;
    IF_ID[63:32]<=PC;
    end
    end

//Instruction Decoding
always @(posedge clock)
	begin
    //Strech opcode and functcode
    opcode=IF_ID[31:26];
    functcode=IF_ID[5:0];
    //store register data to ID_EX
    ID_EX[95:64]<=gr[IF_ID[25:21]];
    ID_EX[63:32]<=gr[IF_ID[20:16]];
    if (opcode==6'b100011 || opcode==6'b101011 || opcode==6'b001000 ||opcode==6'b001001)
        ID_EX[31:0]<={{16{IF_ID[15]}},IF_ID[15:0]};
    else
        ID_EX[31:0]<={16'b0,IF_ID[15:0]};
    // Hazard Detect and stall
    if (MemRead==1'b1 && (ID_EX[124:120]==IF_ID[25:21] || ID_EX[124:120]==IF_ID[20:16]))
    begin
        Regdst=1'b0;
        RegWrite=1'b0;
        ALUgate=1'b0;
        ALUSrc=1'b0;
        MemRead=1'b0;
        MemWrite=1'b0;
        MemtoReg=1'b0;
        PC_Control<=1'b0;
    end
    //Design control signal
    //Regdst
    else
    begin
        if (opcode==6'b000000)
            Regdst=1'b1;
        else if (opcode==6'b001000 || opcode==6'b001001 || opcode==6'b001100 || opcode==6'b001101 || opcode==6'b100011)
            Regdst=1'b0;
        //RegWrite
        if (opcode==6'b000000 || opcode==6'b001000 || opcode==6'b001001 || opcode==6'b001100 || opcode==6'b001101 || opcode==6'b100011)
            RegWrite=1'b1;
        else
            RegWrite=1'b0;
        if (opcode==6'b000000 && functcode==6'b001000)
            RegWrite=1'b0;
        //ALUgate
        if (opcode==6'b000000 || opcode==6'b001000 || opcode==6'b001001 || opcode==6'b001100 || opcode==6'b001101 || opcode==6'b100011 || opcode==6'b101011)
            ALUgate=1'b1;
        else
            ALUgate=1'b0;
        if (opcode==6'b000000 && functcode==6'b001000)
            ALUgate=1'b0;
        //ALUSrc
        if (opcode==6'b001000 || opcode==6'b001001 || opcode==6'b001100 || opcode==6'b001101 || opcode==6'b100011 || opcode==6'b101011)
            ALUSrc=1'b1;
        else if (opcode==6'b000000)
            ALUSrc=1'b0;
        //MemRead
        if (opcode==6'b100011)
            MemRead=1'b1;
        else
            MemRead=1'b0;
        //MemWrite
        if (opcode==6'b101011)
            MemWrite=1'b1;
        else
            MemWrite=1'b0;
        //MemtoReg
        if (opcode==6'b100011)
            MemtoReg=1'b1;
        else
            MemtoReg=1'b0;
        PC_Control<=1'b1;
    end
    //store opcode and functcode to ID_EX
    ID_EX[107:102]<=opcode;
    ID_EX[101:96]<=functcode;
    //store control signals to ID_EX
    ID_EX[114]<=Regdst;
    ID_EX[113]<=RegWrite;
    ID_EX[112]<=ALUgate;
    ID_EX[111]<=ALUSrc;
    ID_EX[110]<=MemRead;
    ID_EX[109]<=MemWrite;
    ID_EX[108]<=MemtoReg;
    //store rs, rt and rd address to ID_EX;
    ID_EX[129:125]<=IF_ID[25:21];
    ID_EX[124:120]<=IF_ID[20:16];
    ID_EX[119:115]<=IF_ID[15:11];
    end

//Excution
always @(posedge clock)
    begin
    overflow=1'b0;
    //get data from ID_EX
    if (ID_EX[112]==1'b1 && ID_EX[111]==1'b1)
    begin
        ALU_reg1=gr[ID_EX[129:125]];
        ALU_reg2=ID_EX[31:0];
    end
    else if (ID_EX[112]==1'b1 && ID_EX[111]==1'b0)
    begin
        ALU_reg1=gr[ID_EX[129:125]];
        ALU_reg2=gr[ID_EX[124:120]];
    end
    //bypassing
    //EX_MEM rd = ID_EX rs
    if (EX_MEM[41:37]==ID_EX[129:125] && ID_EX[112]==1'b1 && EX_MEM[52]==1'b0)
        ALU_reg1=EX_MEM[31:0];
    //EX_MEM rd = ID_EX rt
    if (EX_MEM[41:37]==ID_EX[124:120] && ID_EX[112]==1'b1 && ID_EX[111]==1'b0 && EX_MEM[52]==1'b0)
        ALU_reg2=EX_MEM[31:0];
    //MEM_WB rd = ID_EX rs
    if (MEM_WB[71:67]==ID_EX[129:125] && ID_EX[112]==1'b1 && MEM_WB[77]==1'b0)
        ALU_reg1=MEM_WB[31:0];
    //MEM_WB rd = ID_EX rt
    if (MEM_WB[71:67]==ID_EX[124:120] && ID_EX[112]==1'b1 && ID_EX[111]==1'b0 && MEM_WB[77]==1'b0)
        ALU_reg2=MEM_WB[31:0];
    //EX_MEM rt = ID_EX rs
    if (EX_MEM[46:42]==ID_EX[129:125] && ID_EX[112]==1'b1 && EX_MEM[52]==1'b1)
        ALU_reg1=EX_MEM[31:0];
    //EX_MEM rt = ID_EX rt
    if (EX_MEM[46:42]==ID_EX[124:120] && ID_EX[112]==1'b1 && ID_EX[111]==1'b0 && EX_MEM[52]==1'b1)
        ALU_reg2=EX_MEM[31:0];
    //MEM_WB rt = ID_EX rs (ALU)
    if (MEM_WB[76:72]==ID_EX[129:125] && ID_EX[112]==1'b1 && MEM_WB[77]==1'b1 && MEM_WB[64]==1'b0)
        ALU_reg1=MEM_WB[31:0];
    //MEM_WB rt = ID_EX rt (ALU)
    if (MEM_WB[76:72]==ID_EX[124:120] && ID_EX[112]==1'b1 && ID_EX[111]==1'b0 && MEM_WB[77]==1'b1 && MEM_WB[64]==1'b0)
        ALU_reg2=MEM_WB[31:0];
    //MEM_WB rt = ID_EX rs (Memory)
    if (MEM_WB[76:72]==ID_EX[129:125] && ID_EX[112]==1'b1 && MEM_WB[77]==1'b1 && MEM_WB[64]==1'b1)
        ALU_reg1=MEM_WB[63:32];
    //MEM_WB rt = ID_EX rt (ALU)
    if (MEM_WB[76:72]==ID_EX[124:120] && ID_EX[112]==1'b1 && ID_EX[111]==1'b0 && MEM_WB[77]==1'b1 && MEM_WB[64]==1'b1)
        ALU_reg2=MEM_WB[63:32];
    //excute calculation
    //lw, sw
    if (ID_EX[107:102]==6'b100011 || ID_EX[107:102]==6'b101011)
        ALU_result=ALU_reg1+ALU_reg2;
    //addi
    else if (ID_EX[107:102]==6'b001000)
    begin
        ALU_result=$signed(ALU_reg1)+$signed(ALU_reg2);
        if ((ALU_reg1[31]==ALU_reg2[31]) && (ALU_reg1[31]!=ALU_result[31]))
            overflow=1'b1;
        else overflow=1'b0;
    end
    //addiu
    else if (ID_EX[107:102]==6'b001001)
        ALU_result=$unsigned(ALU_reg1)+$unsigned(ALU_reg2);
    //andi
    else if (ID_EX[107:102]==6'b001100)
        ALU_result=ALU_reg1 & ALU_reg2;
    //ori
    else if (ID_EX[107:102]==6'b001101)
        ALU_result=ALU_reg1 | ALU_reg2;
    //Rype
    else if (ID_EX[107:102]==6'b000000)
    begin
        //add
        if (ID_EX[101:96]==6'b100000)
        begin
            ALU_result=$signed(ALU_reg1)+$signed(ALU_reg2);
            if ((ALU_reg1[31]==ALU_reg2[31]) && (ALU_reg1[31]!=ALU_result[31]))
                overflow=1'b1;
            else overflow=1'b0;
        end
        //addu
        else if (ID_EX[101:96]==6'b100001)
            ALU_result=$unsigned(ALU_reg1)+$unsigned(ALU_reg2);
        //sub
        else if (ID_EX[101:96]==6'b100010)
        begin
            ALU_result=$signed(ALU_reg1)-$signed(ALU_reg2);
            if ((ALU_reg1[31]==ALU_reg2[31]) && (ALU_reg1[31]!=ALU_result[31]))
                overflow=1'b1;
            else overflow=1'b0;
        end
        //subu
        else if (ID_EX[101:96]==6'b100011)
            ALU_result=$unsigned(ALU_reg1)-$unsigned(ALU_reg2);
        //and
        else if (ID_EX[101:96]==6'b100100)
            ALU_result=ALU_reg1 & ALU_reg2;
        //or
        else if (ID_EX[101:96]==6'b100101)
            ALU_result=ALU_reg1 | ALU_reg2;
        //xor
        else if (ID_EX[101:96]==6'b100110)
            ALU_result=ALU_reg1 ^ ALU_reg2;
        //nor
        else if (ID_EX[101:96]==6'b100111)
            ALU_result=~(ALU_reg1 | ALU_reg2);
        //slt
        else if (ID_EX[101:96]==6'b101010)
        begin
            if ($signed(ALU_reg1)<$signed(ALU_reg2))
                ALU_result=32'b1;
            else ALU_result=32'b0;
        end
    end
    //store ALU_result to EX_MEM
    EX_MEM[31:0]<=ALU_result;
    //store control signals to EX_MEM
    EX_MEM[36]<=ID_EX[114];
    EX_MEM[35]<=ID_EX[113];
    EX_MEM[34]<=ID_EX[110];
    EX_MEM[33]<=ID_EX[109];
    EX_MEM[32]<=ID_EX[108];
    EX_MEM[53]<=ID_EX[112];
    EX_MEM[52]<=ID_EX[111];
    //store rs,rt and rd address to EX_MEM
    EX_MEM[51:47]<=ID_EX[129:125];
    EX_MEM[46:42]<=ID_EX[124:120];
    EX_MEM[41:37]<=ID_EX[119:115];
    end

//Memory
always @(posedge clock)
    begin
    //get address
    if (EX_MEM[34]==1'b1 || EX_MEM[33]==1'b1)
        address=EX_MEM[31:0];
    //Memory Read
    if (EX_MEM[34]==1'b1)
        load_data={data_memory[address],data_memory[address+1],data_memory[address+2],data_memory[address+3]};
    //Memory Save
    if (EX_MEM[33]==1'b1)
    begin
        data_memory[address]<=gr[EX_MEM[46:42]][31:24];
        data_memory[address+1]<=gr[EX_MEM[46:42]][23:16];
        data_memory[address+2]<=gr[EX_MEM[46:42]][15:8];
        data_memory[address+3]<=gr[EX_MEM[46:42]][7:0];
    end
    //store memory read data to MEM_WB
    MEM_WB[63:32]<=load_data;
    //store ALU_result to MEM_WB
    MEM_WB[31:0]<=EX_MEM[31:0];
    //store control signals to MEM_WB
    MEM_WB[66]<=EX_MEM[36];
    MEM_WB[65]<=EX_MEM[35];
    MEM_WB[64]<=EX_MEM[32];
    MEM_WB[78]<=EX_MEM[53];
    MEM_WB[77]<=EX_MEM[52];
    //store rt and rd address to MEM_WB
    MEM_WB[76:72]<=EX_MEM[46:42];
    MEM_WB[71:67]<=EX_MEM[41:37];
    end

//Write Back
always @(posedge clock)
    begin
    //Memory to rd
    if (MEM_WB[66]==1'b1 && MEM_WB[65]==1'b1 && MEM_WB[64]==1'b1)
        gr[MEM_WB[71:67]]<=MEM_WB[63:32];
    //Memory to rt
    else if (MEM_WB[66]==1'b0 && MEM_WB[65]==1'b1 && MEM_WB[64]==1'b1)
        gr[MEM_WB[76:72]]<=MEM_WB[63:32];
    //ALU_result to rd
    else if (MEM_WB[66]==1'b1 && MEM_WB[65]==1'b1 && MEM_WB[64]==1'b0)
        gr[MEM_WB[71:67]]<=MEM_WB[31:0];
    //ALU_result to rt
    else if (MEM_WB[66]==1'b0 && MEM_WB[65]==1'b1 && MEM_WB[64]==1'b0)
        gr[MEM_WB[76:72]]<=MEM_WB[31:0];
    end
endmodule