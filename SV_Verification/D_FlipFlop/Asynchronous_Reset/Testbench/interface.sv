interface itf();

    logic d;
    logic rst;
    logic en;
    logic clk;
  
    logic q;
    logic qbar;
  
  clocking drv_clk @(posedge clk);
    output d,en,rst;
  endclocking
  
  clocking mon_clk @(posedge clk);
    input d,en,rst,q,qbar;
  endclocking
  
  modport drv(input clk, clocking drv_clk);
  modport mon(input clk, clocking mon_clk);

endinterface
