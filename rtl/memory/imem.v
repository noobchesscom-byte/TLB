module imem(
input [31:0] address,
output reg [31:0] instruction
);

always @(*) begin

        case(address)

32'h00000000:
instruction = 32'h20080005;

32'h00000004:
instruction = 32'h20090005;

32'h00000008:
instruction = 32'h11090001;

32'h0000000C:
instruction = 32'h200A0001;

32'h00000010:
instruction = 32'h200B0009;

default:
instruction = 32'h20000000;

        endcase

end

endmodule
