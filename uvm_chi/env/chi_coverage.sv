class chi_coverage extends uvm_component;
  `uvm_component_utils(chi_coverage)

  uvm_analysis_imp #(chi_item, chi_coverage) analysis_export;
  chi_item sample_tr;

  covergroup chi_cg;
    option.per_instance = 1;

    cp_opcode: coverpoint sample_tr.opcode;
    cp_txn:    coverpoint sample_tr.txn_type;
    cp_qos:    coverpoint sample_tr.qos { bins legal[] = {[0:15]}; }
    cp_resp:   coverpoint sample_tr.resp;

    x_opcode_txn: cross cp_opcode, cp_txn;
    x_txn_resp:   cross cp_txn, cp_resp;
  endgroup

  function new(string name = "chi_coverage", uvm_component parent = null);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
    chi_cg = new();
  endfunction

  function void write(chi_item tr);
    sample_tr = tr;
    chi_cg.sample();
  endfunction
endclass
