module Instructions_ControlSignal (
 T, D, I,B
,AND,ADD,LDA,STA,BUN,BSA,ISZ,CMA,CLA,CIL,CIR
);

input  I;
input [7:0] T, D ;
input [7:0] B;
output AND,ADD,LDA,STA,BUN,BSA,ISZ,CMA,CLA,CIL,CIR ;

// Memory-Reference
assign AND= D[0] & T[4];
assign ADD= D[1] & T[5];
assign LDA= D[2] & T[4];
assign STA= D[3] & T[4];
assign BUN= D[4] & T[4];
assign BSA= D[5] & T[4];
 assign ISZ= D[6] & T[4];

wire  r;
assign r=D[7] & !I & T[3];
// Register-Reference
assign CLA= r & B[3];
assign CMA= r & B[2];
assign CIR= r & B[1];
assign CIL= r & B[0];



endmodule