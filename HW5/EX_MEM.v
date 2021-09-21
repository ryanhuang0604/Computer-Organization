module EX_MEM(
		  clk_i,
		  rst_n,
		  ID_EX_RegWrite,
		  ID_EX_Branch,
		  ID_EX_Jump,
		  ID_EX_MemRead,
		  ID_EX_MemWrite,
		  ID_EX_MemtoReg,
		  ID_EX_PC_new,
		  BranchAddress,
		  BranchResult1bit,
		  result,
		  ID_EX_reg_out2,
		  WriteReg,
		  ID_EX_instruction,
		  EX_MEM_RegWrite,
		  EX_MEM_Branch,
		  EX_MEM_Jump,
		  EX_MEM_MemRead,
		  EX_MEM_MemWrite,
		  EX_MEM_MemtoReg,
		  EX_MEM_PC_new,
		  EX_MEM_BranchAddress,
		  EX_MEM_BranchResult1bit,
		  EX_MEM_result,
		  EX_MEM_reg_out2,
		  EX_MEM_WriteReg,
		  EX_MEM_instruction
		  );


input clk_i;
input rst_n;
input ID_EX_RegWrite;
input ID_EX_Branch;
input ID_EX_Jump;
input ID_EX_MemRead;
input ID_EX_MemWrite;
input ID_EX_MemtoReg;
input [31:0] ID_EX_PC_new;
input [31:0] BranchAddress;
input BranchResult1bit;
input [31:0] result;
input [31:0] ID_EX_reg_out2;
input [4:0] WriteReg;
input [31:0] ID_EX_instruction;
output EX_MEM_RegWrite;
output EX_MEM_Branch;
output EX_MEM_Jump;
output EX_MEM_MemRead;
output EX_MEM_MemWrite;
output EX_MEM_MemtoReg;
output [31:0] EX_MEM_PC_new;
output [31:0] EX_MEM_BranchAddress;
output EX_MEM_BranchResult1bit;
output [31:0] EX_MEM_result;
output [31:0] EX_MEM_reg_out2;
output [4:0] EX_MEM_WriteReg;
output [31:0] EX_MEM_instruction;

reg EX_MEM_RegWrite;
reg EX_MEM_Branch;
reg EX_MEM_Jump;
reg EX_MEM_MemRead;
reg EX_MEM_MemWrite;
reg EX_MEM_MemtoReg;
reg [31:0] EX_MEM_PC_new;
reg [31:0] EX_MEM_BranchAddress;
reg EX_MEM_BranchResult1bit;
reg [31:0] EX_MEM_result;
reg [31:0] EX_MEM_reg_out2;
reg [4:0] EX_MEM_WriteReg;
reg [31:0] EX_MEM_instruction;

always @(posedge clk_i or negedge rst_n) begin
   if(~rst_n) begin
		  EX_MEM_RegWrite <= 0;
		  EX_MEM_Branch <= 0;
		  EX_MEM_Jump <= 0;
		  EX_MEM_MemRead <= 0;
		  EX_MEM_MemWrite <= 0;
		  EX_MEM_MemtoReg <= 0;
		  EX_MEM_PC_new <= 0;
		  EX_MEM_BranchAddress <= 0;
		  EX_MEM_BranchResult1bit <= 0;
		  EX_MEM_result <= 0;
		  EX_MEM_reg_out2 <= 0;
		  EX_MEM_WriteReg <= 0;
		  EX_MEM_instruction <= 0;
	end
	else begin
		  EX_MEM_RegWrite <= ID_EX_RegWrite;
		  EX_MEM_Branch <= ID_EX_Branch;
		  EX_MEM_Jump <= ID_EX_Jump;
		  EX_MEM_MemRead <= ID_EX_MemRead;
		  EX_MEM_MemWrite <= ID_EX_MemWrite;
		  EX_MEM_MemtoReg <= ID_EX_MemtoReg;
		  EX_MEM_PC_new <= ID_EX_PC_new;
		  EX_MEM_BranchAddress <= BranchAddress;
		  EX_MEM_BranchResult1bit <= BranchResult1bit;
		  EX_MEM_result <= result;
		  EX_MEM_reg_out2 <= ID_EX_reg_out2;
		  EX_MEM_WriteReg <= WriteReg;
		  EX_MEM_instruction <= ID_EX_instruction;
	end
end


endmodule
