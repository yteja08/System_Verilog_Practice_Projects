class Transaction #(parameter int width =8);
   bit reset;
  rand bit w_en, r_en;
  rand bit [width-1:0]data;
  bit [width-1:0]d_out;
  bit full;
  bit empty;
  
  constraint wr_constraint {
  {w_en, r_en} dist {
    2'b00 := 1,
    2'b01 := 4,
    2'b10 := 4,
    2'b11 := 1
  };
}
endclass
