module cpu_tb;

reg clk;

reg reset;

cpu dut(
.clk(clk),
.reset(reset)
);

always #5 clk = ~clk;

initial begin

$dumpfile("waveforms/cpu.vcd");
$dumpvars(0, cpu_tb);

clk = 0;

reset = 1;

#10;

reset = 0;

#100;

$finish;

end

endmodule
