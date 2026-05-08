module execute_stage(
input clk,
input reg_write,
input [31:0] instruction,
input [2:0] alucontrol,
input [4:0] write_reg,
input [31:0] write_data,
output [31:0] alu_result
);

wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;

wire [5:0] func;
wire [5:0] opcode;

wire [15:0] imm;

wire [4:0] shamt;

wire [25:0] addr;

wire [31:0] read_data1;
wire [31:0] read_data2;

decode decode_hard(
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

register register_hard(
.clk(clk),
.reg_write(reg_write),

.read_reg1(rs),
.read_reg2(rt),

.write_reg(write_reg),
.write_data(write_data),

.read_data1(read_data1),
.read_data2(read_data2)
);

alu alu_hard(
.a(read_data1),
.b(read_data2),
.alucontrol(alucontrol),
.result(alu_result)
);

endmodule
