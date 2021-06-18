module controller(input [3:0] op_code,output reg mem_write_en,data_write_en);
always @(*) 
case(op_code)  
      4'b1000: mem_write_en=1;
      4'b1001: mem_write_en=1;
      4'b1010: mem_write_en=1;
      4'b1011: mem_write_en=1;
      4'b1100: mem_write_en=1;
      4'b1101: mem_write_en=1;
      4'b0001: mem_write_en=1;
      4'b0010: mem_write_en=1;
      4'b0011: mem_write_en=1;
      default:mem_write_en=0; 
endcase
always @(*) 
case(op_code)  
      4'b0100: data_write_en=1;
      default:data_write_en=0; 
endcase

endmodule