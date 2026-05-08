module decode(input [31:0] instruction,
output [4:0] rs,
output [4:0] rt,
output [4:0] rd,
output [5:0] func,
output [5:0] opcode,
output [15:0] imm,
output [4:0] shamt,
output [25:0] addr);
assign opcode = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign shamt = instruction[10:6];
assign func = instruction[5:0];
assign imm = instruction[15:0];
assign addr = instruction[25:0];
endmodule
