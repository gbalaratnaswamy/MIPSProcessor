module t_Memory;
    reg [7:0] reg_write_data;
    reg [3:0] reg_write_dest,reg_read_addr_1,reg_read_addr_2;
    wire [7:0] reg_read_data_1,reg_read_data_2;
    reg clk,rst,reg_write_en;
    register_file  m1(clk,rst, reg_write_en,  reg_write_dest,   reg_write_data, reg_read_addr_1,  reg_read_data_1,  reg_read_addr_2,reg_read_data_2  );   
    initial begin
        clk=0;reg_write_en=0;rst=0;reg_write_data=0;
        reg_write_dest=0;reg_read_addr_1=0;
        #10 reg_read_addr_1=1;
        #10 reg_read_addr_1=2;
        #10 reg_read_addr_1=3;
        #10 reg_read_addr_1=4;
        #10 reg_read_addr_1=5;
        #10 reg_read_addr_1=6;
        #10 reg_read_addr_1=7;
        #10 reg_read_addr_1=8;
        #10 reg_read_addr_1=9;
        #10 reg_read_addr_1=10;
        #10 reg_read_addr_1=11;
        #10 reg_read_addr_1=12;
        #10 reg_read_addr_1=13;
        #10 reg_read_addr_1=14;
        #10 reg_read_addr_1=15;
        #10 $finish;
    end
    initial begin
        rst=0;
        #5 rst=1;
        #2 rst = 0;
    end
    always #10 clk=~clk;
    initial begin
        //$monitor("a=%b,b=%b,sel=%b,out=%b",ta,tb,tsel,tout);
        $dumpfile("memory.vcd"); //Specify the file where all the variables will be dumped.
        $dumpvars;
    end
endmodule