`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Test jednostki arytmetyczno logicznej
//////////////////////////////////////////////////////////////////////////////////


module cpu_test;

reg clk = 1'b0;
  
 procesor CPU(
        .clk(clk)
    );
    
initial
 begin
    //Wartoœæ pocz¹tkowa sygna³u clk_tb
    clk = 1'b0;
    //Co 5 jednostek czasu zmien wartoœæ clk_tb na przeciwn¹
 forever
    #5 clk = ~clk;
 end
    
initial
    begin

    #500 $stop; 
end

initial
  $monitor("%t ",$time);
    
endmodule
