/*module async_fifo(
	input rclk,wclk,rrst_n,wrst_n,
	input [7:0] wdata,
	output [7:0] rdata,
	output wfull,rempty
);*/


module DualProtRAM(
	input [2:0] waddr,raddr,
	input wclk,wen,
	input [7:0] wdata,
	output reg [7:0] rdata
);

	reg [7:0] RAM [7:0];

	always @(posedge wclk)

	begin
		if(wen == 1'b1)
			RAM[waddr] <= wdata;
		else
			RAM[waddr] <= RAM[waddr];		
	end

	always @ (raddr)
	begin
		rdata <= RAM[raddr];
	end

endmodule

module synch_FF #(parameter WIDTH = 4)(
	input clk,rstn,
	input [WIDTH - 1 : 0] INp,
	output reg [WIDTH - 1 : 0] OUTp
);

	reg [WIDTH - 1 : 0] Intermidiate_IN;	

	always@(posedge clk or negedge rstn)
	begin
		if(rstn)
		begin
			Intermidiate_IN <= INp;
			OUTp <= Intermidiate_IN;
		end

		else
		begin
			Intermidiate_IN <= 0;
			OUTp <= 0;
		end
			
	end
endmodule
