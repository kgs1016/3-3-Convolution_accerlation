//this file is for main memory module

module memory_module(
  input [7:0] data_w, //data input
  input clk, rst,
  
  input [3:0] addr_A0, addr_A1, addr_A2, //0 is to save
  input [3:0] addr_F0, addr_F1, addr_F2, //0 is to save
  input [1:0] addr_S0, addr_S1, addr_S2, addr_S3,
  input [1:0] addr_P1_0, addr_P1_1, addr_P1_2, addr_P1_3,
  input [1:0] addr_P2_0, addr_P2_1, addr_P2_2, addr_P2_3,
  
  input [1:0] en_INP, //enable for INPUT
  input [1:0] en_FIL, //enable for FILTER
  input [1:0] en_S, //enable for SM
  input [1:0] en_P1, //enable for PM1
  input [1:0] en_P2, //enable for PM2
  
  output [7:0] out_A0, out_A1, out_A2, //matrix data you want
  output [7:0] out_F0, out_F1, out_F2, //filter data you want
  output [7:0] out_S0, out_S1, out_S2, out_S3, //Serial mode output
  output [7:0] out_P1_0, out_P1_1, out_P1_2, out_P1_3, //Parallel mode 1 output
  output [7:0] out_P2_0, out_P2_1, out_P2_2, out_P2_3 //Parallel mode 2 output
);

//-----------------------------------------INPUT-------------------------------------------//
//RAM _ INPUT MATRIX
three_out_ram INPUT_RAM(.data_w(data_w), .addr0(addr_A0), .addr1(addr_A1), .addr2(addr_A2), .ce(en_INP[1]), .we(en_INP[0]), .clk(clk), .data_r0(out_A0), .data_r1(out_A1), .data_r2(out_A2));

//RAM _ FILTER MATRIX
three_out_ram INPUT_FIl(.data_w(data_w), .addr0(addr_F0), .addr1(addr_F1), .addr2(addr_F2), .ce(en_FIL[1]), .we(en_FIL[0]), .clk(clk), .data_r0(out_F0), .data_r1(out_F1), .data_r2(out_F2));


//-----------------------------------------OUTPUT-------------------------------------------//
//RAM _ Output of Serial mode
out_ram S_OUT(.data_w(data_w), .addr0(addr_S0), .addr1(addr_S1), .addr2(addr_S2), .addr3(addr_S3), .ce(en_S[1]), .we(en_S[0]), .clk(clk), .data_r0(out_S0), .data_r1(out_S1), .data_r2(out_S2), .data_r3(out_S3));

//RAM _ Output of Parallel mode 1
out_ram P1_OUT(.data_w(data_w), .addr0(addr_P1_0), .addr1(addr_P1_1), .addr2(addr_P1_2), .addr3(addr_P1_3), .ce(en_P1[1]), .we(en_P1[0]), .clk(clk), .data_r0(out_P1_0), .data_r1(out_P1_1), .data_r2(out_P1_2), .data_r3(out_P1_3));

//RAM _ Output of Parallel mode 2
out_ram P2_OUT(.data_w(data_w), .addr0(addr_P2_0), .addr1(addr_P2_1), .addr2(addr_P2_2), .addr3(addr_P2_3), .ce(en_P2[1]), .we(en_P2[0]), .clk(clk), .data_r0(out_P2_0), .data_r1(out_P2_1), .data_r2(out_P2_2), .data_r3(out_P2_3));

endmodule

