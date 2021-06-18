module test(input clk,rst);
    reg [1:0] state,next_state;
    reg super;
    reg [4:0] count;
    always@(posedge clk, posedge rst) begin
        if(rst) begin
            state<=0;
        end
        else state<=next_state;
    end
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            super<=0;
            count<=0;
        end
        else if(state==2'b01) begin
            count<=(count==7)?0:count+1;
        end
        else if (state==2'b10)begin 
            count<=3;
        end
    end
    always @(*) begin
        if(state==2'b11)
        next_state<=2'b0;
        else if(state==2'b01) begin
            if(count==7)
            next_state<=2'b10;
            else 
            next_state<=2'b01;
        end
        else
        next_state<=state+1;
    end
endmodule