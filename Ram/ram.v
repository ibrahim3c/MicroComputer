

module RAM_8x4bit (
    input wire clk,         
    // input wire read,
    input wire write,    
    input wire [3:0] addr,  
    input wire [7:0] data_in
   // ,  output reg [7:0] data_out  
);
// 8x4-bit memory matrix==> arr[16][8]
reg [7:0] memory [0:15];  // 16 memory locations and one location 8 bit
    // Initialize memory array with desired values
   initial begin
    // Initialize memory array with desired values
    memory[0]  = 8'h00; memory[1]  = 8'h00; memory[2]  = 8'h00; memory[3]  = 8'h00;
    memory[4]  = 8'h00; memory[5]  = 8'h00; memory[6]  = 8'h00; memory[7]  = 8'h00;
    memory[8]  = 8'h00; memory[9]  = 8'h00; memory[10] = 8'h00; memory[11] = 8'h00;
    memory[12] = 8'h00; memory[13] = 8'h00; memory[14] = 8'h00; memory[15] = 8'h00;
end


always @ (posedge clk)
begin
    // if (read)
    //     data_out <= memory[addr]; // Read data from memory 
     if(write)
        memory[addr] <= data_in;  // Write data to memory 
end

endmodule



