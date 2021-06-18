module t_Memory_2;
    reg [7:0] reg_write_data;
    reg [3:0] reg_write_dest,reg_read_addr_1,reg_read_addr_2;
    wire [7:0] reg_read_data_1,reg_read_data_2;
    reg clk,rst,reg_write_en;
    register_file  m1(clk,rst, reg_write_en,  reg_write_dest,   reg_write_data, reg_read_addr_1,  reg_read_data_1,  reg_read_addr_2,reg_read_data_2  );   
    initial begin
        clk=0;reg_write_en=0;rst=0;reg_write_data=0;
        reg_write_dest=0;reg_read_addr_1=0;
        #10 reg_write_dest=3;
        reg_read_addr_2=3;
        reg_write_data=7;
        #5
        reg_write_en=1;
        #20 reg_write_en=0;
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