`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Parametryzowany rejestr
//////////////////////////////////////////////////////////////////////////////////


module register #(parameter WIDTH = 16)
    (
        input [WIDTH-1:0] data_in,
        input CLK,
        input CE,
        output reg [WIDTH-1:00] data_out = 0
    );
    
always @(posedge(CLK))
begin
    if(CE)data_out <= data_in; //Jeœli CE w stanie wysokim, zapisz rejestr now¹ wartoœci¹
end

    
    
    
endmodule
