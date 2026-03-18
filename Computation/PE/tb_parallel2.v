`timescale 1ns/1ns

module tb_SA_2x2;
  
  reg CLK, RST; 
  reg [7:0] A1, A2, B1, B2;
  reg [1:0] EN;
  reg [2:0] conv_sel;
  
  wire [7:0] OUT;

  
  
  SA_2x2 SA2(.clk(CLK), .rst(RST), .A_in_1(A1), .A_in_2(A2), .B_in_1(B1), .B_in_2(B2), .P2_en(EN), .c_sel(conv_sel), .SAout(OUT)); 
  
  initial 
  begin
    CLK = 1'b0;
    RST = 1'b1;
    A1 = 8'd0;
    A2 = 8'd0;
    B1 = 8'd0;
    B2 = 8'd0;
    EN= 2'b0;
    conv_sel=3'b000;
   
    
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
    RST = 1'b0;
    B1 = 8'd3; B2 = 8'd4;
    EN= 2'b11;
    
    #20 // t2
    conv_sel=3'b000;
    B1 = 8'd1; B2 = 8'd0;

        
    #20 // t3
    EN= 2'b00;
    A1 = 8'd1; A2 = 8'd2;
    
    #20 // t4
    A1=8'd4; A2 =8'd3;

    
    #20 A1=8'd0; A2 =8'd7; // t5
    conv_sel=3'b100; 

    
    #20 // t6
    conv_sel=3'b101;
    A1 = 8'd4; A2 = 8'd9;
    
    #20 // t7
    conv_sel=3'b001;
    A1 = 8'd2; A2 = 8'd9;
    
    #20 // t8
    EN=2'b10;
    conv_sel=3'b110;
    A1 = 8'd0; A2 = 8'd1;
    B1 = 8'd7; B2 = 8'd1; 
    
    #20 // t9
    EN=2'b11;
    conv_sel=3'b111;
    B1 = 8'd1; B2 = 8'd0;
    
    #20 // t10
    EN= 2'b00;
    conv_sel=3'b011;
    A1 = 8'd1; A2 = 8'd2;
    
    #20 // t11
    A1=8'd4; A2 =8'd3;
   
    #20 // t12
    conv_sel=3'b100;
    A1=8'd0; A2 =8'd7; 
    
    #20 // t13
    conv_sel=3'b101;
    A1 = 8'd4; A2 = 8'd9;
    
    #20 // t14
    conv_sel=3'b001;
    A1 = 8'd2; A2 = 8'd9;
    
    #20 // t15
    EN=2'b10;
    conv_sel=3'b110;
    A1 = 8'd0; A2 = 8'd1;
    B1 = 8'd7; B2 = 8'd1; 
    
    #20 // t16
    EN=2'b11;
    conv_sel=3'b111;
    B1 = 8'd1; B2 = 8'd0;
    
    #20 // t17
    EN= 2'b00;
    conv_sel=3'b011;
    A1 = 8'd1; A2 = 8'd2;
    
    #20 // t18
    A1=8'd4; A2 =8'd3;
   
    #20 // t19: get c11
    conv_sel=3'b100;
    A1=8'd0; A2 =8'd7; 
    
    #20 // t20: get c12
    conv_sel=3'b101;
    A1 = 8'd4; A2 = 8'd9;
    
    #20 // t21
    conv_sel=3'b001;
    A1 = 8'd2; A2 = 8'd9;
    
    #20 // t22:  get c21
    conv_sel=3'b110;
    A1 = 8'd0; A2 = 8'd1;
    
    #20 //t23: get c22
    conv_sel=3'b111;
  end  
      
endmodule
