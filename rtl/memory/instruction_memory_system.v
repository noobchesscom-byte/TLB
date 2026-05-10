module instruction_memory_system #(
    parameter POLICY  = 0,
    parameter ENTRIES = 8,
    parameter PENALTY = 5,
    parameter ENABLE  = 1
)(

input clk,
input reset,

input access_valid,

input [31:0] virtual_address,

output [31:0] instruction,

output stall_request,
output [31:0] itlb_hits,

output [31:0] itlb_misses
);

wire [31:0] physical_address;

wire tlb_hit;

wire tlb_miss;
tlb #(
    .POLICY  (POLICY),
    .ENTRIES (ENTRIES),
    .PENALTY (PENALTY),
    .ENABLE  (ENABLE)
)tlb_hard(

.clk(clk),
.reset(reset),
.hit_count_out(itlb_hits),

.miss_count_out(itlb_misses),
.access_valid(access_valid),

.virtual_address(virtual_address),

.physical_address(physical_address),

.hit(tlb_hit),

.miss(tlb_miss),

.stall_request(stall_request)

);

imem imem_hard(

.address(physical_address),

.instruction(instruction)

);

endmodule
