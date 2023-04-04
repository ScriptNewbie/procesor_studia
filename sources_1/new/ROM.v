`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Prosta pamiêæ asynchroniczna zaimplementowana przy wykorzystaniu wyra¿enia case
//////////////////////////////////////////////////////////////////////////////////


module ROM #(parameter ROM_WIDTH = 21)(
        input [15:0] ADDR,
        output reg [ROM_WIDTH-1:0] data
    );
    

   
//Zmiana na wejœciu ADDR powoduje zmienê danej na magistrali wyjœciowej
   always @(*)
         case (ADDR)
            4'b0000: data <= 21'b111010000000000000001;
            4'b0001: data <= 21'b110010000000000000000;//a do r1 
            4'b0010: data <= 21'b110010000000000000001;//a do r2
            4'b0011: data <= 21'b111000000000000000000;//r1 do a - loop begin
            4'b0100: data <= 21'b000000000000000000001;//dodaj r2
            4'b0101: data <= 21'b110010000000000000000;//a do r1
            4'b0110: data <= 21'b000000000000000000001;//dodaj r2
            4'b0111: data <= 21'b110010000000000000001;//a do r2
            4'b1000: data <= 21'b000000000000000000000;//dodaj r1
            4'b1001: data <= 21'b110010000000000000000;//a do r1
            4'b1010: data <= 21'b000000000000000000001;//dodaj r2
            4'b1011: data <= 21'b110010000000000000001;//a do r221'b111010000000000001011;
            4'b1100: data <= 21'b010010000000000000011;
            4'b1101: data <= 21'b111010000000000001101;
            4'b1110: data <= 21'b111010000000000001110;
            4'b1111: data <= 21'b010010000000000000000;
            default: data <= 21'b010010000000000001000;
         endcase
endmodule
