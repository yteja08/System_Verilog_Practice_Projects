class monitor;
  virtual itf vitf;
  mailbox mon2scb;
  transaction tr;
  
  function new(virtual itf vitf, mailbox mon2scb);
    this.vitf=vitf;
    this.mon2scb=mon2scb;
  endfunction
  
  task run();
    repeat(15) begin
      
      @(mon_clk);
      
      tr=new();
      tr.rst=vitf.rst;
      tr.en=vitf.en;
      tr.d=vitf.d;
      tr.q=vitf.q;
      tr.qbar=vitf.qbar;
      
      $display("MONITOR: rst=%0b, d=%0b, en=%0b, q=%0b, qbar=%0b",tr.reset,tr.d,tr.en, tr.q,tr.qbar);
     
      mon2scb.put(tr);
      
    end
  endtask
endclass
