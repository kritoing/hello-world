class chi_basic_seq extends uvm_sequence #(chi_item);
  `uvm_object_utils(chi_basic_seq)

  rand int unsigned num_items;
  constraint c_num { num_items inside {[100:300]}; }

  function new(string name = "chi_basic_seq");
    super.new(name);
  endfunction

  task body();
    chi_item req;
    repeat(num_items) begin
      req = chi_item::type_id::create("req");
      start_item(req);
      if (!req.randomize() with {
          opcode inside {8'h01, 8'h02, 8'h10, 8'h11};
          txn_type inside {[0:8]};
          resp inside {[0:3]};
        }) begin
        `uvm_error(get_type_name(), "randomize failed for chi_basic_seq item")
      end
      finish_item(req);
    end
  endtask
endclass

class chi_corner_seq extends uvm_sequence #(chi_item);
  `uvm_object_utils(chi_corner_seq)

  function new(string name = "chi_corner_seq");
    super.new(name);
  endfunction

  task body();
    chi_item req;
    repeat(64) begin
      req = chi_item::type_id::create("corner_req");
      start_item(req);
      if (!req.randomize() with {
          opcode inside {8'hFF, 8'h00, 8'h7F};
          qos inside {0, 1, 14, 15};
          delay_cycles inside {[0:2]};
        }) begin
        `uvm_error(get_type_name(), "randomize failed for chi_corner_seq item")
      end
      finish_item(req);
    end
  endtask
endclass
