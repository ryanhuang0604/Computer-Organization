module Shifter_alt( result, sftSrc );

//I/O ports 
output	[28-1:0] result;
input	[26-1:0] sftSrc ;

//Internal Signals
wire	[28-1:0] result;
  
//Main function
assign result[27:2] = sftSrc[25:0];
assign result[1] = 1'b0;
assign result[0] = 1'b0;

endmodule