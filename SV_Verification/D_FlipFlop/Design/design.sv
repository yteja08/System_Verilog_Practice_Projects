module dff(
  input logic d, clk, reset,
  output logic q);
  
  always@(posedge clk) begin
    if(reset) begin
      q<=1'b0;
    end
    else
      q<=d;
  end
endmodule
  
