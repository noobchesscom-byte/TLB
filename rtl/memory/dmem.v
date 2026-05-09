module dmem(
input clk,
input mem_write,
input [31:0] address,
input [31:0] write_data,
output [31:0] read_data
);
reg [31:0] memory [0:255];
assign read_data = memory[address[31:2]];
always @(posedge clk) begin
	if(mem_write)
memory[address[31:2]] <= write_data;
end

endmodule
