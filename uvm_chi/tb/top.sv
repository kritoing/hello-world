`timescale 1ns/1ps

module top;
  import uvm_pkg::*;
  import chi_pkg::*;

  logic clk;
  logic rst_n;

  chi_if chi_vif(.clk(clk), .rst_n(rst_n));

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst_n = 0;
    repeat(10) @(posedge clk);
    rst_n = 1;
  end

  initial begin
    uvm_config_db#(virtual chi_if)::set(null, "*", "vif", chi_vif);
    run_test("chi_full_func_test");
  end
endmodule
