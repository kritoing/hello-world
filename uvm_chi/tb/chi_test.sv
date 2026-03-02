class chi_base_test extends uvm_test;
  `uvm_component_utils(chi_base_test)

  chi_env env;

  function new(string name = "chi_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = chi_env::type_id::create("env", this);
  endfunction
endclass

class chi_full_func_test extends chi_base_test;
  `uvm_component_utils(chi_full_func_test)

  function new(string name = "chi_full_func_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    chi_basic_seq  basic_seq;
    chi_corner_seq corner_seq;

    phase.raise_objection(this);

    basic_seq = chi_basic_seq::type_id::create("basic_seq");
    corner_seq = chi_corner_seq::type_id::create("corner_seq");

    basic_seq.start(env.req_agent.sqr);
    corner_seq.start(env.req_agent.sqr);

    #100ns;
    phase.drop_objection(this);
  endtask
endclass
