
`include "Environment.sv"
`include "Interface.sv"

module FIFO_tb;

  signals sig();
  Environment env;

  syn_fifo DUT(
    .clk(sig.clk),
    .reset(sig.reset),
    .w_en(sig.w_en),
    .r_en(sig.r_en),
    .data(sig.data),
    .d_out(sig.d_out),
    .full(sig.full),
    .empty(sig.empty)
  );

  always #5 sig.clk = ~sig.clk;

  initial begin
    sig.clk   = 0;
    sig.reset = 1;

    env = new(sig);
    env.run();

    repeat(2) @(negedge sig.clk);
    sig.reset = 0;

    #25;
    sig.reset = 1;

    @(negedge sig.clk);
    sig.reset = 0;

    #100;

    env.scr.report();
    $finish;
  end

endmodule
