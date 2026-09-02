class generator;

  transaction tr1;
  mailbox gen2drv;

  function new(mailbox gen2drv);
        this.gen2drv = gen2drv;
    endfunction
  
  task main();
    repeat(15) begin
      
      tr1=new();
      assert(tr1.randomize());
      gen2drv.put(tr1);
      $display("Generator: reset=%0b ,d=%0b, q=%0b", tr1.reset,tr1.d,tr1.q);
    end
    $display("------------------------------------------------------------");
    $display(">>> Displaying The Samples Happened In The Posedge Of CLK<<<");
    $display("------------------------------------------------------------");
  endtask
endclass
