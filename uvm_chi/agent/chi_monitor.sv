class chi_monitor extends uvm_component;
  `uvm_component_utils(chi_monitor)

  virtual chi_if vif;
  uvm_analysis_port #(chi_item) ap;

  function new(string name = "chi_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual chi_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Cannot get chi_if vif from config_db")
    end
  endfunction

  task run_phase(uvm_phase phase);
    chi_item tr;
    forever begin
      @(posedge vif.clk);
      if (vif.rst_n && vif.valid && vif.ready) begin
        tr = chi_item::type_id::create("tr");
        tr.opcode   = vif.opcode;
        tr.txn_type = vif.txn_type;
        tr.addr     = vif.addr;
        tr.data     = vif.data;
        tr.src_id   = vif.src_id;
        tr.tgt_id   = vif.tgt_id;
        tr.qos      = vif.qos;
        tr.resp     = vif.resp;
        ap.write(tr);
      end
    end
  endtask
endclass
