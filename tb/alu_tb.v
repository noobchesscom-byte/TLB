module alu_tb;

reg [31:0] a;
reg [31:0] b;

reg [2:0] alucontrol;

wire [31:0] result;

alu dut(
    .a(a),
    .b(b),
    .alucontrol(alucontrol),
    .result(result)
);

initial begin

    $dumpfile("waveforms/alu.vcd");
    $dumpvars(0, alu_tb);

    a = 32'd10;
    b = 32'd5;

    alucontrol = 3'b000;
    #10;

    alucontrol = 3'b001;
    #10;

    alucontrol = 3'b010;
    #10;

    alucontrol = 3'b011;
    #10;

    alucontrol = 3'b100;
    #10;

    alucontrol = 3'b101;
    #10;

    $finish;

end

endmodule
