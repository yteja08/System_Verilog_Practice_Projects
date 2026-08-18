
`include "Environment.sv"
`include "Interface.sv"

module memory_tb;
  signals sig();
  Environment env;
  memory dut (.clk(sig.clk),.rst(sig.rst),.read_write(sig.read_write),.data(sig.data),.add(sig.add),.out(sig.out));
  
  always #5 sig.clk = ~sig.clk;
  
  initial begin
    sig.clk =0;
    sig.rst =1;
    env = new(sig);
    env.run();
    
    #15 sig.rst =0;

    #15 sig.rst =1;
    # 10 sig.rst =0;
    #100;
    env.scr.report();
    $finish;
  end
  
endmodule
