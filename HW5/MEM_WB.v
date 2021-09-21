module MEM_WB(
		  clk_i,
		  rst_n,
		  EX_MEM_RegWrite,
		  EX_MEM_MemtoReg,
		  EX_MEM_WriteReg,
		  DMResult,
		  EX_MEM_result,
		  MEM_WB_RegWrite,
		  MEM_WB_MemtoReg,
		  MEM_WB_WriteReg,
		  MEM_WB_DMResult,
		  MEM_WB_result
		  );
		  
input clk_i;
input rst_n;
input EX_MEM_RegWrite;
input EX_MEM_MemtoReg;
input [4:0] EX_MEM_WriteReg;
input [31:0] DMResult;
input [31:0] EX_MEM_result;
output MEM_WB_RegWrite;
output MEM_WB_MemtoReg;
output [4:0] MEM_WB_WriteReg;
output [31:0] MEM_WB_DMResult;
output [31:0] MEM_WB_result;

reg MEM_WB_RegWrite;
reg MEM_WB_MemtoReg;
reg [4:0] MEM_WB_WriteReg;
reg [31:0] MEM_WB_DMResult;
reg [31:0] MEM_WB_result;

always @(posedge clk_i or negedge rst_n) begin
   if(~rst_n) begin
		  MEM_WB_RegWrite <= 0;
		  MEM_WB_MemtoReg <= 0;
		  MEM_WB_WriteReg <= 0;
		  MEM_WB_DMResult <= 0;
		  MEM_WB_result <= 0;
	end
	else begin
		  MEM_WB_RegWrite <= EX_MEM_RegWrite;
		  MEM_WB_MemtoReg <= EX_MEM_MemtoReg;
		  MEM_WB_WriteReg <= EX_MEM_WriteReg;
		  MEM_WB_DMResult <= DMResult;
		  MEM_WB_result <= EX_MEM_result;
	end
end


endmodule
