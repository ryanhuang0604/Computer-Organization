module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [31:0] PC_next, PC_now, instruction, result, reg_out1, reg_out2, ans_signExtend, ans_zeroFilled, reg_out2_new, ans_alu, ans_shifter;
wire RegDst, RegWrite, ALUSrc, zero, overflow;
wire [4:0] WriteReg;
wire [2:0] ALUOP;
wire [3:0] operation;
wire [1:0] FURslt;

wire Branch, Jump, Jal, Jr, MemRead, MemWrite, MemtoReg, BranchType, BranchResult1bit;
wire [31:0] BranchAddress, BranchResult, JumpResult, WBResult, BranchAdderSrc2, DMResult, WBResult_new, JrResult;
wire [27:0] JumpAddress;
wire [4:0] WriteReg_new;


//modules
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(JrResult) ,   
	    .pc_out_o(PC_now) 
	    );
	
Adder Adder1(
        .src1_i(PC_now),     
	    .src2_i(4),
	    .sum_o(PC_next)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(PC_now),  
	    .instr_o(instruction)    
	    );
		
Data_Memory DM(
			.clk_i(clk_i),
			.addr_i(result),
			.data_i(reg_out2),
			.MemRead_i(MemRead),
			.MemWrite_i(MemWrite),
			.data_o(DMResult)
		 );

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(RegDst),
        .data_o(WriteReg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(WriteReg_new) ,  
        .RDdata_i(WBResult_new)  , 
        .RegWrite_i(RegWrite),
        .RSdata_o(reg_out1) ,  
        .RTdata_o(reg_out2)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
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
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALUOP),   
        .ALU_operation_o(operation),
		.FURslt_o(FURslt)
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(ans_signExtend)
        );

Zero_Filled ZF(
        .data_i(instruction[15:0]),
        .data_o(ans_zeroFilled)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(reg_out2),
        .data1_i(ans_signExtend),
        .select_i(ALUSrc),
        .data_o(reg_out2_new)
        );	
		
ALU ALU(
		.aluSrc1(reg_out1),
	    .aluSrc2(reg_out2_new),
	    .ALU_operation_i(operation),
		.result(ans_alu),
		.zero(zero),
		.overflow(overflow)
	    );
		
Shifter shifter( 
		.result(ans_shifter), 
		.leftRight(operation[2]),
		.shamt(instruction[10:6]),
		.sftSrc(reg_out2_new) 
		);
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(ans_alu),
        .data1_i(ans_shifter),
		.data2_i(ans_zeroFilled),
        .select_i(FURslt),
        .data_o(result)
        );			
		
//new module		
Shifter_alt JumpShifter(    
		.result(JumpAddress),
		.sftSrc(instruction[25:0]) 
		);
		
Shifter BranchShifter(
		.result(BranchAdderSrc2), 
		.leftRight(1'b0),
		.shamt(5'b10),
		.sftSrc(ans_signExtend) 
		);

Adder BranchAdder(
       .src1_i(PC_next),     
	    .src2_i(BranchAdderSrc2),
	    .sum_o(BranchAddress)    
	    );

Mux2to1 #(.size(32)) BranchSelect(
        .data0_i(PC_next),
        .data1_i(BranchAddress),
        .select_i(Branch&&BranchResult1bit),
        .data_o(BranchResult)
        );	
		  
Mux2to1 #(.size(32)) JumpSelect(
        .data0_i(BranchResult),
        .data1_i({PC_next[31:28],JumpAddress}),
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
        .data0_i(result),
        .data1_i(DMResult),
        .select_i(MemtoReg),
        .data_o(WBResult)
        );	

Mux2to1 #(.size(1)) BranchCtrl(
        .data0_i(zero),
        .data1_i(~zero),
        .select_i(BranchType),
        .data_o(BranchResult1bit)
        );	

Mux2to1 #(.size(32)) JalWriteData(
        .data0_i(WBResult),
        .data1_i(PC_next),
        .select_i(Jal),
        .data_o(WBResult_new)
        );	
		  
Mux2to1 #(.size(5)) JalWriteRegister(
        .data0_i(WriteReg),
        .data1_i(5'b11111),
        .select_i(Jal),
        .data_o(WriteReg_new)
        );	

endmodule