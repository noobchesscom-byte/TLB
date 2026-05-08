module regfile_tb;

reg clk;
reg reg_write;
reg [4:0] read_reg1;
reg [4:0] read_reg2;
reg [4:0] write_reg;
reg [31:0] write_data;
wire [31:0] read_data1;
wire [31:0] read_data2;

register dut( .clk(clk),
    .reg_write(reg_write),
.read_reg1(read_reg1),
    .read_reg2(read_reg2),
.write_reg(write_reg),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("waveforms/regfile.vcd");
    $dumpvars(0, regfile_tb);
    clk = 0;
    reg_write = 1;
    write_reg = 5'd8;
    write_data = 32'd25;
    #10;
    read_reg1 = 5'd8;
    #10;
    write_reg = 5'd0;
    write_data = 32'd100;
    #10;
    read_reg2 = 5'd0;
    #10;
    $finish;
end
endmodule
