
module SubBytes(
input [127:0] in,
output [127:0] out
);
genvar i;
generate
for( i= 0; i<16;i=i+1)begin :Sub
S_Box mm(in[8*i+7:8*i],out[8*i+7:8*i]);
end
endgenerate
endmodule
