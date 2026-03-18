
module multiplier(a, b , product);


	input [7:0] a, b;
	output [7:0] product;

	wire  cout1,cout2,cout3,cout4,cout5,cout6,cout7;
	
	wire [7:0] AND_0,AND_1,AND_2,AND_3,AND_4,AND_5,AND_6,AND_7;

	wire [7:0] ADD_0,ADD_1,ADD_2,ADD_3,ADD_4,ADD_5,ADD_6;

	      and_gate a0_0(a[0], b[0], AND_0[0]);
	      and_gate a0_1(a[0], b[1], AND_0[1]);
	      and_gate a0_2(a[0], b[2], AND_0[2]);
	      and_gate a0_3(a[0], b[3], AND_0[3]);
	      and_gate a0_4(a[0], b[4], AND_0[4]);
	      and_gate a0_5(a[0], b[5], AND_0[5]);
	      and_gate a0_6(a[0], b[6], AND_0[6]);
	      and_gate a0_7(a[0], b[7], AND_0[7]);
	      and_gate a1_0(a[1], b[0], AND_1[0]);
	      and_gate a1_1(a[1], b[1], AND_1[1]);
	      and_gate a1_2(a[1], b[2], AND_1[2]);
	      and_gate a1_3(a[1], b[3], AND_1[3]);
	      and_gate a1_4(a[1], b[4], AND_1[4]);
	      and_gate a1_5(a[1], b[5], AND_1[5]);
	      and_gate a1_6(a[1], b[6], AND_1[6]);
	      and_gate a1_7(a[1], b[7], AND_1[7]);
	      and_gate a2_0(a[2], b[0], AND_2[0]);
	      and_gate a2_1(a[2], b[1], AND_2[1]);
	      and_gate a2_2(a[2], b[2], AND_2[2]);
	      and_gate a2_3(a[2], b[3], AND_2[3]);
	      and_gate a2_4(a[2], b[4], AND_2[4]);
	      and_gate a2_5(a[2], b[5], AND_2[5]);
    	  and_gate a2_6(a[2], b[6], AND_2[6]);
	      and_gate a2_7(a[2], b[7], AND_2[7]);
	      and_gate a3_0(a[3], b[0], AND_3[0]);
          and_gate a3_1(a[3], b[1], AND_3[1]);
          and_gate a3_2(a[3], b[2], AND_3[2]);
          and_gate a3_3(a[3], b[3], AND_3[3]);
          and_gate a3_4(a[3], b[4], AND_3[4]);
          and_gate a3_5(a[3], b[5], AND_3[5]);
          and_gate a3_6(a[3], b[6], AND_3[6]);
          and_gate a3_7(a[3], b[7], AND_3[7]);
          and_gate a4_0(a[4], b[0], AND_4[0]);
          and_gate a4_1(a[4], b[1], AND_4[1]);
          and_gate a4_2(a[4], b[2], AND_4[2]);
          and_gate a4_3(a[4], b[3], AND_4[3]);
          and_gate a4_4(a[4], b[4], AND_4[4]);
          and_gate a4_5(a[4], b[5], AND_4[5]);
          and_gate a4_6(a[4], b[6], AND_4[6]);
          and_gate a4_7(a[4], b[7], AND_4[7]);
	      and_gate a5_0(a[5], b[0], AND_5[0]);
          and_gate a5_1(a[5], b[1], AND_5[1]);
          and_gate a5_2(a[5], b[2], AND_5[2]);
          and_gate a5_3(a[5], b[3], AND_5[3]);
          and_gate a5_4(a[5], b[4], AND_5[4]);
          and_gate a5_5(a[5], b[5], AND_5[5]);
          and_gate a5_6(a[5], b[6], AND_5[6]);
          and_gate a5_7(a[5], b[7], AND_5[7]);
	      and_gate a6_0(a[6], b[0], AND_6[0]);
          and_gate a6_1(a[6], b[1], AND_6[1]);
          and_gate a6_2(a[6], b[2], AND_6[2]);
          and_gate a6_3(a[6], b[3], AND_6[3]);
          and_gate a6_4(a[6], b[4], AND_6[4]);
          and_gate a6_5(a[6], b[5], AND_6[5]);
          and_gate a6_6(a[6], b[6], AND_6[6]);
          and_gate a6_7(a[6], b[7], AND_6[7]);
	      and_gate a7_0(a[7], b[0], AND_7[0]);
          and_gate a7_1(a[7], b[1], AND_7[1]);
          and_gate a7_2(a[7], b[2], AND_7[2]);
          and_gate a7_3(a[7], b[3], AND_7[3]);
          and_gate a7_4(a[7], b[4], AND_7[4]);
          and_gate a7_5(a[7], b[5], AND_7[5]);
          and_gate a7_6(a[7], b[6], AND_7[6]);
          and_gate a7_7(a[7], b[7], AND_7[7]);
	

	
	

	eight_bit_adder Add0({1'b0,AND_0[7:1]}, AND_1,1'b0 ,ADD_0, cout1);
	eight_bit_adder Add1({cout1,ADD_0[7:1]}, AND_2, 1'b0, ADD_1, cout2);
	eight_bit_adder Add2({cout2,ADD_1[7:1]}, AND_3, 1'b0, ADD_2, cout3);
	eight_bit_adder Add3({cout3,ADD_2[7:1]}, AND_4, 1'b0, ADD_3, cout4);
	eight_bit_adder Add4({cout4,ADD_3[7:1]}, AND_5, 1'b0, ADD_4, cout5);
	eight_bit_adder Add5({cout5,ADD_4[7:1]}, AND_6, 1'b0, ADD_5, cout6);
	eight_bit_adder Add6({cout6,ADD_5[7:1]}, AND_7, 1'b0, ADD_6, cout7);
	
	
	
	assign product =  {ADD_6[0],ADD_5[0],ADD_4[0],ADD_3[0],ADD_2[0],ADD_1[0],ADD_0[0],AND_0[0]};
	  

endmodule
