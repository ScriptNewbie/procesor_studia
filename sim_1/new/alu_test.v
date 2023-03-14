`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Test jednostki arytmetyczno logicznej
//////////////////////////////////////////////////////////////////////////////////


module alu_test;

wire [15:0] Y;
reg [15:0] A;
reg [15:0] B; 
reg [3:0] op;
reg [4:0] in_flag = 3'b0000;
wire [4:0] out_flag;
    
 alu ALU(
        .opcode(op),
        .arg1(A),
        .arg2(B),
        .in_flg(in_flag),
        .out_flg(out_flag),
        .res(Y)
    );
    
initial
    begin
    //Testowanie sumowania z przeniesieniem
    op = 0;
    A = 65535;
    B = 5;
    #10 in_flag = out_flag;
    A = 1;
    B = 1;
    #10 in_flag = out_flag; //Bez przeniesienia
    //Testowanie reszty operacji
    #10 op = 1; //Odejmowanie
    A = 7;
    B = 5;
    #20 op = 2; //AND
    #20 op = 3; //OR
    #20 op = 4; //XOR
    #20 op = 5; //NOT
    #20 op = 6; //Przepisanie 1 argumentu
    #20 op = 7; //Przepisanie 2 argumentu
    #20 $stop; 
end

initial
  $monitor("%t : %d : %d : %d : %d : %b",$time, op,A,B,Y, out_flag);
    
endmodule
