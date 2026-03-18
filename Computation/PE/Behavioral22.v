module accumulator(clk, rst, ctrl, p_sum,out_conv);

    input clk, rst;
    input [2:0] ctrl;
    input [7:0] p_sum;

 
    output [7:0] out_conv;
    reg [7:0] temp;   
    reg [7:0] c11, c12, c21, c22;
  
    
         
    always @(posedge clk or posedge rst)begin
        if(rst) begin
	       c11<=8'd0;
	       c12<=8'd0;
	       c21<=8'd0;
	       c22<=8'd0;
	       temp<=8'd0;   
        end
        else begin
	         if (ctrl[2]==1) begin
	           case(ctrl[1:0])
	             2'b00: begin c11<=c11+p_sum; temp<=c11+p_sum; end
	             2'b01: begin c12<=c12+p_sum; temp<=c12+p_sum; end
	             2'b10: begin c21<=c21+p_sum; temp<=c21+p_sum; end             
	             2'b11: begin c22<=c22+p_sum; temp<=c22+p_sum; end
	           endcase
	         end
          	else begin
	           temp<=0; end
	      end
  end
  assign out_conv=temp;
endmodule
