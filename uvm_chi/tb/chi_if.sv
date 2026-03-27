interface chi_if(input logic clk, input logic rst_n);
  logic         valid;
  logic         ready;
  logic [7:0]   opcode;
  logic [3:0]   txn_type;
  logic [47:0]  addr;
  logic [255:0] data;
  logic [15:0]  src_id;
  logic [15:0]  tgt_id;
  logic [7:0]   qos;
  logic [3:0]   resp;

  modport tx_mp (
    input  clk, rst_n, ready,
    output valid, opcode, txn_type, addr, data, src_id, tgt_id, qos, resp
  );

  modport rx_mp (
    input clk, rst_n, valid, opcode, txn_type, addr, data, src_id, tgt_id, qos, resp,
    output ready
  );
endinterface
