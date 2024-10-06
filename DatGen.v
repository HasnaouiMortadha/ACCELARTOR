module Data_Generator (
    input clk,            // Clock signal
    input reset,          // Reset signal
    input mode,           // Mode signal: 0 for sequential, 1 for random data
    output reg [7:0] data_out // 8-bit data output
);

// Internal signal for random number generation (LFSR)
reg [7:0] lfsr;

// Sequential counter
reg [7:0] counter;

// Mode selection and data generation process
always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 8'd0;  // Reset sequential counter
        lfsr <= 8'h1;     // Reset LFSR with a non-zero seed
    end else begin
        if (mode == 1'b0) begin
            // Generate sequential data
            counter <= counter + 1;
            data_out <= counter;
        end else begin
            // Generate pseudo-random data using LFSR
            lfsr[0] <= lfsr[7];               // Shift bits
            lfsr[1] <= lfsr[0];
            lfsr[2] <= lfsr[1];
            lfsr[3] <= lfsr[2] ^ lfsr[7];     // XOR feedback for randomness
            lfsr[4] <= lfsr[3];
            lfsr[5] <= lfsr[4];
            lfsr[6] <= lfsr[5];
            lfsr[7] <= lfsr[6];
            data_out <= lfsr; // Output pseudo-random data
        end
    end
end

endmodule
