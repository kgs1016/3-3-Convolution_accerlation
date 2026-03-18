`timescale 1ns/1ns
module tb_top;
  reg clk;
  wire [7:0] out_digit; 
  wire [6:0] out_data;
  top_module top(clk, out_digit, out_data);
  initial begin clk=1'b0;end
  initial begin forever #10 clk=!clk; end
  
endmodule
