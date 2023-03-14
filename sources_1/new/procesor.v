`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2023 14:25:26
// Design Name: 
// Module Name: procesor
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


module procesor (
    input clk
);

wire [15:0] PC_in;
wire PC_load;
wire [15:0] INS_addr;
wire [25:0] INS;
wire PC_in_source;
wire [15:0] PC_jump_addr;

wire [15:0] linkreg_in;
wire [15:0] linkreg_out;
wire linkreg_ce;

wire [2:0] opcode;
reg [15:0] arg2;
wire [15:0] alu_res;
wire [4:0] flag_in;
wire [4:0] flag_out;

wire A_ce;
wire [15:0] A_out;

wire [15:0] REGS_input;
wire [15:0] REGS_output;
wire [4:0] REGS_addr;
wire REGS_ce;

wire [15:0] instant_value;

wire arg_source;



program_counter PC(
        .IN(PC_in),
        .load(PC_load),
        .clk(clk),
        .OUT(INS_addr),
        .CE(1'b1)
);

ROM PM(
        .ADDR(INS_addr),
        .data(INS)
    );

register #(.WIDTH(5)) flag_reg (
    .data_in(flag_out),
    .data_out(flag_in)
);    

alu alu(
        .opcode(opcode),
        .arg1(A_out),
        .arg2(arg2),
        .res(alu_res),
        .in_flg(flag_in),
        .out_flg(flag_out)
    );

register A(
    .data_in(alu_res),
    .data_out(A_out),
    .CE(A_ce),
    .CLK(clk)
);

register link_reg(
    .data_in(linkreg_in),
    .data_out(linkreg_out),
    .CE(linkreg_ce),
    .CLK(clk)
);

registers REGS(
    .CLK(clk),
    .CE(REGS_ce),
    .addr(REGS_addr),
    .data_in(REGS_input),
    .data_out(REGS_output)
);

instruction_decoder instruction_decoder(
        .INS(INS),
        .INS_addr(INS_addr),
        
        .A_ce(A_ce),
        .REGS_ce(REGS_ce),
        
        .REGS_addr(REGS_addr),
        
        .opcode(opcode),
        .instant(instant_value),
        
        .load_pc(PC_load),
        .load_linkreg(linkreg_ce),
        .new_pc(PC_jump_addr),
        .new_linkreg(linkreg_in),
        .PC_source(PC_in_source),
        .arg_source(arg_source)
    );

assign PC_in = PC_in_source ? PC_jump_addr : linkreg_out;

//More sources to be added so case no assign
always @(arg_source)
    case (arg_source)
        1'b0: arg2 = REGS_output;
        1'b1: arg2 = instant_value;
    endcase
    
    
endmodule
