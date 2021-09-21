module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o );
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;
 
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire			RegDst_o;

//Main function
/*your code here*/
wire addi;
wire lui;
wire rType;
 
assign addi = ~instr_op_i[5] && ~instr_op_i[4] && instr_op_i[3] && ~instr_op_i[2] && ~instr_op_i[1] && ~instr_op_i[0];
assign lui = ~instr_op_i[5] && ~instr_op_i[4] && instr_op_i[3] && instr_op_i[2] && instr_op_i[1] && instr_op_i[0];
assign rType = ~instr_op_i[5] && ~instr_op_i[4] && ~instr_op_i[3] && ~instr_op_i[2] && ~instr_op_i[1] && ~instr_op_i[0];

assign RegWrite_o = 1;
assign ALUOp_o[2] = addi || lui;
assign ALUOp_o[1] = rType;
assign ALUOp_o[0] = lui;
assign ALUSrc_o = addi;
assign RegDst_o = rType;


endmodule