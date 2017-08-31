`timescale 100 ps/10 ps

// The `timescale directive specifies that
// the simulation time unit is 100 ps and
// the simulator timestep is 10 ps

module rle_testbench;
	// signal declaration
	reg clkt, rstt;
	reg recv_readyt, send_readyt;
	reg [7:0] in_datat;
	reg end_of_streamt;
	wire [23:0] out_datat;
	wire rd_reqt, wr_reqt;

	// instantiate the circuit under test
	rle_enc uut
		(.clk(clkt), .rst(rstt), .recv_ready(recv_readyt), .send_ready(send_readyt), .in_data(in_datat), .end_of_stream(end_of_streamt), .out_data(out_datat), .rd_req(rd_reqt), .wr_req(wr_reqt));


	// clock running forever
	initial
	begin
		clkt=0; 
		recv_readyt=1; //indicating that they were connected to the input and output sides
		send_readyt=1; //by FIFO
		end_of_streamt=0; //No bits read in yet
	end

	always
	begin

	// Clock signal assignment
		#0.8 clkt=~clkt; //creates a period of 160 ps
		

	end

	// reset for a few cycles
	initial
	begin

	// Reset signal assignment
		rstt=1;
		#52.4
		rstt=0;

	end

	// test vector generator
	initial
	begin
	#52.4
	// test vector 1
	in_datat=8'b00111100;

	// test vector 2
	#35 in_datat=8'b11100000;
		
 	// test vector 3
	#52.4 in_datat=8'b11111110;
	
	// test vector 4
	#35 in_datat=8'b01010101;

	// test vector 5
	#64 in_datat=8'b10101010;
		
 	  // test vector 6
	#80 in_datat=8'b11001100;
		
	// test vector 7
	#62 in_datat=8'b11010101;

	// test vector 8
	#80 in_datat=8'b10001001;
		
 	  // test vector 9
	#80 in_datat=8'b00001111;
		
	// test vector 10
	#35 in_datat=8'b11110000;

	// test vector 11
	#35 in_datat=8'b10000001;
		
	// test vector 12
	#45 in_datat=8'b01111110;

		$stop;
	end
endmodule