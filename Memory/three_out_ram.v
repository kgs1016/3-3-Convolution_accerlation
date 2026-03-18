//this is file for 3 out ram

module three_out_ram(
	input [7:0] data_w,
	input [3:0] addr0,
	input [3:0] addr1,
	input [3:0] addr2,
	input ce, we, clk,
	output [7:0] data_r0,
	output [7:0] data_r1,
	output [7:0] data_r2
);

reg [7:0] mem [15:0];
reg [3:0] addr_reg0;
reg [3:0] addr_reg1;
reg [3:0] addr_reg2;

always @ (posedge clk) //posedge ce can be added
begin
    if (ce)  begin //can read and write
        if (we) begin //can write
            mem[addr0] <= data_w; //save the data
        end
        
        //load the address
        addr_reg0 <= addr0;
        addr_reg1 <= addr1;
        addr_reg2 <= addr2; 
    end
end

assign data_r0 = mem[addr_reg0];
assign data_r1 = mem[addr_reg1];
assign data_r2 = mem[addr_reg2];
	
endmodule

