module tlb #( 

parameter ENTRIES = 4,
parameter PENALTY = 5,
parameter ENABLE = 1,
parameter POLICY = 0

)(

input clk,
input reset,

input access_valid,

input [31:0] virtual_address,
output reg [31:0] physical_address,

output reg hit,
output reg miss,

output reg stall_request,
output wire [31:0] hit_count_out,
output wire [31:0] miss_count_out

);

reg [19:0] vpn [0:ENTRIES-1];

reg [19:0] ppn [0:ENTRIES-1];

reg valid [0:ENTRIES-1];

reg [31:0] age [0:ENTRIES-1];

reg [31:0] hit_count;

reg [31:0] miss_count;
assign hit_count_out = hit_count;

assign miss_count_out = miss_count;
reg miss_active;

reg [31:0] miss_counter;

integer i;

reg [31:0] replace_ptr;

reg [31:0] hit_idx;

reg [31:0] victim;

always @(*) begin

        case(POLICY)

                0:
                victim = replace_ptr;

                1:
                victim = $random % ENTRIES;

                2: begin

                        victim = 0;

                        for(i = 1; i < ENTRIES; i = i + 1) begin

                                if(age[i] > age[victim])

                                        victim = i;

                        end

                end

                default:
                victim = replace_ptr;

        endcase

end
always @(*) begin
	hit_idx  = 1'b0;
        hit = 1'b0;

        miss = 1'b0;

        physical_address = 32'b0;

        if(access_valid == 1'b1) begin

                if(ENABLE == 0) begin

                        miss = 1'b1;

                end

                else begin

                        for(i = 0; i < ENTRIES; i = i + 1) begin

                                if(
                                (valid[i] == 1'b1) &&
                                (vpn[i] == virtual_address[31:12])
                                ) begin

                                        hit = 1'b1;
					hit_idx = i;
                                        physical_address = {
                                        ppn[i],
                                        virtual_address[11:0]
                                        };

                                end

                        end

                        if(hit == 1'b0)

                                miss = 1'b1;

                end

        end

end

always @(posedge clk or posedge reset) begin

        if(reset) begin

                stall_request <= 0;

                miss_active <= 0;

                miss_counter <= 0;

                hit_count <= 0;

                miss_count <= 0;

                replace_ptr <= 0;

                for(i = 0; i < ENTRIES; i = i + 1) begin

                        valid[i] <= 0;

                        vpn[i] <= 0;

                        ppn[i] <= 0;

                        age[i] <= 0;

                end
		hit_idx <= 0;
        end

        else begin
		for(i = 0; i < ENTRIES; i = i + 1)
			
			if(valid[i] == 1'b1)

				age[i] <= age[i] + 1;

                if(hit == 1'b1) begin

			hit_count <= hit_count + 1;

			age[hit_idx] <= 0;

end

                if(miss == 1'b1)

                        miss_count <= miss_count + 1;

                if(miss == 1'b1 && miss_active == 1'b0) begin

                        miss_active <= 1'b1;

                        stall_request <= 1'b1;

                        miss_counter <= PENALTY;

                end

                else if(miss_active == 1'b1) begin

                        if(miss_counter > 0)

                                miss_counter <= miss_counter - 1;

                        else begin

                                valid[victim] <= 1'b1;

                                vpn[victim] <= virtual_address[31:12];

                                ppn[victim] <= virtual_address[31:12] + 20'h00010;

                                age[victim] <= 0;

                                if(replace_ptr == ENTRIES - 1)

                                        replace_ptr <= 0;

                                else

                                        replace_ptr <= replace_ptr + 1;

                                miss_active <= 1'b0;

                                stall_request <= 1'b0;

                                miss_counter <= 0;

                        end

                end

        end

end

endmodule
