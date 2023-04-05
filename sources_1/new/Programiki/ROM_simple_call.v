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
      5'b00000: data <= 21'b011010000000000000010;//cal
      5'b00001: data <= 21'b010010000000000000000;//jmp
      
      5'b00010: data <= 21'b111010000000000000001;
      5'b00011: data <= 21'b111010000000000000010;
      5'b00100: data <= 21'b111010000000000000011;
      5'b00101: data <= 21'b100010000000000000000;
      default: data <= 21'b010010000000000000000;
   endcase

endmodule
