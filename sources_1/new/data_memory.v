`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2023 15:57:51
// Design Name: 
// Module Name: data_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_memory(
input [15:0] data_in,
input [9:0] address,
input WE,
input CLK,
output [15:0] data_out
);

reg [15:0] data [0:1023];

always @(posedge(CLK))
begin
   if(WE) data[address] <= data_in;
end
assign data_out = data[address];

endmodule
