class monitor;
  virtual itf vitf;
  mailbox mon2scb;
  transaction tr2;
  event drive_done;
  
  function new(virtual itf vitf, mailbox mon2scb, event drive_done);
    this.vitf=vitf;
    this.mon2scb=mon2scb;
    this.drive_done=drive_done;
  endfunction
  
  task main();
    repeat(15) begin
      
      @drive_done;
      
      tr2=new();
      tr2.a=vitf.a;
      tr2.b=vitf.b;
      tr2.c=vitf.c;
      tr2.sum=vitf.sum;
      tr2.carry=vitf.carry;
      $display("MONITOR:, a=%0b ,b=%0b, c=%0b, sum=%0b, carry=%0b", tr2.a,tr2.b,tr2.c,tr2.sum,tr2.carry);
      mon2scb.put(tr2);
      
    end
  endtask
endclass
