`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Dekoder instrukcji
//////////////////////////////////////////////////////////////////////////////////


module instruction_decoder(
        input [15:0] INS,
        input [15:0] INS_addr,
        
        output A_ce,
        output REGS_ce,
        
        output load_pc,
        output load_linkreg,
        output [15:0] new_pc,
        output [15:0] new_linkreg,
        
        output [4:0] REGS_addr,
        output [3:0] opcode,
        output [15:0] instant,
        
        output PC_source,
        output arg_source
        
  
    );
    
assign new_linkreg = INS_addr + 1; 

endmodule
