module full_adder(
  input logic a,b,c,
  output logic sum, carry);
  
  always_comb begin
    sum=(a^b^c);
    carry=((a&b)|(b&c)|(a&c));
  end
  
endmodule
