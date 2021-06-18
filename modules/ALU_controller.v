module ALUControl( output reg [2:0] ALU_control, output reg [7:0] ALU_b , input [3:0] op_fun, input [3:0] inst_b,input [7:0]mem2_b,input [3:0]lsw_b);  
  always @(*)  
  case (op_fun)  
    4'b0001: ALU_b={4'b0000,inst_b};  
    4'b0010: ALU_b={4'b0000,inst_b};   
    4'b0011: ALU_b={4'b0000,lsw_b}; 
    4'b0100: ALU_b={4'b0000,lsw_b}; 
    default: ALU_b=mem2_b;
  endcase  
  always @(*)  
  casex (op_fun)  
    4'b1xxx: ALU_control=op_fun[2:0];  
    4'b0001: ALU_control=3'b000;   
    4'b0010: ALU_control=3'b001;  
    4'b0110: ALU_control=3'b101;
    default: ALU_control=3'b000;
  endcase 
 endmodule  
// Verilog code for JR control unit
// module JR_Control( input[1:0] alu_op, 
//        input [3:0] funct,
//        output JRControl
//     );
// assign JRControl = ({alu_op,funct}==6'b001000) ? 1'b1 : 1'b0;
// endmodule