`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Bank rejestrów roboczych
//////////////////////////////////////////////////////////////////////////////////


module registers(
        input CLK,
        input CE,
        input [4:0] addr,
        input [15:0] data_in,
        
        output [15:0] data_out
    );

wire [15:0] data_out_bus [31:0];
reg [31:0] r_CE;
   
//Zainstancjownowanie wszystkich 32 rejestrów roboczych
genvar i;
generate
for (i=0; i<32; i=i+1) begin : r
   register register(
        data_in,
        CLK,
        r_CE[i],
        data_out_bus[i]
        );
end
endgenerate

always @(*)
begin
    r_CE = 32'b0;
    r_CE[addr] = CE ? 1'b1 : 1'b0; //Wypracowanie sygna³u CE dla odpowiedniego rejestru (je¿eli jest CE na wejœciu modu³u)
end

    
assign data_out = data_out_bus[addr]; //Wystawienie na wyjœcie danych z rejestru o podanym adresie


    
endmodule
