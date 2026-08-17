interface signals #(parameter int depth=16, width=8);
logic clk,reset,w_en,r_en;
logic [width-1:0]data;
 logic [width-1:0]d_out;
logic full,empty;
endinterface
