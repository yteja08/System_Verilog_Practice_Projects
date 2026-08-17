module syn_fifo #(parameter int depth = 16, width = 8)(
  input  clk, reset, w_en, r_en,
  input  [width-1:0] data,
  output reg [width-1:0]  d_out,
  output full, empty
);


  reg [$clog2(depth):0] r_ptr, w_ptr;
  reg [width-1:0] mem [depth-1:0];

  always @(posedge clk) begin
    if (reset) begin
      d_out <= 0;
      r_ptr <= 0;
      w_ptr <= 0;
    end
    else begin
      if (w_en && !full) begin
  
        mem[w_ptr[$clog2(depth)-1:0]] <= data;
        w_ptr <= w_ptr + 1;
      end
      if (r_en && !empty) begin

        d_out <= mem[r_ptr[$clog2(depth)-1:0]];
        r_ptr <= r_ptr + 1;
      end
    end
  end

  wire wrap = w_ptr[$clog2(depth)] ^ r_ptr[$clog2(depth)];


  assign full  = wrap & (w_ptr[$clog2(depth)-1:0] == r_ptr[$clog2(depth)-1:0]);
  assign empty = (w_ptr == r_ptr);

endmodule
