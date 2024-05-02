module AR_Reg(
    input INR,LD,clk,CLR
    ,input[3:0] in
    ,output reg [3:0] out
) ;
    always @(posedge clk ) begin
        if(CLR) out<=4'b0;
         if(LD)  out <=in;
         if(INR)  out<=in+1;
    end


endmodule



