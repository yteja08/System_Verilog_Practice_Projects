class monitor;
  virtual itf vitf;
  mailbox mon2scb;
  transaction tr2;
  event drive_done;
  
  function new(virtual itf vitf, mailbox mon2scb,event drive_done);
    this.vitf=vitf;
    this.mon2scb=mon2scb;
    this.drive_done=drive_done;
  endfunction
  
  task main();
    repeat(15) begin
      
      @drive_done;
      
      @(posedge vitf.clk);
      
    
      #1;
      
      tr2=new();
      tr2.reset=vitf.reset;
      tr2.d=vitf.d;
      tr2.q=vitf.q;
      $display("MONITOR: reset=%0b, d=%0b, q=%0b",tr2.reset,tr2.d,tr2.q);
      mon2scb.put(tr2);
      
    end
  endtask
endclass
