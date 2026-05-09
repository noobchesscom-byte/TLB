module execute_stage(
input clk,
input [31:0] pc_curr,
input [31:0] instruction,
output branch_taken,
output [31:0] branch_target,
output [31:0] alu_result
);
wire [2:0] alucontrol;
wire reg_write;
wire mem_write;
wire mem_to_reg;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire alu_src;
wire [31:0] imm_ext;
wire [31:0] alu_input_b;
wire [5:0] func;
wire [5:0] opcode;
wire branch;
wire [31:0] branch_offset;
wire [15:0] imm;

wire [4:0] shamt;
wire [31:0] writeback_data;
wire [25:0] addr;
wire [31:0] mem_read_data;
wire [31:0] read_data1;
wire [31:0] read_data2;
wire reg_dst;

wire [4:0] write_reg;
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
.reg_dst(reg_dst),
.opcode(opcode),
.alu_src(alu_src),
.funct(func),
.reg_write(reg_write),
.mem_write(mem_write),
.mem_to_reg(mem_to_reg),
.branch(branch),
.alucontrol(alucontrol)
);
register register_hard(
.clk(clk),
.reg_write(reg_write),

.read_reg1(rs),
.read_reg2(rt),

.write_reg(write_reg),
.write_data(writeback_data),

.read_data1(read_data1),
.read_data2(read_data2)
);

alu alu_hard(
.a(read_data1),
.b(alu_input_b),
.alucontrol(alucontrol),
.result(alu_write_result)
);
dmem dmem_hard(.clk(clk),

.mem_write(mem_write),

.address(alu_write_result),

.write_data(read_data2),

.read_data(mem_read_data)
);
sign_extend sign_extend_hard(
.imm(imm),
.imm_ext(imm_ext)
);

assign alu_result = alu_write_result;
assign writeback_data =
(mem_to_reg) ? mem_read_data : alu_write_result;
assign alu_input_b =
(alu_src) ? imm_ext : read_data2;
assign write_reg =
(reg_dst) ? rd : rt;
assign branch_taken =
(branch && (alu_write_result == 0));
assign branch_offset = imm_ext << 2;
assign branch_target =
pc_curr + 4 + branch_offset;
endmodule
