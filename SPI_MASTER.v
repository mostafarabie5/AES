module SPI_MASTER (CS, CLK, MOSI, MISO, 
				   DATA_IN, data_valid, DONE, clock,DATA_OUT);
output  CS,CLK, MOSI,DONE,DATA_OUT;

input MISO, clock, data_valid;

input [15:0] DATA_IN;
reg [15:0] OUT_SR=16'b0;
reg [15:0] DATA_OUT=16'b0;
reg [15:0] IN_SR=16'b0;
reg CS=1'b1,DONE=1'b0;

assign CLK = clock;

reg STATE;
integer counter;

parameter IDEL =1'b0;
parameter SHIFT = 1'b1;
parameter PERIOD = 10;

initial  begin
	counter =0;
	STATE = IDEL;
end

always @(posedge CLK) begin
	if(CS) STATE = IDEL;
end

//always @(posedge CS) STATE <=IDEL;

always @(posedge CLK) begin
	case(STATE) 
	IDEL: begin
		DONE <= 0;
		if(!CS) STATE <= SHIFT;
		if(data_valid) begin
			OUT_SR <= DATA_IN;
			CS <=0;
		end

	end
	SHIFT: begin
		if(!CS) begin
		OUT_SR <= OUT_SR>>1;
		

		end
	end

	endcase
end
always @(posedge DONE) DATA_OUT<=IN_SR;

always @(negedge CLK) begin
	case(STATE)
	SHIFT: begin
		IN_SR <= IN_SR>>1;
		IN_SR[15] <= MISO;
		DONE <= 0;
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
			CS <= 1;
			counter =0;
		end
	end
	endcase
end
assign MOSI = OUT_SR[0];

endmodule

