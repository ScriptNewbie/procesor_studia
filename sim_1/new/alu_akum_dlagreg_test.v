`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench po³¹czonych modu³ów - akumulatora, jednostki arytmetyczno logicznej i rejestru flag
//////////////////////////////////////////////////////////////////////////////////


module alu_akum_flagreg_test;

wire [15:0] alu_res;
wire [15:0] A_out;

wire [4:0] flag_in;
wire [4:0] flag_out;

reg [3:0] opcode;
reg [15:0] arg2;
reg clk;
reg A_ce = 1;
reg flagreg_ce = 1;

register A(
    .data_in(alu_res),
    .data_out(A_out),
    .CE(A_ce),
    .CLK(clk)
);

register #(.WIDTH(5)) flag_reg (
    .data_in(flag_out),
    .data_out(flag_in),
    .CE(flagreg_ce),
    .CLK(clk)
);    

alu alu(
        .opcode(opcode),
        .arg1(A_out),
        .arg2(arg2),
        .res(alu_res),
        .in_flg(flag_in),
        .out_flg(flag_out)
    );

//Symulacja zegara
initial
begin
clk = 1'b0;
forever
#5 clk = ~clk;
end

initial
begin
    opcode = 0;
    arg2 = 0;
    #10 arg2 = 20000; //Dodawanie wartoœci 20000 do akumulatora do przeniesienia by sprawdziæ czy w kolejnym dodawaniu doda siê flaga przeniesienia
    #45 opcode = 1; //Zmiana na odejmowanie i podobny test
    #50 $finish; //Testy reszty funkcjonalnoœci alu by³y przeprowadzane w testbenchu samego alu
end

initial
  $monitor("%t : %d : %d : %d :%b : %d : %b",$time, opcode, A_out,arg2, flag_in, alu_res, flag_out);

endmodule
