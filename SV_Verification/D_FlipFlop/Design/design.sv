module dff(
  input logic d, clk, reset,
  output logic q);
  
  always_ff begin
    if(reset) begin
      q<=1'b0;
    end
    else
      q<=d;
  end
endmodule
  
