module one_to_two_eight_demux(a, s, out1, out2);
    input [7:0] a;
    input s;
    
    output [7:0] out1, out2;
    
    one_to_two_demux_behavioral_module OUT0(.a(a[0]), .s(s), .out1(out1[0]), .out2(out2[0]));
    one_to_two_demux_behavioral_module OUT1(.a(a[1]), .s(s), .out1(out1[1]), .out2(out2[1]));
    one_to_two_demux_behavioral_module OUT2(.a(a[2]), .s(s), .out1(out1[2]), .out2(out2[2]));
    one_to_two_demux_behavioral_module OUT3(.a(a[3]), .s(s), .out1(out1[3]), .out2(out2[3]));
    one_to_two_demux_behavioral_module OUT4(.a(a[4]), .s(s), .out1(out1[4]), .out2(out2[4]));
    one_to_two_demux_behavioral_module OUT5(.a(a[5]), .s(s), .out1(out1[5]), .out2(out2[5]));
    one_to_two_demux_behavioral_module OUT6(.a(a[6]), .s(s), .out1(out1[6]), .out2(out2[6]));
    one_to_two_demux_behavioral_module OUT7(.a(a[7]), .s(s), .out1(out1[7]), .out2(out2[7]));
endmodule
