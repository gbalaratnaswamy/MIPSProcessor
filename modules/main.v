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

