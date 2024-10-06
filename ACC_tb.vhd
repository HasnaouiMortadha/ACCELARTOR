module Data_Processing_Accelerator_tb;

// Signals for testing
reg clk;
reg reset;
reg [7:0] data_in1;
reg [7:0] data_in2;
wire [8:0] result;

// Instantiate the Data Processing Accelerator
Data_Processing_Accelerator uut (
    .clk(clk),
    .reset(reset),
    .data_in1(data_in1),
    .data_in2(data_in2),
    .result(result)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 ns clock period
end

// Test stimulus
initial begin
    // Initialize inputs
    reset = 1;
    data_in1 = 8'd0;
    data_in2 = 8'd0;
    
    // Apply reset
    #10;
    reset = 0;

    // Test case 1: Add 100 + 55
    data_in1 = 8'd100;
    data_in2 = 8'd55;
    #10; // Wait for one clock cycle

    // Test case 2: Add 200 + 100
    data_in1 = 8'd200;
    data_in2 = 8'd100;
    #10;

    // Test case 3: Add 255 + 1 (overflow test)
    data_in1 = 8'd255;
    data_in2 = 8'd1;
    #10;

    // Test case 4: Reset the system
    reset = 1;
    #10;
    reset = 0;

    // Test case 5: Add 50 + 75 after reset
    data_in1 = 8'd50;
    data_in2 = 8'd75;
    #10;

    // End simulation
    $stop;
end

endmodule

