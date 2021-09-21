module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o, Branch_o, Jump_o, MemRead_o, MemWrite_o, MemtoReg_o , BranchType_o, Jal_o);
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;
output			Branch_o;
output			Jump_o;
output			MemRead_o;
output			MemWrite_o;
output			MemtoReg_o;
output			BranchType_o;
output			Jal_o;

//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire			RegDst_o;
wire			Branch_o;
wire			Jump_o;
wire			MemRead_o;
wire			MemWrite_o;
wire			MemtoReg_o;
wire			BranchType_o;
wire			Jal_o;

//Main function
wire r_type;
wire addi;
wire lui;
wire lw;
wire sw;
wire beq;
wire blt;
wire bne;
wire bnez;
wire bgez;
wire jump;
wire jal;


assign r_type=~instr_op_i[5]&&~instr_op_i[4]&&~instr_op_i[3]&&~instr_op_i[2]&&~instr_op_i[1]&&~instr_op_i[0];
assign addi=~instr_op_i[5]&&~instr_op_i[4]&&instr_op_i[3]&&~instr_op_i[2]&&~instr_op_i[1]&&~instr_op_i[0];
assign lui=~instr_op_i[5]&&~instr_op_i[4]&&instr_op_i[3]&&instr_op_i[2]&&instr_op_i[1]&&instr_op_i[0];
assign lw=instr_op_i[5]&&~instr_op_i[4]&&~instr_op_i[3]&&~instr_op_i[2]&&instr_op_i[1]&&instr_op_i[0];
assign sw=instr_op_i[5]&&~instr_op_i[4]&&instr_op_i[3]&&~instr_op_i[2]&&instr_op_i[1]&&instr_op_i[0];
assign beq=~instr_op_i[5]&&~instr_op_i[4]&&~instr_op_i[3]&&instr_op_i[2]&&~instr_op_i[1]&&~instr_op_i[0];
assign bne=~instr_op_i[5]&&~instr_op_i[4]&&~instr_op_i[3]&&instr_op_i[2]&&~instr_op_i[1]&&instr_op_i[0];
assign jump=~instr_op_i[5]&&~instr_op_i[4]&&~instr_op_i[3]&&~instr_op_i[2]&&instr_op_i[1]&&~instr_op_i[0];
assign jal=~instr_op_i[5]&&~instr_op_i[4]&&~instr_op_i[3]&&~instr_op_i[2]&&instr_op_i[1]&&instr_op_i[0];
assign blt=~instr_op_i[5]&&~instr_op_i[4]&&~instr_op_i[3]&&instr_op_i[2]&&instr_op_i[1]&&~instr_op_i[0];
assign bnez=~instr_op_i[5]&&~instr_op_i[4]&&~instr_op_i[3]&&instr_op_i[2]&&~instr_op_i[1]&&instr_op_i[0];
assign bgez=~instr_op_i[5]&&~instr_op_i[4]&&~instr_op_i[3]&&~instr_op_i[2]&&~instr_op_i[1]&&instr_op_i[0];

assign RegDst_o=r_type;
assign RegWrite_o=r_type||addi||lui||lw||jal;
assign ALUOp_o[2]=addi||lui||bne||bnez||blt;
assign ALUOp_o[1]=r_type||bne||bnez||blt||bgez;
assign ALUOp_o[0]=lui||beq||blt||bgez;
assign ALUSrc_o=addi||lw||sw;
assign Branch_o=beq||bne||blt||bnez||bgez;
assign Jump_o=jump||jal;
assign MemRead_o=lw;
assign MemWrite_o=sw;
assign MemtoReg_o=lw;
assign BranchType_o=bne||bnez||bgez;
assign Jal_o=jal;

endmodule
   