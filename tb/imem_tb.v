module imem_tb;

reg [31:0] address;
wire [31:0] instruction;

imem dut(
    .address(address),
    .instruction(instruction)
);

initial begin

    $dumpfile("waveforms/imem.vcd");
    $dumpvars(0, imem_tb);

    address = 32'd0;
    #10;

    address = 32'd4;
    #10;

    address = 32'd8;
    #10;

    address = 32'd12;
    #10;

    $finish;

end

endmodule
