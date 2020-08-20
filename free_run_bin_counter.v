`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2020 11:01:47 AM
// Design Name: 
// Module Name: running_binary_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module free_run_bin_counter
 #(parameter N=8)(
 input clk, reset,
 output wire max_tick,
 output wire [N-1:0] q);
// signal declaration
reg [N-1:0] r_reg;
wire [N-1:0] r_next;
// body or register
always@(posedge clk, posedge reset )
 if(reset)
 r_reg <= 0;
 else
 r_reg <= r_next;
// next_state_logic
assign r_next = r_reg + 1;
// output logic
assign q = r_reg;
assign max_tick = (r_reg == 2**N-1) ? 1'b1 : 1'b0;
endmodule


module test();
parameter N=8;

 reg clk, reset;
 wire max_tick;
 wire [N-1:0] q;
 
 
 initial
 clk = 0;
 always
 #10 clk = ~ clk;
 
 initial
 begin
    // testing reset for N clock cycles 
    //r_next = 8'b0000_0001; 
    reset  = 0;
    @(negedge clk) reset = 1;
    repeat (2**N) @(negedge clk) reset = 0;
    wait(max_tick == 1);

    $stop;
     
 end

free_run_bin_counter inst0(clk, reset, max_tick,  q );

endmodule 

