
module Cipher_tb();

reg clk = 0;
localparam text = 128'h3925841d02dc09fbdc118597196a0b32;
reg [127:0] plaintext = text;

//encrypted = 128'h3925841d02dc09fbdc118597196a0b32;
//key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
//result = 128'h3243f6a8885a308d313198a2e0370734;

localparam key_data = 128'h2b7e151628aed2a6abf7158809cf4f3c;
reg [127:0] key = key_data;                         
reg [15:0] DATA_IN;
reg [127:0] results=128'b0;
reg data_valid;
wire DONE;
wire [15:0] DATA_OUT;
always #10 clk = ~clk;
wire CS;

reg MODE;
integer counter=0;
reg [1:0]STATE;
localparam key_flag = 0;
localparam text_flag = 1;
localparam recvice_data =2;

initial begin
    data_valid =0;
    DATA_IN = key[15:0];
    key <= key>>16;
    STATE <=key_flag;
    MODE <= 1;
end

always @(posedge clk) begin

    case (STATE)
        key_flag:begin
            if(CS&&counter<8) data_valid<=1;
            if(!CS) data_valid<=0;
            if(DONE) begin
                counter =counter+1;
                data_valid<=1;
                DATA_IN <= key[15:0];
                key <= key>>16;
                if(counter==8)begin
                    data_valid<=0;
                    STATE <= text_flag;
                    counter <=0;
                    DATA_IN <= plaintext[15:0];
                    plaintext <= plaintext>>16; 
                end 
            end
        end 
        text_flag:begin
            if(CS&&counter<8) begin
                data_valid<=1;
            end 
            if(!CS) data_valid<=0;
            if(DONE) begin
            counter =counter+1;
            data_valid<=1;
            DATA_IN <= plaintext[15:0];
            plaintext <= plaintext>>16;
            if(counter==8)begin
                data_valid<=1;
                STATE<=recvice_data;
		counter <= 0;
            	end
    	    end
        end
        recvice_data: begin
            if(DONE) begin
            counter =counter+1;
            results <= results>>16;
            results[127:112] <= DATA_OUT;
            if(counter==9)begin
		$display("Results %h",results);
                STATE<=3;
            	end
    	    end
        end
    endcase
    

end

SPI_MASTER Mas(CS, CLK, MOSI, MISO, 
				   DATA_IN, data_valid, DONE, clk,DATA_OUT);
Cipher cih(CS, CLK,MOSI,MISO,MODE);

endmodule