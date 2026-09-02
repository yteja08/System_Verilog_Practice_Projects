module dff(
input logic d,clk,rst,enable,
output logic q,qbar
);

always @(posedge clk or posedge rst) begin
    
    q<=(rst?1'b0:(enable?d:q));

end 

assign qbar=~q;

endmodule


