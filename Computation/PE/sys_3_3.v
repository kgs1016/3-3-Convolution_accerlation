module SA_3x3(clk, rst, A_in_1, A_in_2, A_in_3, B_in_1, B_in_2, B_in_3, P1_en , C_out);
    
  input clk, rst, P1_en;
  
  input [7:0] A_in_1, A_in_2, A_in_3, B_in_1, B_in_2, B_in_3;
  input P1_en; 
  output [7:0] C_out;
  


  wire[7:0]  a_bridge[5:0], b_bridge[5:0], out_bridge[5:0];  
  wire [7:0] result1, result2, result3, temp;
  
  singlePE PE11(.clk(clk), .rst(rst), .in_a(A_in_1), .in_b(B_in_1), .b_en(P1_en), .p_sum(8'd0), .out_a(a_bridge[0]), .out_b(b_bridge[0]), .out_conv(out_bridge[0]));
  singlePE PE12(.clk(clk), .rst(rst), .in_a(a_bridge[0]), .in_b(B_in_2), .b_en(P1_en), .p_sum(8'd0), .out_a(a_bridge[1]), .out_b(b_bridge[1]), .out_conv(out_bridge[1]));
  singlePE PE13(.clk(clk), .rst(rst), .in_a(a_bridge[1]), .in_b(B_in_3), .b_en(P1_en), .p_sum(8'd0), .out_a(), .out_b(b_bridge[2]), .out_conv(out_bridge[2]));
  singlePE PE21(.clk(clk), .rst(rst), .in_a(A_in_2), .in_b(b_bridge[0]), .b_en(P1_en), .p_sum(out_bridge[0]), .out_a(a_bridge[2]), .out_b(b_bridge[3]), .out_conv(out_bridge[3]));
  singlePE PE22(.clk(clk), .rst(rst), .in_a(a_bridge[2]), .in_b(b_bridge[1]), .b_en(P1_en), .p_sum(out_bridge[1]), .out_a(a_bridge[3]), .out_b(b_bridge[4]), .out_conv(out_bridge[4]));
  singlePE PE23(.clk(clk), .rst(rst), .in_a(a_bridge[3]), .in_b(b_bridge[2]), .b_en(P1_en), .p_sum(out_bridge[2]), .out_a(), .out_b(b_bridge[5]), .out_conv(out_bridge[5]));
  singlePE PE31(.clk(clk), .rst(rst), .in_a(A_in_3), .in_b(b_bridge[3]), .b_en(P1_en), .p_sum(out_bridge[3]), .out_a(a_bridge[4]), .out_b(), .out_conv(result1));
  singlePE PE32(.clk(clk), .rst(rst), .in_a(a_bridge[4]), .in_b(b_bridge[4]), .b_en(P1_en), .p_sum(out_bridge[4]), .out_a(a_bridge[5]), .out_b(), .out_conv(result2));
  singlePE PE33(.clk(clk), .rst(rst), .in_a(a_bridge[5]), .in_b(b_bridge[5]), .b_en(P1_en), .p_sum(out_bridge[5]), .out_a(), .out_b(), .out_conv(result3));

  eight_bit_adder ADD1(.a(result1), .b(result2), .cin(1'b0), .sum(temp), .cout());
  eight_bit_adder ADD2(.a(temp), .b(result3), .cin(1'b0), .sum(C_out), .cout());


endmodule
