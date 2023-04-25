`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Prosta pamiêæ asynchroniczna zaimplementowana przy wykorzystaniu wyra¿enia case
//////////////////////////////////////////////////////////////////////////////////


module ROM #(parameter ROM_WIDTH = 21)(
        input [15:0] ADDR,
        output reg [ROM_WIDTH-1:0] data
    );
    

   
//Zmiana na wejœciu ADDR powoduje zmienê danej na magistrali wyjœciowej

//Test wywo³ania i powrotu z funkcji - program 3 krotnie wywo³uje funkcje mnozenia dla wartosci z rejestrów r1 i r2, wynik jest zapisywany w rejestrze r0 
always @(*)
   case (ADDR)
      6'b000000: data <= 21'b111010000000000000101; //a = 5
      6'b000001: data <= 21'b110010000000000000001;//r1 = a
      6'b000010: data <= 21'b111010000000000000011; //a = 3
      6'b000011: data <= 21'b110010000000000000010;//r2 = a
      6'b000100: data <= 21'b011010000000000010011;//call mnozenie
      
      6'b000101: data <= 21'b111010000000000000110; //a = 6
      6'b000110: data <= 21'b110010000000000000001;//r1 = a
      6'b000111: data <= 21'b111010000000000000110; //a = 6
      6'b001000: data <= 21'b110010000000000000010;//r2 = a
      6'b001001: data <= 21'b011010000000000010011;//call mnozenie
      
      6'b001010: data <= 21'b111010000000000000111; //a = 7
      6'b001011: data <= 21'b110010000000000000001;//r1 = a
      6'b001100: data <= 21'b111010000000000001000; //a = 8
      6'b001101: data <= 21'b110010000000000000010;//r2 = a
      6'b001110: data <= 21'b011010000000000010011;//call mnozenie
      
      6'b001111: data <= 21'b010010000000000001111;//stop
      6'b010000: data <= 21'b010010000000000001111;//wolne miejsce na instrukcje
      6'b010001: data <= 21'b010010000000000001111;//wolne miejsce na instrukcje
      6'b010010: data <= 21'b010010000000000001111;//wolne miejsce na instrukcje
      
      6'b010011: data <= 21'b111010000000000000000;//a = 0 //mnozenie
      6'b010100: data <= 21'b110010000000000000011;//r3 = a
      6'b010101: data <= 21'b111000000000000000001;//a = r1
      
      6'b010110: data <= 21'b111000000000000000011;//a = r3 - start loop
      6'b010111: data <= 21'b000000000000000000001;//a += r1
      6'b011000: data <= 21'b110010000000000000011;//r3 = a
      6'b011001: data <= 21'b111000000000000000010;//a = r2
      6'b011010: data <= 21'b001010000000000000001;//--a
      6'b011011: data <= 21'b110010000000000000010;//r2 = a
      6'b011100: data <= 21'b010100000000000011110;//jmp if 0
      6'b011101: data <= 21'b010010000000000010110;//jmp loop start
      6'b011110: data <= 21'b111000000000000000011;//a = r3
      6'b011111: data <= 21'b110010000000000000000;//r0 = a
      6'b100000: data <= 21'b100010000000000000000;//ret
      
      default: data <= 21'b010010000000000001000;
   endcase

endmodule
