module eight_bit_register_module(in, clk, rst, out);
   input clk;
   input rst; 
   input [7:0] in;
   output [7:0] out; 	
	
   d_flip_flop_behavioral_module d0(.d(in[0]), .clk(clk), .rst(rst), .preset(1'b0), .q(out[0]), .q_bar());
   d_flip_flop_behavioral_module d1(.d(in[1]), .clk(clk), .rst(rst), .preset(1'b0), .q(out[1]), .q_bar());
   d_flip_flop_behavioral_module d2(.d(in[2]), .clk(clk), .rst(rst), .preset(1'b0), .q(out[2]), .q_bar());
   d_flip_flop_behavioral_module d3(.d(in[3]), .clk(clk), .rst(rst), .preset(1'b0), .q(out[3]), .q_bar());
   d_flip_flop_behavioral_module d4(.d(in[4]), .clk(clk), .rst(rst), .preset(1'b0), .q(out[4]), .q_bar());
   d_flip_flop_behavioral_module d5(.d(in[5]), .clk(clk), .rst(rst), .preset(1'b0), .q(out[5]), .q_bar());
   d_flip_flop_behavioral_module d6(.d(in[6]), .clk(clk), .rst(rst), .preset(1'b0), .q(out[6]), .q_bar());
   d_flip_flop_behavioral_module d7(.d(in[7]), .clk(clk), .rst(rst), .preset(1'b0), .q(out[7]), .q_bar());

endmodule
