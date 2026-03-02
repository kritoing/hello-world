class chi_scoreboard extends uvm_component;
  `uvm_component_utils(chi_scoreboard)

  uvm_analysis_imp #(chi_item, chi_scoreboard) analysis_export;
  int unsigned total_txn;

  function new(string name = "chi_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
  endfunction

  function void write(chi_item tr);
    total_txn++;

    if (tr.addr[5:0] != 6'b0)
      `uvm_error(get_type_name(), $sformatf("Address not cacheline aligned: %h", tr.addr))

    if (!(tr.qos inside {[0:15]}))
      `uvm_error(get_type_name(), $sformatf("QoS out-of-range: %0d", tr.qos))

    if (tr.src_id == tr.tgt_id)
      `uvm_warning(get_type_name(), "src_id == tgt_id, check routing scenario")
  endfunction

  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Total observed CHI txns: %0d", total_txn), UVM_LOW)
  endfunction
endclass
