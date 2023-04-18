`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Prosta jednostka arytmetyczno logincza
//////////////////////////////////////////////////////////////////////////////////


module alu(
        input [2:0] opcode,
        input [15:0] arg1,
        input [15:0] arg2,
        input  [4:0] in_flg,
        input block_cy_ov,
        output [4:0] out_flg,
        output reg [15:0] res
    );
    
wire Z;
reg CY;
wire S;
wire P;
wire OV;

wire Z_in, CY_in, S_in, P_in, OV_in;
assign {Z_in, CY_in, S_in, P_in, OV_in} = in_flg;

    
always @(*)
    begin
        case(opcode) //SprawdŸ jak¹ operacjê wykonaæ
        3'b000: begin
            {CY, res} = arg1 + arg2 + (~block_cy_ov & CY_in); //Dodawanie + wypracowanie flagi cary
        end
        3'b001: begin
            {CY, res} = arg1 - arg2 - (~block_cy_ov & CY_in); //Odejmowanie + wypracowanie flagi cary
        end
        3'b010: begin
            res = arg1 & arg2; //AND
            CY = 1'b0;
        end
        3'b011: begin
            res = arg1 | arg2; //OR
            CY = 1'b0;
        end
        3'b100: begin
            res = arg1 ^ arg2; //XOR
            CY = 1'b0;
        end
        3'b101: begin
            res = ~arg1; //NEGACJA
            CY = 1'b0;
        end
        3'b110: begin
            res = arg1; //Przepisanie operandu 1
            CY = 1'bx;
        end
        3'b111: begin
            res = arg2; //Przepisanie operandu 2
            CY = 1'bx;
        end
        default: begin
        res = arg2;
        CY = 1'bx;
        end
        endcase
    end

assign Z = ~|res; //Wypracowanie flagi 0
assign S = res[15]; //Wypracowanie flagi znaku
assign P = ^res; //Wypracowanie bitu parzystoœci
assign OV = ((arg1[15] == 1'b0 && arg2[15] == 1'b0 && res[15] == 1'b1) || (arg1[15] == 1'b1 && arg2[15] == 1'b1 && res[15] == 1'b0)) ? 1'b1 : 1'b0; //Wypracowanie flagi przepe³nienia  
assign out_flg = {Z, block_cy_ov ? CY_in : CY, S, P, block_cy_ov ? OV_in : OV}; //Konkatenacja flag do magistrali wyjœciowej
 
endmodule
