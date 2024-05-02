module IR_ControlSingal (
    load, T
);
input [7:0] T;

output load;

assign load=/*Rn & */T[1];


endmodule


// AR => 8 bit =>( one bit for J,3 bits for opCode,4 bits for add)
// B[3]=>CLA
// B[2]=>CMA
// B[1]=>CIR
// B[0]=>CIL