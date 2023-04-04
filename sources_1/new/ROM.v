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
      5'b00000: data <= 21'b111010000000000000001;
      5'b00001: data <= 21'b110010000000000000000;//a do r0
      5'b00010: data <= 21'b110010000000000000001;//a do r1 
      5'b00011: data <= 21'b110010000000000000010;//a do r2
      5'b00100: data <= 21'b111000000000000000001;//r1 do a - loop begin
      5'b00101: data <= 21'b000000000000000000010;//dodaj r2
      5'b00110: data <= 21'b110010000000000000001;//a do r1
      5'b00111: data <= 21'b110010000000000000000;//a do r0
      5'b01000: data <= 21'b000000000000000000010;//dodaj r2
      5'b01001: data <= 21'b110010000000000000010;//a do r2
      5'b01010: data <= 21'b110010000000000000000;//a do r0
      5'b01011: data <= 21'b000000000000000000001;//dodaj r1
      5'b01100: data <= 21'b110010000000000000001;//a do r1
      5'b01101: data <= 21'b110010000000000000000;//a do r0
      5'b01110: data <= 21'b000000000000000000010;//dodaj r2
      5'b01111: data <= 21'b110010000000000000010;//a do r2
      5'b10000: data <= 21'b110010000000000000000;//a do r0
      5'b10001: data <= 21'b010010000000000000011;//jmp
      5'b10010: data <= 21'b111010000000000001101;
      5'b10011: data <= 21'b111010000000000001110;
      default: data <= 21'b010010000000000001000;
   endcase

endmodule
