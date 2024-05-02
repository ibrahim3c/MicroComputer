`include "Registers/AC.v"
`include "Registers/AR.v"
`include "Registers/DR.v"
`include "Registers/IR.v"
`include "Registers/PC.v"
`include "Ram/ram.v"
`include "CommonBus/CommonBus.v"
`include "ControlUnit.v"
`include "Adder&Logic.v"
`include "Instructions.v"

module Micro_Computer (
     clk
);
input wire clk;

// Signals for control unit
wire [7:0] T, D, B;
wire LDAC, CLRAC, INRAC, LDAR, INRAR, LDDR, INRDR, LDIR, INRPC, CLRSC, s;
wire  AND, ADD, LDA, STA, BUN, BSA, ISZ, CMA, CLA, CIL, CIR;
wire [2:0] count;

// Signals for adder and logic unit
wire [7:0] AC, DR,IR,OUT;
wire [3:0] PC, AR;
wire cin, cout;

// for ram
// 8x4-bit memory matrix==> arr[16][8]
reg [7:0] ram [0:15];  // 16 memory locations and one location 8 bit
    // Initialize memory array with desired values
   initial begin
    // Initialize memory array with desired values
    ram[0]  = 8'h0C;  // AND => 0 000 1100 (12)
    ram[1]  = 8'h91;  // ADD => 1 001 1010 (10) indirect
    ram[2]  = 8'h26;  // LDA => 0 010 0110 (6)
    ram[3]  = 8'h76;  //CLA  => 0 111 0110  // register reference   
    ram[4]  = 8'h04;
    ram[5]  = 8'h05;
    ram[6]  = 8'h06; 
    ram[7]  = 8'h07;
    ram[8]  = 8'h08;
    ram[9]  = 8'h09;
    ram[10] = 8'h1B; 
    ram[11] = 8'h0B;
    ram[12] = 8'h1C;
    ram[13] = 8'h0D;
    ram[14] = 8'h0E; 
    ram[15] = 8'h0F;
end


initial begin
    AC = 8'h00; // Initial value for ac
    DR = 8'h00; // Initial value for dr
    IR = 8'h00; // Initial value for ir
    PC = 4'h0;  // Initial value for pc
    AR = 4'h0;  // Initial value for ar
    cin=0;

end

// sequence Counter
Sequence_Counter3Bit2 counter (
    .clk(clk),
    .reset(CLRSC),
    .count(count)
);

Decoder3x8 decoder (
     .A(count),
     .Y(T)
);


IR_Reg ir (
    .LD(LDIR),
    .clk(clk),
    .in(OUT),
    .out(IR)
);


// to get D

Decoder3x8 d2(
.A(IR[6:4]), 
.Y(D)

);


// CU
ControlUnit CU (
    .T(T),
    .D(D),
    .I(IR[7]),
    .B(IR),
    .LDAC(LDAC),
    .CLRAC(CLRAC),
    .INRAC(INRAC),
    .LDAR(LDAR),
    .INRAR(INRAR),
    .LDDR(LDDR),
    .INRDR(INRDR),
    .LDIR(LDIR),
    .INRPC(INRPC),
    .CLRSC(CLRSC),
    .s(s),
    .AND(AND),
    .ADD(ADD),
    .LDA(LDA),
    .STA(STA),
    .BUN(BUN),
    .BSA(BSA),
    .ISZ(ISZ),
    .CMA(CMA),
    .CLA(CLA),
    .CIL(CIL),
    .CIR(CIR)
);



// common bus
BUS_SEL CommonBus (
    .AR(AR),
    .PC(PC),
    .DR(DR),
    .AC(AC),
    .IR(IR),
    .RAM(ram[AR]),
    .S(S),
    .OUT(OUT)
);


// registers
AC_Reg  ac (
    .INR(INR),
    .LD(LDAC),
    .clk(clk),
    .CLR(CLRAC),
    .in(OUT),
    .out(AC)
);

AR_Reg ar (
    .INR(INR),
    .LD(LDAR),
    .clk(clk),
    .CLR(CLRAR),
    .in(OUT[3:0]),
    .out(AR)
);


// Adder&Logic
AdderAndLogic2 U1 (
  .AND(AND),  
  .ADD(ADD),  
  .LDA(LDA), 
  .CMA(CMA),  
  .CIR(CIR),  
  .CIL(CIL),  
  .AC(AR),  
  .DR(DR),       
  .CIN(cin),     
  .cout(cout),    
  .ACData(AR)         
);
   

DR_Reg dr (
    .INR(INR),
    .LD(LDDR),
    .clk(clk),
    // .CLR(CLRDR),
    .in(OUT),
    .out(DR)
);



PC_Reg pc (
    .INR(INR),
    // .LD(LDPC),
    .clk(clk),
    // .CLR(CLRPC),
    .in(OUT[3:0]),
    .out(PC)
);

// Memory
RAM_8x4bit RAM (
    .clk(clk),
    // .read(read),
    .write(write),
    .addr(AR),
    .data_in(OUT)
    //, .data_out(ram)
);


 initial begin
    $monitor("Time=%0t AC=%h DR=%h IR=%h PC=%h AR=%h OUT=%h", $time, AC, DR, IR, PC, AR, OUT);
end


endmodule