`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Prosty licznik instrukcji
//////////////////////////////////////////////////////////////////////////////////

module program_counter(
        input [15:0] IN,
        input load,
        input CE,
        input clk,
        output reg [15:0] OUT
    );

always @(posedge(clk))
begin
    if(CE)
    begin
        if(load) OUT = IN; //Jeœli CE i load w stanie wysokim prze³aduj licznik instrukcji
        else OUT = OUT + 1; //W innym wypadku zinkrementuj wartoœæ
    end
end    
  
endmodule
