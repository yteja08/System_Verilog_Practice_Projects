class Transaction #(parameter D_W =8 , A_W =4);
  bit rst;
  rand bit read_write;
  rand bit [D_W-1:0] data;
  rand bit [A_W-1:0] add;
  bit [D_W-1:0] out;
endclass
