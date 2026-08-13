class driver;
  virtual itf vitf;
  mailbox gen2drv;
  transaction tr;
  event drive_done;
  
  function new(virtual itf vitf, mailbox gen2drv, event drive_done);
    this.vitf=vitf;
    this.gen2drv=gen2drv;
    this.drive_done=drive_done;
  endfunction
  
  task main();
    repeat(15) begin
      
      gen2drv.get(tr);
      
      vitf.a=tr.a;
      vitf.b=tr.b;
      vitf.c=tr.c;
      #1;
      $display("DRIVER:, a=%0b ,b=%0b, c=%0b", vitf.a,vitf.b,vitf.c);
      ->drive_done;
      #1;
    end
  endtask
endclass
