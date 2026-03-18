module memory_module(clk, rst, IN, add1, add2, add3, bdd1, bdd2, bdd3, cond, arw, brw, crw, a_1, a_2, a_3, b_1, b_2, b_3, dis_out);
   input clk;
   input rst; 
   input [7:0] IN;
   input [4:0] add1, add2, add3, bdd1, bdd2, bdd3, cond;
   input [1:0] arw, brw, crw; //11: read, 10:write, else: 0 	
   output [7:0] a_1, a_2, a_3, b_1, b_2, b_3, dis_out;
	
    memoryin A1(IN, add1, arw, clk, rst, a_1);
    memoryin A2(IN, add2, arw, clk, rst, a_2);    
    memoryin A3(IN, add3, arw, clk, rst, a_3);
    memoryin B1(IN, bdd1, brw, clk, rst, b_1);    
    memoryin B2(IN, bdd2, brw, clk, rst, b_2);
    memoryin B3(IN, bdd3, brw, clk, rst, b_3);
    memoryin SUM(IN, cond, crw, clk, rst, dis_out);
                            
    
endmodule
