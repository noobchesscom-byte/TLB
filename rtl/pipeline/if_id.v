module if_id(
input clk,
input reset,
input stall,
input flush,
input [31:0] instruction_in,
input [31:0] pc_in,

output reg [31:0] instruction_out,
output reg [31:0] pc_out
);

always @(posedge clk or posedge reset) begin

        if(reset) begin

                instruction_out <= 32'b0;

                pc_out <= 32'b0;

        end
	else if(flush) begin
		instruction_out <= 32'b0;
		pc_out <= 32'b0;
		end

        else begin
		 if(stall == 1'b0) begin

                instruction_out <= instruction_in;

                pc_out <= pc_in;

        end
      end 
end

endmodule
