module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o );

//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALU_operation_o;  
output     [2-1:0] FURslt_o;
     
//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		[2-1:0] FURslt_o;

//Main function
wire addi;
wire nor1;
wire shift;
wire lw;
wire sw;
wire beq;
wire bne;
wire bnez;
wire bgez;
wire blt;

assign shift=~funct_i[5]&&~funct_i[4]&&~funct_i[3]&&~funct_i[2]&&~funct_i[0];
assign nor1=funct_i[5]&&~funct_i[4]&&~funct_i[3]&&funct_i[2]&&funct_i[1]&&funct_i[0];
assign addi=~ALUOp_i[1]&&~ALUOp_i[0];
assign lw=~ALUOp_i[2]&&~ALUOp_i[1]&&~ALUOp_i[0];
assign sw=~ALUOp_i[2]&&~ALUOp_i[1]&&~ALUOp_i[0];
assign beq=~ALUOp_i[2]&&~ALUOp_i[1]&&ALUOp_i[0];
assign bne=ALUOp_i[2]&&ALUOp_i[1]&&~ALUOp_i[0];
assign bnez=ALUOp_i[2]&&ALUOp_i[1]&&~ALUOp_i[0];
assign bgez=~ALUOp_i[2]&&ALUOp_i[1]&&ALUOp_i[0];
assign blt=ALUOp_i[2]&&ALUOp_i[1]&&ALUOp_i[0];


assign ALU_operation_o[3]=(nor1)?1:0;
assign ALU_operation_o[2]=(blt)?1:(bgez)?0:(bnez)?0:(bne)?1:(beq)?1:(sw)?0:(lw)?0:(nor1)?1:(addi)?0:ALUOp_i[0]||(ALUOp_i[1]&&funct_i[1]);
assign ALU_operation_o[1]=(blt)?1:(bgez)?1:(bnez)?1:(bne)?1:(beq)?1:(sw)?1:(lw)?1:(nor1)?1:(addi)?1:!ALUOp_i[1]||~funct_i[2];
assign ALU_operation_o[0]=(blt)?1:(bgez)?1:(bnez)?0:(bne)?0:(beq)?0:(sw)?0:(lw)?0:(nor1)?0:(addi)?0:ALUOp_i[1]&&(funct_i[3]||funct_i[0]);
assign FURslt_o=(addi)?0:(nor1||(~ALUOp_i[2]&&~shift))?0:(ALUOp_i[0]&&~shift)?2:1;

endmodule     
