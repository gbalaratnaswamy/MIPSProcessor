module t_ALUController;
 wire [2:0] ALU_control;  
 wire [3:0] ALU_b ,result; 
 wire zero,cout;
 reg [3:0] op_fun; 
 reg [3:0] inst_b,mem2_b,a,lsw_b;
ALUControl m1( ALU_control,  ALU_b , op_fun, inst_b, mem2_b,lsw_b); 
ALU m2(a,ALU_b, ALU_control,result,zero); 
initial begin
    inst_b=1;
    mem2_b=2;
    a=3;
    op_fun=0;
    #5 op_fun=4'b1001;
    #5 op_fun=4'b1010;
    #5 op_fun=4'b1011;
    #5 op_fun=4'b1100;
    #5 op_fun=4'b1101;
    #5 a=2;
    #5 op_fun=4'b1110;
    #5 op_fun=4'b0000;
    #5 op_fun=4'b0001;
    #5 op_fun=4'b1110;
end 
initial begin
        //$monitor("a=%b,b=%b,sel=%b,out=%b",ta,tb,tsel,tout);
        $dumpfile("alu_control.vcd"); //Specify the file where all the variables will be dumped.
        $dumpvars;
    end
endmodule;