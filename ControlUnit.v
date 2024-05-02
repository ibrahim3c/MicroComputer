`include "Registers/AC.v"
`include "Registers/AC_Control.v"
`include "Registers/AR.v"
`include "Registers/AR_Control.v"
`include "Registers/DR.v"
`include "Registers/DR_Control.v"
`include "Registers/PC.v"
`include "Registers/PC_Control.v"
`include "Registers/IR.v"
`include "Registers/IR_Control.v"
`include "Ram/ram.v"
`include "Ram/ram_Control.v"
`include "CommonBus/CommonBusControlSignal.v"
`include "Instructions.v"
`include "other/seqCounter3bit.v"


module ControlUnit (
    input [7:0] T, input [7:0] D ,input I, input [7:0] B,
    output  LDAC, CLRAC, INRAC,LDAR,INRAR,/*CLRAR,ReadRam,*/WriteRam,LDDR,INRDR,LDIR,INRPC,CLRSC
    ,output [0:2] s,
    output AND,ADD,LDA,STA,BUN,BSA,ISZ,CMA,CLA,CIL,CIR
);


// AC
AC_ControlSingal ac (
    .T(T),
    .D(D),
    .I(I),
    .B(B),
    .LD(LDAC),
    .CLR(CLRAC),
    .INR(INRAC)
);

//AR
AR_ControlSingal ar (LDAR/*, CLR*/ , INRAR, T, D, I);

 //DR
 DR_ControlSingal dr (
    LDDR, INRDR,T, D
);
 //IR

IR_ControlSingal  ir (
    LDIR, T
);
 //PC
 PC_ControlSingal  pc (
    /*LD, CLR,   I,*/ D, T,INRPC
);

//RAM
 RAM_Control_Signal ram (
	.I(I),
	.T(T), 
    .D(D),
	.Write(WriteRam)
    /*,.Read(ReadRam)*/ // from CommonBus
);

// SC

SC_ControlSignal  sc (
   T, D, I,CLRSC
);

// controlBus
wire [7:0]x;
CommonBus_ControlSignal commanBus(
.x(x), 
.D(D),
.T(T),
.I(I)
);
Selections sss(
    .x(x),
    .s(s)
);

Instructions_ControlSignal instructionControlSignal (
 T, D, I,B
,AND,ADD,LDA,STA,BUN,BSA,ISZ,CMA,CLA,CIL,CIR
);

endmodule
