`include "interface.sv"
`include "environment.sv"

module testbench();
  itf ditf();
  environment env;  

full_adder dut(
  .a(ditf.a),
  .b(ditf.b),
  .c(ditf.c),
  .sum(ditf.sum),
  .carry(ditf.carry));
  
  initial begin
    env=new(ditf);
    env.run_test();
  end
  
endmodule

