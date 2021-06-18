module ALU(input [3:0] a,b,input [2:0] ALU_control,output reg [3:0] result,output zero);  
 always @(*)
 begin   
      case(ALU_control)  
      3'b000: result = a + b; // add  
      3'b001: result = a - b; // sub  
      3'b010: result = a & b; // and  
      3'b011: result = a | b; // or   
      3'b100: begin if (a<b) result = 4'd1;  
                     else result = 4'd0;  
                     end  
      3'b101: begin if (a==b) result = 4'd1;  
                     else result = 4'd0;  
                     end  
      default:result = a + b; // add  
      endcase  
 end  
 assign zero = (result==4'd0) ? 1'b1: 1'b0;  
 endmodule  