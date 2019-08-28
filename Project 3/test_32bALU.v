`timescale 1ns/1ps

module alu_test;

reg[31:0] a,b;
reg[2:0] opcode;

wire[31:0] c;
wire zero;
wire overflow;
wire neg;

parameter  sla = 3'b000,
srai = 3'b001;

alu testalu(a,b,opcode,c);


initial
begin

$display("op: a      : b      : c      : reg_A  : reg_B  : reg_C");
$monitor(" %h:%h:%h:%h:%h:%h:%h",
opcode, a, b, c, testalu.reg_A, testalu.reg_B, testalu.reg_C);

//// arith left shift

#10 a=32'b1101_1101_1101_1101_1101_1101_1101_1101;
opcode= sla;//3'b000

#10 a=32'b0100_0000_0100_0000_0100_0000_0100_0000;
opcode= sla;


//// arith right shift

#10 a=32'b1111_1101_1111_1101_1111_1101_1111_1101;
opcode= srai; //3'b001

#10 a=32'b0011_1001_0011_1001_0011_1001_0011_1001;
opcode= srai;

#10 $finish;
end
endmodule


