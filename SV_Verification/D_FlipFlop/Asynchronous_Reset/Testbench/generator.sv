class generator;

  transaction tr;
  mailbox gen2drv;

  function new(mailbox gen2drv);
        this.gen2drv = gen2drv;
    endfunction
  
  task run();
    repeat(15) begin
      
      tr=new();
      assert(tr.randomize());
      gen2drv.put(tr);
      
      $display("Generator: rst=%0b ,d=%0b, en=%0b, q=%0b, qbar=%0b", tr.rst ,tr.d ,tr.en ,tr.q, tr.qbar);
    
    end
  endtask
endclass
