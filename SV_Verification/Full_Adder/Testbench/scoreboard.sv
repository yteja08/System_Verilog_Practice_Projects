class scoreboard;
  mailbox mon2scb;
  transaction tr2;
  
  bit expected_sum;
  bit expected_carry;
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction
  
  task main();
    repeat(15) begin
      mon2scb.get(tr2);
      $display("SCOREBOARD:, a=%0b ,b=%0b, c=%0b, sum=%0b, carry=%0b", tr2.a,tr2.b,tr2.c,tr2.sum,tr2.carry);
      
      expected_sum=(tr2.a^tr2.b^tr2.c);
      expected_carry=((tr2.a&tr2.b)|(tr2.c&tr2.b)|(tr2.a&tr2.c));
      
      if ((expected_sum ==tr2.sum) &&  (expected_carry==tr2.carry))
        $display("PASS");
      else
        $display("FAIL");
      
    end
  endtask
endclass
    
