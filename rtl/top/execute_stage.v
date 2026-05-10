module execute_stage(
input clk,
input [31:0] pc_curr,
input [31:0] instruction,
input [31:0] alu_src_a,
input [31:0] alu_src_b,
input [31:0] read_data1,
input [31:0] read_data2,

input [31:0] imm_ext,

input [2:0] alucontrol,

input alu_src,
input branch,
input jump,

input reg_write,
input mem_write,
input mem_to_reg,
input reg_dst,

input [4:0] rd,
input [4:0] rt,

output branch_taken,
output [31:0] branch_target,
output [31:0] alu_result,
output [31:0] jump_target
);

wire [31:0] alu_input_b;
wire [31:0] branch_offset;

wire [31:0] pc_plus_4;

wire [4:0] write_reg;
wire [31:0] alu_write_result;

alu alu_hard(
.a(alu_src_a),
.b(alu_input_b),
.alucontrol(alucontrol),
.result(alu_write_result)
);

assign alu_result = alu_write_result;


assign alu_input_b =
(alu_src == 1'b1) ?
imm_ext :
alu_src_b;
assign write_reg =
(reg_dst == 1'b1) ? rd : rt;

assign branch_taken =
(branch == 1'b1) &&
(alu_write_result == 32'b0);

assign branch_offset = imm_ext << 2;

assign branch_target =
pc_curr + 4 + branch_offset;

assign pc_plus_4 = pc_curr + 4;

assign jump_target =
(jump === 1'b1) ?
{pc_plus_4[31:28], instruction[25:0], 2'b00} :
32'b0;

endmodule
