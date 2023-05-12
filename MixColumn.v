
module MixColumn (state,out);
input [0:127]state;
output [0:127]out;
assign out [0:7]=m2(state[0:7])^m3(state[8:15])^(state[16:23])^(state[24:31]);
assign out [8:15]=(state[0:7])^m2(state[8:15])^m3(state[16:23])^(state[24:31]);
assign out [16:23]=(state[0:7])^(state[8:15])^m2(state[16:23])^m3(state[24:31]);
assign out [24:31]=m3(state[0:7])^(state[8:15])^(state[16:23])^m2(state[24:31]);

assign out [32:39]=m2(state[32:39])^m3(state[40:47])^(state[48:55])^(state[56:63]);
assign out [40:47]=(state[32:39])^m2(state[40:47])^m3(state[48:55])^(state[56:63]);
assign out [48:55]=(state[32:39])^(state[40:47])^m2(state[48:55])^m3(state[56:63]);
assign out [56:63]=m3(state[32:39])^(state[40:47])^(state[48:55])^m2(state[56:63]);

assign out [64:71]=m2(state[64:71])^m3(state[72:79])^(state[80:87])^(state[88:95]);
assign out [72:79]=(state[64:71])^m2(state[72:79])^m3(state[80:87])^(state[88:95]);
assign out [80:87]=(state[64:71])^(state[72:79])^m2(state[80:87])^m3(state[88:95]);
assign out [88:95]=m3(state[64:71])^(state[72:79])^(state[80:87])^m2(state[88:95]);

assign out [96:103]=m2(state[96:103])^m3(state[104:111])^(state[112:119])^(state[120:127]);
assign out [104:111]=(state[96:103])^m2(state[104:111])^m3(state[112:119])^(state[120:127]);
assign out [112:119]=(state[96:103])^(state[104:111])^m2(state[112:119])^m3(state[120:127]);
assign out [120:127]=m3(state[96:103])^(state[104:111])^(state[112:119])^m2(state[120:127]);

function [0:7]m2;
input [0:7]m;
m2=(m[0]==1'b0)?(m << 1):
(m << 1)^8'h1b;
endfunction
function [0:7]m3;
input [0:7]m;
m3=m2(m)^m;
endfunction
endmodule 