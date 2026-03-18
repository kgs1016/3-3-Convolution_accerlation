module SA_2x2(clk, rst, A_in_1, A_in_2, B_in_1, B_in_2, P2_en, c_sel, SAout);
    
  input clk, rst;
  input [7:0] A_in_1, A_in_2, B_in_1, B_in_2;
  input [1:0] P2_en;
  input [2:0] c_sel;
  
  output [7:0] SAout;
  


  wire[7:0]  a_bridge[1:0], b_bridge[1:0], out_bridge[1:0];  
  wire [7:0] result1, result2, temp;// partial_sum;
  //wire [7:0] acc1, acc2, acc3, acc4;
  //wire [7:0] target_reg, acc1_reg, acc2_reg, acc3_reg, acc4_reg;
  
  singlePE PE11(.clk(clk), .rst(rst), .in_a(A_in_1), .in_b(B_in_1), .b_en(P2_en[0]), .p_sum(8'd0), .out_a(a_bridge[0]), .out_b(b_bridge[0]), .out_conv(out_bridge[0]));
  singlePE PE12(.clk(clk), .rst(rst), .in_a(a_bridge[0]), .in_b(B_in_2), .b_en(P2_en[0]), .p_sum(8'd0), .out_a(), .out_b(b_bridge[1]), .out_conv(out_bridge[1]));
 
  singlePE PE21(.clk(clk), .rst(rst), .in_a(A_in_2), .in_b(b_bridge[0]), .b_en(P2_en[1]), .p_sum(out_bridge[0]), .out_a(a_bridge[1]), .out_b(), .out_conv(result1));
  singlePE PE22(.clk(clk), .rst(rst), .in_a(a_bridge[1]), .in_b(b_bridge[1]), .b_en(P2_en[1]), .p_sum(out_bridge[1]), .out_a(), .out_b(), .out_conv(result2));
 

  eight_bit_adder ADD1(.a(result1), .b(result2), .cin(1'b0), .sum(temp), .cout());
  accumulator acc(.clk(clk), .rst(rst), .ctrl(c_sel), .p_sum(temp), .out_conv(SAout));
  //eight_bit_adder ACCUM11(.a(partial_sum), .b(target_reg), .cin(1'b0), .sum(SAout), .cout());
  //one_to_four_eight_demux DEMUX(.a(SAout), .s(c_sel[1:0]), .out1(acc1), .out2(acc2), .out3(acc3), .out4(acc4));
  
  //eight_bit_register_module CONV_11(.in(acc1), .clk(clk), .rst(rst), .out(acc1_reg));
  //eight_bit_register_module CONV_12(.in(acc2), .clk(clk), .rst(rst), .out(acc2_reg));
  //eight_bit_register_module CONV_21(.in(acc3), .clk(clk), .rst(rst), .out(acc3_reg));
  //eight_bit_register_module CONV_22(.in(acc4), .clk(clk), .rst(rst), .out(acc4_reg));
  
  //four_to_one_eight_mux MUX_CONV(.a(acc1_reg), .b(acc2_reg), .c(acc3_reg), .d(acc4_reg), .s(c_sel[1:0]), .out(temp));  

  //two_to_one_eight_mux ADDACT(.a(8'd0), .b(temp), .s(c_sel[2]), .out(target_reg));






endmodule
