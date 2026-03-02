class chi_driver extends uvm_driver #(chi_item);
  `uvm_component_utils(chi_driver)

  virtual chi_if vif;

  function new(string name = "chi_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual chi_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Cannot get chi_if vif from config_db")
    end
  endfunction

  task run_phase(uvm_phase phase);
    chi_item req;
    reset_signals();
    forever begin
      seq_item_port.get_next_item(req);
      drive_item(req);
      seq_item_port.item_done();
    end
  endtask

  task reset_signals();
    vif.valid    <= 0;
    vif.opcode   <= '0;
    vif.txn_type <= '0;
    vif.addr     <= '0;
    vif.data     <= '0;
    vif.src_id   <= '0;
    vif.tgt_id   <= '0;
    vif.qos      <= '0;
    vif.resp     <= '0;
    wait(vif.rst_n === 1'b1);
  endtask

  task drive_item(chi_item req);
    repeat(req.delay_cycles) @(posedge vif.clk);

    @(posedge vif.clk);
    vif.valid    <= 1'b1;
    vif.opcode   <= req.opcode;
    vif.txn_type <= req.txn_type;
    vif.addr     <= req.addr;
    vif.data     <= req.data;
    vif.src_id   <= req.src_id;
    vif.tgt_id   <= req.tgt_id;
    vif.qos      <= req.qos;
    vif.resp     <= req.resp;

    do @(posedge vif.clk); while (!vif.ready);
    vif.valid <= 1'b0;
  endtask
endclass
