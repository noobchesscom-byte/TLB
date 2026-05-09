module if_stage(input clk,
input reset,
input jump,
input [31:0] jump_target,
input branch_taken,
input [31:0] branch_target,
output [31:0] instruction,
output [31:0] pc);
wire [31:0] pc_curr;
wire [31:0] pc_next;
pc pc_hard(
.clk(clk),
.reset(reset),
.pc_next(pc_next),
.pc_curr(pc_curr));
imem imem_hard(
    .address(pc_curr),
    .instruction(instruction)
);
assign pc_next =
(jump === 1'b1) ? jump_target :
(branch_taken === 1'b1) ? branch_target :
(pc_curr + 4);
assign pc=pc_curr;
endmodule
