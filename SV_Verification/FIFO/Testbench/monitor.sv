class Monitor;
  Transaction tr;
  mailbox #(Transaction ) mon_scr;
  virtual signals sig;
  
  function new(mailbox #(Transaction ) mon_scr,  virtual signals sig);
    this.mon_scr = mon_scr;
    this.sig =  sig;
  endfunction
  
  task run();
    forever 
      begin
        tr = new();
        @(posedge sig.clk );
        #1;
        tr.reset = sig.reset;
        tr.w_en = sig.w_en;
        tr.r_en = sig.r_en;
        tr.data = sig.data;
        tr.d_out = sig.d_out;
        tr.full = sig.full;
        tr.empty = sig.empty;
        mon_scr.put(tr);
        $display("[MON] time =%0t | reset =%b | w_en =%b | r_en =%b | data =%0d",$time, sig.reset, sig.w_en, sig.r_en, sig.data);
      end
  endtask
  
endclass
