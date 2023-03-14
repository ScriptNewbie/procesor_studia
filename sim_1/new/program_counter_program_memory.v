`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Test po��czonych modu��w - pami�ci programu i licznika programu
//////////////////////////////////////////////////////////////////////////////////


module program_counter_program_memory;

wire [15:0] INS_addr;
wire [15:0] INS;
reg [15:0] PC_in = 0;
reg clk;
reg reset = 1;
wire PC_load;

program_counter PC(
        .IN(PC_in),
        .load(PC_load),
        .clk(clk),
        .OUT(INS_addr),
        .CE(1'b1)
);

ROM PM(
        .ADDR(INS_addr),
        .data(INS)
    );
    
initial
begin
clk = 1'b0;
forever
#5 clk = ~clk;
end

assign PC_load = INS == 16'hC0FE ? 1 : 0 | reset; //Je�li natrafisz na instrukcj� 16'hCAFE w pami�ci programu, prze�aduj licznik rozkaz�w (wyzeruj go) - or z reset w celu za�adowania warto�ci na pocz�tku symulacji

initial 
begin
#10 reset = 0;
#220 $finish;
end
endmodule
