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
/*your code here*/
assign ALU_operation_o = ({ALUOp_i,funct_i} == 9'b010010010 || ALUOp_i == 3'b100) ? 4'b0010 : //add addi
						 ({ALUOp_i,funct_i} == 9'b010010000) ? 4'b0110 : //sub
						 ({ALUOp_i,funct_i} == 9'b010010100) ? 4'b0001 : //and
						 ({ALUOp_i,funct_i} == 9'b010010110) ? 4'b0000 : //or
						 ({ALUOp_i,funct_i} == 9'b010010101) ? 4'b1101 : //nor
						 ({ALUOp_i,funct_i} == 9'b010100000) ? 4'b0111 : //slt
						 ({ALUOp_i,funct_i} == 9'b010000000) ? 4'b1000 : //sll
						 ({ALUOp_i,funct_i} == 9'b010000010) ? 4'b0000 : //srl
						 ({ALUOp_i,funct_i} == 9'b010000110) ? 4'b1010 : 4'b0010; //sllv srlv
						 
assign FURslt_o = ({ALUOp_i,funct_i} == 9'b010010010) ? 0 : //add
		 		  ({ALUOp_i,funct_i} == 9'b010010000) ? 0 : //sub
				  ({ALUOp_i,funct_i} == 9'b010010100) ? 0 : //and
				  ({ALUOp_i,funct_i} == 9'b010010110) ? 0 : //or
				  ({ALUOp_i,funct_i} == 9'b010010101) ? 0 : //nor
				  ({ALUOp_i,funct_i} == 9'b010100000) ? 0 : //slt
				  ({ALUOp_i,funct_i} == 9'b010000000) ? 1 : //sll
				  ({ALUOp_i,funct_i} == 9'b010000010) ? 1 : //srl
				  ({ALUOp_i,funct_i} == 9'b010000110) ? 1 : //sllv
				  ({ALUOp_i,funct_i} == 9'b010000100) ? 1 : //srlv
				  (ALUOp_i == 3'b100) ? 0 : 2; //addi lui	


endmodule     