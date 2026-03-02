class chi_item extends uvm_sequence_item;
  rand bit [7:0]   opcode;
  rand bit [3:0]   txn_type;
  rand bit [47:0]  addr;
  rand bit [255:0] data;
  rand bit [15:0]  src_id;
  rand bit [15:0]  tgt_id;
  rand bit [7:0]   qos;
  rand bit [3:0]   resp;
  rand int unsigned delay_cycles;

  constraint c_addr_align { addr[5:0] == 0; }
  constraint c_qos        { qos inside {[0:15]}; }
  constraint c_delay      { delay_cycles inside {[0:20]}; }

  `uvm_object_utils_begin(chi_item)
    `uvm_field_int(opcode, UVM_ALL_ON)
    `uvm_field_int(txn_type, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(src_id, UVM_ALL_ON)
    `uvm_field_int(tgt_id, UVM_ALL_ON)
    `uvm_field_int(qos, UVM_ALL_ON)
    `uvm_field_int(resp, UVM_ALL_ON)
    `uvm_field_int(delay_cycles, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "chi_item");
    super.new(name);
  endfunction
endclass
