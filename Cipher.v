module Cipher#(parameter NK =4,NR = NK+6) (CS, CLK, SDI, SDO,mode);
input mode;
input CS, CLK,SDI;
output SDO;
wire [15:0] DATA_OUT;
reg [15:0] DATA_IN=0;
reg data_valid=0;
wire done_flag;
SPI_SLAVE Reciever(CS, CLK, SDI, SDO, DATA_IN, DATA_OUT, data_valid, done_flag);


localparam key_flag=0;
localparam text_flag=1;
localparam out_data=2;
reg [127:0] plaintext=128'b0;
reg [127:0] key=0;
wire[127:0] encrypted;
wire[127:0] decrypted;

integer counter =0;
reg [2:0] STATE ;
initial begin
    STATE = key_flag;
end
AES_Encryption AE(plaintext,key,encrypted);
AES_Decryption AD(plaintext,key,decrypted);
always @(posedge CLK) begin
    case (STATE)
        key_flag: begin
            if(done_flag) begin
                key <= key>>16;
                key[127:112] <=DATA_OUT;
                counter = counter + 1;
                if(counter==8)begin
                    $display("%h",key);
                    counter = 0;
                    STATE <= text_flag;
                end
            end
        end  
        text_flag: begin
            if(done_flag)begin
              plaintext <= plaintext >> 16;
              plaintext[127:112] <= DATA_OUT;
              counter = counter+1;
              if(counter==8) begin
                  $display("%h",plaintext);
                  counter<=0;
                  STATE<=out_data;
              end
            end
        end
        out_data: begin
            data_valid<=1;
            if(!mode) begin
                 if(counter==0)       DATA_IN <= encrypted[15:0];
                 else if(counter==1)  DATA_IN <= encrypted[31:16];
                 else if(counter==2)  DATA_IN <= encrypted[47:32];
                 else if(counter==3)  DATA_IN <= encrypted[63:48];
                 else if(counter==4)  DATA_IN <= encrypted[79:64];
                 else if(counter==5)  DATA_IN <= encrypted[95:80];
                 else if(counter==6)  DATA_IN <= encrypted[111:96];
                 else if(counter==7)  DATA_IN <= encrypted[127:112];    
            end 
            else begin
                if(counter==0)       DATA_IN <= decrypted[15:0];
                else if(counter==1)  DATA_IN <= decrypted[31:16];
                else if(counter==2)  DATA_IN <= decrypted[47:32];
                else if(counter==3)  DATA_IN <= decrypted[63:48];
                else if(counter==4)  DATA_IN <= decrypted[79:64];
                else if(counter==5)  DATA_IN <= decrypted[95:80];
                else if(counter==6)  DATA_IN <= decrypted[111:96];
                else if(counter==7)  DATA_IN <= decrypted[127:112];    
            end
           
            
            if(done_flag) begin
              counter = counter+1;
              data_valid<=0;
              if(counter==8) begin
                  $display("%h",plaintext);
              end
            end
        end
    endcase
    
end

endmodule

// 4: 128, 6: 192 , 8:256

// Transimiting : Master
// Reciever : Slave Tex