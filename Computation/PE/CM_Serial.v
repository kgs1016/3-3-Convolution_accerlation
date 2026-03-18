module CM_Serial(a, b, clk, rst, mux_reset, out);
    input clk;
    input rst;   
    input mux_reset;
    input  [7:0] a, b;
    output [7:0] out;
    
    wire [7:0] mux_out;
    
    singlePE PE1(.clk(clk), .rst(rst), .in_a(a), .in_b(b), .b_en(1'b1), .p_sum(mux_out), 
	.out_a(), .out_b(), .out_conv(out));
                
    two_to_one_eight_mux MUX(.a(out), .b(8'd0), .s(mux_reset), .out(mux_out));

endmodule
