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

    // Print state every cycle
    $display("Time | PC       | instr_ID | stall | fwd_a | fwd_b | wreg | wdata");
    repeat(15) begin
        @(posedge clk);
        $display("%4t | %h | %h |  %b    |  %b   |  %b   |  %2d  | %h",
            $time,
            dut.if_pc,
            dut.id_instruction,
            dut.stall,
            dut.forward_a,
            dut.forward_b,
            dut.write_reg_wb,
            dut.writeback_data
        );
    end

    $finish;
end
endmodule
