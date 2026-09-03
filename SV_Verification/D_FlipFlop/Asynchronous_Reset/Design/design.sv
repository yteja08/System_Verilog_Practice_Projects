module dff(
input logic d,clk,rst,en,
output logic q,qbar
);

always @(posedge clk or posedge rst) begin
    
    q<=(rst?1'b0:(en?d:q));

end 

assign qbar=~q;

endmodule


  

