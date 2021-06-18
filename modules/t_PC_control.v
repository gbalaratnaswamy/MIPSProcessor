module t_PCController; 
reg [7:0] PC_now;
reg [3:0] op_code;
reg [7:0] inst_addr;
reg[3:0] ALU;;
wire [7:0] PC_next;
PCControl m1(PC_now,  op_code,inst_addr, ALU,PC_next); 
initial begin
    PC_now=0;op_code=0;inst_addr=0;
    ALU=0;
    #5 PC_now = 1;
    #5 PC_now = 2;
    #5 PC_now = 3;
    #5 PC_now = 4;
    #5 PC_now = 5;
    #5 op_code=4'b0101;
    #5 op_code=4'b0110;
    #5 ALU=4'b1;
    #5 inst_addr=4'b0101;
    #5 $finish;
    
end
initial begin
        //$monitor("a=%b,b=%b,sel=%b,out=%b",ta,tb,tsel,tout);
        $dumpfile("pccont.vcd"); //Specify the file where all the variables will be dumped.
        $dumpvars;
    end
endmodule;