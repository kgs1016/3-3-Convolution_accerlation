//This is for 7segment display
//`timescale 1ns/1ns

module seven_seg_display(
    input clk, 
    input reset,
    input [7:0] c, // 8bit binary c11, c12, c21, c22
    output reg [7:0] digit, //activate=1, others=0
    output reg [6:0] seg_data //7segment code
    );


    reg [3:0] LED_BCD; //4bit BCD code
    reg [19:0] refresh_counter; //20bit refresh counter
    wire [2:0] LED_activating_counter; //we have 8digit->need 3bit counter
    
    
    always @(posedge clk or posedge reset)  
    begin
        if (reset)
            refresh_counter <= 0; //reset refresh counter
        else
            refresh_counter <= refresh_counter + 1;
    end
    
    assign LED_activating_counter = refresh_counter[19:17]; //3bit counter to represent 8 cases
    
    wire [3:0] one,ten,hundred;
    binary_to_BCD binary_to_BCD_inst(.clk(clk), .binary_in(c), .O(one), .T(ten), .H(hundred));
    
    
    always @(*)
    begin
        case(LED_activating_counter)
            3'b000 : begin
                digit <= 8'b10000000;
                LED_BCD <= 4'b0000; //0
            end
            3'b001 : begin
                digit <= 8'b01000000;
                LED_BCD <= 4'b0000; //0
            end
            3'b010 : begin
                digit <= 8'b00100000;
                LED_BCD <= 4'b0000; //0
            end
            3'b011 : begin
                digit <= 8'b00010000;
                LED_BCD <= 4'b0000; //0
            end
            3'b100 : begin
                digit <= 8'b00001000;
                LED_BCD <= 4'b0000; //0            
            end
            3'b101 : begin
                digit <= 8'b00000100;
                LED_BCD <= hundred;        
            end
            3'b110 : begin
                digit <= 8'b00000010;
                LED_BCD <= ten;
            end
                3'b111 : begin
                digit <= 8'b00000001;
                LED_BCD <= one;
            end           
        endcase
    end
    
    always @(*)
    begin
        case(LED_BCD)
        4'b0000 : seg_data = 7'b1111110; //0
        4'b0001 : seg_data = 7'b0110000; //1
        4'b0010 : seg_data = 7'b1101101; //2
        4'b0011 : seg_data = 7'b1111001; //3
        4'b0100 : seg_data = 7'b0110011; //4
        4'b0101 : seg_data = 7'b1011011; //5
        4'b0110 : seg_data = 7'b1011111; //6
        4'b0111 : seg_data = 7'b1110010; //7
        4'b1000 : seg_data = 7'b1111111; //8
        4'b1001 : seg_data = 7'b1111011; //9
        default : seg_data = 7'b1111110; //0
        endcase
    end
    
    initial
    begin
        refresh_counter = 20'b00000000000000000000;
    end
    

    
                       
                
endmodule