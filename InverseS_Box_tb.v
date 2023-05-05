

module InverseS_Box_tb();
reg[0:7] i;
wire[0:7] out;
initial begin 
i = 8'h09;
end
InverseS_Box mm(i,out);
endmodule