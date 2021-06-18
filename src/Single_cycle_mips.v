module main(input clk,rst);
wire [3:0] op_code;
wire [3:0] ALU_out, rs ,rt ,rd,null;

wire [7:0] inst_address;
assign inst_address={rt,rd};

wire reg_write_en;
wire [3:0] reg_read_addr_2;
wire [3:0] reg_write_data,reg_read_data_1,reg_read_data_2;


wire [3:0] data_out;
wire data_write_en,data_read;

//pc
reg [7:0] pc_now;
wire [7:0] pc_next;
always @(posedge clk or posedge rst)  
 begin   
      if(rst)   
           pc_now <= 8'd0;  
      else  
           pc_now <= pc_next;  
 end  
PCControl pccont(pc_now,op_code,inst_address, next_instruction[7:0],ALU_out, pc_next); 


// alu
 wire [2:0] ALU_control;  
 wire [3:0] ALU_b; 
 wire zero;
 
ALUControl alccon( ALU_control,  ALU_b , op_code, rt, reg_read_data_2,rd); 
ALU alu(reg_read_data_1,ALU_b, ALU_control,ALU_out,zero); 


// memory
MemoryControl memcont(reg_write_data , ALU_out,data_out,op_code);
Memory mem(clk,rst, reg_write_en, rd, reg_write_data, rs, reg_read_data_1, rt, reg_read_data_2); 


//data

 dataMemory datamem(clk, ALU_out, reg_read_data_2, data_write_en, data_read, data_out);


 //controller 

 controller contrn(op_code,reg_write_en,data_write_en);


 // instruction memory
 wire [15:0] instruction_set,next_instruction;
 InstructionMemory insmem(pc_now, instruction_set,next_instruction); 
 assign {op_code , rs, rt, rd}=instruction_set;

endmodule




module ALUControl( output reg [2:0] ALU_control, output reg [3:0] ALU_b , input [3:0] op_fun, input [3:0] inst_b,mem2_b,lsw_b);  
  always @(*)  
  case (op_fun)  
    4'b0001: ALU_b=inst_b;  
    4'b0010: ALU_b=inst_b;   
    4'b0011: ALU_b=lsw_b; 
    4'b0100: ALU_b=lsw_b; 
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

  module MemoryControl(output reg [3:0] mem_write_d , input [3:0] ALU_out,Data_out,op_and_fun);  
 always @(*)  
 casex (op_and_fun)  
  4'b0011: mem_write_d=Data_out;  
  4'b0100: mem_write_d=Data_out;   
  default: mem_write_d=ALU_out; 
  endcase  

 endmodule  

 module Memory  (  
    input clk,rst,
    input reg_write_en,  
    input [3:0] reg_write_dest,  
    input [3:0] reg_write_data,  
    input [3:0] reg_read_addr_1,  
    output [3:0] reg_read_data_1,  
    input [3:0] reg_read_addr_2,  
    output [3:0] reg_read_data_2  
 );  
    reg [3:0] reg_array [15:0];   
    always @ (posedge clk or posedge rst) begin  
        if(rst) begin  
            reg_array[0] <= 4'd0;  
            reg_array[1] <= 4'd1;  
            reg_array[2] <= 4'd2;  
            reg_array[3] <= 4'd3;  
            reg_array[4] <= 4'd4;  
            reg_array[5] <= 4'd5;  
            reg_array[6] <= 4'd6; 
            reg_array[7] <= 4'd7;
            reg_array[8] <= 4'd8;  
            reg_array[9] <= 4'd9; 
            reg_array[10] <= 4'd10;  
            reg_array[11] <= 4'd11; 
            reg_array[12] <= 4'd12;  
            reg_array[13] <= 4'd13;  
            reg_array[14] <= 4'd14;  
            reg_array[15] <= 4'd15;
        end  
        else begin  
                if(reg_write_en) begin  
                    reg_array[reg_write_dest] <= reg_write_data;  
                end  
        end  
    end  
    assign reg_read_data_1 = ( reg_read_addr_1 == 0)? 4'b0 : reg_array[reg_read_addr_1];  
    assign reg_read_data_2 = ( reg_read_addr_2 == 0)? 4'b0 : reg_array[reg_read_addr_2];  
endmodule 




module PCControl(input [7:0] PC_now, input [3:0] op_code,input [7:0] inst_addr,next_addr,input[3:0] ALU,output reg [7:0] PC_next);  
 always @(*)
 begin   
      case(op_code)  
      4'b0000:PC_next=PC_now;
      4'b0101:PC_next=inst_addr ;  
      4'b0110: begin if(ALU==4'd1) PC_next=next_addr + PC_now + 2; else PC_next=PC_now+2 ; end
      default:PC_next=PC_now+1; 
      endcase  
 end   
 endmodule  

 module InstructionMemory(input [7:0] pc, output wire [15:0] instruction,output wire[15:0] next_instruction );  
     reg [15:0] rom[255:0];  
     initial  begin  
          rom[8'd0]  = 16'b0001_0000_0001_0010;  
          rom[8'd1]  = 16'b0001_0000_0001_0011;  
          rom[8'd2]  = 16'b0001_0000_1011_0100;  
          rom[8'd3]  = 16'b1000_0010_0011_0010;  
          rom[8'd4]  = 16'b0110_0010_0100_0110;  
          rom[8'd5]  = 16'b0000_0000_0000_0111; 
          rom[8'd6]  = 16'b0101_0000_0000_0011;  
          rom[8'd7]  = 16'b0000000000000000;  
          rom[8'd8]  = 16'b0000000000000000;  
          rom[8'd9]  = 16'b0000000000000000;  
          rom[8'd10] = 16'b0000000000000000;  
          rom[8'd11] = 16'b0000000000000000;  
          rom[8'd12] = 16'b0000000000000000;  
          rom[8'd13] = 16'b0000000000000000;  
          rom[8'd14] = 16'b0000000000000000;  
          rom[8'd15] = 16'b0000000000000000; 
          rom[8'd16] = 16'b0000000000000000; 
          rom[8'd17] = 16'b0000000000000000;   
          rom[8'd18] = 16'b0000000000000000;  
          rom[8'd19] = 16'b0000000000000000;  
          rom[8'd20] = 16'b0000000000000000;  
          rom[8'd21] = 16'b0000000000000000;  
          rom[8'd22] = 16'b0000000000000000;  
          rom[8'd23] = 16'b0000000000000000;  
          rom[8'd24] = 16'b0000000000000000;  
          rom[8'd25] = 16'b0000000000000000;  
          rom[8'd26] = 16'b0000000000000000;  
          rom[8'd27] = 16'b0000000000000000;  
          rom[8'd28] = 16'b0000000000000000;  
          rom[8'd29] = 16'b0000000000000000;  
          rom[8'd30] = 16'b0000000000000000;  
          rom[8'd31] = 16'b0000000000000000;  
          rom[8'd32] = 16'b0000000000000000;  
     end  
     assign instruction = (pc < 32 )? rom[pc]: 16'd0;  
     assign next_instruction = (pc < 31 )? rom[pc+1]: 16'd0;  
 endmodule   