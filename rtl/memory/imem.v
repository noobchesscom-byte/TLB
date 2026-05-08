module imem(
    input [31:0] address,
    output [31:0] instruction
);
reg [31:0] memory [0:255];
initial begin
    memory[0] = 32'h20080005;
    memory[1] = 32'h20090003;
    memory[2] = 32'h01095020;
end
assign instruction = memory[address[31:2]];
endmodule
