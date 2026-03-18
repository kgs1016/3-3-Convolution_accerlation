module LUT(arw, brw, add, bdd, z);
    input [4:0] add;
    input [4:0] bdd;
    input [1:0] arw;
    input [1:0] brw;
    output reg [7:0] z;

    always @(arw, brw, add, bdd) begin
      if(arw==2'b10)
        begin
        case (add[3:0])
            4'd0: z <= 8'd3;
            4'd1: z <= 8'd5;
            4'd2: z <= 8'd0;
            4'd3: z <= 8'd1;
            4'd4: z <= 8'd4;
            4'd5: z <= 8'd0;
            4'd6: z <= 8'd6;
            4'd7: z <= 8'd4;
            4'd8: z <= 8'd4;
            4'd9: z <= 8'd6;
            4'd10: z <= 8'd0;
            4'd11: z <= 8'd4;
            4'd12: z <= 8'd1;
            4'd13: z <= 8'd0;
            4'd14: z <= 8'd5;
            4'd15: z <= 8'd3;
            default: z <= 0;
        endcase
      end
    else if(brw==2'b10)
      begin
        case(bdd[3:0])
            4'b0000: z <= 8'd1;
            4'b0001: z <= 8'd3;
            4'b0010: z <= 8'd1;
            4'b0011: z <= 8'd0;
            4'b0100: z <= 8'd5;
            4'b0101: z <= 8'd0;
            4'b0110: z <= 8'd1;
            4'b0111: z <= 8'd3;
            4'b1000: z <= 8'd1;
            default: z<=0;
      endcase
    end
    end
endmodule