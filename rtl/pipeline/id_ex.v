module id_ex(

input clk,
input reset,
input reg_write_in,
input mem_write_in,
input mem_to_reg_in,
input reg_dst_in,
input stall,
input [4:0] rs_in,
input [4:0] rt_in,
input [4:0] rd_in,
input [31:0] instruction_in,
 input [31:0] pc_in,
input flush,
input [31:0] read_data1_in,
 input [31:0] read_data2_in,

input [31:0] imm_ext_in,

input [2:0] alucontrol_in,

input alu_src_in,
input branch_in,
input jump_in,

output reg [31:0] instruction_out,
output reg [31:0] pc_out,

output reg [31:0] read_data1_out,
output reg [31:0] read_data2_out,

output reg [31:0] imm_ext_out,

output reg [2:0] alucontrol_out,
output reg reg_write_out,
output reg mem_write_out,
output reg mem_to_reg_out,
output reg reg_dst_out,

output reg [4:0] rs_out,
output reg [4:0] rt_out,
output reg [4:0] rd_out,

 output reg alu_src_out,
 output reg branch_out,
 output reg jump_out

);

always @(posedge clk or posedge reset) begin

        if(reset) begin

                reg_write_out <= 0;
                mem_write_out <= 0;
                mem_to_reg_out <= 0;
                reg_dst_out <= 0;

                rs_out <= 0;
                rt_out <= 0;
                rd_out <= 0;

                instruction_out <= 32'b0;

                pc_out <= 32'b0;

                read_data1_out <= 32'b0;
                read_data2_out <= 32'b0;

                imm_ext_out <= 32'b0;

                alucontrol_out <= 3'b000;

                alu_src_out <= 0;
                branch_out <= 0;
                jump_out <= 0;

        end

        else begin
		if(flush) begin

                reg_write_out <= 0;
                mem_write_out <= 0;
                mem_to_reg_out <= 0;
                reg_dst_out <= 0;

                alucontrol_out <= 3'b000;

                alu_src_out <= 0;
                branch_out <= 0;
                jump_out <= 0;

                rs_out <= 0;
                rt_out <= 0;
                rd_out <= 0;

                instruction_out <= 32'b0;

                pc_out <= 32'b0;

                read_data1_out <= 32'b0;
                read_data2_out <= 32'b0;

                imm_ext_out <= 32'b0;

        end

             else if(stall == 1'b1) begin

                        reg_write_out <= 0;
                        mem_write_out <= 0;
                        mem_to_reg_out <= 0;
                        reg_dst_out <= 0;

                        alucontrol_out <= 3'b000;

                        alu_src_out <= 0;
                        branch_out <= 0;
                        jump_out <= 0;

                        rs_out <= 0;
                        rt_out <= 0;
                        rd_out <= 0;

                        instruction_out <= 32'b0;

                        pc_out <= pc_out;

                        read_data1_out <= 32'b0;
                        read_data2_out <= 32'b0;

                        imm_ext_out <= 32'b0;

                end

                else begin

                        reg_write_out <= reg_write_in;
                        mem_write_out <= mem_write_in;
                        mem_to_reg_out <= mem_to_reg_in;
                        reg_dst_out <= reg_dst_in;

                        rs_out <= rs_in;
                        rt_out <= rt_in;
                        rd_out <= rd_in;

                        instruction_out <= instruction_in;

                        pc_out <= pc_in;

                        read_data1_out <= read_data1_in;
                        read_data2_out <= read_data2_in;

                        imm_ext_out <= imm_ext_in;

                        alucontrol_out <= alucontrol_in;

                        alu_src_out <= alu_src_in;

                        branch_out <= branch_in;
                        jump_out <= jump_in;

                end

        end

end
     
endmodule
