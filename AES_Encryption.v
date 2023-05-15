
module AES_Encryption#(parameter NK=4,NR=NK+6)(plaintext,key,encrypted);
input [0:127]plaintext;
input[0:32*NK-1] key;
output wire[0:127]encrypted;

wire [0:127]out[0:NR];
wire [0:127] afterSub;
wire [0:127] afterShift;
wire [0:32*4*(NR+1)-1] completeKey;

KeyExpansion e1(key,completeKey);

Add_Round_Key a1(plaintext,completeKey[0:127],out[0]);

genvar i;
generate
for(i=1;i<NR;i=i+1)begin :EncryptionSteps
		EncryptionRound r1(out[i-1],completeKey[128*i+:128],out[i]);
		end
endgenerate


SubBytes s1(out[NR-1],afterSub);
ShiftRows s2(afterSub,afterShift);
Add_Round_Key a2(afterShift,completeKey[128*NR+:128],out[NR]);

assign encrypted=out[NR];

endmodule