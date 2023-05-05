


module SubBytes_tb();

reg [127:0] in;
wire [127:0] out;
initial begin
	in =128'h54776F204F6E65204E696E652054776F;
end
SubBytes ff(in,out);
endmodule