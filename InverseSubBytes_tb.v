
module InverseSubBytes_tb();

reg [127:0] in;
wire [127:0] out;
reg [127:0] result;
initial begin
	in=128'h20f5a8b7849f4db72ff99f4db720f5a8;
	result =128'h54776F204F6E65204E696E652054776F;

#5
if(out == result)
$monitor("First case is True");
else
$monitor("First case is wrong");
end

InverseSubBytes f2(in,out);
endmodule
