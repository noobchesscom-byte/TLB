module execute_stage(
input clk,
input [31:0] instruction,
output [31:0] alu_result
);
wire [2:0] alucontrol;
wire reg_write;
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
wire [31:0] alu_write_result;
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
control_unit control_hard(
.opcode(opcode),
.funct(func),
.reg_write(reg_write),
.alucontrol(alucontrol)
);
register register_hard(
.clk(clk),
.reg_write(reg_write),

.read_reg1(rs),
.read_reg2(rt),

.write_reg(rd),
.write_data(alu_write_result),

.read_data1(read_data1),
.read_data2(read_data2)
);

alu alu_hard(
.a(read_data1),
.b(read_data2),
.alucontrol(alucontrol),
.result(alu_write_result)
);
assign alu_result = alu_write_result;
endmodule
