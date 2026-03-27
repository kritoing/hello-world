class chi_agent extends uvm_component;
  `uvm_component_utils(chi_agent)

  chi_sequencer sqr;
  chi_driver    drv;
  chi_monitor   mon;
  uvm_active_passive_enum is_active = UVM_ACTIVE;

  function new(string name = "chi_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active)) begin
      is_active = UVM_ACTIVE;
    end

    mon = chi_monitor::type_id::create("mon", this);
    if (is_active == UVM_ACTIVE) begin
      sqr = chi_sequencer::type_id::create("sqr", this);
      drv = chi_driver::type_id::create("drv", this);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(sqr.seq_item_export);
    end
  endfunction
endclass
