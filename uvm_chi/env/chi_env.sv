class chi_env extends uvm_env;
  `uvm_component_utils(chi_env)

  chi_agent      req_agent;
  chi_scoreboard scb;
  chi_coverage   cov;

  function new(string name = "chi_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    req_agent = chi_agent::type_id::create("req_agent", this);
    scb       = chi_scoreboard::type_id::create("scb", this);
    cov       = chi_coverage::type_id::create("cov", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    req_agent.mon.ap.connect(scb.analysis_export);
    req_agent.mon.ap.connect(cov.analysis_export);
  endfunction
endclass
