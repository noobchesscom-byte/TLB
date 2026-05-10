module cpu(
input clk,
input reset
);

wire jump;
wire flush;
wire [31:0] if_instruction;
wire [31:0] if_pc;
wire [1:0] forward_a;
wire [1:0] forward_b;
wire [4:0] write_reg_ex;
wire [31:0] alu_src_a;
wire [31:0] alu_src_b;
wire [31:0] id_instruction;
wire [31:0] id_pc;

wire [31:0] ex_instruction;
wire [31:0] ex_pc;

wire [31:0] instruction;
wire [31:0] pc;
wire [31:0] alu_result_wb;

wire [31:0] mem_read_data_wb;

wire reg_write_wb;
wire mem_to_reg_wb;
wire [4:0] write_reg_wb;

wire [31:0] writeback_data;
wire branch_taken;

wire [31:0] branch_target;
wire [31:0] jump_target;

wire [31:0] alu_result;
wire [31:0] alu_result_mem;

wire [31:0] write_data_mem;

wire [31:0] read_data1_id;
wire [31:0] read_data2_id;

wire [31:0] read_data1_ex;
wire [31:0] read_data2_ex;

wire [31:0] imm_ext_id;
wire [31:0] imm_ext_ex;

wire [31:0] mem_read_data;

wire [5:0] opcode_id;
wire [5:0] funct_id;

wire [4:0] rs_id;
wire [4:0] rt_id;
wire [4:0] rd_id;

wire [4:0] rs_ex;
wire [4:0] rt_ex;
wire [4:0] rd_ex;

wire [15:0] imm_id;

wire [25:0] addr_id;

wire [2:0] alucontrol_id;
wire [2:0] alucontrol_ex;

wire alu_src_id;
wire branch_id;
wire jump_id;

wire alu_src_ex;
wire branch_ex;
wire jump_ex;

wire reg_write_id;
wire mem_write_id;
wire mem_to_reg_id;
wire reg_dst_id;

wire reg_write_ex;
wire mem_write_ex;
wire mem_to_reg_ex;
wire reg_dst_ex;

wire reg_write_mem;
wire mem_write_mem;
wire mem_to_reg_mem;

wire [4:0] write_reg_mem;
wire stall;
if_stage if_hard(
.clk(clk),
.reset(reset),

.branch_taken(branch_taken),

.jump(jump_ex),

.jump_target(jump_target),

.branch_target(branch_target),
.stall(stall),
.instruction(if_instruction),
.pc(if_pc)
);


if_id if_id_hard(

.clk(clk),
.reset(reset),
.stall(stall),
.instruction_in(if_instruction),
.pc_in(if_pc),
.flush(flush),
.instruction_out(id_instruction),
.pc_out(id_pc)

);
mem_wb mem_wb_hard(

.clk(clk),
.reset(reset),

.alu_result_in(alu_result_mem),

.mem_read_data_in(mem_read_data),

.reg_write_in(reg_write_mem),

.mem_to_reg_in(mem_to_reg_mem),

.write_reg_in(write_reg_mem),

.alu_result_out(alu_result_wb),

.mem_read_data_out(mem_read_data_wb),

.reg_write_out(reg_write_wb),

.mem_to_reg_out(mem_to_reg_wb),

.write_reg_out(write_reg_wb)

);
forwarding_unit forwarding_hard(

.rs_ex(rs_ex),
.rt_ex(rt_ex),

.rd_mem(write_reg_mem),
.rd_wb(write_reg_wb),

.reg_write_mem(reg_write_mem),
.reg_write_wb(reg_write_wb),

.forward_a(forward_a),
.forward_b(forward_b)

);
hazard_unit hazard_hard(

.mem_to_reg_ex(mem_to_reg_ex),

.rt_ex(write_reg_ex),

.rs_id(id_instruction[25:21]),
.rt_id(id_instruction[20:16]),

.stall(stall)

);
decode decode_hard(

.instruction(id_instruction),

.opcode(opcode_id),
.rs(rs_id),
.rt(rt_id),
.rd(rd_id),

.shamt(),

.func(funct_id),

.imm(imm_id),

.addr(addr_id)

);

control_unit control_hard(

.opcode(opcode_id),
.funct(funct_id),

.mem_to_reg(mem_to_reg_id),

.alu_src(alu_src_id),

.branch(branch_id),

.reg_dst(reg_dst_id),

.mem_write(mem_write_id),

.reg_write(reg_write_id),

.jump(jump_id),

.alucontrol(alucontrol_id)

);

sign_extend sign_extend_hard(

.imm(imm_id),

.imm_ext(imm_ext_id)

);

register register_hard(
.clk(clk),

.reg_write(reg_write_wb),

.read_reg1(rs_id),
.read_reg2(rt_id),

.write_reg(write_reg_wb),

.write_data(writeback_data),

.read_data1(read_data1_id),
.read_data2(read_data2_id)
);

id_ex id_ex_hard(

.clk(clk),
.reset(reset),
.stall(stall),
.instruction_in(id_instruction),
.pc_in(id_pc),

.read_data1_in(read_data1_id),
.read_data2_in(read_data2_id),

.imm_ext_in(imm_ext_id),

.alucontrol_in(alucontrol_id),

.alu_src_in(alu_src_id),
.branch_in(branch_id),
.jump_in(jump_id),

.reg_write_in(reg_write_id),
.mem_write_in(mem_write_id),
.mem_to_reg_in(mem_to_reg_id),
.reg_dst_in(reg_dst_id),

.rs_in(rs_id),
.rt_in(rt_id),
.rd_in(rd_id),

.instruction_out(ex_instruction),
.pc_out(ex_pc),

.read_data1_out(read_data1_ex),
.read_data2_out(read_data2_ex),

.imm_ext_out(imm_ext_ex),

.alucontrol_out(alucontrol_ex),

.alu_src_out(alu_src_ex),
.branch_out(branch_ex),
.jump_out(jump_ex),

.reg_write_out(reg_write_ex),
.mem_write_out(mem_write_ex),
.mem_to_reg_out(mem_to_reg_ex),
.reg_dst_out(reg_dst_ex),

.rs_out(rs_ex),
.rt_out(rt_ex),
.rd_out(rd_ex)

);

execute_stage execute_hard(
.clk(clk),

.instruction(ex_instruction),

.pc_curr(ex_pc),

.read_data1(read_data1_ex),
.read_data2(read_data2_ex),
.alu_src_a(alu_src_a),
.alu_src_b(alu_src_b),
.imm_ext(imm_ext_ex),

.alucontrol(alucontrol_ex),

.alu_src(alu_src_ex),
.branch(branch_ex),
.jump(jump_ex),

.reg_write(reg_write_ex),
.mem_write(mem_write_ex),
.mem_to_reg(mem_to_reg_ex),
.reg_dst(reg_dst_ex),

.rd(rd_ex),
.rt(rt_ex),

.branch_taken(branch_taken),
.branch_target(branch_target),

.alu_result(alu_result),

.jump_target(jump_target)

);

ex_mem ex_mem_hard(

.clk(clk),
.reset(reset),

.alu_result_in(alu_result),

.write_data_in(alu_src_b),

.reg_write_in(reg_write_ex),
.mem_write_in(mem_write_ex),
.mem_to_reg_in(mem_to_reg_ex),

.write_reg_in(
(reg_dst_ex == 1'b1) ?
rd_ex :
rt_ex
),

.alu_result_out(alu_result_mem),

.write_data_out(write_data_mem),

.reg_write_out(reg_write_mem),
.mem_write_out(mem_write_mem),
.mem_to_reg_out(mem_to_reg_mem),

.write_reg_out(write_reg_mem)

);

dmem dmem_hard(

.clk(clk),

.mem_write(mem_write_mem),

.address(alu_result_mem),

.write_data(write_data_mem),

.read_data(mem_read_data)

);
assign write_reg_ex =

(reg_dst_ex == 1'b1) ?
rd_ex :
rt_ex;
assign writeback_data =
(mem_to_reg_wb == 1'b1) ?
mem_read_data_wb :
alu_result_wb;
assign alu_src_a =

(forward_a == 2'b10) ?
alu_result_mem :

(forward_a == 2'b01) ?
writeback_data :

read_data1_ex;
assign alu_src_b =

(forward_b == 2'b10) ?
alu_result_mem :

(forward_b == 2'b01) ?
writeback_data :
read_data2_ex;
assign flush = branch_taken | jump_ex;
endmodule
