`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2023 11:08:52
// Design Name: 
// Module Name: program_counter_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module program_counter_test;

reg clk_tb;
reg [15:0] IN_tb = 0;
reg load_tb = 1;
reg CE_tb = 1;
wire [15:0] OUT_tb;

program_counter PC(
        IN_tb,
        load_tb,
        CE_tb,
        clk_tb,
        OUT_tb
    );


initial
begin
//Wartoœæ pocz¹tkowa sygna³u clk_tb
clk_tb = 1'b0;
//Co 5 jednostek czasu zmien wartoœæ clk_tb na przeciwn¹
forever
#5 clk_tb = ~clk_tb;
end

initial
begin
   #11 load_tb = 0;
   IN_tb = 10;
   #60 load_tb = 1;
   #11 load_tb = 0;
   IN_tb = 22;
   #40 load_tb = 1;
   #22 load_tb = 0; 
end



endmodule
