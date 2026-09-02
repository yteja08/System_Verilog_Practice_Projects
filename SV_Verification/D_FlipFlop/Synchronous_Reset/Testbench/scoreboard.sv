class scoreboard;
  mailbox mon2scb;
  transaction tr2;
  
  bit expected_q;
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction
  
  task main();
    repeat(15) begin
      mon2scb.get(tr2);
      $display("SCOREBOARD:, reset=%0b ,d=%0b, q=%0b", tr2.reset,tr2.d,tr2.q,);
      
      expected_q=(tr2.d);
      
      if (((expected_q == tr2.q) && (tr2.reset == 1'b0)) || ((tr2.reset == 1'b1) && (tr2.q == 1'b0))) begin
        $display("PASS");
        $display("------------------------------------------------------------");
      end
      else begin
        $display("FAIL");
        $display("------------------------------------------------------------");
      end
      
    end
  endtask
endclass
    
