module imem(
input [31:0] address,
output reg [31:0] instruction
);

always @(*) begin

        case(address)

                // lw t0, 0(zero)
                32'h00000000:
                instruction = 32'h8C080000;

                // addi t1, t0, 1
                // SHOULD CAUSE LOAD-USE STALL
                32'h00000004:
                instruction = 32'h21090001;

                // addi t2, t1, 1
                // SHOULD USE FORWARDING
                32'h00000008:
                instruction = 32'h212A0001;

                // addi t3, t2, 1
                // SHOULD USE FORWARDING AGAIN
                32'h0000000C:
                instruction = 32'h214B0001;

                // addi t4, t3, 1
                32'h00000010:
                instruction = 32'h216C0001;

                default:
                instruction = 32'h00000000;

        endcase

end

endmodule
