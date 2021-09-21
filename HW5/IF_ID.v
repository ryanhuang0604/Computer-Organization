module IF_ID(clk_i,
		  rst_n,
		  PC_new,
		  instruction,
		  IF_ID_PC_new,
		  IF_ID_instruction
    );
input clk_i;
input rst_n;
input [31:0] PC_new;
input [31:0] instruction;
output [31:0] IF_ID_PC_new;
output [31:0] IF_ID_instruction;

reg [31:0] IF_ID_PC_new;
reg [31:0] IF_ID_instruction;

always @(posedge clk_i or negedge rst_n) begin
   if(~rst_n) begin
	    IF_ID_PC_new <= 0;
		 IF_ID_instruction <= 0;
	end
	else begin
	    IF_ID_PC_new <= PC_new;
		 IF_ID_instruction <= instruction;
	end
end

endmodule
