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
4'b0000: data <= 21'b111010000000000000001;
4'b0001: data <= 21'b110100000000000000000;
4'b0010: data <= 21'b111010000000000000010;
4'b0011: data <= 21'b110100000000000000001;
4'b0100: data <= 21'b111010000000000000011;
4'b0101: data <= 21'b110100000000000000010;
4'b0110: data <= 21'b111100000000000000000;
4'b0111: data <= 21'b111100000000000000001;
4'b1000: data <= 21'b111100000000000000010;
4'b1001: data <= 21'b010010000000000001001;
   endcase

endmodule
