class transaction;
  
  rand bit d;
  rand bit reset;
  bit q;
  bit clk;
  
  constraint c1{reset dist{0:=13,1:=8};}
  
endclass
