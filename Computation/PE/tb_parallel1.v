`timescale 1ns/1ns

module tb_SA_3x3;
  
  reg CLK, RST, EN1; 
  reg [7:0] A1, A2, A3, B1, B2, B3;
  wire [7:0] OUT;
  
  SA_3x3 SA1(.clk(CLK), .rst(RST), .A_in_1(A1), .A_in_2(A2), .A_in_3(A3), .B_in_1(B1), 
  .B_in_2(B2), .B_in_3(B3), .P1_en(EN1), .C_out(OUT));  
  
  initial 
  begin
    CLK = 1'b0;
    RST = 1'b1;
    A1 = 8'd0;
    A2 = 8'd0;
    A3 = 8'd0;
    B1 = 8'd0;
    B2 = 8'd0;
    B3 = 8'd0;
    EN1= 1'b0;
   
    
  end
  
 
 	initial
	begin
		 forever
		 begin
			#10 CLK = !CLK;
		 end
	end
  
  initial 
  begin
    #20 // t1
    RST=1'b0;
    EN1=1'b1;
    B1 = 8'd1; B2 = 8'd2; B3 = 8'd3;
    
    #20 // t2
    EN1=1'b1;
    B1 = 8'd4; B2 = 8'd5; B3 = 8'd6;
    
    #20 // t3
    EN1=1'b1;
    B1 = 8'd7; B2 = 8'd8; B3 = 8'd9;
    
    #20 // t4
    EN1=1'b0;
    A1=8'd1; A2 =8'd0; A3=8'd0;
   
    #20 // t5
    A1 = 8'd0; A2 = 8'd2; A3 = 8'd0;    
    
    #20 // t6
    A1 = 8'd0; A2 = 8'd0; A3 = 8'd3;
    
    #20 // t7
    A1 = 8'd0; A2 = 8'd0; A3 = 8'd0;
    
    #20 // t8
    A1 = 8'd1; A2 = 8'd2; A3 = 8'd3;
    
    #20 // t9
    A1=8'd0; A2 =8'd2; A3=8'd0;
   
    #20 // t10
    A1 = 8'd0; A2 = 8'd0; A3 = 8'd3;    
    
    #20 // t11
    A1 = 8'd0; A2 = 8'd0; A3 = 8'd0;
    
    #20 // t12
    A1 = 8'd0; A2 = 8'd2; A3 = 8'd3;
    
    #20 // t13
    A1 = 8'd0; A2 = 8'd0; A3 = 8'd0;
    
  end  
      
endmodule

