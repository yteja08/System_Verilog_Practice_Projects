
module memory #(parameter D_W= 8 , A_W= 16)(
  input clk, rst,
  input read_write,
  input [D_W-1:0] data,
  input [A_W-1:0] add,
  output reg [D_W-1:0]out
);
  reg [D_W-1:0] mem [A_W-1:0];
  always @(posedge clk or posedge rst)
    begin
      if(rst)
        begin
          out <=0;
        end
      else
        begin
          if(read_write)
            out <= mem[add];
          else
             mem [add] <= data;
        end
    end
endmodule
