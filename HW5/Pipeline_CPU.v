module Pipeline_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles

wire [31:0] PC_old;
wire [31:0] PC_new;
wire [31:0] instruction;
wire [31:0] reg_out1;
wire [31:0] reg_out2;
wire [31:0] reg_out2_new;
wire [31:0] result;
wire RegDst;
wire RegWrite;
wire [4:0] WriteReg;
wire ALUSrc;
wire Branch;
wire Jump;
wire Jal;
wire Jr;
wire MemRead;
wire MemWrite;
wire MemtoReg;
wire BranchType;
wire [2:0] ALUOP;
wire [3:0] operation;
wire [1:0] FURslt;
wire [31:0] ans_signex;
wire [31:0] ans_shifter;
wire [31:0] ans_alu;
wire [31:0] ans_lui;
wire zero;
wire overflow;

wire [31:0] BranchAddress;  //new wires
wire [31:0] BranchResult;
wire [27:0] JumpAddress;
wire [31:0] JumpResult;
wire [31:0] WBResult;
wire [31:0] BranchAdderSrc2;
wire BranchResult1bit;
wire [31:0] DMResult;
wire [31:0] WBResult_new;
wire [4:0] WriteReg_new;
wire [31:0] JrResult;

//IF/ID
wire [31:0] IF_ID_PC_new;
wire [31:0] IF_ID_instruction;

//ID/EX
wire ID_EX_RegWrite;
wire [2:0] ID_EX_ALUOp;
wire ID_EX_ALUSrc;
wire ID_EX_RegDst;
wire ID_EX_Branch;
wire ID_EX_Jump;
wire ID_EX_MemRead;
wire ID_EX_MemWrite;
wire ID_EX_MemtoReg;
wire ID_EX_BranchType;
wire [31:0] ID_EX_PC_new;
wire [31:0] ID_EX_reg_out1;
wire [31:0] ID_EX_reg_out2;
wire [31:0] ID_EX_ans_signex;
wire [31:0] ID_EX_ans_lui;
wire [31:0] ID_EX_instruction;


//EX/MEM
wire EX_MEM_RegWrite;
wire EX_MEM_Branch;
wire EX_MEM_Jump;
wire EX_MEM_MemRead;
wire EX_MEM_MemWrite;
wire EX_MEM_MemtoReg;
wire [31:0] EX_MEM_PC_new;
wire [31:0] EX_MEM_BranchAddress;
wire EX_MEM_BranchResult1bit;
wire [31:0] EX_MEM_result;
wire [31:0] EX_MEM_reg_out2;
wire [4:0] EX_MEM_WriteReg;
wire [31:0] EX_MEM_instruction;

//MEM/WB
wire MEM_WB_RegWrite;
wire MEM_WB_MemtoReg;
wire [4:0] MEM_WB_WriteReg;
wire [31:0] MEM_WB_DMResult;
wire [31:0] MEM_WB_result;

//modules
Program_Counter PC(
       .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(BranchResult) ,   
	    .pc_out_o(PC_old) 
	    );
	
Adder Adder1(
        .src1_i(PC_old),     
	    .src2_i(4),
	    .sum_o(PC_new)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(PC_old),  
	    .instr_o(instruction)    
	    );
		 
Data_Memory DM(
			.clk_i(clk_i),
			.addr_i(EX_MEM_result),
			.data_i(EX_MEM_reg_out2),
			.MemRead_i(EX_MEM_MemRead),
			.MemWrite_i(EX_MEM_MemWrite),
			.data_o(DMResult)
		 );

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(ID_EX_instruction[20:16]),
        .data1_i(ID_EX_instruction[15:11]),
        .select_i(ID_EX_RegDst),
        .data_o(WriteReg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	     .rst_n(rst_n) ,     
        .RSaddr_i(IF_ID_instruction[25:21]) ,  
        .RTaddr_i(IF_ID_instruction[20:16]) ,  
        .Wrtaddr_i(MEM_WB_WriteReg) ,  
        .Wrtdata_i(WBResult)  , 
        .RegWrite_i(MEM_WB_RegWrite),
        .RSdata_o(reg_out1) ,  
        .RTdata_o(reg_out2)   
        );
	
Decoder Decoder(
        .instr_op_i(IF_ID_instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUOp_o(ALUOP),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),
		 .Branch_o(Branch),
		 .Jump_o(Jump),
		 .MemRead_o(MemRead),
		 .MemWrite_o(MemWrite),
		 .MemtoReg_o(MemtoReg),
		 .BranchType_o(BranchType),
		 .Jal_o(Jal)
		);

ALU_Ctrl AC(
        .funct_i(ID_EX_instruction[5:0]),   
        .ALUOp_i(ID_EX_ALUOp),   
        .ALU_operation_o(operation),
		  .FURslt_o(FURslt)
        );
	
Sign_Extend SE(
        .data_i(IF_ID_instruction[15:0]),
        .data_o(ans_signex)
        );

Zero_Filled ZF(
        .data_i(IF_ID_instruction[15:0]),
        .data_o(ans_lui)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(ID_EX_reg_out2),
        .data1_i(ID_EX_ans_signex),
        .select_i(ID_EX_ALUSrc),
        .data_o(reg_out2_new)
        );	
		
ALU ALU(
		.aluSrc1(ID_EX_reg_out1),
	    .aluSrc2(reg_out2_new),
	    .ALU_operation_i(operation),
		.result(ans_alu),
		.zero(zero),
		.overflow(overflow)
	    );
		
Shifter shifter( 
		.result(ans_shifter), 
		.leftRight(operation[2]),
		.shamt(ID_EX_instruction[10:6]),
		.sftSrc(reg_out2_new) 
		);
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(ans_alu),
        .data1_i(ans_shifter),
		  .data2_i(ID_EX_ans_lui),
        .select_i(FURslt),
        .data_o(result)
        );			

Shifter_alt JumpShifter(    //new module
		.result(JumpAddress),
		.sftSrc(instruction[25:0]) 
		);
		
Shifter BranchShifter(
		.result(BranchAdderSrc2), 
		.leftRight(1'b0),
		.shamt(5'b10),
		.sftSrc(ID_EX_ans_signex) 
		);

Adder BranchAdder(
       .src1_i(ID_EX_PC_new),     
	    .src2_i(BranchAdderSrc2),
	    .sum_o(BranchAddress)    
	    );

Mux2to1 #(.size(32)) BranchSelect(
        .data0_i(EX_MEM_PC_new),
        .data1_i(EX_MEM_BranchAddress),
        .select_i(EX_MEM_Branch&&EX/MEM_BranchResult1bit),
        .data_o(BranchResult)
        );	
		  
Mux2to1 #(.size(32)) JumpSelect(
        .data0_i(BranchResult),
        .data1_i({PC_new[31:28],JumpAddress}),
        .select_i(Jump),
        .data_o(JumpResult)
        );	
		  
Mux2to1 #(.size(32)) JrSelect(
        .data0_i(JumpResult),
        .data1_i(reg_out1),
        .select_i(RegDst&&~instruction[5]&&~instruction[4]&&instruction[3]&&~instruction[2]&&~instruction[1]&&~instruction[0]),
        .data_o(JrResult)
        );	

Mux2to1 #(.size(32)) WBSrc(
        .data0_i(MEM_WB_result),
        .data1_i(MEM_WB_DMResult),
        .select_i(MEM_WB_MemtoReg),
        .data_o(WBResult)
        );	

Mux2to1 #(.size(1)) BranchCtrl(
        .data0_i(zero),
        .data1_i(~zero),
        .select_i(ID_EX_BranchType),
        .data_o(BranchResult1bit)
        );

IF_ID IF_ID(
		  .clk_i(clk_i),
		  .rst_n(rst_n),
		  .PC_new(PC_new),
		  .instruction(instruction),
		  .IF_ID_PC_new(IF_ID_PC_new),
		  .IF_ID_instruction(IF_ID_instruction)
		  );
		  
ID_EX ID_EX(
		  .clk_i(clk_i),
		  .rst_n(rst_n),
		  .RegWrite(RegWrite),
		  .ALUOP(ALUOP),
		  .ALUSrc(ALUSrc),
		  .RegDst(RegDst),
		  .Branch(Branch),
		  .Jump(Jump),
		  .MemRead(MemRead),
		  .MemWrite(MemWrite),
		  .MemtoReg(MemtoReg),
		  .BranchType(BranchType),
		  .IF_ID_PC_new(IF_ID_PC_new),
		  .reg_out1(reg_out1),
		  .reg_out2(reg_out2),
		  .ans_signex(ans_signex),
		  .ans_lui(ans_lui),
		  .IF_ID_instruction(IF_ID_instruction),
		  .ID_EX_RegWrite(ID_EX_RegWrite),
		  .ID_EX_ALUOp(ID_EX_ALUOp),
		  .ID_EX_ALUSrc(ID_EX_ALUSrc),
		  .ID_EX_RegDst(ID_EX_RegDst),
		  .ID_EX_Branch(ID_EX_Branch),
		  .ID_EX_Jump(ID_EX_Jump),
		  .ID_EX_MemRead(ID_EX_MemRead),
		  .ID_EX_MemWrite(ID_EX_MemWrite),
		  .ID_EX_MemtoReg(ID_EX_MemtoReg),
		  .ID_EX_BranchType(ID_EX_BranchType),
		  .ID_EX_PC_new(ID_EX_PC_new),
		  .ID_EX_reg_out1(ID_EX_reg_out1),
		  .ID_EX_reg_out2(ID_EX_reg_out2),
		  .ID_EX_ans_signex(ID_EX_ans_signex),
		  .ID_EX_ans_lui(ID_EX_ans_lui),
		  .ID_EX_instruction(ID_EX_instruction)
		  );
		  
EX_MEM EX_MEM(
		  .clk_i(clk_i),
		  .rst_n(rst_n),
		  .ID_EX_RegWrite(ID_EX_RegWrite),
		  .ID_EX_Branch(ID_EX_Branch),
		  .ID_EX_Jump(ID_EX_Jump),
		  .ID_EX_MemRead(ID_EX_MemRead),
		  .ID_EX_MemWrite(ID_EX_MemWrite),
		  .ID_EX_MemtoReg(ID_EX_MemtoReg),
		  .ID_EX_PC_new(ID_EX_PC_new),
		  .BranchAddress(BranchAddress),
		  .BranchResult1bit(BranchResult1bit),
		  .result(result),
		  .ID_EX_reg_out2(ID_EX_reg_out2),
		  .WriteReg(WriteReg),
		  .ID_EX_instruction(ID_EX_instruction),
		  .EX_MEM_RegWrite(EX_MEM_RegWrite),
		  .EX_MEM_Branch(EX_MEM_Branch),
		  .EX_MEM_Jump(EX_MEM_Jump),
		  .EX_MEM_MemRead(EX_MEM_MemRead),
		  .EX_MEM_MemWrite(EX_MEM_MemWrite),
		  .EX_MEM_MemtoReg(EX_MEM_MemtoReg),
		  .EX_MEM_PC_new(EX_MEM_PC_new),
		  .EX_MEM_BranchAddress(EX_MEM_BranchAddress),
		  .EX_MEM_BranchResult1bit(EX_MEM_BranchResult1bit),
		  .EX_MEM_result(EX_MEM_result),
		  .EX_MEM_reg_out2(EX_MEM_reg_out2),
		  .EX_MEM_WriteReg(EX_MEM_WriteReg),
		  .EX_MEM_instruction(EX_MEM_instruction)
		  );
		  
MEM_WB MEM_WB(
		  .clk_i(clk_i),
		  .rst_n(rst_n),
		  .EX_MEM_RegWrite(EX_MEM_RegWrite),
		  .EX_MEM_MemtoReg(EX_MEM_MemtoReg),
		  .EX_MEM_WriteReg(EX_MEM_WriteReg),
		  .DMResult(DMResult),
		  .EX_MEM_result(EX_MEM_result),
		  .MEM_WB_RegWrite(MEM_WB_RegWrite),
		  .MEM_WB_MemtoReg(MEM_WB_MemtoReg),
		  .MEM_WB_WriteReg(MEM_WB_WriteReg),
		  .MEM_WB_DMResult(MEM_WB_DMResult),
		  .MEM_WB_result(MEM_WB_result)
		  );

endmodule



