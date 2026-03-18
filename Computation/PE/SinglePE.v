module singlePE(clk, rst, in_a,in_b,b_en, p_sum,out_a,out_b,out_conv);

    input clk, rst, b_en;
    
    input [7:0] in_a,in_b, p_sum;

    output reg [7:0] out_a, out_b;
    output [7:0] out_conv;   
    reg [7:0] pre_out;
    wire[7:0]  a_product_b;
    wire cout;
    
         
    always @(posedge clk or posedge rst)begin
        if(rst) begin
            out_a <= 8'd0;
            out_b <= 8'd0;   
            pre_out <= 8'd0;
        end
        else begin
            out_a <= in_a;
            pre_out<=p_sum;
            if(b_en==1) begin
             out_b <= in_b;
          end
        end
     end

    multiplier m1(out_a, out_b, a_product_b);
    eight_bit_adder a1(pre_out,a_product_b,1'b0,out_conv,cout);
endmodule
