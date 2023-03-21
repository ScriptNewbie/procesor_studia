`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Dekoder instrukcji
//////////////////////////////////////////////////////////////////////////////////


module instruction_decoder(
        input [20:0] INS,
        input [15:0] INS_addr,
		input [4:0] flags,
        
        output reg A_ce,
        output reg REGS_ce,
		output reg flags_ce,
        
        output reg load_pc,
        output reg load_linkreg,
		
        output [15:0] new_pc,
        output [15:0] new_linkreg,
        
        output [4:0] REGS_addr,
        output [3:0] opcode,
        output reg [15:0] instant,
		
        output reg PC_source,
        output reg [1:0] arg_source,
		output reg block_cy_ov,
        
        output reg mem_we,
        output [9:0] mem_addr
  
    );
	
reg [2:0] output_type;

wire [4:0] operation;
wire iscall;
wire Z, CY, S, P, OV;

assign operation = 	INS[20:16];
assign iscall = operation[2];
assign {Z, CY, S, P, OV} = flags;
	
always @(*)
begin
    case (operation)
        5'b00000: begin 
            output_type <= 3'b000;
        end
        5'b00100: begin 
            output_type <= 3'b000;
        end
        5'b01000: begin 
            output_type <= 3'b000;
        end
        5'b01100: begin 
            output_type <= 3'b000;
        end
        5'b10000: begin 
            output_type <= 3'b000;
        end
        5'b10100: begin 
            output_type <= 3'b000;
        end
                    
        5'b00001: begin 
            output_type <= 3'b001;
        end
        
        5'b00101: begin 
            output_type <= 3'b001;
        end
        
        5'b01001: begin 
            output_type <= 3'b010;
        end
        5'b01101: begin 
            output_type <= 3'b010;
        end
        
        5'b01010: begin 
            if(Z) output_type <= 3'b010;
            else  output_type <= 3'b111;
        end
        5'b01110: begin 
            if(Z) output_type <= 3'b010;
            else  output_type <= 3'b111;
        end
        
        5'b01011: begin 
            if(OV) output_type <= 3'b010;
            else  output_type <= 3'b111;
        end
        5'b01111: begin 
            if(OV) output_type <= 3'b010;
            else  output_type <= 3'b111;
        end
        
        5'b10001: begin
            output_type <= 3'b011;
        end
        
        5'b11101: begin
            output_type <= 3'b100;
        end
        
        5'b11110: begin
            output_type <= 3'b100;
        end
        
        5'b11100: begin
            output_type <= 3'b100;
        end
        
        5'b11001: begin
            output_type <= 3'b101;
        end
        
        5'b11010: begin
            output_type <= 3'b101;
        end
        
        default: begin 
           output_type <= 3'b111;
        end
    endcase
end

always @(*)
begin
//Operacje arytmetyczno logiczne
    case (output_type)
		3'b000: begin 
			A_ce <= 1'b1;
			REGS_ce <= 1'b0;
			flags_ce <= 1'b1;
				
			load_pc <= 1'b0;
			load_linkreg <= 1'b0;
				
			instant <= 'b1;
				
			PC_source <= 1'b0;
			arg_source <= 2'b00;
			block_cy_ov <= 1'b0;
			mem_we <= 1'b0;
		end
		//INC/DEC
		3'b001: begin 
		    A_ce <= 1'b1;
            REGS_ce <= 1'b0;
            flags_ce <= 1'b1;
                    
            load_pc <= 1'b0;
            load_linkreg <= 1'b0;
                    
            instant <= 'b1;
                    
            PC_source <= 1'b0;
            arg_source <= 2'b01;
            block_cy_ov <= 1'b1;
            mem_we <= 1'b0;
        end
        //Skoki
        3'b010: begin 
		    A_ce <= 1'b0;
            REGS_ce <= 1'b0;
            flags_ce <= 1'b0;
                    
            load_pc <= 1'b1;
            load_linkreg <= iscall;
                    
            instant <= 'b1;
                    
            PC_source <= 1'b0;
            arg_source <= 2'b01;
            block_cy_ov <= 1'b1;
            mem_we <= 1'b0;
        end
        3'b011: begin 
		    A_ce <= 1'b0;
            REGS_ce <= 1'b0;
            flags_ce <= 1'b0;
                    
            load_pc <= 1'b1;
            load_linkreg <= 1'b0;
                    
            instant <= 'b1;
                    
            PC_source <= 1'b1;
            arg_source <= 2'b01;
            block_cy_ov <= 1'b1;
            mem_we <= 1'b0;
        end
        3'b100: begin 
		    A_ce <= 1'b1;
            REGS_ce <= 1'b0;
            flags_ce <= 1'b0;
                    
            load_pc <= 1'b0;
            load_linkreg <= 1'b0;
                    
            instant <= INS[15:0];
                    
            PC_source <= 1'b1;
            arg_source <= operation[1:0];
            block_cy_ov <= 1'b1;
            mem_we <= 1'b0;
        end
        3'b101: begin 
		    A_ce <= 1'b0;
		    
            REGS_ce <= operation[0];
            mem_we <= operation[1];
            
            flags_ce <= 1'b0;
                 
            load_pc <= 1'b0;
            load_linkreg <= 1'b0;
                    
            instant <= 'b1;
                    
            PC_source <= 1'b1;
            arg_source <= 2'b01;
            block_cy_ov <= 1'b1;
            
        end
        default: begin 
		    A_ce <= 1'b0;
			REGS_ce <= 1'b0;
			flags_ce <= 1'b0;
				
			load_pc <= 1'b0;
			load_linkreg <= 1'b0;
				
			instant <= 'b1;
				
			PC_source <= 1'b0;
			arg_source <= 'b0;
			block_cy_ov <= 1'b0;
			mem_we <= 1'b0;
		end
    endcase
end
    
assign opcode = INS[20:18];
assign new_pc = INS[15:0];
assign new_linkreg = INS_addr + 1; 
assign REGS_addr = INS[4:0];
assign mem_addr = INS[9:0];

endmodule
