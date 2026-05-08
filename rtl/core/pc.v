module pc(
input clk,
input reset,
input [31:0] pc_next,
output reg [31:0] pc_curr);
always @(posedge clk) begin
	if(reset)
		pc_curr <= 32'b0;
	else
		pc_curr <=pc_next;
end
endmodule

