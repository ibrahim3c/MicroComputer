// B[3]=>CLA
// B[2]=>CMA
// B[1]=>CIR
// B[0]=>CIL

module AC_ControlSingal (
    input [7:0] T, input [7:0] D ,input I, input [7:0] B,
    output  LD,CLR,INR
);
wire  r;
assign r=D[7] & !I & T[3];
assign LD= (T[5]  & (D[0]|D[1]|D[2]) ) |  ( r &  ( B[0]|B[1]|B[2]));
assign CLR = r & B[3];

endmodule