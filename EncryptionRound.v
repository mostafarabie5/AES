
module EncryptionRound #(parameter NK=4,NR=NK+6)(in,key,out);

input[0:127] in;
input [0:127] key;
output [0:127]out;

wire [0:127] afterSub;
wire [0:127] afterShift;
wire [0:127] afterMix;
wire [0:127] afterRound;
SubBytes s1(in,afterSub);
ShiftRows s2(afterSub,afterShift);
MixColumn m1(afterShift,afterMix);
Add_Round_Key a2(afterMix,key,afterRound);
assign out = afterRound;
endmodule
