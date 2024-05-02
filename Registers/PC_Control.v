// AND,ADD, LDA, CMA,CIR,CIL
module PC_ControlSingal (
    /*LD, CLR,  I,*/ D, T,INR
);
// input  I;
input [7:0] T, D;
output /*LD, CLR,*/ INR;

assign INR=(T[1])|(D[5] & T[5]);

endmodule