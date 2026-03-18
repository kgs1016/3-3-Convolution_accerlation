`timescale 1ns / 1ns
module tb_demux;

    reg [7:0] a;
    reg [1:0] s;
    
    wire [7:0] outA, outB, outC, outD;
    
    one_to_four_eight_demux DEMUX(.a(a), .s(s), .out1(outA), .out2(outB), .out3(outC), .out4(outD));
    initial begin
    a=8'd0;
    s=2'b00;
    end
    
    initial begin
    #10 a=8'd7; s=2'b01;
    #10 a=8'd5; s=2'b10;
end


endmodule
