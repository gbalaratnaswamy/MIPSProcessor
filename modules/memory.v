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