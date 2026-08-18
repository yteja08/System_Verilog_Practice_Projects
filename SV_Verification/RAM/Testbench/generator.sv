class Generator;
  Transaction tr;
  mailbox #(Transaction) gen_dri;
  virtual signals sig;
  
  function new(mailbox #(Transaction) gen_dri, virtual signals sig);
    this.sig = sig;
    this.gen_dri = gen_dri;
  endfunction
  
  task run();
    forever 
      begin
        tr = new();
        @(posedge sig.clk);
        void '(tr.randomize());
        gen_dri.put(tr);
        $display("[GEN] time =%0t ",$time);
      end
  endtask
  
endclass
