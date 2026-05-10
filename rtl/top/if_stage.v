module if_stage#(
    parameter TLB_POLICY  = 0,
    parameter TLB_ENTRIES = 8,
    parameter TLB_PENALTY = 5,
    parameter TLB_ENABLE  = 1
)(input clk,
input reset,
input jump,
input stall,
input [31:0] jump_target,
input branch_taken,
input [31:0] branch_target,
output [31:0] itlb_hits,

output [31:0] itlb_misses,
output stall_request,
output [31:0] instruction,
output [31:0] pc);

wire [31:0] pc_curr;
wire [31:0] pc_next;

pc pc_hard(
.clk(clk),
.reset(reset),
.pc_next(pc_next),
.pc_curr(pc_curr)
);
instruction_memory_system#(
    .POLICY  (TLB_POLICY),
    .ENTRIES (TLB_ENTRIES),
    .PENALTY (TLB_PENALTY),
    .ENABLE  (TLB_ENABLE)
) ims_hard(

.clk(clk),
.reset(reset),

.access_valid(1'b1),

.virtual_address(pc_curr),
.itlb_hits(itlb_hits),

.itlb_misses(itlb_misses),
.instruction(instruction),

.stall_request(stall_request)

);
assign pc_next =

(stall == 1'b1 || stall_request == 1'b1) ? pc :

(jump === 1'b1) ? jump_target :

(branch_taken === 1'b1) ? branch_target :

(pc_curr + 4);
assign pc = pc_curr;

endmodule
