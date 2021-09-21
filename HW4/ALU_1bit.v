module ALU_1bit( result, carryOut, a, b, invertA, invertB, operation, carryIn, less ); 
  
  output wire result;
  output wire carryOut;
  
  input wire a;
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  input wire carryIn;
  input wire less;
  
  /*your code here*/
  wire real_a;
  wire real_b;
  wire andResult;
  wire orResult;
  wire addResult;

  assign real_a = (invertA) ? (~a+1) : a;
  assign real_b = (invertB) ? ~b : b;  
  and f1(andResult, ((invertA) ? (~a) : a), real_b);
  or f2(orResult, ((invertA) ? (~a) : a), real_b);
  Full_adder f3(addResult, carryOut, carryIn, real_a, real_b);

  assign result = (operation[1] & operation[0] & less) |
				  (~operation[1] & operation[0] & andResult) |
		          (~operation[1] & ~operation[0] & orResult) |
                  (operation[1] & ~operation[0] & addResult);

endmodule