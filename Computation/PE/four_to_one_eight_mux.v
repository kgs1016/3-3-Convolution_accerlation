module four_to_one_eight_mux(a, b, c, d, s, out);
    input [7:0] a, b, c, d;
    input [1:0] s;
    output [7:0] out;
    
    four_to_one_mux_behavioral_module out0(.a(a[0]), .b(b[0]), .c(c[0]), .d(d[0]), .s0(s[0]), .s1(s[1]), .out(out[0]));
    four_to_one_mux_behavioral_module out1(.a(a[1]), .b(b[1]), .c(c[1]), .d(d[1]), .s0(s[0]), .s1(s[1]), .out(out[1]));
    four_to_one_mux_behavioral_module out2(.a(a[2]), .b(b[2]), .c(c[2]), .d(d[2]), .s0(s[0]), .s1(s[1]), .out(out[2]));
    four_to_one_mux_behavioral_module out3(.a(a[3]), .b(b[3]), .c(c[3]), .d(d[3]), .s0(s[0]), .s1(s[1]), .out(out[3]));
    four_to_one_mux_behavioral_module out4(.a(a[4]), .b(b[4]), .c(c[4]), .d(d[4]), .s0(s[0]), .s1(s[1]), .out(out[4]));
    four_to_one_mux_behavioral_module out5(.a(a[5]), .b(b[5]), .c(c[5]), .d(d[5]), .s0(s[0]), .s1(s[1]), .out(out[5]));
    four_to_one_mux_behavioral_module out6(.a(a[6]), .b(b[6]), .c(c[6]), .d(d[6]), .s0(s[0]), .s1(s[1]), .out(out[6]));
    four_to_one_mux_behavioral_module out7(.a(a[7]), .b(b[7]), .c(c[7]), .d(d[7]), .s0(s[0]), .s1(s[1]), .out(out[7]));
        

endmodule
