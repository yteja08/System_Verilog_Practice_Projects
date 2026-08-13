class generator;
  transaction tr;
  mailbox gen2drv;
  
  function new(mailbox gen2drv);
    this.gen2drv=gen2drv;
  endfunction
  
  task main();
    repeat(15) begin
      tr=new();
      assert(tr.randomize());
      gen2drv.put(tr);
      $display("Generator:, a=%0b ,b=%0b, c=%0b", tr.a,tr.b,tr.c);
    end
  endtask
endclass
