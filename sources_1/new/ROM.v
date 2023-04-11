`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Prosta pamiêæ asynchroniczna zaimplementowana przy wykorzystaniu wyra¿enia case
//////////////////////////////////////////////////////////////////////////////////


module ROM #(parameter ROM_WIDTH = 21)(
        input [15:0] ADDR,
        output reg [ROM_WIDTH-1:0] data
    );
    

   
//Zmiana na wejœciu ADDR powoduje zmienê danej na magistrali wyjœciowej

//zawartoœæ akumulatora jest traktowana jako liczba ze znakiem, pojawiaj¹ siê w nim kolejne liczby ci¹gu fibonaciego, a¿ do wyst¹pienia overflowu wtedy program staje.  
always @(*)
   case (ADDR)
5'b00000: data <= 21'b111010000000000000101;
5'b00001: data <= 21'b111010000000000000011;
5'b00010: data <= 21'b110110000000000000000;
5'b00011: data <= 21'b110110000000000000000;
5'b00100: data <= 21'b111010000000000000101;
5'b00101: data <= 21'b111010000000000000011;
5'b00110: data <= 21'b111010000000000000101;
5'b00111: data <= 21'b111010000000000000011;
5'b01000: data <= 21'b111010000000000000101;
5'b01001: data <= 21'b111010000000000000011;
5'b01010: data <= 21'b111010000000000000101;
5'b01011: data <= 21'b111010000000000000011;
5'b01100: data <= 21'b111010000000000000101;
5'b01101: data <= 21'b111010000000000000011;
5'b01110: data <= 21'b111010000000000000101;
5'b01111: data <= 21'b111010000000000000011;
5'b10000: data <= 21'b010010000000000010000;
        default: data <= 21'b010010000000000000000;
   endcase

endmodule
