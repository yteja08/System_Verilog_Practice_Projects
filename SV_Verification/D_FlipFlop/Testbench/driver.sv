class driver;
  virtual itf vitf;
  mailbox gen2drv;
  transaction tr1;
  event drive_done;
  
  function new(virtual itf vitf, mailbox gen2drv,event drive_done);
    this.vitf=vitf;
    this.gen2drv=gen2drv;
    this.drive_done=drive_done;
  endfunction
  
  task main();
    repeat(15) begin
      
      gen2drv.get(tr1);
      
      @(negedge vitf.clk);
      
      vitf.reset=tr1.reset;
      vitf.d=tr1.d;
      vitf.q=tr1.q;
      
      ->drive_done;
      #1;
      $display("DRIVER:, reset=%0b ,d=%0b, q=%0b", vitf.reset,vitf.d,vitf.q);
      #1;
    end
  endtask
endclass
