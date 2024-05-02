module CommonBus_ControlSignal(x, D, T, I);

	input  I;
	input [7:0] T, D;
	output [7:0] x;	
	wire R;
    // assign R=;
	assign x[0]=0;
	assign x[1] = (D[4] & T[4]) | (D[5] & T[5]);  //AR 
	assign x[2] = (D[5] & T[4]) | T[0];  //PC 
	assign x[3] = T[6] & D[6];     //DR 
	assign x[4] = D[3] & T[4];     //AC 
	assign x[5] = T[2] ;           //IR 
    // assign x[6]=R & T[1];          // TR
	assign x[7] = /*(~R & */T[1] | ((~D[7]) & I & T[3]) | ((D[0] | D[1] | D[2]) & T[4]);   // M[AR] 	
	
endmodule


module Selections (
	input [7:0]x,
	output [2:0]s
);

assign s[0]=x[1] | x[3] | x[5] | x[7];
assign s[1]=x[2] | x[3] | x[6] | x[7];
assign s[2]=x[4] | x[5] | x[6] | x[7];

endmodule