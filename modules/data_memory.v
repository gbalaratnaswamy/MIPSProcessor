 module dataMemory ( 
     input clk,
     input[3:0] mem_access_addr,  
     input [3:0] mem_write_data,  
     input mem_write_en,  
     input mem_read,  
     output [3:0] mem_read_data  
 );  
     // integer i;  
     reg [3:0] ram [15:0];   
     // initial begin  
     //      for(i=0;i<256;i=i+1)  
     //           ram[i] <= 16'd0;  
     // end  
     always @(posedge clk) begin  
          if (mem_write_en)  
               ram[mem_access_addr] <= mem_write_data;  
     end  
     assign mem_read_data = (mem_read==1'b1) ? ram[mem_access_addr]: 4'd0;   
 endmodule   