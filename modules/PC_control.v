module PCControl(input [7:0] PC_now, input [3:0] op_code,input [7:0] inst_addr,input[7:0] ALU,output reg [7:0] PC_next);  
 always @(*)
 begin   
      case(op_code)  
      4'b0000:PC_next=PC_now;
      4'b0101:PC_next=inst_addr ;  
      4'b0110: begin if(ALU==4'd1) PC_next=PC_now + inst_addr[3:0] + 1; else PC_next=PC_now+1 ; end
      default:PC_next=PC_now+1; 
      endcase  
 end   
 endmodule  