module Data_Generator_tb;

// Testbench signals
reg clk;
reg reset;
reg mode;
wire [7:0] data_out;

// Instantiate the Data Generator
Data_Generator uut (
    .clk(clk),
    .reset(reset),
    .mode(mode),
    .data_out(data_out)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10 ns clock period
end

// Test process
initial begin
    // Initialize inputs
    reset = 1;
    mode = 0;
    #20;
    
    // Release reset
    reset = 0;
    
    // Test case 1: Sequential mode (mode = 0)
    mode = 0;
    #100;  // Wait for some clock cycles to observe sequential data
    
    // Test case 2: Random mode (mode = 1)
    mode = 1;
    #100;  // Wait for some clock cycles to observe random data
    
    // Test case 3: Apply reset
    reset = 1;
    #10;
    reset = 0;
    mode = 0;  // Return to sequential mode
    #100;
    
    // End simulation
    $stop;
end

endmodule
