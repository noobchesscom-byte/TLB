module cpu(
input clk,
input reset
);
wire jump;

wire [31:0] jump_target;
wire [31:0] instruction;
wire [31:0] pc;
wire branch_taken;
wire [31:0] branch_target;
wire [31:0] alu_result;

if_stage if_hard(.clk(clk),
.reset(reset),
.branch_taken(branch_taken),
.branch_target(branch_target),
.instruction(instruction),
.pc(pc),
.jump(jump),
.jump_target(jump_target)
);

execute_stage execute_hard(.clk(clk),
.instruction(instruction),
.pc_curr(pc),
.branch_taken(branch_taken),
.branch_target(branch_target),
.alu_result(alu_result),
.jump(jump),
.jump_target(jump_target)
);

endmodule
