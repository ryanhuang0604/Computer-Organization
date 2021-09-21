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
  reg real_a;
  reg real_b;
  wire andResult;
  wire orResult;
  wire addResult;

  always@(invertA)
  begin
  if (invertA)
	assign real_a = ~a;
  else
	assign real_a = a;
  end
	
  always@(invertB)
  begin
  if (invertB)
	assign real_b = ~b;
  else
	assign real_b = b;
  end
  
  and AND(andResult, real_a, real_b);
  or OR(orResult, real_a, real_b);
  Full_adder ADD(addResult, carryOut, carryIn, real_a, real_b);

  assign result = (operation[1] & ~operation[0] & addResult) |
				(~operation[1] & operation[0] & andResult) |
				(~operation[1] & ~operation[0] & orResult) |
				(operation[1] & operation[0] & less);

endmodule