
module S_Box_tb();
reg[0:7] i;
wire[0:7] out;
initial begin 
i = 8'h09;
end
S_Box mm(i,out);
endmodule