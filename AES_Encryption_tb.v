
module AES_Encryption_tb();
reg [0:127]plaintext;
reg[0:32*4-1] key;
wire[0:127]encrypted;
reg[0:127]result;
initial begin
plaintext = 128'h3243f6a8885a308d313198a2e0370734;
key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
result=128'h3925841d02dc09fbdc118597196a0b32;
#5 if(result==encrypted)
$monitor("Check = True");
else
$monitor("Check = False");
end

AES_Encryption e1(plaintext,key,encrypted);


endmodule
