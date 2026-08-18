class Driver;
  Transaction tr;
  mailbox #(Transaction) gen_dri;
  virtual signals sig;
  
  function new(mailbox #(Transaction) gen_dri, virtual signals sig);
    this.gen_dri = gen_dri;
    this.sig = sig;
  endfunction
  
  task run();
    forever begin
      tr= new();
      @(negedge sig.clk or posedge sig.rst);
      gen_dri.get(tr);
      
      sig.read_write = tr.read_write;
      sig.data = tr.data;
      sig.add = tr.add;
      
      $display("[DRI] time =%0t sig.read_write =%b ,sig.data =%b , sig.add =%b", $time,tr.read_write, tr.data,tr.add);
    end
  endtask
endclass
