module dmem_tb;

reg clk;

reg mem_write;

reg [31:0] address;

reg [31:0] write_data;

wire [31:0] read_data;

dmem dut(
.clk(clk),
.mem_write(mem_write),
.address(address),
.write_data(write_data),
.read_data(read_data)
);

always #5 clk = ~clk;

initial begin

$dumpfile("waveforms/dmem.vcd");
$dumpvars(0, dmem_tb);

clk = 0;

mem_write = 1;

address = 32'd4;

write_data = 32'd100;

#10;

mem_write = 0;

#10;

$finish;

end

endmodule
