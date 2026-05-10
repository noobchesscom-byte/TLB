`timescale 1ns/1ps

module cpu_tb;

reg clk, reset;
always #5 clk = ~clk;

cpu #(.TLB_POLICY(0),.TLB_ENTRIES(4),.TLB_PENALTY(3),.ITLB_ENABLE(0),.DTLB_ENABLE(0)) dut_notlb  (.clk(clk),.reset(reset));
cpu #(.TLB_POLICY(0),.TLB_ENTRIES(4),.TLB_PENALTY(3),.ITLB_ENABLE(1),.DTLB_ENABLE(1)) dut_fifo   (.clk(clk),.reset(reset));
cpu #(.TLB_POLICY(1),.TLB_ENTRIES(4),.TLB_PENALTY(3),.ITLB_ENABLE(1),.DTLB_ENABLE(1)) dut_random (.clk(clk),.reset(reset));
cpu #(.TLB_POLICY(2),.TLB_ENTRIES(4),.TLB_PENALTY(3),.ITLB_ENABLE(1),.DTLB_ENABLE(1)) dut_lru    (.clk(clk),.reset(reset));

integer cycle;

initial begin
    $dumpfile("waveforms/cpu.vcd");
    $dumpvars(0, cpu_tb);

    clk = 0; reset = 1; cycle = 0;
    #20; reset = 0;

    $display("==========================================================");
    $display("  Full CPU TLB Policy Test — 4 CPUs running in parallel");
    $display("  Each CPU runs the same multi-page program.");
    $display("  TLB: 4 entries, penalty=3 cycles");
    $display("==========================================================");
    $display("Cycle | CPU         | PC(IF)   | iHits | iMiss | dHits | dMiss | stall");

    repeat(200) begin
        @(posedge clk);
        cycle = cycle + 1;
        if (cycle % 20 == 0) begin
            $display("%5d | NO_TLB      | %h | %4d  |  %4d | %4d  |  %4d | %b",
                cycle, dut_notlb.if_hard.pc,
                dut_notlb.itlb_hits, dut_notlb.itlb_misses,
                dut_notlb.dtlb_hits, dut_notlb.dtlb_misses,
                dut_notlb.stall_request);
            $display("%5d | FIFO        | %h | %4d  |  %4d | %4d  |  %4d | %b",
                cycle, dut_fifo.if_hard.pc,
                dut_fifo.itlb_hits, dut_fifo.itlb_misses,
                dut_fifo.dtlb_hits, dut_fifo.dtlb_misses,
                dut_fifo.stall_request);
            $display("%5d | RANDOM      | %h | %4d  |  %4d | %4d  |  %4d | %b",
                cycle, dut_random.if_hard.pc,
                dut_random.itlb_hits, dut_random.itlb_misses,
                dut_random.dtlb_hits, dut_random.dtlb_misses,
                dut_random.stall_request);
            $display("%5d | LRU         | %h | %4d  |  %4d | %4d  |  %4d | %b",
                cycle, dut_lru.if_hard.pc,
                dut_lru.itlb_hits, dut_lru.itlb_misses,
                dut_lru.dtlb_hits, dut_lru.dtlb_misses,
                dut_lru.stall_request);
            $display("----------------------------------------------------------");
        end
    end

    $display("==========================================================");
    $display("  FINAL RESULTS after 200 cycles:");
    $display("  NO_TLB  iTLB hits=%4d misses=%4d  dTLB hits=%4d misses=%4d",
        dut_notlb.itlb_hits, dut_notlb.itlb_misses,
        dut_notlb.dtlb_hits, dut_notlb.dtlb_misses);
    $display("  FIFO    iTLB hits=%4d misses=%4d  dTLB hits=%4d misses=%4d",
        dut_fifo.itlb_hits, dut_fifo.itlb_misses,
        dut_fifo.dtlb_hits, dut_fifo.dtlb_misses);
    $display("  RANDOM  iTLB hits=%4d misses=%4d  dTLB hits=%4d misses=%4d",
        dut_random.itlb_hits, dut_random.itlb_misses,
        dut_random.dtlb_hits, dut_random.dtlb_misses);
    $display("  LRU     iTLB hits=%4d misses=%4d  dTLB hits=%4d misses=%4d",
        dut_lru.itlb_hits, dut_lru.itlb_misses,
        dut_lru.dtlb_hits, dut_lru.dtlb_misses);
    $display("==========================================================");

    $finish;
end

endmodule
