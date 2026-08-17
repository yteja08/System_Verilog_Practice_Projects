class Driver;
  
  Transaction tr;
  mailbox #(Transaction) gen_dri;
  virtual signals sig;
  
  function new(mailbox #(Transaction) gen_dri, virtual signals sig);
    this.sig = sig;
    this.gen_dri = gen_dri;
  endfunction
  
  task run();
    forever begin
      tr = new();
      @(negedge sig.clk);
      gen_dri.get(tr);
      sig.reset = tr.reset;
      sig.w_en = tr.w_en;
      sig.r_en = tr.r_en;
      sig.data = tr.data;
      
      $display("[DRI] time =%0t | reset =%b | w_en =%b | r_en =%b | data =%0d",$time, tr.reset, tr.w_en, tr.r_en, tr.data);
    end
  endtask
endclass
