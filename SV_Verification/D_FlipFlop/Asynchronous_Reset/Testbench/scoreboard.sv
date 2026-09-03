class scoreboard;
  mailbox mon2scb;
  transaction tr;
  
  bit expected_q;
  bit expected_qbar;
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction
  
  task run();
    repeat(30) begin
      mon2scb.get(tr);
      
      $display("SCOREBOARD:, rst=%0b ,d=%0b, en=%0b, q=%0b, qbar=%0b", tr.rst, tr.d, tr.en, tr.q, tr.qbar);
      
      expected_q=(tr.rst?1'b0:(tr.en?tr.d:tr.q));
      expected_qbar=(~expected_q);
      
      if (((expected_q == tr.q) && (tr.rst == 1'b0)) || ((tr.rst == 1'b1) && (expected_q == 1'b0))) begin
        
        $display("------------------------------------------------------------");
        $display("PASS");
        $display("------------------------------------------------------------");
      end
      
      else begin
        $display("------------------------------------------------------------");
        $display("FAIL");
        $display("------------------------------------------------------------");
      end
      
    end
  endtask
endclass
    

