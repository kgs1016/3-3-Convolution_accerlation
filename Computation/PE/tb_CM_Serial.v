`timescale 1ns / 1ns
module tb_CM_Serial;
  
	reg [7:0] A, B;
	reg CLK;
	reg RESET;
	reg MUX_RESET;

	wire [7:0] OUT;

	CM_Serial SERIAL(.a(A), .b(B), .clk(CLK), .rst(RESET), .mux_reset(MUX_RESET), .out(OUT));

	initial
	begin 
		forever
		begin
			#10 CLK = !CLK;
		end
	end

	initial
	begin
		CLK = 1'b1;
		RESET = 1'b1;
		MUX_RESET = 1'b0;
		A = 8'd12; B = 8'd5;
    
  end
  
  initial
  begin
		#20
		RESET = 1'b0;
		#20
		A = 8'd3; B = 8'd2;
		#20
		A = 8'd2; B = 8'd5;
		#20
		A = 8'd5; B = 8'd3;
    #20
		A = 8'd2; B = 8'd7;
		#20
		A = 8'd3; B = 8'd2;
    #20
		A = 8'd9; B = 8'd3;
    #20
		A = 8'd2; B = 8'd4;
		#20
		A = 8'd1; B = 8'd1;
    #20
		A = 8'd3; B = 8'd3;
    MUX_RESET = 1'b1;
	
		
	end

endmodule
