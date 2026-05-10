module hazard_unit(

input mem_to_reg_ex,

input [4:0] rt_ex,

input [4:0] rs_id,
input [4:0] rt_id,

output reg stall

);

always @(*) begin

        stall = (mem_to_reg_ex == 1'b1) &&
                ((rt_ex == rs_id) || (rt_ex == rt_id));

end

endmodule
