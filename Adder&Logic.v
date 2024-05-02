`include "other/FullAdder.v"
module AdderAndLogic (
 input AND,ADD, LDA, CMA,CIR,CIL,    //instructions signals 
    input [7:0] AC,input [7:0] DR,
    input CIN,E,
    output cout ,
    output [7:0]  ACData);
    

    wire [7:0] and8b,add8b,lda8b,cma8b,cir8b,cil8b;     
   
    wire [7:0] And,Add,lda,cma,cir,cil ;        
    
    
    //AND OPERATION
    assign and8b = (AND ? 8'b1 :8'b0);
	assign And = AC & and8b & DR;
	
	//ADD OPERTION
	wire [7:0] SUM;
	Full_Adder  FA ( .a(AC),.b(DR),.cin(CIN),.sum(SUM),.carry(CARRY));
	assign add8b = (ADD ? 8'b1 :8'b0);
	assign Add = SUM & add8b ;
	
	//LDA OPERATION (DR to AC)
	assign lda8 = (LDA ? 8'b1 :8'b0);
	assign lda = lda8 & DR ;
	
	//CMA OPERATION (Complement AC)
	assign cma8b = (CMA ? 8'b1 :8'b0);
	assign cma = (~AC) & cma8b;
	
	
	
	wire [7:0] ac_shift_right, ac_shift_left, e_shift_right, e_shift_left;
	wire [7:0]or_result1, or_result2;

	// CIR (circulate right) OPERATION
	assign cir8b = (CIR ? 8'b1 : 8'b0); // Control signal for CIR
	assign ac_shift_right = AC >> 1; // Step 1: Shift AC to the right by 1 bit
	assign e_shift_right = E ? 8'b10000000 : 8'b0; // Step 2: Create a mask for E, 8'b10000000 if E is true
	assign or_result1 = ac_shift_right | e_shift_right; // Step 3: OR operation to combine AC shifted right with E
	assign cir = or_result1 & cir8b; // Step 4: Output of the OR operation with or_result1 and cir8b

	// CIL (circulate left) OPERATION
	assign cil8b = (CIL ? 8'b1 : 8'b0); // Control signal for CIL
	assign ac_shift_left = AC << 1; // Step 1: Shift AC to the left by 1 bit
	assign e_shift_left = {8'b0, E}; // Step 2: Create a mask for E, 8'b0000000E
	assign or_result2 = ac_shift_left | e_shift_left; // Step 3: OR operation to combine AC shifted left with E
	assign cil = or_result2 & cil8b; // Step 4: Output of the OR operation with or_result2 and cil8b

		
    assign ACDATA = And | Add | lda | cma | cir | cil; // All AND gates signals to be into an OR gate that results in AC
  
endmodule


///    another module 


 module AdderAndLogic2 (
    input AND, ADD, LDA, CMA, CIR, CIL,    // Instructions signals 
    input [7:0] AC, DR,
    input CIN, E,
    output cout,
    output reg [7:0] ACData
);

// Wire declarations
wire [7:0] SUM;
reg [7:0] ac_shift_right, ac_shift_left;
reg [7:0] e_shift_right, e_shift_left; // Fixed declaration
reg [7:0]or_result1, or_result2;

// Full Adder instantiation
Full_Adder FA (
    .a(AC),
    .b(DR),
    .cin(CIN),
    .sum(SUM),
    .carry(cout)
);

// Always block for operations
always @* begin
    // AND OPERATION
    if (AND) begin
        ACData = AC & DR;
    end

    // ADD OPERATION
    else if (ADD) begin
        ACData = SUM;
    end

    // LDA OPERATION (DR to AC)
    else if (LDA) begin
        ACData = DR;
    end

    // CMA OPERATION (Complement AC)
    else if (CMA) begin
        ACData = ~AC;
    end

    // CIR (Circulate Right) OPERATION
    else if (CIR) begin
        ac_shift_right = AC >> 1;
        e_shift_right = E ? 8'b10000000 : 8'b0;
        or_result1 = ac_shift_right | e_shift_right;
        ACData = or_result1;
    end

    // CIL (Circulate Left) OPERATION
    else if (CIL) begin
        ac_shift_left = AC << 1;
        e_shift_left = {8'b0, E};
        or_result2 = ac_shift_left | e_shift_left;
        ACData = or_result2;
    end

    // Default assignment if no operation is selected
    else begin
        ACData = AC;
    end
end

endmodule


// best one 


module AdderAndLogic3 (
    input AND, ADD, LDA, CMA, CIR, CIL,    // Instruction signals 
    input [7:0] AC, DR,
    input CIN,
    output E,
    output [7:0] Data
);

// Full Adder instantiation
wire [7:0] SUM;
Full_Adder FA (
    .a(AC),
    .b(DR),
    .cin(CIN),
    .sum(SUM),
    .carry(E)
);

// AND OPERATION
assign Data = (AND) ? (AC & DR) :
             (ADD) ? SUM :
             (LDA) ? DR :
             (CMA) ? (~AC) :
             (CIR) ? (AC >> 1 | (E ? 8'b10000000 : 8'b0)) :
             (CIL) ? (AC << 1 | {7'b0, E}) :
             AC; // Default operation


endmodule
