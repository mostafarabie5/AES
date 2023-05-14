module SPI_MASTER_TB();

//reg [127:0] text = 128'h3243f6a8885a308d313198a2e0370734;
//reg [127:0] rec_text=128'h0;

reg [15:0] master_text=16'hABCD;
reg [15:0] slave_text =16'hFEDC;
wire [15:0] master_data_out;
wire [15:0] slave_data_out;
reg clk=0;
reg data_enable =1;
wire master_done;
wire slave_done;
wire mosi,miso;
wire cs;
wire clock;


always #10 clk = ~clk;

always @(posedge clk) begin
	if(master_done) data_enable<=1;
	if(!cs) data_enable <=0;
end

always @(master_done) begin
 

    if(master_done) begin
        $display("Master  %h",master_data_out);
        $display("Slave   %h",slave_data_out);
        data_enable = 1;
    if(master_data_out == slave_text && master_text == slave_data_out) $display("DONE AND SUCESS");
	#20 master_text<= 16'h1234; slave_text = 16'h9876;
	

    //rec_text = rec_text>>16;
    //rec_text[127:112] <=recvice;
	//if(i==2) data <= text[31:16];
    //else if(i==3) data <= text[47:32];
    //else if(i==4) data <= text[63:48];
    //else if(i==5) data <= text[79:64];
    //else if(i==6) data <= text[95:80];
    //else if(i==7) data <= text[111:96];
    //else if(i==8) data <= text[127:112];
end
end 

//always @(posedge clk) begin
//if(!cs)
//    sen_text<= sen_text>>1;
//    recvice<=recvice>>1;
//    recvice[15] <= (mosi!==1'bx)?mosi:2'b0;
//	if(i==9) begin 
//	if(text==rec_text)
//	$display("Check = Successed");
//	else
//	$display("Check = Failed");
//
//    $finish;
//    end
//	$monitor(data_out);
//end


SPI_MASTER M(cs, clock, mosi, miso, 
				   master_text, data_enable, master_done, clk, master_data_out); 

SPI_SLAVE S(cs, clk, mosi, miso,
                   slave_text, slave_data_out,data_enable,slave_done);



endmodule