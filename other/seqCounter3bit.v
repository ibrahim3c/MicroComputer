module Sequence_Counter3Bit(
    input clk, reset, INC,
    output reg [2:0] count
);
    always @(posedge clk) begin
        if (reset)
            count <= 3'h0;
        else if(INC)
            count <= count + 1;
    end
endmodule

module Sequence_Counter3Bit2(
    input clk, reset,
    output reg [2:0] count
);
    always @(posedge clk) begin
        if (reset)
            count <= 3'h0;
        else 
            count <= count + 1;
    end
endmodule

module SC_ControlSignal (
   
   T, D, I,CLR
);
input  I;
input [7:0] T, D;
output  CLR;
wire  r;
assign r=D[7] & !I & T[3];
assign CLR=(D[0]&T[5]) | (D[1]&T[5]) | (D[2]&T[5]) | r |(D[4]&T[4]) | (D[3]&T[4])  | (D[5]&T[5]) |(D[6]&T[6]);    
endmodule
