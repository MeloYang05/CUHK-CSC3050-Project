`timescale 1ns/1ps

// general register
`define gr0  	5'b00000
`define gr1  	5'b00001
`define gr2  	5'b00010
`define gr3 	5'b00011
`define gr4  	5'b00100
`define gr5  	5'b00101
`define gr6  	5'b00110
`define gr7  	5'b00111

module CPU_test;
reg clock;
reg start;
reg [319:0] in_instruction;

CPU a(.clock(clock),.start(start),.in_instruction(in_instruction));

initial begin
clock=0;
start=0;
in_instruction[319:288]={6'b101011,26'b0};
in_instruction[287:256]={6'b100011,`gr0,`gr1,16'b0};
in_instruction[255:224]={6'b001000,`gr1,`gr2,16'b11};
in_instruction[223:192]={6'b001000,`gr2,`gr3,16'b11};
in_instruction[191:160]={6'b000000,`gr2,`gr3,`gr4,5'b0,6'b100010};
in_instruction[159:128]={6'b000000,`gr1,`gr4,`gr5,5'b0,6'b100100};
in_instruction[127:96]={6'b001101,`gr4,`gr6,16'b11111};
in_instruction[95:64]={6'b001000,`gr6,`gr7,16'b111111};
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $display("PC=%h gr0=%h gr1=%h gr2=%h gr3=%h gr4=%h gr5=%h gr6=%h gr7=%h instruction=%b\n",a.PC,a.gr[0],a.gr[1],a.gr[2],a.gr[3],a.gr[4],a.gr[5],a.gr[6],a.gr[7],a.instruction);
#period $finish;
end

parameter period=10;
always #5clock=~clock;

endmodule