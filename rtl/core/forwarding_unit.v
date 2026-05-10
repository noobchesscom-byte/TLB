module forwarding_unit(

input [4:0] rs_ex,
input [4:0] rt_ex,

input [4:0] rd_mem,
input [4:0] rd_wb,

input reg_write_mem,
input reg_write_wb,

output reg [1:0] forward_a,
output reg [1:0] forward_b

);

always @(*) begin

        forward_a = 2'b00;
        forward_b = 2'b00;

        if(
        (reg_write_mem == 1'b1) &&
        (rd_mem != 5'b0) &&
        (rd_mem == rs_ex)
        ) begin

                forward_a = 2'b10;

        end

        else if(
        (reg_write_wb == 1'b1) &&
        (rd_wb != 5'b0) &&
        (rd_wb == rs_ex)
        ) begin

                forward_a = 2'b01;

        end

        if(
        (reg_write_mem == 1'b1) &&
        (rd_mem != 5'b0) &&
        (rd_mem == rt_ex)
        ) begin

                forward_b = 2'b10;

        end

        else if(
        (reg_write_wb == 1'b1) &&
        (rd_wb != 5'b0) &&
        (rd_wb == rt_ex)
        ) begin

                forward_b = 2'b01;

        end

end

endmodule
