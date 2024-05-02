`timescale 1ns / 1ps
`include "Main.v"
module Micro_Computer_tb;

    // Inputs
    reg clk;

    // Instantiate the Micro_Computer module
    Micro_Computer uut (
        .clk(clk)
    );

    // Clock generation
 initial begin
 forever clk = ~clk;
  end;


    // Initial values
    initial begin
        clk = 0; // Initialize clock
        #100; // Run simulation for 100 ns
        $finish; // End simulation
    end

endmodule
