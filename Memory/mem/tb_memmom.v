`timescale 1ns/1ns
module tb_memmom;
   reg clk;
   reg rst; 
   reg [7:0] IN;
   reg [4:0] add1, add2, add3, bdd1, bdd2, bdd3, cond;
   reg [1:0] arw, brw, crw; //11: read, 10:write, else: 0 	
   wire [7:0] a_1, a_2, a_3, b_1, b_2, b_3, dis_out;

 memory_module Memory(clk, rst, IN, add1, add2, add3, bdd1, bdd2, bdd3, cond, arw, brw, crw, a_1, a_2, a_3, b_1, b_2, b_3, dis_out);

initial begin
  rst=1'b1;
  clk=1'b0;
  IN=8'd0; add1=5'd0; add2=5'd0; add3=5'd0; bdd1=5'd0; bdd2=5'd0; bdd3=5'd0; cond=5'd0;
  arw=2'd0; brw=2'd0; crw=2'd0;
end

initial begin
forever #10 clk=!clk; end                

initial begin
  #5 rst=1'b0;
  #20 IN=8'd13; add1=5'd0; add2=5'd0; add3=5'd0; arw=2'b10;
  #20 IN=8'd12; add1=5'd1; add2=5'd1; add3=5'd1; arw=2'b10;
  #20 IN=8'd12; add1=5'd2; add2=5'd2; add3=5'd2; arw=2'b10;
  #20 arw=2'd0;
  #20 IN=8'd13; bdd1=5'd0; bdd2=5'd0; bdd3=5'd0; brw=2'b10;
  #20 IN=8'd12; bdd1=5'd1; bdd2=5'd1; bdd3=5'd1; brw=2'b10;
  #20 IN=8'd12; bdd1=5'd2; bdd2=5'd2; bdd3=5'd2; brw=2'b10;
  #20 brw=2'd0; IN=8'd12; bdd1=5'd5;
  #20 IN=8'd13; cond=5'd0; crw=2'b10;
  #20 crw=2'b11; cond=5'd0;
  #20 IN=8'd13; add1=5'd0; add2=5'd1; add3=5'd2; arw=2'b11;
end  
endmodule
