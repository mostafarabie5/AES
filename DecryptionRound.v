module DecryptionRound #(parameter NK=4,NR=NK+6)(in,key,out);

input[0:127] in;
input [0:127] key;
output [0:127]out;

wire [0:127] afterSub;
wire [0:127] afterShift;

wire [0:127] afterRound;
inverse_ShiftRows s2(in,afterShift);
InverseSubBytes s1(afterShift,afterSub);
inverseAdd_Round_Key a2(afterSub,key,afterRound);
invMixColumn m1(afterRound,out);

endmodule
