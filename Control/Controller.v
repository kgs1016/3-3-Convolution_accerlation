module Controller ( 	
  input clk,
	input reset,
	output reg P1_en,  //filter hold for 3x3
	output reg [1:0] P2_en, //filter hold for 2x2 rows
	output reg mux_reset,   //after serial conv
  output reg [2:0] c_sel, //1: acc 00 at c11
  output reg [1:0] sel_m, //00: 0, 01: s 10: 3x3 11: 2x2
  output reg [4:0] addr_a1,
  output reg [4:0] addr_a2,
  output reg [4:0] addr_a3,
  output reg [4:0] addr_b1,
  output reg [4:0] addr_b2,
  output reg [4:0] addr_b3,
  output reg [4:0] cond,
  output reg [1:0] arw,
  output reg [1:0] brw, 
  output reg [1:0] crw //11: read, 10:write, else: 0 	      
  );
	


reg [7:0] state;
reg [7:0] next_state;

reg [26:0] clk_cnt; 

parameter [26:0] COUNT_MAX = 99999999;

//parameter setting//
parameter INITIAL=0,  SERIAL_START=26, SERIAL_END=64, P1_START=65, P1_END=79, P2_START=80, P2_END=104, DISPLAY_S_C11=105, DISPLAY_S_C12=106, 
DISPLAY_S_C21=107, DISPLAY_S_C22=108, DISPLAY_3X3_C11=109, DISPLAY_3X3_C12=110, DISPLAY_3X3_C21=111, DISPLAY_3X3_C22=112,
DISPLAY_2X2_C11=113, DISPLAY_2X2_C12=114, DISPLAY_2X2_C21=115, DISPLAY_2X2_C22=116, END=117;

parameter add11=5'd0, add12=5'd1, add13=5'd2, add14=5'd3, add21=5'd4, add22=5'd5, add23=5'd6, add24=5'd7, add31=5'd8, add32=5'd9, add33=5'd10, 
add34=5'd11, add41=5'd12, add42=5'd13, add43=5'd14, add44=5'd15, bdd11=5'd0, bdd12=5'd1, bdd13=5'd2, bdd21=5'd3, bdd22=5'd4, bdd23=5'd5,
bdd31=5'd6, bdd32=5'd7, bdd33=5'd8, add00=5'b11111, bdd00=5'b11111;

always @ (state or clk_cnt)//DISPLAY STATE
begin
	case (state)
		DISPLAY_S_C11 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_S_C11;
		end
		DISPLAY_S_C12 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_S_C12;
		end
		DISPLAY_S_C21 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_S_C21;
		end
		DISPLAY_S_C22 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_S_C22;
		end
		DISPLAY_3X3_C11 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_3X3_C11;
		end
		DISPLAY_3X3_C12 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_3X3_C12;
		end
		DISPLAY_3X3_C21 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_3X3_C21;
		end
		DISPLAY_3X3_C22 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_3X3_C22;
		end
		DISPLAY_2X2_C11 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_2X2_C11;
		end
		DISPLAY_2X2_C12 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_2X2_C12;
		end
		DISPLAY_2X2_C21 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_2X2_C21;
		end													
		DISPLAY_2X2_C22 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_2X2_C22;		
		end
		END : begin
			next_state = END;
		end
		default : begin
			next_state = state + 8'd1;
		end
	endcase
end

always @ (state) //OUTPUT
begin
  //
	case (state)
	  INITIAL: begin
	  P1_en=1'b0;  //filter hold for 3x3
	  P2_en=2'd0; //filter hold for 2x2 rows
	  mux_reset=1'b0;   //after serial conv
    c_sel=3'd0; //1: acc 00 at c11
    sel_m=2'd0; //00: 0, 01: s 10: 3x3 11: 2x2
    addr_a1=5'd0;
    addr_a2=5'd0;
    addr_a3=5'd0;
    addr_b1=5'd0;
    addr_b2=5'd0;
    addr_b3=5'd0;
    cond=5'd0;
    arw=2'b10;
    brw=2'd0; 
    crw=2'd0;
  end
    //Start: Write input
		8'd1 : begin 
		  arw=2'b10;
		  addr_a1<=5'd0; 		addr_a2<=5'd0; 		addr_a3<=5'd0; 
		end
		8'd2 : begin 
		  arw=2'b10;
		  addr_a1<=5'd1; 		addr_a2<=5'd1; 		addr_a3<=5'd1; 
		end
		8'd3 : begin 
		  arw=2'b10;
		  addr_a1<=5'd2; 		addr_a2<=5'd2; 		addr_a3<=5'd2; 
		end
		8'd4 : begin 
		  arw=2'b10;
		  addr_a1<=5'd3; 		addr_a2<=5'd3; 		addr_a3<=5'd3; 
		end
		8'd5 : begin 
		  arw=2'b10;
		  addr_a1<=5'd4; 		addr_a2<=5'd4; 		addr_a3<=5'd4; 
		end
		8'd6 : begin 
		  arw=2'b10;
		  addr_a1<=5'd5; 		addr_a2<=5'd5; 		addr_a3<=5'd5; 
		end
		8'd7 : begin 
		  arw=2'b10;
		  addr_a1<=5'd6; 		addr_a2<=5'd6; 		addr_a3<=5'd6; 
		end
		8'd8 : begin 
		  arw=2'b10;
		  addr_a1<=5'd7; 		addr_a2<=5'd7; 		addr_a3<=5'd7; 
		end
		8'd9 : begin 
		  arw=2'b10;
		  addr_a1<=5'd8; 		addr_a2<=5'd8; 		addr_a3<=5'd8; 
		end		
		8'd10 : begin 
		  arw=2'b10;
		  addr_a1<=5'd9; 		addr_a2<=5'd9; 		addr_a3<=5'd9; 
		end
		8'd11 : begin 
		  arw=2'b10;
		  addr_a1<=5'd10; 		addr_a2<=5'd10; 		addr_a3<=5'd10; 
		end
		8'd12 : begin 
		  arw=2'b10;
		  addr_a1<=5'd11; 		addr_a2<=5'd11; 		addr_a3<=5'd11; 
		end
		8'd13 : begin 
		  arw=2'b10;
		  addr_a1<=5'd12; 		addr_a2<=5'd12; 		addr_a3<=5'd12; 
		end
		8'd14: begin 
		  arw=2'b10;
		  addr_a1<=5'd13; 		addr_a2<=5'd13; 		addr_a3<=5'd13; 
		end
		8'd15: begin 
		  arw=2'b10;
		  brw=2'b10;
		  addr_a1<=5'd14; 		addr_a2<=5'd14; 		addr_a3<=5'd14; 
		end
		8'd16: begin 
		  arw=2'b10;

		  addr_a1<=5'd15; 		addr_a2<=5'd15; 		addr_a3<=5'd15; 
		end

		8'd17: begin //filter input
			arw=2'b00;

		  addr_b1<=5'd0; 		addr_b2<=5'd0; 		addr_b3<=5'd0; 
		end
		8'd18: begin 
		  brw=2'b10;
		  addr_b1<=5'd1; 		addr_b2<=5'd1; 		addr_b3<=5'd1; 
		end
		8'd19: begin 
		  brw=2'b10;
		  addr_b1<=5'd2; 	 addr_b2<=5'd2; 		addr_b3<=5'd2; 
		end
		8'd20: begin 
		  brw=2'b10;
		  addr_b1<=5'd3; 	 addr_b2<=5'd3; 		addr_b3<=5'd3; 
		end
		8'd21: begin 
		  brw=2'b10;
		  addr_b1<=5'd4; 		addr_b2<=5'd4; 		addr_b3<=5'd4; 
		end
		8'd22: begin 
		  brw=2'b10;
		  addr_b1<=5'd5; 		addr_b2<=5'd5; 		addr_b3<=5'd5; 
		end
		8'd23: begin 
		  brw=2'b10;
		  addr_b1<=5'd6; 		addr_b2<=5'd6; 		addr_b3<=5'd6; 
		end
		8'd24: begin 
		  brw=2'b10;
		  addr_b1<=5'd7; 		addr_b2<=5'd7; 		addr_b3<=5'd7; 
		end
		8'd25: begin 

		  addr_b1<=5'd8; 		addr_b2<=5'd8; 		addr_b3<=5'd8; 
		end	
									
///////////////////////////////////////////////////////////////////////
		// Serial mode
       // Serial mode
		SERIAL_START : begin
		//module initiate
  		  arw=2'b11;

      sel_m <=2'b01;
			addr_a1 <= add11;
			addr_b1 <= bdd33;
		end
		8'd27 : begin
		  		  brw=2'b11;
		  
end
		// C11 starts
		8'd28 : begin
			mux_reset = 1'b0; 
			addr_a1 <= add12;
			addr_b1 <= bdd32;
		end
		8'd29 : begin
			addr_a1 <= add13;
			addr_b1 <= bdd31;
		end
		8'd30 : begin
			addr_a1 <= add21;
			addr_b1 <= bdd23;
		end
		8'd31 : begin
			addr_a1 <= add22;
			addr_b1 <= bdd22;
		end
		8'd32 : begin
			addr_a1 <= add23;
			addr_b1 <= bdd21;
		end
		8'd33 : begin
			addr_a1 <= add31;
			addr_b1 <= bdd13;
		end
		8'd34 : begin
			addr_a1 <= add32;
			addr_b1 <= bdd12;
		end
		8'd35 : begin
			addr_a1 <= add33;
			addr_b1 <= bdd11;
		end
		
	  8'd36 : begin
 			//C11 Write: CM to data need a wire
			addr_a1 <= add12;  
			addr_b1 <= bdd33;

		end
		// C12 START				
		8'd37 : begin

			crw=2'b10; cond=5'd0;
			addr_a1 <= add13;
			addr_b1 <= bdd32;
			mux_reset = 1'b1;
		end
		8'd38 : begin
		  		  crw=2'b00;
		  mux_reset = 1'b0;
			addr_a1 <= add14;
			addr_b1 <= bdd31;
		end
		8'd39 : begin
			addr_a1 <= add22;
			addr_b1 <= bdd23;
		end
		8'd40 : begin
			addr_a1 <= add23;
			addr_b1<= bdd22;
		end
		8'd41 : begin
			addr_a1 <= add24;
			addr_b1 <= bdd21;
		end
		8'd42 : begin
			addr_a1 <= add32;
			addr_b1 <= bdd13;
		end
		8'd43 : begin
			addr_a1 <= add33;
			addr_b1 <= bdd12;
		end
		8'd44 : begin	
			addr_a1 <= add34;
			addr_b1 <= bdd11;
		end

		8'd45 : begin

			addr_a1 <= add21;
			addr_b1 <= bdd33;

    end
		// C21 starts				
		8'd46 : begin 
		  		  			crw=2'b10; cond=5'd1;//c12 load
		  		  			mux_reset = 1'b1;



			addr_a1 <= add22;
			addr_b1<= bdd32;
		end
		8'd47 : begin
		  		  crw=2'b00;
		  	  		mux_reset = 1'b0;	

			addr_a1 <= add23;
			addr_b1 <= bdd31;
		end
		8'd48 : begin

			addr_a1 <= add31;
			addr_b1 <= bdd23;
		end
		8'd49 : begin
			addr_a1 <= add32;
			addr_b1 <= bdd22;
		end
		8'd50 : begin
			addr_a1 <= add33;
			addr_b1 <= bdd21;
		end
		8'd51 : begin
			addr_a1 <= add41;
			addr_b1 <= bdd13;
		end
		8'd52 : begin
			addr_a1 <= add42;
			addr_b1 <= bdd12;
		end
		8'd53 : begin
			addr_a1 <= add43;
			addr_b1 <= bdd11;

		end
    8'd54 : begin
//c21 load
			addr_a1 <= add22;
			addr_b1 <= bdd33;

		end
		// C22 starts
		8'd55 : begin
						 			crw=2'b10; cond=5'd2;

		  						mux_reset = 1'b1;

		  addr_a1 <= add23;
			addr_b1 <= bdd32;


		// C21 stored	
		end
		8'd56 : begin
					  crw=2'b00;
			addr_a1 <= add24;
			addr_b1 <= bdd31;
					  mux_reset = 1'b0;
		end
		8'd57 : begin
			addr_a1 <= add32;
			addr_b1 <= bdd23;
		end
		8'd58 : begin
		 addr_a1 <= add33;
			addr_b1 <= bdd22;
		end
		8'd59 : begin
			addr_a1 <= add34;
			addr_b1 <= bdd21;
		end
		8'd60 : begin
			addr_a1 <= add42;
			addr_b1 <= bdd13;
		end
		8'd61 : begin
			addr_a1 <= add43;
			addr_b1 <= bdd12;	
		end
		8'd62 : begin
			addr_a1 <= add44;
			addr_b1 <= bdd11;
		end
		8'd63 : begin

		end
		SERIAL_END : begin
		   			crw=2'b10; cond=5'd3;//c22 Load
 mux_reset=1'b1;		
		end	
//////////////////////////////////////////////////////////////////////
		// Parallel1 mode
		P1_START : begin //t0
		//module transition
	    mux_reset = 1'b0;
	          crw=2'b00; 
      sel_m=2'b10;
  		  arw=2'b11;
  		  brw=2'b11;
		  P1_en=1'b1;
			addr_b1 =bdd31; addr_b2=bdd32; addr_b3=bdd33;
		end 
		8'd66 : begin //t1
			addr_b1 =bdd21; addr_b2=bdd22; addr_b3=bdd23;
		end		
		8'd67 : begin //t2
			addr_b1 =bdd11; addr_b2=bdd12; addr_b3=bdd13;
		end
		8'd68 : begin //t3
			addr_a1 =add31; addr_a2=add00; addr_a3=add00;
		end
		8'd69 : begin //t4
		  P1_en=1'b0;
			addr_a1 =add32; addr_a2=add21; addr_a3=add00;
		end		
		8'd70 : begin //t5
			addr_a1 =add33; addr_a2=add22; addr_a3=add11;
		end
		8'd71 : begin //t6
			addr_a1 =add34; addr_a2=add23; addr_a3=add12;
		end
		8'd72 : begin //t7
			addr_a1 =add41; addr_a2=add24; addr_a3=add13;
		end		
		8'd73 : begin //t8: get c11
			addr_a1 =add42; addr_a2=add31; addr_a3=add14;
		  
		end
		8'd74 : begin //t9: get c12
			addr_a1 =add43; addr_a2=add32; addr_a3=add21;
			crw=2'b10; cond<=5'd4;

		end
		8'd75 : begin //t10

		  		  crw=2'b10; cond<=5'd5;
			addr_a1 =add44; addr_a2=add33; addr_a3=add22;
		end		
		8'd76 : begin //t11
				  crw=2'b00;
			addr_a1 =add00; addr_a2=add34; addr_a3=add23;
		end
		8'd77 : begin //t12:
			addr_a1 =add00; addr_a2=add00; addr_a3=add24;

		end
		8'd78 : begin //t13:
				  crw=2'b10; cond<=5'd6;

		end
		8'd79 : begin
		  			crw=2'b10; cond<=5'd7;
		end						// C22 stored
		
///////////////////////////////////////////////////////////////////////

		// Parallel2 mode
		//
		P2_START : begin //t0
		//module transition

  		  arw=2'b00;
  		  brw=2'b00;
		crw=2'b00;

  		  arw=2'b11;
  		  brw=2'b11;
			addr_b1 =bdd32; addr_b2=bdd33;
		end
		// C11 starts 
		8'd81 : begin //t1		      
		      addr_b1 =bdd31; addr_b2=bdd00;//else at parallel1
      P2_en=2'b11;
		end
		8'd82 : begin //t2
		sel_m=2'b11;
			addr_a1 =add13; addr_a2=add11;
		end
		8'd83 : begin //t3
		  P2_en = 2'b00; //filter keep
			addr_a1 =add14; addr_a2=add12;
		end
		8'd84 : begin //t4
			addr_a1 =add00; //0 at a1
			addr_a2=add13;	
		end
		8'd85 : begin //t5-get partial sum of c11
		  addr_a1 =add23; addr_a2=add21;
			c_sel=3'b100;
		end
		8'd86 : begin //t6-get p_sum for c12
			addr_a1 =add24; addr_a2=add22;
			c_sel=3'b101;
		end
		8'd87 : begin //t7
			addr_a1 =add00; addr_a2=add23;
			addr_b1 =bdd22; addr_b2=bdd23; 
			c_sel=3'b001;
		end
		8'd88 : begin //t8-get c21
			addr_a1 =add00; addr_a2=add00;
			addr_b1 =bdd21; addr_b2=bdd00;
			c_sel=3'b110;
			P2_en=2'b10;
		end
		8'd89 : begin //t9-get c22
			addr_a1 =add23; addr_a2=add21; 
			c_sel=3'b111;
			P2_en=2'b11;
		end
		8'd90 : begin //t10 
			addr_a1 =add24; addr_a2=add22; 
			c_sel=3'b011;
			P2_en=2'b00;
		end
		8'd91 : begin //t11
			addr_a1 =add00; addr_a2=add23; 
		end
		8'd92 : begin //t12-get partial sum of c11
			addr_a1 =add33; addr_a2=add31;
			c_sel=3'b100;
		end
		8'd93 : begin //t13-get p_sum for c12
			addr_a1 =add34; addr_a2=add32;
			c_sel=3'b101;
		end
		8'd94 : begin //t14
			addr_a1 =add00; addr_a2=add33;
			addr_b1 =bdd12; addr_b2=bdd13; 
			c_sel=3'b001;
		end
		8'd95 : begin //t15-get c21
			addr_a1 =add00; addr_a2=add00;
			addr_b1 =bdd11; addr_b2=bdd00;
			c_sel=3'b110;
			P2_en=2'b10;
		end
		8'd96 : begin //t16-get c22
			addr_a1 =add33; addr_a2=add31; 
			c_sel=3'b111;
			P2_en=2'b11;
		end
		8'd97 : begin //t17
			addr_a1 =add34; addr_a2=add32; 
			c_sel=3'b011;
			P2_en=2'b00;
		end
		8'd98 : begin //t18
			addr_a1 =add00; addr_a2=add33; 
		end
		8'd99 : begin //t19: p2_c11
			addr_a1 =add43; addr_a2=add41;
			c_sel=3'b100;
		  crw=2'b10; cond<=5'd8;
		end
		8'd100 : begin //t20: p2_c12
			addr_a1 =add44; addr_a2=add42;
			c_sel=3'b101;
			crw=2'b10; cond<=5'd9;
		end
		8'd101 : begin //t21
		  P2_en<=2'b00;
			addr_a1 =add00; addr_a2=add43;
			addr_b1 =bdd00; addr_b2=bdd00; 
			c_sel=3'b001; crw=2'b00;
		end
		8'd102 : begin //t22: p2_c21
			addr_a1 =add00; addr_a2=add00;
			c_sel=3'b110;
			crw=2'b10; cond<=5'd10;
		end
		8'd103: begin //t23: p2_c22
			c_sel=3'b111;
		  crw=2'b10; cond<=5'd11; 	
		end
		P2_END : begin //t24 c22 store

  		  arw=2'b00;
  		  brw=2'b00;
		  crw=2'b10;  		  
		end	
		
		//timing consideration
		DISPLAY_S_C11 : begin
    crw=2'b11; cond=5'd0;
          sel_m=2'b00;
    //memory address for out_conv
		end
		DISPLAY_S_C12 : begin
		  crw=2'b11; cond=5'd1;
    //memory address for out_conv
		end
		DISPLAY_S_C21 : begin
		  crw=2'b11; cond=5'd2;
    //memory address for out_conv
		end
		DISPLAY_S_C22 : begin
        crw=2'b11; cond=5'd3;
    //memory address for out_conv
		end
		DISPLAY_3X3_C11 : begin
        crw=2'b11; cond=5'd4;		  
    //memory address for out_conv
		end
		DISPLAY_3X3_C12 : begin
        crw=2'b11; cond=5'd5;		  
    //memory address for out_conv
		end
		DISPLAY_3X3_C21 : begin
        crw=2'b11; cond=5'd6;
      //memory address for out_conv
		end
		DISPLAY_3X3_C22 : begin
        crw=2'b11; cond=5'd7;		  
      //memory address for out_conv
		end
		DISPLAY_2X2_C11 : begin
        crw=2'b11; cond=5'd8;
      //memory address for out_conv
		end
		DISPLAY_2X2_C12 : begin
        crw=2'b11; cond=5'd9;		  
      //memory address for out_conv
		end
		DISPLAY_2X2_C21 : begin
        crw=2'b11; cond=5'd10;		  
      //memory address for out_conv
		end
		DISPLAY_2X2_C22 : begin
        crw=2'b11; cond=5'd11;		  
      //memory address for out_conv
		end
		END : begin
			crw=2'b00;
		end

	endcase
end

always @ (posedge clk or posedge reset) //state_transition
begin
	if (reset)
		state <= INITIAL;
	else
		state <= next_state;
end

always @ (posedge clk or posedge reset) //clock counter
begin 
	if (reset) begin
		clk_cnt <= 27'd0;
	end else begin
		case (state)
      DISPLAY_S_C11, DISPLAY_S_C12, DISPLAY_S_C21, DISPLAY_S_C22,
      DISPLAY_3X3_C11, DISPLAY_3X3_C12, DISPLAY_3X3_C21, DISPLAY_3X3_C22,
      DISPLAY_2X2_C11, DISPLAY_2X2_C12, DISPLAY_2X2_C21, DISPLAY_2X2_C22 : begin
				if (clk_cnt == COUNT_MAX)
					clk_cnt <= 27'd0;
				else
					clk_cnt <= clk_cnt + 27'd1;	
			end
			default : begin
				clk_cnt <= 27'd0;
			end
		endcase
	end
end

endmodule






