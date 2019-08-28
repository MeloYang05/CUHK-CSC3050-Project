module testbench();
    reg [31:0]reg_A,reg_B;
    reg [15:0] reg_im;
    reg [4:0] reg_opcode;
    wire [31:0] a,b,reg_C,Hi,Lo;
    wire [15:0] im;
    wire [4:0] opcode;
    wire overflow,negative,zero;
    assign a=reg_A;
    assign b=reg_B;
    assign im=reg_im;
    assign opcode=reg_opcode;
    ALU alu(a,b,im,opcode,reg_C,Hi,Lo,overflow,negative,zero);
    initial
    begin
    	$display("----------------------------------------------------------");
		$display("                      MIPS_ADD TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b10;reg_B=32'b0;reg_im=16'b1110;reg_opcode=5'b00000;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0111_1111_1111_1111_1111_1111_1111_1111;reg_B=32'b111;reg_im=16'b1110;reg_opcode=5'b00000;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_SUB TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b0;reg_B=32'b0;reg_im=16'b1110;reg_opcode=5'b00001;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0111_1111_1111_1111_1111_1111_1111_1111;reg_B=32'b111;reg_im=16'b1110;reg_opcode=5'b00001;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_MULT TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b1110;reg_B=32'b10;reg_im=16'b1110;reg_opcode=5'b00010;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0111_1111_1111_1111_1111_1111_1111_1111;reg_B=32'b111;reg_im=16'b1110;reg_opcode=5'b00010;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_DIV TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b1110;reg_B=32'b10;reg_im=16'b1110;reg_opcode=5'b00011;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b1111_1111_1111_1111_1111_1111_1111_1111;reg_B=32'b1;reg_im=16'b1110;reg_opcode=5'b00011;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_ADDI TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b1110;reg_B=32'b10;reg_im=16'b1110;reg_opcode=5'b00100;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0111_1111_1111_1111_1111_1111_1111_1111;reg_B=32'b111;reg_im=16'b1110;reg_opcode=5'b00100;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_ADDU TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b1110;reg_B=32'b10;reg_im=16'b1110;reg_opcode=5'b00101;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0111_1111_1111_1111_1111_1111_1111_1111;reg_B=32'b111;reg_im=16'b1110;reg_opcode=5'b00101;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_SUBU TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b1110;reg_B=32'b10;reg_im=16'b1110;reg_opcode=5'b00110;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b11;reg_B=32'b111;reg_im=16'b1110;reg_opcode=5'b00110;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_MULTU TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b1110;reg_B=32'b10;reg_im=16'b1110;reg_opcode=5'b00111;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b1101;reg_B=32'b111;reg_im=16'b1110;reg_opcode=5'b00111;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_DIVU TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b1110;reg_B=32'b10;reg_im=16'b1110;reg_opcode=5'b01000;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b01111111;reg_B=32'b111;reg_im=16'b1110;reg_opcode=5'b01000;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_ADDIU TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b1110;reg_B=32'b10;reg_im=16'b1110;reg_opcode=5'b01001;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b11;reg_B=32'b111;reg_im=16'b1111_1111_1111_1111;reg_opcode=5'b01001;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_SQRT TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b1001;reg_B=32'b10;reg_im=16'b1110;reg_opcode=5'b01010;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b1;reg_B=32'b111;reg_im=16'b1110;reg_opcode=5'b01010;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_AND TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b111110;reg_B=32'b1000;reg_im=16'b1110;reg_opcode=5'b01011;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0011011;reg_B=32'b1011;reg_im=16'b1110;reg_opcode=5'b01011;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_OR TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b111110;reg_B=32'b1000;reg_im=16'b1110;reg_opcode=5'b01100;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0011011;reg_B=32'b1011;reg_im=16'b1110;reg_opcode=5'b01100;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_NOR TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b111110;reg_B=32'b1000;reg_im=16'b1110;reg_opcode=5'b01101;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0011011;reg_B=32'b1011;reg_im=16'b1110;reg_opcode=5'b01101;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_XOR TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b111110;reg_B=32'b1000;reg_im=16'b1110;reg_opcode=5'b01110;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0011011;reg_B=32'b1011;reg_im=16'b1110;reg_opcode=5'b01110;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_XNOR TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b111110;reg_B=32'b1000;reg_im=16'b1110;reg_opcode=5'b01111;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0011011;reg_B=32'b1011;reg_im=16'b1110;reg_opcode=5'b01111;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_ANDI TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b111110;reg_B=32'b1000;reg_im=16'b1110;reg_opcode=5'b10000;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0011011;reg_B=32'b1011;reg_im=16'b1110;reg_opcode=5'b10000;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_ORI TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b111110;reg_B=32'b1000;reg_im=16'b1110;reg_opcode=5'b10001;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b0011011;reg_B=32'b1011;reg_im=16'b1110;reg_opcode=5'b10001;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_SLT TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b11;reg_B=32'b1000;reg_im=16'b1110;reg_opcode=5'b10010;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b1111_1111_1111_0000_1111_1111_1111_1111;reg_B=32'b1011;reg_im=16'b1110;reg_opcode=5'b10010;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_SLTI TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b111111;reg_B=32'b1000;reg_im=16'b1110;reg_opcode=5'b10011;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b1111_1111_1111_0000_1111_1111_1111_1111;reg_B=32'b1011;reg_im=16'b1110;reg_opcode=5'b10011;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $display("----------------------------------------------------------");
		$display("                      MIPS_SLTU TEST                       ");
		$display("----------------------------------------------------------");
        #20 reg_A=32'b11;reg_B=32'b1000;reg_im=16'b1110;reg_opcode=5'b10100;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b",Hi,Lo);
        $display("----------------------------------------------------------\n");
        #20 reg_A=32'b1111_1111_1111_0000_1111_1111_1111_1111;reg_B=32'b1011;reg_im=16'b1110;reg_opcode=5'b10100;#20
        $display("reg_A=%b reg_B=%b reg_im=%b opcode=%b\n",a,b,im,opcode,);
        $display("reg_C=%b overflow=%b negative=%b zero=%b\n",reg_C,overflow,negative,zero);
        $display("Hi=%b Lo=%b\n",Hi,Lo);
        $finish;
    end
    endmodule

module ALU(a,b,im,opcode,result,Hi,Lo,overflow,negative,zero);
    input [31:0] a,b;
    input [15:0] im;
    input[4:0] opcode;
    output[31:0] result,Hi,Lo;
    output overflow,negative,zero;
    wire [31:0] Hi_mult,Lo_mult,Hi_div,Lo_div,Hi_multu,Lo_multu,Hi_divu,Lo_divu;
    wire [31:0] result_add,result_sub,result_mult,result_div,result_addi,
                result_addu,result_subu,result_multu,result_divu,result_addiu,
                result_sqrt,result_and,result_or,result_nor,result_xor,
                result_xnor,result_andi,result_ori,result_slt,result_slti,result_sltu;
    wire overflow_add,overflow_sub,overflow_mult,overflow_div,overflow_addi,
         overflow_addu,overflow_subu,overflow_multu,overflow_divu,overflow_addiu,
         overflow_sqrt,overflow_and,overflow_or,overflow_nor,overflow_xor,
         overflow_xnor,overflow_andi,overflow_ori,overflow_slt,overflow_slti,overflow_sltu;
    A_add m0(a,b,result_add,overflow_add);
    A_sub m1(a,b,result_sub,overflow_sub);
    A_mult m2(a,b,Hi_mult,Lo_mult,overflow_mult);
    A_div m3(a,b,Hi_div,Lo_div,overflow_div);
    A_addi m4(a,im,result_addi,overflow_addi);
    A_addu m5(a,b,result_addu,overflow_addu);
    A_subu m6(a,b,result_subu,overflow_subu);
    A_multu m7(a,b,Hi_multu,Lo_multu,overflow_multu);
    A_divu m8(a,b,Hi_divu,Lo_divu,overflow_divu);
    A_addiu m9(a,im,result_addiu,overflow_addiu);
    A_sqrt m10(a,result_sqrt,overflow_sqrt);
    A_and m11(a,b,result_and,overflow_and);
    A_or m12(a,b,result_or,overflow_or);
    A_nor m13(a,b,result_nor,overflow_nor);
    A_xor m14(a,b,result_xor,overflow_xor);
    A_xnor m15(a,b,result_xnor,overflow_xnor);
    A_andi m16(a,im,result_andi,overflow_andi);
    A_ori m17(a,im,result_ori,overflow_ori);
    A_slt m18(a,b,result_slt,overflow_slt);
    A_slti m19(a,im,result_slti,overflow_slti);
    A_sltu m20(a,b,result_sltu,overflow_sltu);
    multiplexer_32bits mu0(opcode,result_add,result_sub,result_mult,result_div,result_addi,
                           result_addu,result_subu,result_multu,result_divu,result_addiu,
                           result_sqrt,result_and,result_or,result_nor,result_xor,
                           result_xnor,result_andi,result_ori,result_slt,result_slti,result_sltu,result);
    multiplexer_1bit mu1(opcode,overflow_add,overflow_sub,overflow_mult,overflow_div,overflow_addi,
                           overflow_addu,overflow_subu,overflow_multu,overflow_divu,overflow_addiu,
                           overflow_sqrt,overflow_and,overflow_or,overflow_nor,overflow_xor,
                           overflow_xnor,overflow_andi,overflow_ori,overflow_slt,overflow_slti,overflow_sltu,overflow);
    multiplexer_4to1 mu2(opcode,Hi_mult,Hi_div,Hi_multu,Hi_divu,Hi);
    multiplexer_4to1 mu3(opcode,Lo_mult,Lo_div,Lo_multu,Lo_divu,Lo);
    assign zero=~(|result);
    assign negative=~opcode[4]&~opcode[3]&~opcode[2]&~opcode[1]&~opcode[0]&result[31]
                    |~opcode[4]&~opcode[3]&~opcode[2]&~opcode[1]&opcode[0]&result[31]
                    |~opcode[4]&~opcode[3]&opcode[2]&~opcode[1]&~opcode[0]&result[31]
                    |~opcode[4]&~opcode[3]&opcode[2]&opcode[1]&~opcode[0]&result[31];
    assign result_mult=32'b0;
    assign result_div=32'b0;
    assign result_multu=32'b0;
    assign result_divu=32'b0;
endmodule

module multiplexer_1bit(op,u0,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15,u16,u17,u18,u19,u20,result);
    input [4:0] op;
    input u0,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15,u16,u17,u18,u19,u20;
    output result;
    assign result=~op[4]&~op[3]&~op[2]&~op[1]&~op[0]&u0|~op[4]&~op[3]&~op[2]&~op[1]&op[0]&u1
                 |~op[4]&~op[3]&~op[2]&op[1]&~op[0]&u2|~op[4]&~op[3]&~op[2]&op[1]&op[0]&u3
                 |~op[4]&~op[3]&op[2]&~op[1]&~op[0]&u4|~op[4]&~op[3]&op[2]&~op[1]&op[0]&u5
                 |~op[4]&~op[3]&op[2]&op[1]&~op[0]&u6|~op[4]&~op[3]&op[2]&op[1]&op[0]&u7
                 |~op[4]&op[3]&~op[2]&~op[1]&~op[0]&u8|~op[4]&op[3]&~op[2]&~op[1]&op[0]&u9
                 |~op[4]&op[3]&~op[2]&op[1]&~op[0]&u10|~op[4]&op[3]&~op[2]&op[1]&op[0]&u11
                 |~op[4]&op[3]&op[2]&~op[1]&~op[0]&u12|~op[4]&op[3]&op[2]&~op[1]&op[0]&u13
                 |~op[4]&op[3]&op[2]&op[1]&~op[0]&u14|~op[4]&op[3]&op[2]&op[1]&op[0]&u15
                 |op[4]&~op[3]&~op[2]&~op[1]&~op[0]&u16|op[4]&~op[3]&~op[2]&~op[1]&op[0]&u17
                 |op[4]&~op[3]&~op[2]&op[1]&~op[0]&u18|op[4]&~op[3]&~op[2]&op[1]&op[0]&u19
                 |op[4]&~op[3]&op[2]&~op[1]&~op[0]&u20;
endmodule

module multiplexer_32bits(op,u0,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15,u16,u17,u18,u19,u20,result);
    input [4:0] op;
    input [31:0] u0,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15,u16,u17,u18,u19,u20;
    output [31:0] result;
    wire [31:0] op4,op3,op2,op1,op0;
    assign op4={32{op[4]}};
    assign op3={32{op[3]}};
    assign op2={32{op[2]}};
    assign op1={32{op[1]}};
    assign op0={32{op[0]}};
    assign result=~op4&~op3&~op2&~op1&~op0&u0|~op4&~op3&~op2&~op1&op0&u1
                 |~op4&~op3&~op2&op1&~op0&u2|~op4&~op3&~op2&op1&op0&u3
                 |~op4&~op3&op2&~op1&~op0&u4|~op4&~op3&op2&~op1&op0&u5
                 |~op4&~op3&op2&op1&~op0&u6|~op4&~op3&op2&op1&op0&u7
                 |~op4&op3&~op2&~op1&~op0&u8|~op4&op3&~op2&~op1&op0&u9
                 |~op4&op3&~op2&op1&~op0&u10|~op4&op3&~op2&op1&op0&u11
                 |~op4&op3&op2&~op1&~op0&u12|~op4&op3&op2&~op1&op0&u13
                 |~op4&op3&op2&op1&~op0&u14|~op4&op3&op2&op1&op0&u15
                 |op4&~op3&~op2&~op1&~op0&u16|op4&~op3&~op2&~op1&op0&u17
                 |op4&~op3&~op2&op1&~op0&u18|op4&~op3&~op2&op1&op0&u19
                 |op4&~op3&op2&~op1&~op0&u20;
endmodule

module multiplexer_4to1(op,u0,u1,u2,u3,result);
    input [4:0] op;
    input [31:0] u0,u1,u2,u3,u4;
    output [31:0] result;
    wire [31:0] op4,op3,op2,op1,op0;
    assign op4={32{op[4]}};
    assign op3={32{op[3]}};
    assign op2={32{op[2]}};
    assign op1={32{op[1]}};
    assign op0={32{op[0]}};
    assign result=~op4&~op3&~op2&op1&~op0&u0|~op4&~op3&~op2&op1&op0&u1|~op4&~op3&op2&op1&op0&u2|~op4&op3&~op2&~op1&~op0&u3;
endmodule

module single_add(adder1,adder2,carryin,sum,carryout);
    input adder1,adder2,carryin;
    output sum,carryout;
    assign sum=((~adder1)&(~adder2)&carryin)|((~adder1)&adder2&(~carryin))|(adder1&(~adder2)&(~carryin))|(adder1&adder2&carryin);
    assign carryout=((~adder1)&adder2&carryin)|(adder1&(~adder2)&carryin)|(adder1&adder2&(~carryin))|(adder1&adder2&carryin);
endmodule

module A_add(a,b,sum,overflow);
    input[31:0] a,b;
    output[31:0] sum;
    output overflow;
    wire carryin;
    assign carryin=1'b0;
    wire [31:0] carryout;
    single_add a0(a[0],b[0],carryin,sum[0],carryout[0]);
    single_add a1(a[1],b[1],carryout[0],sum[1],carryout[1]);
    single_add a2(a[2],b[2],carryout[1],sum[2],carryout[2]);
    single_add a3(a[3],b[3],carryout[2],sum[3],carryout[3]);
    single_add a4(a[4],b[4],carryout[3],sum[4],carryout[4]);
    single_add a5(a[5],b[5],carryout[4],sum[5],carryout[5]);
    single_add a6(a[6],b[6],carryout[5],sum[6],carryout[6]);
    single_add a7(a[7],b[7],carryout[6],sum[7],carryout[7]);
    single_add a8(a[8],b[8],carryout[7],sum[8],carryout[8]);
    single_add a9(a[9],b[9],carryout[8],sum[9],carryout[9]);
    single_add a10(a[10],b[10],carryout[9],sum[10],carryout[10]);
    single_add a11(a[11],b[11],carryout[10],sum[11],carryout[11]);
    single_add a12(a[12],b[12],carryout[11],sum[12],carryout[12]);
    single_add a13(a[13],b[13],carryout[12],sum[13],carryout[13]);
    single_add a14(a[14],b[14],carryout[13],sum[14],carryout[14]);
    single_add a15(a[15],b[15],carryout[14],sum[15],carryout[15]);
    single_add a16(a[16],b[16],carryout[15],sum[16],carryout[16]);
    single_add a17(a[17],b[17],carryout[16],sum[17],carryout[17]);
    single_add a18(a[18],b[18],carryout[17],sum[18],carryout[18]);
    single_add a19(a[19],b[19],carryout[18],sum[19],carryout[19]);
    single_add a20(a[20],b[20],carryout[19],sum[20],carryout[20]);
    single_add a21(a[21],b[21],carryout[20],sum[21],carryout[21]);
    single_add a22(a[22],b[22],carryout[21],sum[22],carryout[22]);
    single_add a23(a[23],b[23],carryout[22],sum[23],carryout[23]);
    single_add a24(a[24],b[24],carryout[23],sum[24],carryout[24]);
    single_add a25(a[25],b[25],carryout[24],sum[25],carryout[25]);
    single_add a26(a[26],b[26],carryout[25],sum[26],carryout[26]);
    single_add a27(a[27],b[27],carryout[26],sum[27],carryout[27]);
    single_add a28(a[28],b[28],carryout[27],sum[28],carryout[28]);
    single_add a29(a[29],b[29],carryout[28],sum[29],carryout[29]);
    single_add a30(a[30],b[30],carryout[29],sum[30],carryout[30]);
    single_add a31(a[31],b[31],carryout[30],sum[31],carryout[31]);
    assign overflow=(a[31]&b[31]&(~sum[31]))|((~a[31])&(~b[31])&sum[31]);
endmodule

module A_addu(a,b,sum,overflow);
    input [31:0] a,b;
    output [31:0] sum;
    output overflow;
    wire overflow_0;
    A_add au(a,b,sum,overflow_0);
    assign overflow=1'b0;
endmodule

module A_addi(a,im,sum,overflow);
    input [31:0] a;
    input [15:0] im;
    output [31:0] sum;
    output overflow;
    wire [31:0] c;
    assign c={{16{im[15]}},im[15:0]};
    A_add ai(a,c,sum,overflow);
endmodule

module A_addiu(a,im,sum,overflow);
    input [31:0] a;
    input [15:0] im;
    output [31:0] sum;
    output overflow;
    wire [31:0] c;
    wire overflow_0;
    assign c={{16{im[15]}},im[15:0]};
    A_add aiu(a,c,sum,overflow_0);
    assign overflow=1'b0;
endmodule

module twoscomplement(x,y);
    input [31:0] x;
    output [31:0] y;
    wire [31:0] z;
    assign z=~x;
    A_add a(z,32'b1,y,overflow);
endmodule

module A_sub(a,b,difference,overflow);
    input [31:0] a,b;
    output [31:0] difference;
    output overflow;
    wire [31:0] c;
    twoscomplement t0(b,c);
    A_add s(a,c,difference,overflow);
endmodule

module A_subu(a,b,difference,overflow);
    input [31:0] a,b;
    output [31:0] difference;
    output overflow;
    wire overflow_0;
    A_sub su(a,b,difference,overflow_0);
    assign overflow=1'b0;
endmodule

module A_mult(a,b,Hi,Lo,overflow);
    input [31:0] a,b;
    output [31:0] Hi,Lo;
    output overflow;
    wire [31:0] p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,p30,p31;
    assign p0=a&{32{b[0]}};
    assign p1=a&{32{b[1]}};
    assign p2=a&{32{b[2]}};
    assign p3=a&{32{b[3]}};
    assign p4=a&{32{b[4]}};
    assign p5=a&{32{b[5]}};
    assign p6=a&{32{b[6]}};
    assign p7=a&{32{b[7]}};
    assign p8=a&{32{b[8]}};
    assign p9=a&{32{b[9]}};
    assign p10=a&{32{b[10]}};
    assign p11=a&{32{b[11]}};
    assign p12=a&{32{b[12]}};
    assign p13=a&{32{b[13]}};
    assign p14=a&{32{b[14]}};
    assign p15=a&{32{b[15]}};
    assign p16=a&{32{b[16]}};
    assign p17=a&{32{b[17]}};
    assign p18=a&{32{b[18]}};
    assign p19=a&{32{b[19]}};
    assign p20=a&{32{b[20]}};
    assign p21=a&{32{b[21]}};
    assign p22=a&{32{b[22]}};
    assign p23=a&{32{b[23]}};
    assign p24=a&{32{b[24]}};
    assign p25=a&{32{b[25]}};
    assign p26=a&{32{b[26]}};
    assign p27=a&{32{b[27]}};
    assign p28=a&{32{b[28]}};
    assign p29=a&{32{b[29]}};
    assign p30=a&{32{b[30]}};
    assign p31=a&{32{b[31]}};
    wire [63:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31;
    assign x0={{32{p0[31]}},p0}<<0;
    assign x1={{32{p1[31]}},p1}<<1;
    assign x2={{32{p2[31]}},p2}<<2;
    assign x3={{32{p3[31]}},p3}<<3;
    assign x4={{32{p4[31]}},p4}<<4;
    assign x5={{32{p5[31]}},p5}<<5;
    assign x6={{32{p6[31]}},p6}<<6;
    assign x7={{32{p7[31]}},p7}<<7;
    assign x8={{32{p8[31]}},p8}<<8;
    assign x9={{32{p9[31]}},p9}<<9;
    assign x10={{32{p10[31]}},p10}<<10;
    assign x11={{32{p11[31]}},p11}<<11;
    assign x12={{32{p12[31]}},p12}<<12;
    assign x13={{32{p13[31]}},p13}<<13;
    assign x14={{32{p14[31]}},p14}<<14;
    assign x15={{32{p15[31]}},p15}<<15;
    assign x16={{32{p16[31]}},p16}<<16;
    assign x17={{32{p17[31]}},p17}<<17;
    assign x18={{32{p18[31]}},p18}<<18;
    assign x19={{32{p19[31]}},p19}<<19;
    assign x20={{32{p20[31]}},p20}<<20;
    assign x21={{32{p21[31]}},p21}<<21;
    assign x22={{32{p22[31]}},p22}<<22;
    assign x23={{32{p23[31]}},p23}<<23;
    assign x24={{32{p24[31]}},p24}<<24;
    assign x25={{32{p25[31]}},p25}<<25;
    assign x26={{32{p26[31]}},p26}<<26;
    assign x27={{32{p27[31]}},p27}<<27;
    assign x28={{32{p28[31]}},p28}<<28;
    assign x29={{32{p29[31]}},p29}<<29;
    assign x30={{32{p30[31]}},p30}<<30;
    assign x31={{32{p31[31]}},p31}<<31;
    wire [63:0] product;
    assign product=x0+x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+x15+x16+x17+x18+x19+x20+x21+x22+x23+x24+x25+x26+x27+x28+x29+x30+x31;
    assign Hi=product[63:32];
    assign Lo=product[31:0];
    assign overflow=1'b0;
endmodule

module A_multu(a,b,Hi,Lo,overflow);
    input [31:0] a,b;
    output [31:0] Hi,Lo;
    output overflow;
    wire [31:0] p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,p30,p31;
    assign p0=a&{32{b[0]}};
    assign p1=a&{32{b[1]}};
    assign p2=a&{32{b[2]}};
    assign p3=a&{32{b[3]}};
    assign p4=a&{32{b[4]}};
    assign p5=a&{32{b[5]}};
    assign p6=a&{32{b[6]}};
    assign p7=a&{32{b[7]}};
    assign p8=a&{32{b[8]}};
    assign p9=a&{32{b[9]}};
    assign p10=a&{32{b[10]}};
    assign p11=a&{32{b[11]}};
    assign p12=a&{32{b[12]}};
    assign p13=a&{32{b[13]}};
    assign p14=a&{32{b[14]}};
    assign p15=a&{32{b[15]}};
    assign p16=a&{32{b[16]}};
    assign p17=a&{32{b[17]}};
    assign p18=a&{32{b[18]}};
    assign p19=a&{32{b[19]}};
    assign p20=a&{32{b[20]}};
    assign p21=a&{32{b[21]}};
    assign p22=a&{32{b[22]}};
    assign p23=a&{32{b[23]}};
    assign p24=a&{32{b[24]}};
    assign p25=a&{32{b[25]}};
    assign p26=a&{32{b[26]}};
    assign p27=a&{32{b[27]}};
    assign p28=a&{32{b[28]}};
    assign p29=a&{32{b[29]}};
    assign p30=a&{32{b[30]}};
    assign p31=a&{32{b[31]}};
    wire [63:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31;
    assign x0={32'b0,p0}<<0;
    assign x1={32'b0,p1}<<1;
    assign x2={32'b0,p2}<<2;
    assign x3={32'b0,p3}<<3;
    assign x4={32'b0,p4}<<4;
    assign x5={32'b0,p5}<<5;
    assign x6={32'b0,p6}<<6;
    assign x7={32'b0,p7}<<7;
    assign x8={32'b0,p8}<<8;
    assign x9={32'b0,p9}<<9;
    assign x10={32'b0,p10}<<10;
    assign x11={32'b0,p11}<<11;
    assign x12={32'b0,p12}<<12;
    assign x13={32'b0,p13}<<13;
    assign x14={32'b0,p14}<<14;
    assign x15={32'b0,p15}<<15;
    assign x16={32'b0,p16}<<16;
    assign x17={32'b0,p17}<<17;
    assign x18={32'b0,p18}<<18;
    assign x19={32'b0,p19}<<19;
    assign x20={32'b0,p20}<<20;
    assign x21={32'b0,p21}<<21;
    assign x22={32'b0,p22}<<22;
    assign x23={32'b0,p23}<<23;
    assign x24={32'b0,p24}<<24;
    assign x25={32'b0,p25}<<25;
    assign x26={32'b0,p26}<<26;
    assign x27={32'b0,p27}<<27;
    assign x28={32'b0,p28}<<28;
    assign x29={32'b0,p29}<<29;
    assign x30={32'b0,p30}<<30;
    assign x31={32'b0,p31}<<31;
    wire [63:0] product;
    assign product=x0+x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+x15+x16+x17+x18+x19+x20+x21+x22+x23+x24+x25+x26+x27+x28+x29+x30+x31;
    assign Hi=product[63:32];
    assign Lo=product[31:0];
    assign overflow=1'b0;
endmodule

module A_and(a,b,result,overflow);
    input [31:0] a,b;
    output [31:0] result;
    output overflow;
    assign result=a&b;
    assign overflow=1'b0;
endmodule

module A_or(a,b,result,overflow);
    input [31:0] a,b;
    output [31:0] result;
    output overflow;
    assign result=a|b;
    assign overflow=1'b0;
endmodule

module A_nor(a,b,result,overflow);
    input [31:0] a,b;
    output [31:0] result;
    output overflow;
    assign result=~(a|b);
    assign overflow=1'b0;
endmodule

module A_xor(a,b,result,overflow);
    input [31:0] a,b;
    output [31:0] result;
    output overflow;
    assign result=a^b;
    assign overflow=1'b0;
endmodule

module A_nand(a,b,result,overflow);
    input [31:0] a,b;
    output [31:0] result;
    output overflow;
    assign result=~(a&b);
    assign overflow=1'b0;
endmodule

module A_xnor(a,b,result,overflow);
    input [31:0] a,b;
    output [31:0] result;
    output overflow;
    assign result=~(a^b);
    assign overflow=1'b0;
endmodule

module A_andi(a,im,result,overflow);
    input [31:0] a;
    input [15:0] im;
    output [31:0] result;
    output overflow;
    wire [31:0] c;
    assign c={16'b0,im};
    assign result=a&c;
    assign overflow=1'b0;
endmodule

module A_ori(a,im,result,overflow);
    input [31:0] a;
    input [15:0] im;
    output [31:0] result;
    output overflow;
    wire [31:0] c;
    assign c={16'b0,im};
    assign result=a|c;
    assign overflow=1'b0;
endmodule

module single_comparator(a,b,larger_before,equal_before,less_before,larger_result,equal_result,less_result);
    input a,b;
    input larger_before,equal_before,less_before;
    output larger_result,equal_result,less_result;
    assign larger_result=a&~b|(a&b|~a&~b)&larger_before;
    assign equal_result=(a&b|~a&~b)&equal_before;
    assign less_result=~a&b|(a&b|~a&~b)&less_before;
endmodule

module comparator_32bits_unsign(a,b,larger_result,equal_result,less_result);
    input [31:0] a,b;
    output larger_result,equal_result,less_result;
    wire m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18,m19,m20,m21,m22,m23,m24,m25,m26,m27,m28,m29,m30,m31;
    wire e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25,e26,e27,e28,e29,e30,e31;
    wire l0,l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,l12,l13,l14,l15,l16,l17,l18,l19,l20,l21,l22,l23,l24,l25,l26,l27,l28,l29,l30,l31;
    assign m0=0;
    assign e0=0;
    assign l0=0;
    single_comparator s0(a[0],b[0],m0,e0,l0,m1,e1,l1);
    single_comparator s1(a[1],b[1],m1,e1,l1,m2,e2,l2);
    single_comparator s2(a[2],b[2],m2,e2,l2,m3,e3,l3);
    single_comparator s3(a[3],b[3],m3,e3,l3,m4,e4,l4);
    single_comparator s4(a[4],b[4],m4,e4,l4,m5,e5,l5);
    single_comparator s5(a[5],b[5],m5,e5,l5,m6,e6,l6);
    single_comparator s6(a[6],b[6],m6,e6,l6,m7,e7,l7);
    single_comparator s7(a[7],b[7],m7,e7,l7,m8,e8,l8);
    single_comparator s8(a[8],b[8],m8,e8,l8,m9,e9,l9);
    single_comparator s9(a[9],b[9],m9,e9,l9,m10,e10,l10);
    single_comparator s10(a[10],b[10],m10,e10,l10,m11,e11,l11);
    single_comparator s11(a[11],b[11],m11,e11,l11,m12,e12,l12);
    single_comparator s12(a[12],b[12],m12,e12,l12,m13,e13,l13);
    single_comparator s13(a[13],b[13],m13,e13,l13,m14,e14,l14);
    single_comparator s14(a[14],b[14],m14,e14,l14,m15,e15,l15);
    single_comparator s15(a[15],b[15],m15,e15,l15,m16,e16,l16);
    single_comparator s16(a[16],b[16],m16,e16,l16,m17,e17,l17);
    single_comparator s17(a[17],b[17],m17,e17,l17,m18,e18,l18);
    single_comparator s18(a[18],b[18],m18,e18,l18,m19,e19,l19);
    single_comparator s19(a[19],b[19],m19,e19,l19,m20,e20,l20);
    single_comparator s20(a[20],b[20],m20,e20,l20,m21,e21,l21);
    single_comparator s21(a[21],b[21],m21,e21,l21,m22,e22,l22);
    single_comparator s22(a[22],b[22],m22,e22,l22,m23,e23,l23);
    single_comparator s23(a[23],b[23],m23,e23,l23,m24,e24,l24);
    single_comparator s24(a[24],b[24],m24,e24,l24,m25,e25,l25);
    single_comparator s25(a[25],b[25],m25,e25,l25,m26,e26,l26);
    single_comparator s26(a[26],b[26],m26,e26,l26,m27,e27,l27);
    single_comparator s27(a[27],b[27],m27,e27,l27,m28,e28,l28);
    single_comparator s28(a[28],b[28],m28,e28,l28,m29,e29,l29);
    single_comparator s29(a[29],b[29],m29,e29,l29,m30,e30,l30);
    single_comparator s30(a[30],b[30],m30,e30,l30,m31,e31,l31);
    single_comparator s31(a[31],b[31],m31,e31,l31,larger_result,equal_result,less_result);
endmodule

module comparator_32bits_sign(a,b,larger_result,equal_result,less_result);
    input [31:0] a,b;
    output larger_result,equal_result,less_result;
    wire [31:0] c,d;
    wire internal_larger_result,internal_equal_result,internal_less_result;
    wire larger_result,equal_result,less_result;
    assign c={1'b0,a[30:0]};
    assign d={1'b0,b[30:0]};
    comparator_32bits_unsign c1(c,d,internal_larger_result,internal_equal_result,internal_less_result);
    assign less_result=a[31]&~b[31]|a[31]&b[31]&internal_less_result|~a[31]&~b[31]&internal_less_result;
    assign equal_result=a[31]&b[31]&internal_equal_result|~a[31]&~b[31]&internal_equal_result;
    assign larger_result=~a[31]&b[31]|a[31]&b[31]&internal_larger_result|~a[31]&~b[31]&internal_larger_result;
endmodule

module A_slt(a,b,result,overflow);
    input [31:0] a,b;
    output [31:0] result;
    output overflow;
    wire larger_result,equal_result,less_result;
    comparator_32bits_sign c2(a,b,larger_result,equal_result,less_result);
    assign result=(32'b1)&less_result;
    assign overflow=32'b0;
endmodule

module A_slti(a,im,result,overflow);
    input [31:0] a;
    input [15:0] im;
    output [31:0] result;
    output overflow;
    wire [31:0] c;
    assign c={{16{im[15]}},im};
    wire larger_result,equal_result,less_result;
    comparator_32bits_sign c2(a,c,larger_result,equal_result,less_result);
    assign result=(32'b1)&less_result;
    assign overflow=32'b0;
endmodule

module A_sltu(a,b,result,overflow);
    input [31:0] a,b;
    output [31:0] result;
    output overflow;
    wire larger_result,equal_result,less_result;
    comparator_32bits_unsign c0(a,b,larger_result,equal_result,less_result);
    assign result=(32'b1)&less_result;
    assign overflow=32'b0;
endmodule

module single_div(remainder,divisor,result);
    input [63:0] remainder;
    input [31:0] divisor;
    output [63:0] result;
    output [31:0] left_new_remainder;
    wire soverflow;
    wire [63:0] new_remainder;
    wire [31:0] left_remainder,left_new_remainder;
    assign left_remainder=remainder[63:32];
    A_sub sub(left_remainder,divisor,left_new_remainder,soverflow);
    assign new_remainder={left_new_remainder,remainder[31:0]};
    wire [63:0]less;
    assign less={64{left_new_remainder[31]}};
    wire [63:0] result_a,result_b;
    assign result_a={new_remainder[62:0],1'b1};
    assign result_b=remainder<<1;
    assign result=~less&result_a|less&result_b;
endmodule

module A_divu(a,b,Hi,Lo,overflow);
    input [31:0] a,b;
    output [31:0] Hi,Lo;
    output overflow;
    wire [63:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31;
    wire [63:0] result,remainder_quotient;
    assign r0={32'b0,a[31:0]}<<1;
    single_div d0(r0,b,r1);
    single_div d1(r1,b,r2);
    single_div d2(r2,b,r3);
    single_div d3(r3,b,r4);
    single_div d4(r4,b,r5);
    single_div d5(r5,b,r6);
    single_div d6(r6,b,r7);
    single_div d7(r7,b,r8);
    single_div d8(r8,b,r9);
    single_div d9(r9,b,r10);
    single_div d10(r10,b,r11);
    single_div d11(r11,b,r12);
    single_div d12(r12,b,r13);
    single_div d13(r13,b,r14);
    single_div d14(r14,b,r15);
    single_div d15(r15,b,r16);
    single_div d16(r16,b,r17);
    single_div d17(r17,b,r18);
    single_div d18(r18,b,r19);
    single_div d19(r19,b,r20);
    single_div d20(r20,b,r21);
    single_div d21(r21,b,r22);
    single_div d22(r22,b,r23);
    single_div d23(r23,b,r24);
    single_div d24(r24,b,r25);
    single_div d25(r25,b,r26);
    single_div d26(r26,b,r27);
    single_div d27(r27,b,r28);
    single_div d28(r28,b,r29);
    single_div d29(r29,b,r30);
    single_div d30(r30,b,r31);
    single_div d31(r31,b,result);
    assign remainder_quotient={1'b0,result[63:33],result[31:0]};
    assign Hi=remainder_quotient[63:32];
    assign Lo=remainder_quotient[31:0];
    assign overflow=1'b0;
endmodule

module A_div(a,b,Hi,Lo,overflow);
    input [31:0] a,b;
    output [31:0] Hi,Lo;
    output overflow;
    wire overflow1,overflow2,overflow3,overflow4;
    wire [31:0] sign_a,sign_b;
    assign sign_a={32{a[31]}};
    assign sign_b={32{b[31]}};
    wire [31:0] remainder_pp,remainder_nn,remainder_pn,remainder_np;
    wire [31:0] quotient_pp,quotient_nn,quotient_pn,quotient_np;
    wire [31:0] a_twoscomplement,b_twoscomplement;
    twoscomplement to(a,a_twoscomplement);
    twoscomplement t1(b,b_twoscomplement);
    A_divu d0(a,b,remainder_pp,quotient_pp,overflow1);
    A_divu d1(a_twoscomplement,b_twoscomplement,remainder_nn,quotient_nn,overflow2);
    A_divu d2(a,b_twoscomplement,remainder_pn,quotient_pn,overflow3);
    A_divu d3(a_twoscomplement,b,remainder_np,quotient_np,overflow4);
    wire [31:0] twos_remainder_nn,twos_quotient_pn,twos_remainder_np,twos_quotient_np;
    twoscomplement t2(remainder_nn,twos_remainder_nn);
    twoscomplement t3(quotient_pn,twos_quotient_pn);
    twoscomplement t4(remainder_np,twos_remainder_np);
    twoscomplement t5(quotient_np,twos_quotient_np);
    assign Hi=~sign_a&~sign_b&remainder_pp|sign_a&sign_b&twos_remainder_nn|~sign_a&sign_b&remainder_pn|sign_a&~sign_b&twos_remainder_np;
    assign Lo=~sign_a&~sign_b&quotient_pp|sign_a&sign_b&quotient_nn|~sign_a&sign_b&twos_quotient_pn|sign_a&~sign_b&twos_quotient_np;
    assign overflow=1'b0;
endmodule

module A_sqrt(a,result,overflow);
    input[31:0] a;
    output[31:0] result;
    output overflow;

    wire [31:0] sqrt1;
    assign sqrt1={16'b0,1'b1,15'b0};
    wire large1,equal1,less1;
    wire [31:0] product1;
    assign product1=sqrt1*sqrt1;
    comparator_32bits_unsign c0(product1,a,large1,equal1,less1);
    wire result1;
    assign result1=equal1|less1;

    wire [31:0] sqrt2;
    assign sqrt2={16'b0,~large1,1'b1,14'b0};
    wire large2,equal2,less2;
    wire [31:0] product2;
    assign product2=sqrt2*sqrt2;
    comparator_32bits_unsign c1(product2,a,large2,equal2,less2);
    wire result2;
    assign result2=equal2|less2;

    wire [31:0] sqrt3;
    assign sqrt3={16'b0,~large1,~large2,1'b1,13'b0};
    wire large3,equal3,less3;
    wire [31:0] product3;
    assign product3=sqrt3*sqrt3;
    comparator_32bits_unsign c2(product3,a,large3,equal3,less3);
    wire result3;
    assign result3=less3;

    wire [31:0] sqrt4;
    assign sqrt4={16'b0,~large1,~large2,~large3,1'b1,12'b0};
    wire large4,equal4,less4;
    wire [31:0] product4;
    assign product4=sqrt4*sqrt4;
    comparator_32bits_unsign c3(product4,a,large4,equal4,less4);
    wire result4;
    assign result3=equal4|less4;

    wire [31:0] sqrt5;
    assign sqrt5={16'b0,~large1,~large2,~large3,~large4,1'b1,11'b0};
    wire large5,equal5,less5;
    wire [31:0] product5;
    assign product5=sqrt5*sqrt5;
    comparator_32bits_unsign c4(product5,a,large5,equal5,less5);
    wire result5;
    assign result5=equal5|less5;

    wire [31:0] sqrt6;
    assign sqrt6={16'b0,~large1,~large2,~large3,~large4,~large5,1'b1,10'b0};
    wire large6,equal6,less6;
    wire [31:0] product6;
    assign product6=sqrt6*sqrt6;
    comparator_32bits_unsign c5(product6,a,large6,equal6,less6);
    wire result6;
    assign result6=equal6|less6;

    wire [31:0] sqrt7;
    assign sqrt7={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,1'b1,9'b0};
    wire large7,equal7,less7;
    wire [31:0] product7;
    assign product7=sqrt7*sqrt7;
    comparator_32bits_unsign c6(product7,a,large7,equal7,less7);
    wire result7;
    assign result7=equal7|less7;

    wire [31:0] sqrt8;
    assign sqrt8={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,~large7,1'b1,8'b0};
    wire large8,equal8,less8;
    wire [31:0] product8;
    assign product8=sqrt8*sqrt8;
    comparator_32bits_unsign c7(product8,a,large8,equal8,less8);
    wire result8;
    assign result8=equal8|less8;

    wire [31:0] sqrt9;
    assign sqrt9={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,~large7,~large8,1'b1,7'b0};
    wire large9,equal9,less9;
    wire [31:0] product9;
    assign product9=sqrt9*sqrt9;
    comparator_32bits_unsign c8(product9,a,large9,equal9,less9);
    wire result9;
    assign result9=equal9|less9;

    wire [31:0] sqrt10;
    assign sqrt10={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,~large7,~large8,~large9,1'b1,6'b0};
    wire large10,equal10,less10;
    wire [31:0] product10;
    assign product10=sqrt10*sqrt10;
    comparator_32bits_unsign c9(product10,a,large10,equal10,less10);
    wire result10;
    assign result10=equal10|less10;

    wire [31:0] sqrt11;
    assign sqrt11={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,~large7,~large8,~large9,~large10,1'b1,5'b0};
    wire large11,equal11,less11;
    wire [31:0] product11;
    assign product11=sqrt11*sqrt11;
    comparator_32bits_unsign c10(product11,a,large11,equal11,less11);
    wire result11;
    assign result11=equal11|less11;

    wire [31:0] sqrt12;
    assign sqrt12={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,~large7,~large8,~large9,~large10,~large11,1'b1,4'b0};
    wire large12,equal12,less12;
    wire [31:0] product12;
    assign product12=sqrt12*sqrt12;
    comparator_32bits_unsign c11(product12,a,large12,equal12,less12);
    wire result12;
    assign result12=equal12|less12;

    wire [31:0] sqrt13;
    assign sqrt13={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,~large7,~large8,~large9,~large10,~large11,~large12,1'b1,3'b0};
    wire large13,equal13,less13;
    wire [31:0] product13;
    assign product13=sqrt13*sqrt13;
    comparator_32bits_unsign c12(product13,a,large13,equal13,less13);
    wire result13;
    assign result13=equal13|less13;

    wire [31:0] sqrt14;
    assign sqrt14={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,~large7,~large8,~large9,~large10,~large11,~large12,~large13,1'b1,2'b0};
    wire large14,equal14,less14;
    wire [31:0] product14;
    assign product14=sqrt14*sqrt14;
    comparator_32bits_unsign c13(product14,a,large14,equal14,less14);
    wire result14;
    assign result14=equal14|less14;

    wire [31:0] sqrt15;
    assign sqrt15={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,~large7,~large8,~large9,~large10,~large11,~large12,~large13,~large14,1'b1,1'b0};
    wire large15,equal15,less15;
    wire [31:0] product15;
    assign product15=sqrt15*sqrt15;
    comparator_32bits_unsign c14(product15,a,large15,equal15,less15);
    wire result15;
    assign result15=equal15|less15;

    wire [31:0] sqrt16;
    assign sqrt16={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,~large7,~large8,~large9,~large10,~large11,~large12,~large13,~large14,~large15,1'b1};
    wire large16,equal16,less16;
    wire [31:0] product16;
    assign product16=sqrt16*sqrt16;
    comparator_32bits_unsign c15(product16,a,large16,equal16,less16);
    wire result16;
    assign result16=equal16|less16;

    assign result={16'b0,~large1,~large2,~large3,~large4,~large5,~large6,~large7,~large8,~large9,~large10,~large11,~large12,~large13,~large14,~large15,~large16};
    assign overflow=1'b0;
endmodule