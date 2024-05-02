module IR_Reg(
    input LD,clk
    ,input[7:0] in
    ,output reg [7:0] out
) ;
    always @(posedge clk ) begin

         if(LD)  out <=in;

    end


endmodule


