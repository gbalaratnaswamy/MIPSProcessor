module t_main;
reg clk,rst;
main m1(clk,rst);
initial begin
clk=0;rst=0;
#4 rst=1;
#3 rst=0;
#1000 $finish;
end

always #10 clk=~clk;
    initial begin
        //$monitor("a=%b,b=%b,sel=%b,out=%b",ta,tb,tsel,tout);
        $dumpfile("mips.vcd"); //Specify the file where all the variables will be dumped.
        $dumpvars;
    end
endmodule
//iverilog -o main.out t_main.v main.v memory_controller.v PC_control.v  memory.v ALU.v ALU_controller.v controller.v data_memory.v instruction_set.v