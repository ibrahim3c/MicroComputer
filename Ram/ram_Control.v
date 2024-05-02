module RAM_Control_Signal(

	input  I,
	input [7:0] T, D,
	output wire Write
  //  , Read from Common BUS
);
	wire Dn7,A;
	assign Dn7 = ~D[7];
	assign A = D[2] | D[1] | D[0];

//    always @(*) begin
// 	 Write =/* (T[1]) |*/ (D[3] & T[4]) |(D[5] & T[4]) | (D[6] & T[6]);   // remove interrupt
//    end


    assign Write = /* (T[1]) | */ (D[3] & T[4]) | (D[5] & T[4]) | (D[6] & T[6]);   // remove interrupt
	// assign Read = (T[1]) | (Dn7 & I & T[3]) | (D[6] & T[4]) | (A & T[4]); from CommonBus

endmodule