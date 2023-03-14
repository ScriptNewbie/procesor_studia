`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Prosta pamiêæ asynchroniczna zaimplementowana przy wykorzystaniu wyra¿enia case
//////////////////////////////////////////////////////////////////////////////////


module ROM #(parameter ROM_WIDTH = 26)(
        input [15:0] ADDR,
        output reg [ROM_WIDTH-1:0] data
    );
    

   
//Zmiana na wejœciu ADDR powoduje zmienê danej na magistrali wyjœciowej
   always @(*)
         case (ADDR)
            4'b0000: data <= 1;
            4'b0001: data <= 12;
            4'b0010: data <= 14;
            4'b0011: data <= 13;
            4'b0100: data <= 12;
            4'b0101: data <= 0;
            4'b0110: data <= 15;
            4'b0111: data <= 14;
            4'b1000: data <= 16'h1CED;
            4'b1001: data <= 16'hC0FE;
            4'b1010: data <= 2;
            4'b1011: data <= 3;
            4'b1100: data <= 4;
            4'b1101: data <= 5;
            4'b1110: data <= 6;
            4'b1111: data <= 7;
            default: data <= 8;
         endcase
endmodule
