module alu(a,b,opcode,c);

output signed[31:0] c;
//output zero;
//output overflow;
//output neg;

input signed[31:0] a,b;
input[2:0] opcode;

reg[32:0] reg_C;
//reg zf;
//reg nf;
reg[31:0] reg_A, reg_B;


parameter  sla = 3'b000,
srai = 3'b001;


always @(a,b,opcode)
begin

reg_A = a;
reg_B = b;

case(opcode)

sla: // arith left shift
begin
reg_C={reg_A[30:0],1'b0};

end

srai: // arith right shift
begin
reg_C={reg_A[31:1]};
reg_A=reg_C;
end

endcase
end

assign c = reg_C[31:0];

endmodule
