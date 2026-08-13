
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
  
  event drive_done;
  
  function new(virtual itf vitf);
    this.vitf=vitf;
    
    gen2drv=new();
    mon2scb=new();
    gen=new(gen2drv);
    drv=new(vitf,gen2drv,drive_done);
    mon=new(vitf,mon2scb,drive_done);
    scb=new(mon2scb);
    
  endfunction
    
    task run_test();
      fork
        gen.main();
        drv.main();
        mon.main();
        scb.main();
      join
    endtask
endclass
