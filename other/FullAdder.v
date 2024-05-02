module Full_Adder ( a,b,cin,sum,carry);
    input [7:0]a; input [7:0]b; input cin;
    output [7:0]sum; output carry;
   
assign {cout,sum}=a+ b+cin;


endmodule