module execute_stage_tb;

reg clk;

reg [31:0] instruction;

wire [31:0] alu_result;

execute_stage dut(
.clk(clk),
.instruction(instruction),
.alu_result(alu_result)
);

always #5 clk = ~clk;

initial begin

$dumpfile("waveforms/execute_stage.vcd");
$dumpvars(0, execute_stage_tb);

clk = 0;

instruction = 32'd0;

dut.register_hard.registers[8] = 32'd10;
dut.register_hard.registers[9] = 32'd5;

#10;

instruction = 32'h01095020;

#20;

$finish;

end

endmodule
