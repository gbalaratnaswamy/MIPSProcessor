module t_InstructionMemory;
    reg [7:0] pc;
    wire [15:0] data;
    instr_mem m1(pc,data);
    initial begin
        pc=0;
        #5 pc=8'd1;
        #5 pc=8'd2;
        #5 pc=8'd3;
        #5 pc=8'd4;
        #5 pc=8'd5;
    end
    initial begin
        //$monitor("a=%b,b=%b,sel=%b,out=%b",ta,tb,tsel,tout);
        $dumpfile("inst_mem.vcd"); //Specify the file where all the variables will be dumped.
        $dumpvars;
    end
endmodule