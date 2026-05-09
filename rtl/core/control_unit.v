module control_unit(
input [5:0] opcode,
input [5:0] funct,
output reg alu_src,
output reg branch,
output reg mem_to_reg,
output reg reg_dst,
output reg mem_write,
output reg reg_write,
output reg jump,
output reg [2:0] alucontrol
);

always @(*) begin
	reg_dst = 0;
	mem_to_reg = 0;
        reg_write = 0;
        mem_write = 0;
	jump=0;
	alu_src = 0;
        alucontrol = 3'b000;
	branch = 0;
        case(opcode)

6'b000000: begin
	reg_dst = 1;
        reg_write = 1;

        case(funct)

6'b100000:
        alucontrol = 3'b000;

6'b100010:
        alucontrol = 3'b001;

6'b100100:
        alucontrol = 3'b010;

6'b100101:
        alucontrol = 3'b011;

6'b100110:
        alucontrol = 3'b100;

6'b101010:
        alucontrol = 3'b101;

default:
        alucontrol = 3'b000;

        endcase

end

6'b101011: begin

        mem_write = 1;
	alu_src = 1;
        alucontrol = 3'b000;

end
6'b100011: begin

        reg_write = 1;
	alu_src = 1;
        mem_to_reg = 1;

        alucontrol = 3'b000;

end
6'b001000: begin

        reg_write = 1;

        alu_src = 1;

        reg_dst = 0;

        alucontrol = 3'b000;

end
6'b000100: begin

        branch = 1;

        alucontrol = 3'b001;

end
6'b000010: begin

        jump = 1;

end

default: begin
	mem_to_reg = 0;
        reg_write = 0;
        mem_write = 0;
        alucontrol = 3'b000;

end

        endcase

end
   
endmodule
	
