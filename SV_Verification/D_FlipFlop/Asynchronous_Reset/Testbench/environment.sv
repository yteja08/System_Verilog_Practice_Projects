
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;
  
  mailbox gen2drv;
  mailbox mon2scb;
  
  virtual itf vitf;
  
  function new(virtual itf vitf);
    this.vitf=vitf;
    
    gen2drv=new();
    mon2scb=new();
    gen=new(gen2drv);
    drv=new(vitf,gen2drv);
    mon=new(vitf,mon2scb);
    scb=new(mon2scb);
    
  endfunction
    
    task run_test();
      fork
        gen.run();
        drv.run();
        mon.run();
        scb.run();
      join
    endtask
endclass
