module ID_EX(
		  clk_i,
		  rst_n,
		  RegWrite,
		  ALUOP,
		  ALUSrc,
		  RegDst,
		  Branch,
		  Jump,
		  MemRead,
		  MemWrite,
		  MemtoReg,
		  BranchType,
		  IF_ID_PC_new,
		  reg_out1,
		  reg_out2,
		  ans_signex,
		  ans_lui,
		  IF_ID_instruction,
		  ID_EX_RegWrite,
		  ID_EX_ALUOp,
		  ID_EX_ALUSrc,
		  ID_EX_RegDst,
		  ID_EX_Branch,
		  ID_EX_Jump,
		  ID_EX_MemRead,
		  ID_EX_MemWrite,
		  ID_EX_MemtoReg,
		  ID_EX_BranchType,
		  ID_EX_PC_new,
		  ID_EX_reg_out1,
		  ID_EX_reg_out2,
		  ID_EX_ans_signex,
		  ID_EX_ans_lui,
		  ID_EX_instruction
		  );

input clk_i;
input rst_n;	  
input RegWrite;
input [2:0] ALUOP;
input ALUSrc;
input RegDst;
input Branch;
input Jump;
input MemRead;
input MemWrite;
input MemtoReg;
input BranchType;
input [31:0] IF_ID_PC_new;
input [31:0] reg_out1;
input [31:0] reg_out2;
input [31:0] ans_signex;
input [31:0] ans_lui;
input [31:0] IF_ID_instruction;		  
output ID_EX_RegWrite;
output [2:0] ID_EX_ALUOp;
output ID_EX_ALUSrc;
output ID_EX_RegDst;
output ID_EX_Branch;
output ID_EX_Jump;
output ID_EX_MemRead;
output ID_EX_MemWrite;
output ID_EX_MemtoReg;
output ID_EX_BranchType;
output [31:0] ID_EX_PC_new;
output [31:0] ID_EX_reg_out1;
output [31:0] ID_EX_reg_out2;
output [31:0] ID_EX_ans_signex;
output [31:0] ID_EX_ans_lui;
output [31:0] ID_EX_instruction;

reg ID_EX_RegWrite;
reg [2:0] ID_EX_ALUOp;
reg ID_EX_ALUSrc;
reg ID_EX_RegDst;
reg ID_EX_Branch;
reg ID_EX_Jump;
reg ID_EX_MemRead;
reg ID_EX_MemWrite;
reg ID_EX_MemtoReg;
reg ID_EX_BranchType;
reg [31:0] ID_EX_PC_new;
reg [31:0] ID_EX_reg_out1;
reg [31:0] ID_EX_reg_out2;
reg [31:0] ID_EX_ans_signex;
reg [31:0] ID_EX_ans_lui;
reg [31:0] ID_EX_instruction;

always @(posedge clk_i or negedge rst_n) begin
   if(~rst_n) begin
		  ID_EX_RegWrite <= 0;
		  ID_EX_ALUOp <= 0;
		  ID_EX_ALUSrc <= 0;
		  ID_EX_RegDst <= 0;
		  ID_EX_Branch <= 0;
		  ID_EX_Jump <= 0;
		  ID_EX_MemRead <= 0;
		  ID_EX_MemWrite <= 0;
		  ID_EX_MemtoReg <= 0;
		  ID_EX_BranchType <= 0;
		  ID_EX_PC_new <= 0;
		  ID_EX_reg_out1 <= 0;
		  ID_EX_reg_out2 <= 0;
		  ID_EX_ans_signex <= 0;
		  ID_EX_ans_lui <= 0;
		  ID_EX_instruction <= 0;
	end
	else begin
		  ID_EX_RegWrite <= RegWrite;
		  ID_EX_ALUOp <= ALUOP;
		  ID_EX_ALUSrc <= ALUSrc;
		  ID_EX_RegDst <= RegDst;
		  ID_EX_Branch <= Branch;
		  ID_EX_Jump <= Jump;
		  ID_EX_MemRead <= MemRead;
		  ID_EX_MemWrite <= MemWrite;
		  ID_EX_MemtoReg <= MemtoReg;
		  ID_EX_BranchType <= BranchType;
		  ID_EX_PC_new <= IF_ID_PC_new;
		  ID_EX_reg_out1 <= reg_out1;
		  ID_EX_reg_out2 <= reg_out2;
		  ID_EX_ans_signex <= ans_signex;
		  ID_EX_ans_lui <= ans_lui;
		  ID_EX_instruction <= IF_ID_instruction;
	end
end


endmodule
