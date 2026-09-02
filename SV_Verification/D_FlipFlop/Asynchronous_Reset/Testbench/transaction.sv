`include "interface.sv"
`include "environment.sv"

module testbench();
  itf ditf();
  environment env;  

    dff dut(
  .rst(ditf.rst),
  .d(ditf.d),
  .en(ditf.en),
  .q(ditf.q),
  .qbar(ditf.qbar),
  .clk(ditf.clk)
    );
  
  initial begin
    ditf.clk = 0;
    forever #5
    ditf.clk = ~ditf.clk;
  end
  
  initial begin
    env=new(ditf);
    env.run_test();
    $finish;
  end
  
endmodule
