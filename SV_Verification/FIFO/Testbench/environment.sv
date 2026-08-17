`include "Transaction.sv"
`include "Generator.sv"
`include "Driver.sv"
`include "Monitor.sv"
`include "ScoreBoard.sv"
class Environment;
  
  Transaction tr;
  Generator gen;
  Driver dri;
  Monitor mon;
  ScoreBoard scr;
  virtual signals sig;
  
  mailbox #(Transaction) gen_dri;
  mailbox #(Transaction) mon_scr;
  
  function new(virtual signals sig);
    this.sig = sig;
    
    gen_dri = new();
    mon_scr = new();
    
    gen = new(gen_dri,sig); 
    dri = new(gen_dri,sig);
    mon = new(mon_scr, sig);
    scr = new(mon_scr);
    
  endfunction
  
  task run();
    fork
      
      gen.run();
      dri.run();
      mon.run();
      scr.run();
      
    join_none
  endtask
 
  
endclass
