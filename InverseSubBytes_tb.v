
module InverseSubBytes_tb();

reg [127:0] in;
wire [127:0] out;
wire [127:0] intermediate;
initial begin
	in =128'h54776F204F6E65204E696E652054776F;
end
SubBytes f1(in,intermediate);
InverseSubBytes f2(intermediate,out);
endmodule
