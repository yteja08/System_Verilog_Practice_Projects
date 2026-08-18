class Monitor;
  Transaction tr;
  mailbox #(Transaction) mon_scr;
  virtual signals sig;
  
  function new( mailbox #(Transaction) mon_scr, virtual signals sig);
    this.mon_scr = mon_scr;
    this.sig = sig;
  endfunction
  
  task run();
    forever begin
      tr= new();
      
      @(posedge sig.clk or posedge sig.rst);
      #1;
      tr.rst = sig.rst;
      tr.read_write = sig.read_write;
      tr.data = sig.data;
      tr.add = sig.add;
      tr.out = sig.out;
//       mon_scr.put(tr);
      if(sig.read_write)
        $display("[MON] time =%0t , rst =%b, read_write =1, add =%b out =%b",$time,tr.rst,tr.add,tr.out);
    else
      $display("[MON] time =%0t , rst =%b read_write =0, data= %b, add =%b",$time,tr.rst,tr.data,tr.add);
    mon_scr.put(tr);
    end
  endtask
endclass
