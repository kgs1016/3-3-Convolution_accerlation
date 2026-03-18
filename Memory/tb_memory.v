`timescale 1ns / 1ns
module tb_memory;
  //input
  reg [7:0] DATA; //data input
  reg CLK, RST;
  
  reg [3:0] ADDR_A0, ADDR_A1, ADDR_A2; 
  reg [3:0] ADDR_F0, ADDR_F1, ADDR_F2;
  reg [1:0] ADDR_S0, ADDR_S1, ADDR_S2, ADDR_S3;
  reg [1:0] ADDR_P1_0, ADDR_P1_1, ADDR_P1_2, ADDR_P1_3;
  reg [1:0] ADDR_P2_0, ADDR_P2_1, ADDR_P2_2, ADDR_P2_3;
  
  reg [1:0] EN_INP; //enable for INPUT
  reg [1:0] EN_FIL; //enable for FILTER
  reg [1:0] EN_S; //enable for SM
  reg [1:0] EN_P1; //enable for PM1
  reg [1:0] EN_P2; //enable for PM2
  
  wire [7:0] OUT_A0, OUT_A1, OUT_A2; //matrix data you want
  wire [7:0] OUT_F0, OUT_F1, OUT_F2; //filter data you want
  wire [7:0] OUT_S0, OUT_S1, OUT_S2, OUT_S3; //Serial mode output
  wire [7:0] OUT_P1_0, OUT_P1_1, OUT_P1_2, OUT_P1_3; //Parallel mode 1 output
  wire [7:0] OUT_P2_0, OUT_P2_1, OUT_P2_2, OUT_P2_3; //Parallel mode 2 output
  
  memory_module MEM(
    .data_w(DATA), .clk(CLK), .rst(RST),
    .addr_A0(ADDR_A0), .addr_A1(ADDR_A1), .addr_A2(ADDR_A2),
    .addr_F0(ADDR_F0), .addr_F1(ADDR_F1), .addr_F2(ADDR_F2),
    .addr_S0(ADDR_S0), .addr_S1(ADDR_S1), .addr_S2(ADDR_S2), .addr_S3(ADDR_S3),
    .addr_P1_0(ADDR_P1_0), .addr_P1_1(ADDR_P1_1), .addr_P1_2(ADDR_P1_2), .addr_P1_3(ADDR_P1_3),
    .addr_P2_0(ADDR_P2_0), .addr_P2_1(ADDR_P2_1), .addr_P2_2(ADDR_P2_2), .addr_P2_3(ADDR_P2_3),
    .en_INP(EN_INP), .en_FIL(EN_FIL), .en_S(EN_S), .en_P1(EN_P1), .en_P2(EN_P2),
    .out_A0(OUT_A0), .out_A1(OUT_A1), .out_A2(OUT_A2),
    .out_F0(OUT_F0), .out_F1(OUT_F1), .out_F2(OUT_F2),
    .out_S0(OUT_S0), .out_S1(OUT_S1), .out_S2(OUT_S2), .out_S3(OUT_S3),
    .out_P1_0(OUT_P1_0), .out_P1_1(OUT_P1_1), .out_P1_2(OUT_P1_2), .out_P1_3(OUT_P1_3),
    .out_P2_0(OUT_P2_0), .out_P2_1(OUT_P2_1), .out_P2_2(OUT_P2_2), .out_P2_3(OUT_P2_3)
  );
  
  initial
  begin
    DATA = 8'd0;
    CLK = 1'b0; RST = 1'b0;
    ADDR_A0 = 4'd0; ADDR_A1 = 4'd0; ADDR_A2 = 4'd0;
    ADDR_F0 = 4'd0; ADDR_F1 = 4'd0; ADDR_F2 = 4'd0;
    ADDR_P1_0 = 2'd0; ADDR_P1_1 = 2'd0; ADDR_P1_2 = 2'd0; ADDR_P1_3 = 2'd0;
    ADDR_P2_0 = 2'd0; ADDR_P2_1 = 2'd0; ADDR_P2_2 = 2'd0; ADDR_P2_3 = 2'd0;
    EN_INP = 2'b00; EN_FIL = 2'b00; EN_S = 2'b00; EN_P1 = 2'b00; EN_P2 = 2'b00;
  end
  
  //clock
  initial
  begin
    forever
    begin
      #10 CLK = !CLK;
    end
  end
  
  integer i;
  
  //FILL THE MATRIX
  // A: 4 X 4 element value is same as address value
  initial
  begin
    #20;
    EN_INP = 2'b11;
    for (i = 0; i < 16; i = i + 1)
    begin
      DATA = i;
      #20;
      ADDR_A0 = i;
      ADDR_A1 = 4'dx; ADDR_A2 = 4'dx;
    end
    
    // FILTER: 3 X 3
    #20;
    EN_FIL = 2'b11; EN_INP = 2'b00;
    for (i = 0; i < 9; i = i + 1)
    begin
      DATA = i + 1;
      #20;
      ADDR_F0 = i;
      ADDR_F1 = 4'dx; ADDR_F2 = 4'dx;
    end
    /*-----------------------------------------------------------------------------*/
    
    //read matrix
    #20;
    EN_INP = 2'b10; EN_FIL = 2'b10;
    ADDR_A0 = 4'd1; ADDR_F0 = 4'd1;
    #20;
    EN_INP = 2'b10; EN_FIL = 2'b00;
    ADDR_A0 = 4'd2; ADDR_A1 = 4'd4; ADDR_A2 = 4'd7;
    #20;
    EN_INP = 2'b10; EN_FIL = 2'b00;
    ADDR_A0 = 4'd5; ADDR_A1 = 4'd3;
    #20;
    EN_INP = 2'b10; EN_FIL = 2'b10;
    ADDR_A0 = 4'd15; ADDR_A1 = 4'd10; ADDR_A2 = 4'd5;
    ADDR_F0 = 4'd15; ADDR_F1 = 4'd10; ADDR_F2 = 4'd5;
    
    //output memory check
    //check serial mode
    #20
    EN_INP = 2'b00; EN_FIL = 2'b00; EN_S = 2'b11;
    DATA = 8'd12; ADDR_S0 = 2'b00;
    #20
    EN_INP = 2'b00; EN_FIL = 2'b00; EN_S = 2'b11;
    DATA = 8'd13; ADDR_S0 = 2'b01;
    #20
    EN_INP = 2'b00; EN_FIL = 2'b00; EN_S = 2'b11;
    DATA = 8'd14; ADDR_S0 = 2'b10;
    #20
    EN_INP = 2'b00; EN_FIL = 2'b00; EN_S = 2'b11;
    DATA = 8'd15; ADDR_S0 = 2'b11;
    
    #20
    EN_INP = 2'b00; EN_FIL = 2'b00; EN_S = 2'b10;
    ADDR_S0 = 2'b00; ADDR_S1 = 2'b01; ADDR_S2 = 2'b10; ADDR_S3 = 2'b11;
    
    //check parallel mode
    #20
    EN_S = 2'b00; EN_P1 = 2'b11;
    DATA = 8'd12; ADDR_P1_0 = 2'b00;
    #20
    EN_P1 = 2'b11;
    DATA = 8'd13; ADDR_P1_0 = 2'b01;
    #20
    EN_P1 = 2'b11;
    DATA = 8'd14; ADDR_P1_0 = 2'b10;
    #20
    EN_P1 = 2'b11;
    DATA = 8'd15; ADDR_P1_0 = 2'b11;
    
    #20
    EN_P1 = 2'b10;
    ADDR_P1_0 = 2'b00; ADDR_P1_1 = 2'b01; ADDR_P1_2 = 2'b10; ADDR_P1_3 = 2'b11;
    
  end
  
endmodule
