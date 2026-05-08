module if_stage_tb;
reg clk;
reg reset;
wire [31:0] instruction;
wire [31:0] pc;
if_stage dut(
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .pc(pc)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("waveforms/if_stage.vcd");
    $dumpvars(0, if_stage_tb);
    clk = 0;
    reset = 1;
    #10;
    reset = 0;
    #50;
    $finish;
end
endmodule
