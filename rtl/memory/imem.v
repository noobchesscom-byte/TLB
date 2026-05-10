module imem (
    input  wire [31:0] address,
    output reg  [31:0] instruction
);

    localparam [31:0] P0 = 32'h0001_0000;
    localparam [31:0] P1 = 32'h0001_1000;
    localparam [31:0] P2 = 32'h0001_2000;
    localparam [31:0] P3 = 32'h0001_3000;
    localparam [31:0] P4 = 32'h0001_4000;
    localparam [31:0] P5 = 32'h0001_5000;
    localparam [31:0] P6 = 32'h0001_6000;
    localparam [31:0] P7 = 32'h0001_7000;

    localparam [31:0] J_P1      = {6'b000010, 26'h0004400};
    localparam [31:0] J_P2      = {6'b000010, 26'h0004800};
    localparam [31:0] J_P3      = {6'b000010, 26'h0004C00};
    localparam [31:0] J_P4      = {6'b000010, 26'h0005000};
    localparam [31:0] J_P5      = {6'b000010, 26'h0005400};
    localparam [31:0] J_P6      = {6'b000010, 26'h0005800};
    localparam [31:0] J_P7      = {6'b000010, 26'h0005C00};
    localparam [31:0] J_P0_LOOP = {6'b000010, 26'h0004008};
    localparam [31:0] J_P0_DONE = {6'b000010, 26'h000400C};
    localparam [31:0] J_SELF    = {6'b000010, 26'h000400C};

    always @(*) begin
        case (address)
        (P0+32'h000): instruction = 32'h20010001;  // addi $1,$0,1
        (P0+32'h004): instruction = 32'h20020002;  // addi $2,$0,2
        (P0+32'h008): instruction = 32'h20030003;  // addi $3,$0,3
        (P0+32'h00C): instruction = 32'h20040004;  // addi $4,$0,4
        (P0+32'h010): instruction = 32'h20050005;  // addi $5,$0,5
        (P0+32'h014): instruction = 32'h20060000;  // addi $6,$0,0 (counter)
        (P0+32'h018): instruction = 32'h20070003;  // addi $7,$0,3 (limit)
        (P0+32'h01C): instruction = J_P1;
        (P0+32'h020): instruction = 32'h20C60001;  // addi $6,$6,1
        (P0+32'h024): instruction = 32'h10C70002;  // beq $6,$7,+2
        (P0+32'h028): instruction = J_P1;
        (P0+32'h02C): instruction = J_P6;
        (P0+32'h030): instruction = J_SELF;

        (P1+32'h000): instruction = 32'h20210001;  // addi $1,$1,1
        (P1+32'h004): instruction = J_P2;

        (P2+32'h000): instruction = 32'h20420002;  // addi $2,$2,2
        (P2+32'h004): instruction = J_P3;

        (P3+32'h000): instruction = 32'h20630003;  // addi $3,$3,3
        (P3+32'h004): instruction = J_P4;

        (P4+32'h000): instruction = 32'h20840004;  // addi $4,$4,4
        (P4+32'h004): instruction = J_P5;

        (P5+32'h000): instruction = 32'h20A50005;  // addi $5,$5,5
        (P5+32'h004): instruction = J_P0_LOOP;

        (P6+32'h000): instruction = 32'h20C60006;  // addi $6,$6,6
        (P6+32'h004): instruction = J_P7;

        (P7+32'h000): instruction = 32'h20E70007;  // addi $7,$7,7
        (P7+32'h004): instruction = J_P0_DONE;

        default: instruction = 32'h0000_0000;
        endcase
    end

endmodule
