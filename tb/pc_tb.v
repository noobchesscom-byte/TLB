module pc_tb;

reg clk;
reg reset;
reg [31:0] pc_next;

wire [31:0] pc_curr;

pc dut(
    .clk(clk),
    .reset(reset),
    .pc_next(pc_next),
    .pc_curr(pc_curr)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("waveforms/pc.vcd");
    $dumpvars(0, pc_tb);

    clk = 0;
    reset = 1;
    pc_next = 32'd0;

    #10;
    reset = 0;

    #10;
    pc_next = 32'd4;

    #10;
    pc_next = 32'd8;

    #10;
    pc_next = 32'd12;

    #20;

    $finish;

end

endmodule
