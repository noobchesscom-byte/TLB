module decode_tb;
reg [31:0] instruction;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [5:0] func;
wire [5:0] opcode;
wire [15:0] imm;
wire [4:0] shamt;
wire [25:0] addr;
decode dut(
    .instruction(instruction),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .func(func),
    .opcode(opcode),
    .imm(imm),
    .shamt(shamt),
    .addr(addr)
);
initial begin
    $dumpfile("waveforms/decode.vcd");
    $dumpvars(0, decode_tb);
    instruction = 32'h20080005;
    #10;
    instruction = 32'h20090003;
    #10;
    instruction = 32'h01095020;
    #10;
    $finish;
end
endmodule
