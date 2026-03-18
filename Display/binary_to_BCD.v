//`timescale 1ns/10ps

module binary_to_BCD(
    input clk,
    input [7:0] binary_in,
    output reg [3:0] O=0, //one
    output reg [3:0] T=0, //ten
    output reg [3:0] H=0  //hunderd
);

reg [3:0] i = 0;
reg [19:0] shift_register = 0;
reg [3:0] temp_H = 0;
reg [3:0] temp_T = 0;
reg [3:0] temp_O = 0;

reg [7:0] original_binary_in = 0;

always @(posedge clk) 
begin
  if (i == 0 && (original_binary_in != binary_in)) begin
    shift_register = 20'd0;
    original_binary_in = binary_in;
    shift_register[7:0] = binary_in;
    temp_H = shift_register[19:16];
    temp_T = shift_register[15:12];
    temp_O = shift_register[11:8];
    i = i + 1;
  end
  if (i < 9 & i > 0) begin
    if (temp_H >= 5) temp_H = temp_H + 3;
    if (temp_T >= 5) temp_T = temp_T + 3;
    if (temp_O >= 5) temp_O = temp_O + 3;
      
    shift_register[19:8] = {temp_H, temp_T, temp_O};
    
    shift_register = shift_register << 1;
    
    temp_H = shift_register[19:16];
    temp_T = shift_register[15:12];
    temp_O = shift_register[11:8];
    i = i + 1;
  end
  if (i == 9) begin
    i = 0;
    H = temp_H;
    T = temp_T;
    O = temp_O;
  end
end

endmodule
