package chi_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "agent/chi_item.sv"
  `include "agent/chi_sequencer.sv"
  `include "agent/chi_driver.sv"
  `include "agent/chi_monitor.sv"
  `include "agent/chi_agent.sv"

  `include "env/chi_scoreboard.sv"
  `include "env/chi_coverage.sv"
  `include "env/chi_env.sv"

  `include "seq/chi_basic_seq.sv"

  `include "tb/chi_test.sv"
endpackage
