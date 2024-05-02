module BUS_SEL (
    input [7:0] AR, PC, DR, AC, IR, RAM,   
    input [2:0] S,                       
    output reg [7:0] OUT                   
);

    wire [7:0] mux_out;  

    // Multiplexer module for selecting bits
    MUX_8to1 mux_8to1 (
        .d0(AR),
        .d1(PC),
        .d2(DR),
        .d3(AC),
        .d4(IR),
        .d5(RAM),
        .sel(S),
        .out(mux_out)
    );

    always @* begin
        case (S)
            3'b000: OUT = AR;  // Select AR
            3'b001: OUT = PC;  // Select PC
            3'b010: OUT = DR;  // Select DR
            3'b011: OUT = AC;  // Select AC
            3'b100: OUT = IR;  // Select IR
            3'b101: OUT = RAM; // Select RAM
            default: OUT = 8'h00;  // Default 
        endcase
    end

endmodule




module MUX_8to1 (
    input [7:0] d0, d1, d2, d3, d4, d5,   // 8-bit input data
    input [2:0] sel,                      // Selection input
    output reg [7:0] out                   // Output data
);

    always @* begin
        case (sel)
            3'b000: out = d0;  // Select d0
            3'b001: out = d1;  // Select d1
            3'b010: out = d2;  // Select d2
            3'b011: out = d3;  // Select d3
            3'b100: out = d4;  // Select d4
            3'b101: out = d5;  // Select d5
            default: out = 8'h00;  // Default (can be customized)
        endcase
    end

endmodule
