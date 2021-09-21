module Sign_Extend( data_i, data_o );

//I/O ports
input	[16-1:0] data_i;
output	[32-1:0] data_o;

//Internal Signals
wire	[32-1:0] data_o;

//Sign extended
wire [15:0] pos;
wire [15:0] neg;
assign pos=0;
assign neg=16'b1111111111111111;
assign data_o[15:0]=data_i[15:0];
assign data_o[31:16]=(data_i[15])?neg[15:0]:pos[15:0];

endmodule      
