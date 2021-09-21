module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow );

//I/O ports 
input	[32-1:0] aluSrc1;
input	[32-1:0] aluSrc2;
input	 [4-1:0] ALU_operation_i;

output	[32-1:0] result;
output			 zero;
output			 overflow;

//Internal Signals
wire			 zero;
wire			 overflow;
wire	[32-1:0] result;

//Main function
/*your code here*/
wire invertA;
wire invertB;
wire [1:0]operation;

assign invertA = ALU_operation_i[3];
assign invertB = ALU_operation_i[2];
assign operation[1] = ALU_operation_i[1];
assign operation[0] = ALU_operation_i[0];

wire set, less, c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;
assign less = 1'b0;
assign overflow = c30 ^ c31;

ALU_1bit ALU0(result[0], c0, aluSrc1[0], aluSrc2[0], invertA, invertB, operation, invertB, set);
ALU_1bit ALU1(result[1], c1, aluSrc1[1], aluSrc2[1], invertA, invertB, operation, c0, less);
ALU_1bit ALU2(result[2], c2, aluSrc1[2], aluSrc2[2], invertA, invertB, operation, c1, less);
ALU_1bit ALU3(result[3], c3, aluSrc1[3], aluSrc2[3], invertA, invertB, operation, c2, less);
ALU_1bit ALU4(result[4], c4, aluSrc1[4], aluSrc2[4], invertA, invertB, operation, c3, less);
ALU_1bit ALU5(result[5], c5, aluSrc1[5], aluSrc2[5], invertA, invertB, operation, c4, less);
ALU_1bit ALU6(result[6], c6, aluSrc1[6], aluSrc2[6], invertA, invertB, operation, c5, less);
ALU_1bit ALU7(result[7], c7, aluSrc1[7], aluSrc2[7], invertA, invertB, operation, c6, less);
ALU_1bit ALU8(result[8], c8, aluSrc1[8], aluSrc2[8], invertA, invertB, operation, c7, less);
ALU_1bit ALU9(result[9], c9, aluSrc1[9], aluSrc2[9], invertA, invertB, operation, c8, less);
ALU_1bit ALU10(result[10], c10, aluSrc1[10], aluSrc2[10], invertA, invertB, operation, c9, less);
ALU_1bit ALU11(result[11], c11, aluSrc1[11], aluSrc2[11], invertA, invertB, operation, c10, less);
ALU_1bit ALU12(result[12], c12, aluSrc1[12], aluSrc2[12], invertA, invertB, operation, c11, less);
ALU_1bit ALU13(result[13], c13, aluSrc1[13], aluSrc2[13], invertA, invertB, operation, c12, less);
ALU_1bit ALU14(result[14], c14, aluSrc1[14], aluSrc2[14], invertA, invertB, operation, c13, less);
ALU_1bit ALU15(result[15], c15, aluSrc1[15], aluSrc2[15], invertA, invertB, operation, c14, less);
ALU_1bit ALU16(result[16], c16, aluSrc1[16], aluSrc2[16], invertA, invertB, operation, c15, less);
ALU_1bit ALU17(result[17], c17, aluSrc1[17], aluSrc2[17], invertA, invertB, operation, c16, less);
ALU_1bit ALU18(result[18], c18, aluSrc1[18], aluSrc2[18], invertA, invertB, operation, c17, less);
ALU_1bit ALU19(result[19], c19, aluSrc1[19], aluSrc2[19], invertA, invertB, operation, c18, less);
ALU_1bit ALU20(result[20], c20, aluSrc1[20], aluSrc2[20], invertA, invertB, operation, c19, less);
ALU_1bit ALU21(result[21], c21, aluSrc1[21], aluSrc2[21], invertA, invertB, operation, c20, less);
ALU_1bit ALU22(result[22], c22, aluSrc1[22], aluSrc2[22], invertA, invertB, operation, c21, less);
ALU_1bit ALU23(result[23], c23, aluSrc1[23], aluSrc2[23], invertA, invertB, operation, c22, less);
ALU_1bit ALU24(result[24], c24, aluSrc1[24], aluSrc2[24], invertA, invertB, operation, c23, less);
ALU_1bit ALU25(result[25], c25, aluSrc1[25], aluSrc2[25], invertA, invertB, operation, c24, less);
ALU_1bit ALU26(result[26], c26, aluSrc1[26], aluSrc2[26], invertA, invertB, operation, c25, less);
ALU_1bit ALU27(result[27], c27, aluSrc1[27], aluSrc2[27], invertA, invertB, operation, c26, less);
ALU_1bit ALU28(result[28], c28, aluSrc1[28], aluSrc2[28], invertA, invertB, operation, c27, less);
ALU_1bit ALU29(result[29], c29, aluSrc1[29], aluSrc2[29], invertA, invertB, operation, c28, less);
ALU_1bit ALU30(result[30], c30, aluSrc1[30], aluSrc2[30], invertA, invertB, operation, c29, less);
ALU_1bit ALU31(result[31], c31, aluSrc1[31], aluSrc2[31], invertA, invertB, operation, c30, less);

ALU_1bit ALU(set, c31, aluSrc1[31], aluSrc2[31], invertA, invertB, 2'b10, c30, less);

//assign overflow = c30 ^ c31;
//assign set = result[31] ^ overflow;
assign zero = ~(result[0]|result[1]|result[2]|result[3]|result[4]|result[5]|result[6]|result[7]|result[8]|result[9]|result[10]|result[11]|result[12]|result[13]|result[14]|result[15]|result[16]|result[17]|result[18]|result[19]|result[20]|result[21]|result[22]|result[23]|result[24]|result[25]|result[26]|result[27]|result[28]|result[29]|result[30]|result[31]); 
	  

endmodule