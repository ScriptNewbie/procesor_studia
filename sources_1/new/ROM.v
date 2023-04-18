`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Prosta pami�� asynchroniczna zaimplementowana przy wykorzystaniu wyra�enia case
//////////////////////////////////////////////////////////////////////////////////


module ROM #(parameter ROM_WIDTH = 21)(
        input [15:0] ADDR,
        output reg [ROM_WIDTH-1:0] data
    );
    

   
//Zmiana na wej�ciu ADDR powoduje zmien� danej na magistrali wyj�ciowej

//program wpisuje do pierwszych 3 kom�rek pami�ci liczby 1, 2, 3 a nast�pnie przepisuje je kolejno do akumulatora  
always @(*)
   case (ADDR)
3'b000: data <= 21'b111010000000000000001;
3'b001: data <= 21'b110010000000000000000;
3'b010: data <= 21'b111010000000000000000;
3'b011: data <= 21'b001000000000000000000;
3'b100: data <= 21'b001000000000000000000;
3'b101: data <= 21'b010010000000000000101;
      default: data <= 21'b010010000000000001000;
   endcase

endmodule
