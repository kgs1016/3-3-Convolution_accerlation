module computation_module(clk, rst, a_1, a_2, a_3, b_1, b_2, b_3, P1_en, P2_en, mux_reset,c_sel, sel_m, out);
  input clk, rst;
  input[7:0] a_1, a_2, a_3;
  input [7:0] b_1, b_2, b_3;
  input [1:0] sel_m;
  input mux_reset, P1_en;
  input [2:0] c_sel;
  input [1:0] P2_en;
  output [7:0] out;

  wire [7:0] s_a1, p1_a1, p1_a2, p1_a3, p2_a1, p2_a2, s_b1, p1_b1, p1_b2, p1_b3, p2_b1, p2_b2;
  wire [7:0] out_s, out_p1, out_p2;
  
  one_to_four_eight_demux demux_A1(a_1, sel_m,,s_a1, p1_a1, p2_a1);
  one_to_four_eight_demux demux_A2(a_2, sel_m,,,p1_a2, p2_a2);
  one_to_four_eight_demux demux_A3(a_3, sel_m,,,p1_a3,);
  one_to_four_eight_demux demux_B1(b_1, sel_m,,s_b1, p1_b1, p2_b1);  
  one_to_four_eight_demux demux_B2(b_2, sel_m,,,p1_b2, p2_b2);
  one_to_four_eight_demux demux_B3(b_3, sel_m,,,p1_b3,);
        
  CM_Serial Serial(.a(s_a1), .b(s_b1), .clk(clk), .rst(rst), .mux_reset(mux_reset), .out(out_s));
  SA_3x3 Parallel1(.clk(clk), .rst(rst), .A_in_1(p1_a1), .A_in_2(p1_a2), .A_in_3(p1_a3), .B_in_1(p1_b1), .B_in_2(p1_b2), .B_in_3(p1_b3), .P1_en(P1_en), .C_out(out_p1));
  SA_2x2 Parallel2(.clk(clk), .rst(rst), .A_in_1(p2_a1), .A_in_2(p2_a2), .B_in_1(p2_b1), .B_in_2(p2_b2), .P2_en(P2_en), .c_sel(c_sel), .SAout(out_p2));

  four_to_one_eight_mux conv_out(.a(8'd0), .b(out_s), .c(out_p1), .d(out_p2), .s(sel_m), .out(out[7:0]));


endmodule
