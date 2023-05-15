module SPI_SLAVE(CS, CLK, SDI, SDO,
                DATA_IN, DATA_OUT,data_valid,DONE);
    input CS,CLK, SDI;
    output SDO;
    input [15:0] DATA_IN;
    output reg [15:0] DATA_OUT=16'b0;
    reg [15:0] IN_SR=16'b0;
    reg [15:0] OUT_SR=16'b0;
    input data_valid;
    output reg DONE=2'b0;
   
    reg STATE;
    integer counter;


    parameter IDEL =1'b0;
    parameter SHIFT = 1'b1;

    initial  begin
	    counter =0;
	    STATE = IDEL;
    end

always @(posedge CS) STATE = IDEL;

always @(posedge CLK) if(DONE) DONE<=0;

always @(posedge CLK) begin
	case(STATE) 
	IDEL: begin
		if(!CS) STATE <= SHIFT;
		if(data_valid) begin
			OUT_SR <= DATA_IN;
			DONE <= 0;
		end

	end
	SHIFT: begin
		OUT_SR <= OUT_SR>>1;
		
	end

	endcase
end
always @(negedge CLK) begin
	case(STATE) 
	SHIFT: begin
		IN_SR <= IN_SR>>1;
		IN_SR[15] <= SDI;
		counter = counter+1;
	end

	endcase
end

always @(posedge CLK) begin
	case(STATE)
	SHIFT: begin

		if(counter==16)begin
			DONE <= 1;
			STATE <= IDEL;
			counter =0;
		end
	end
	endcase
end

always @(posedge DONE) DATA_OUT<=IN_SR;

assign SDO = OUT_SR[0];
endmodule
