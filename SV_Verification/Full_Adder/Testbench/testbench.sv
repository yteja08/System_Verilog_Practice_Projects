`include "transaction.sv"
`include "generator.sv"
`include "interface.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

module testbench;
  
    environment env;

    full_adder_itf vitf();

    full_adder dut (
      .a    (vitf.a),
      .b    (vitf.b),
      .cin  (vitf.cin),
      .sum  (vitf.sum),
      .cout (vitf.cout)
    );

    initial begin
      env = new(vitf);
      env.run();
    end

endmodule

