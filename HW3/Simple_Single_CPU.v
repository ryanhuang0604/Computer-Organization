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

//modules
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(PC_next) ,   
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
        .RDaddr_i(WriteReg) ,  
        .RDdata_i(result)  , 
        .RegWrite_i(RegWrite),
        .RSdata_o(reg_out1) ,  
        .RTdata_o(reg_out2)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUOp_o(ALUOP),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst)   
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

endmodule