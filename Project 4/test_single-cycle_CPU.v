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

    // Inputs
	reg clock;
	reg [31:0] d_datain;
	reg [31:0] i_datain;
    reg start;

    wire [31:0] d_dataout;

    CPU uut(
        .clock(clock),
        .start(start), 
		.d_datain(d_datain), 
		.i_datain(i_datain),
        .d_dataout(d_dataout)
    );

    initial begin
        // Initialize Inputs
    clock = 0;
    start = 0;
    d_datain = 0;
    i_datain = 0;
    $display("pc  :        instruction             : reg_A  : reg_B  : reg_C  : reg_C1 :d_datain:  gr0   :  gr1   :  gr2   :  gr3");
    $monitor("%h:%b:%h:%h:%h:%h:%h:%h:%h:%h:%h", 
        uut.pc, i_datain, uut.reg_A, uut.reg_B, uut.reg_C, uut.reg_C1, d_datain, uut.gr[0], uut.gr[1], uut.gr[2], uut.gr[3]);

    /*Test:*/
    //#5 start = 1;
    d_datain <= 32'h0000_00ab;
    i_datain <= {6'b100011, `gr0, `gr1, 16'h0001};

    #period d_datain <= 32'h0000_3c00;
    i_datain <= {6'b100011, `gr0, `gr2, 16'h0002};

    #period i_datain <= {6'b000000, `gr1, `gr2, `gr3,  5'b00000, 6'b100000};

    #period $finish;
    end

parameter period = 10;
always #5 clock = ~clock;
endmodule