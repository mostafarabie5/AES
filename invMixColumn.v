module invMixColumn(state,out);
input [0:127]state;
output[0:127]out;

function [0:7]m02;
input [0:7]m;
input integer n;
integer i;
begin

for (i=0;i<n;i=i+1)
begin 
m=(m[0]==1'b0)?(m << 1):
(m << 1)^8'h1b;
end

 m02=m;
end

endfunction

function [0:7]m0e;
input [0:7]m;
m0e=m02(m,3)^m02(m,2)^m02(m,1);
endfunction

function[0:7]m0d;
input [0:7]m;
m0d=m02(m,3)^m02(m,2)^m;
endfunction 

function[0:7]m0b;
input [0:7]m;
m0b=m02(m,3)^m02(m,1)^m;
endfunction 

function[0:7]m09;
input [0:7]m;
m09=m02(m,3)^m;
endfunction 

assign out [0:7]=m0e(state[0:7])^m0b(state[8:15])^m0d(state[16:23])^m09(state[24:31]);
assign out [8:15]=m09(state[0:7])^m0e(state[8:15])^m0b(state[16:23])^m0d(state[24:31]);
assign out [16:23]=m0d(state[0:7])^m09(state[8:15])^m0e(state[16:23])^m0b(state[24:31]);
assign out [24:31]=m0b(state[0:7])^m0d(state[8:15])^m09(state[16:23])^m0e(state[24:31]);

assign out [32:39]=m0e(state[32:39])^m0b(state[40:47])^m0d(state[48:55])^m09(state[56:63]);
assign out [40:47]=m09(state[32:39])^m0e(state[40:47])^m0b(state[48:55])^m0d(state[56:63]);
assign out [48:55]=m0d(state[32:39])^m09(state[40:47])^m0e(state[48:55])^m0b(state[56:63]);
assign out [56:63]=m0b(state[32:39])^m0d(state[40:47])^m09(state[48:55])^m0e(state[56:63]);

assign out [64:71]=m0e(state[64:71])^m0b(state[72:79])^m0d(state[80:87])^m09(state[88:95]);
assign out [72:79]=m09(state[64:71])^m0e(state[72:79])^m0b(state[80:87])^m0d(state[88:95]);
assign out [80:87]=m0d(state[64:71])^m09(state[72:79])^m0e(state[80:87])^m0b(state[88:95]);
assign out [88:95]=m0b(state[64:71])^m0d(state[72:79])^m09(state[80:87])^m0e(state[88:95]);

assign out [96:103]=m0e(state[96:103])^m0b(state[104:111])^m0d(state[112:119])^m09(state[120:127]);
assign out [104:111]=m09(state[96:103])^m0e(state[104:111])^m0b(state[112:119])^m0d(state[120:127]);
assign out [112:119]=m0d(state[96:103])^m09(state[104:111])^m0e(state[112:119])^m0b(state[120:127]);
assign out [120:127]=m0b(state[96:103])^m0d(state[104:111])^m09(state[112:119])^m0e(state[120:127]);




endmodule 