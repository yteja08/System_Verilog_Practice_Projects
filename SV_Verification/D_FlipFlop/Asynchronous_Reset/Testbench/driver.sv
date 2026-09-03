class driver;
  virtual itf vitf;
  mailbox gen2drv;
  transaction tr;
  
  function new(virtual itf vitf, mailbox gen2drv);
    this.vitf=vitf;
    this.gen2drv=gen2drv;
  endfunction
  
  task run();
    repeat(30) begin
      
      gen2drv.get(tr);
      
      @(vitf.drv_clk);
      
      vitf.rst=tr.rst;
      vitf.d=tr.d;
      vitf.en=tr.en;
      
      $display("DRIVER:, rst=%0b ,d=%0b, en=%0b", vitf.rst,vitf.d,vitf.en);
      
    end
  endtask
endclass
