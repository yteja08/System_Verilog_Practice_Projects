interface signals #(parameter D_W =8 , A_W =16)();
 logic clk, rst;
 logic read_write;
 logic [D_W-1:0] data;
 logic [A_W-1:0] add;
 logic [D_W-1:0]out;
endinterface
