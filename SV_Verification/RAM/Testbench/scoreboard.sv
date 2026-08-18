class ScoreBoard #(parameter D_W=8, A_W =16);
  
  Transaction tr;
  mailbox #(Transaction) mon_scr;
  virtual signals sig;
  bit [D_W-1:0] expected;
  reg [D_W-1:0] mem_r [A_W-1:0];
  int pass, fail;
  
  function new(mailbox #(Transaction) mon_scr, virtual signals sig);
    this.mon_scr = mon_scr;
    this.sig = sig;
  endfunction
  
  task run();
    forever begin
      tr = new();
      
     // @(posedge sig.clk or posedge sig.rst);
      mon_scr.get(tr);
      
      if(sig.rst)
        begin
          expected =0;
          $display("[SCR] time=%0t rst =1 ,expected =%b, Actual =%b", $time, expected,tr.out);
          if(expected == tr.out) begin
            $display("[SCR] time=%0t RESET case PASSED", $time);
            pass++;
          end
          else begin
            $display("[SCR] time=%0t RESET case FAILED", $time);
            fail++;
          end
          
        end
      else begin
        if(tr.read_write) begin
          expected = mem_r[tr.add];
          $display("[SCR] time =%0t READ add=%b expected = %b Actual =%b", $time,tr.add,expected, tr.out);
          if(expected == tr.out) begin
            $display("[SCR] PASSED \n");
            pass++;
          end
          else begin
            $display("[SCR] FAILED \n");
            fail++;
          end
        end
        else begin
          mem_r[tr.add] = tr.data;
          $display("[SCR] time =%0t WRITE add=%b expected = %b Actual =%b", $time,tr.add,mem_r[tr.add], tr.data);
          if( mem_r[tr.add] == tr.data) begin
            $display("[SCR] PASSED \n");
            pass++;
          end
          else begin
            $display("[SCR] FAILED \n");
            fail++;
          end
        end
      end
    end
  endtask
  
  function void report();
    
    $display("--------------------------");
    $display("    PASSED CASE : %0d   ",pass);
    $display("    FAILED CASE : %0d   ",fail);
    $display("--------------------------");
  endfunction
  
endclass
