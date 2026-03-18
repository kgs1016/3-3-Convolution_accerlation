//This is 3 bit up down counter based on Moore state machine
`timescale 1ns/1ns
module top_module(clk, out_digit, out_data);
	input clk;
  output [7:0] out_digit;
	output [6:0] out_data;
  reg rst;
  
  wire [7:0] data; //data input
  wire [7:0] LUT_IN;
  wire [4:0] add1, add2, add3, bdd1, bdd2, bdd3, cond;
  wire [1:0] arw, brw, crw; //11: read, 10:write, else: 0 	
  wire [7:0] a_1, a_2, a_3, b_1, b_2, b_3, dis_out;

  wire [1:0] sel_m; //00: 0, 01: s 10: 3x3 11: 2x2
  wire mux_reset, P1_en;//filter hold for 3x3
  wire [2:0] c_sel;//1: acc 00 at c11
  wire [1:0] P2_en;//filter hold for 2x2 rows
  wire [7:0] conv_out;
   
  reg [7:0] a11=8'd1, a12=8'd1, a13=8'd1, a14=8'd1, a21=8'd1, a22=8'd1, a23=8'd1, a24=8'd1, a31=8'd1, a32=8'd1, a33=8'd1, a34=8'd1,
  a41=8'd1, a42=8'd1, a43=8'd1, a44=8'd1, b11=8'd1, b12=8'd1, b13=8'd1, b21=8'd1, b22=8'd1, b23=8'd1,b31=8'd1, b32=8'd1, b33=8'd1;
  LUT INPUT(.arw(arw), .brw(brw), .add(add1), .bdd(bdd1), .z(LUT_IN));
  two_to_one_eight_mux MUX(.a(LUT_IN), .b(conv_out), .s(crw[1]), .out(data));
  Controller ctrl(.clk(clk), .reset(rst), .P1_en(P1_en), .P2_en(P2_en), .mux_reset(mux_reset), .c_sel(c_sel), .sel_m(sel_m), .addr_a1(add1),
  .addr_a2(add2), .addr_a3(add3), .addr_b1(bdd1), .addr_b2(bdd2), .addr_b3(bdd3), .cond(cond), .arw(arw), .brw(brw), .crw(crw));
  
  computation_module CM(.clk(clk), .rst(rst), .a_1(a_1), .a_2(a_2), .a_3(a_3), .b_1(b_1), .b_2(b_2), .b_3(b_3), .P1_en(P1_en), .P2_en(P2_en),
.mux_reset(mux_reset), .c_sel(c_sel), .sel_m(sel_m), .out(conv_out));

  //need mux for output input for matrix input  
  memory_module MM(.clk(clk), .rst(rst), .IN(data), .add1(add1), .add2(add2), .add3(add3), .bdd1(bdd1), .bdd2(bdd2), .bdd3(bdd3), .cond(cond), .arw(arw), .brw(brw), .crw(crw),
   .a_1(a_1), .a_2(a_2), .a_3(a_3), .b_1(b_1), .b_2(b_2), .b_3(b_3), .dis_out(dis_out));

	
  seven_seg_display display(.clk(clk), .reset(rst), .c(dis_out), .digit(out_digit), .seg_data(out_data));

initial begin rst=1'b1; #20 rst=1'b0; end

endmodule

