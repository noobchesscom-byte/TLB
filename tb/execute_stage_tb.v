module execute_stage_tb;

reg clk;

reg reg_write;

reg [31:0] instruction;

reg [2:0] alucontrol;

reg [4:0] write_reg;

reg [31:0] write_data;

wire [31:0] alu_result;

execute_stage dut(
.clk(clk),
.reg_write(reg_write),
.instruction(instruction),
.alucontrol(alucontrol),
.write_reg(write_reg),
.write_data(write_data),
.alu_result(alu_result)
);

always #5 clk = ~clk;

initial begin

$dumpfile("waveforms/execute_stage.vcd");
$dumpvars(0, execute_stage_tb);

clk = 0;

reg_write = 1;

write_reg = 5'd8;
write_data = 32'd10;

#10;

write_reg = 5'd9;
write_data = 32'd5;

#10;

reg_write = 0;

instruction = 32'h01095020;

alucontrol = 3'b000;

#20;

$finish;

end

endmodule
