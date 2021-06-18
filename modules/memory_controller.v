 module MemoryControl(output reg [3:0] mem_write_d , input [3:0] ALU_out,Data_out,op_and_fun);  
 always @(*)  
 casex (op_and_fun)  
  4'b0011: mem_write_d=Data_out;  
  4'b0100: mem_write_d=Data_out;   
  default: mem_write_d=ALU_out; 
  endcase  

 endmodule  