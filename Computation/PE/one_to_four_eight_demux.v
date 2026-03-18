

module one_to_four_eight_demux(a, s, out1, out2, out3, out4);
  
    input [7:0] a;
    input [1:0] s;
    
    output [7:0] out1, out2, out3, out4;
    one_to_four_demux OUT0(.a(a[0]), .s0(s[0]), .s1(s[1]), .out1(out1[0]), .out2(out2[0]), .out3(out3[0]), .out4(out4[0]));
    one_to_four_demux OUT1(.a(a[1]), .s0(s[0]), .s1(s[1]), .out1(out1[1]), .out2(out2[1]), .out3(out3[1]), .out4(out4[1]));
    one_to_four_demux OUT2(.a(a[2]), .s0(s[0]), .s1(s[1]), .out1(out1[2]), .out2(out2[2]), .out3(out3[2]), .out4(out4[2]));
    one_to_four_demux OUT3(.a(a[3]), .s0(s[0]), .s1(s[1]), .out1(out1[3]), .out2(out2[3]), .out3(out3[3]), .out4(out4[3]));
    one_to_four_demux OUT4(.a(a[4]), .s0(s[0]), .s1(s[1]), .out1(out1[4]), .out2(out2[4]), .out3(out3[4]), .out4(out4[4]));
    one_to_four_demux OUT5(.a(a[5]), .s0(s[0]), .s1(s[1]), .out1(out1[5]), .out2(out2[5]), .out3(out3[5]), .out4(out4[5]));
    one_to_four_demux OUT6(.a(a[6]), .s0(s[0]), .s1(s[1]), .out1(out1[6]), .out2(out2[6]), .out3(out3[6]), .out4(out4[6]));
    one_to_four_demux OUT7(.a(a[7]), .s0(s[0]), .s1(s[1]), .out1(out1[7]), .out2(out2[7]), .out3(out3[7]), .out4(out4[7]));
  

endmodule
