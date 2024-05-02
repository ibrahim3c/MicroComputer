module Sequence_Counter(
    input clk, reset, INC,
    output reg [3:0] count
);
    always @(posedge clk) begin
        if (reset)
            count <= 4'h0;
        else if(INC)
            count <= count + 1;
    end
endmodule
