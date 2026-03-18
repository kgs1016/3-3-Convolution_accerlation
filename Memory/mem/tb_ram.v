module tb_ram;
   reg clk;
   reg rst; 
   reg [7:0] data;
   reg [4:0] address;
   reg [1:0] rw; //11: read, 10:write, else: 0

   wire [7:0] save;
  
  memoryin mem1(data, address, rw, clk, rst, save);
  
  initial begin
  clk=1'b0;
  rst=1'b1;
  data=8'd0;
  address=5'd0;
  rw =2'd0;
end

initial begin
forever  	
  #10 clk =!clk;
end

initial begin
  #10 rst=1'b0;
  #20 rw=2'b10; data=8'd13; address=5'd1;
  #20 rw=2'b10; data=8'd11; address=5'd11;
  #20 rw=2'b11; address=5'd1;
  #20 rw=2'b11; address=5'd17;  
end  
endmodule
