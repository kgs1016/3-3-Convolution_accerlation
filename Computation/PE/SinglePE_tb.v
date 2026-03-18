`timescale 1ns/1ns

module tb_SE;


	reg rst, clk, EN1;
 
	reg [7:0] A1, B1, P1;
	
	wire [7:0] OUT;
	wire [7:0] A_OUT, B_OUT;
	
	
 	singlePE PE1(.clk(clk), .rst(rst), .in_a(A1), .in_b(B1), .b_en(EN1), .p_sum(P1), .out_a(A_OUT), .out_b(B_OUT), .out_conv(OUT));
	initial
	begin
	 clk = 1'b0;
	 EN1=1'b1;
	 rst = 1'b1;
	 A1 = 8'd0;
	 B1 = 8'd0;
	 P1 = 8'd0;
	 
	end
	
	initial
	begin
		 forever
		 begin
			#10 clk = !clk;
		 end
	end
	
	initial 
	begin
    #20 rst=1'b0;
    #20 A1=8'd1; B1=8'd3;
    #20 A1=8'd2; B1=8'd5; P1 = 8'd3;
    #20 A1=8'd1; B1=8'd3; EN1 =1'b0;    
    #20 A1=8'd1; B1=8'd3; EN1 =1'b1;
    #20 A1=8'd2; B1=8'd5; P1 = 8'd3;
    #20 rst=1'b1;
	end
	
	
endmodule