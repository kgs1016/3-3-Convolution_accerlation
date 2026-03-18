module memoryin(data, address, rw, clk, rst, save);
   input clk;
   input rst; 
   input [7:0] data;
   input [4:0] address;
   input [1:0] rw; //11: read, 10:write, else: 0
   reg [7:0] in [0:15];
   wire [7:0] out [0:15]; 	
   output reg [7:0] save;
	
    eight_bit_register_module r0(in[0], clk, rst, out[0]);
    eight_bit_register_module r1(in[1], clk, rst, out[1]);
    eight_bit_register_module r2(in[2], clk, rst, out[2]);
    eight_bit_register_module r3(in[3], clk, rst, out[3]);
    eight_bit_register_module r4(in[4], clk, rst, out[4]);
    eight_bit_register_module r5(in[5], clk, rst, out[5]);
    eight_bit_register_module r6(in[6], clk, rst, out[6]);
    eight_bit_register_module r7(in[7], clk, rst, out[7]);
    eight_bit_register_module r8(in[8], clk, rst, out[8]);
    eight_bit_register_module r9(in[9], clk, rst, out[9]);
    eight_bit_register_module r10(in[10], clk, rst, out[10]);
    eight_bit_register_module r11(in[11], clk, rst, out[11]);
    eight_bit_register_module r12(in[12], clk, rst, out[12]);
    eight_bit_register_module r13(in[13], clk, rst, out[13]);                        
    eight_bit_register_module r14(in[14], clk, rst, out[14]);
    eight_bit_register_module r15(in[15], clk, rst, out[15]);

    always @ (posedge clk) begin
      if(rw==2'b11) begin
        		case(address)
			     5'd0 : save =out[0];
			     5'd1 : save =out[1];
			     5'd2 : save =out[2];
			     5'd3 : save =out[3];
			     5'd4 : save =out[4];
			     5'd5 : save =out[5];
			     5'd6 : save =out[6];
			     5'd7 : save =out[7];
			     5'd8 : save =out[8];
			     5'd9 : save =out[9];
			     5'd10 : save=out[10];
			     5'd11 : save=out[11];
			     5'd12 : save=out[12];
			     5'd13 : save=out[13];
			     5'd14 : save=out[14];	
			     5'd15 : save=out[15];
			     default : save=8'd0;	
			    endcase
			    end
			 else if(rw==2'b10) begin
        		case(address)
			     5'd0 : in[0] <=data;
			     5'd1 : in[1] <=data;
			     5'd2 : in[2] <=data;
			     5'd3 : in[3] <=data;
			     5'd4 : in[4] <=data;
			     5'd5 : in[5] <=data;
			     5'd6 : in[6] <=data;
			     5'd7 : in[7] <=data;
			     5'd8 : in[8] <=data;
			     5'd9 : in[9] <=data;
			     5'd10 : in[10] <=data;
			     5'd11 : in[11] <=data;
			     5'd12 : in[12] <=data;
			     5'd13 : in[13] <=data;
			     5'd14 : in[14] <=data;
			     5'd15 : in[15] <=data;
			    endcase
			    end
			 else begin save<=7'd0; end
     			     			     			     
		end
    
endmodule
