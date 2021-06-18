module t_test;
    reg clk,rst;
    test m1(clk,rst);
    initial begin
        clk=0;rst=0;
        #5 rst=1;
        #7 rst=0;
        #1000 $finish;
    end
    always #10 clk=~clk;
    initial begin
        //$monitor("a=%b,b=%b,sel=%b,out=%b",ta,tb,tsel,tout);
        $dumpfile("test.vcd"); //Specify the file where all the variables will be dumped.
        $dumpvars;
    end
endmodule