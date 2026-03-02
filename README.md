# UVM CHI Verification Skeleton

这是一个可扩展的 UVM 验证框架示例，用于覆盖 CHI 协议验证中的核心能力（激励、监测、检查、覆盖率与场景组织）。

## 目录结构

- `uvm_chi/tb/chi_if.sv`：简化版 CHI 信号接口
- `uvm_chi/agent/*`：transaction / sequencer / driver / monitor / agent
- `uvm_chi/env/*`：scoreboard + functional coverage + env
- `uvm_chi/seq/chi_basic_seq.sv`：基础随机 + corner 场景序列
- `uvm_chi/tb/chi_test.sv`：base test + full function test
- `uvm_chi/tb/top.sv`：仿真顶层

## 当前已实现的“全功能验证”骨架能力

1. **事务级建模**：CHI transaction 字段、约束、随机延迟。
2. **主动激励**：driver 按 valid/ready 握手发包。
3. **被动观测**：monitor 在握手成功时抓取事务。
4. **一致性检查**：scoreboard 对地址对齐/QoS/路由场景做检查。
5. **功能覆盖**：opcode/txn_type/qos/resp 以及关键 cross coverage。
6. **场景编排**：基础随机与 corner case 联合运行。

## 如何扩展到项目级“CHI 全协议验证”

- 增加 CHI 五通道（REQ/RSP/SNP/DAT/CRD）的独立 agent 与时序关系检查。
- 引入 reference model（目录一致性、缓存状态迁移、原子/屏障语义）。
- 增加 protocol checker（ACE/CHI ordering, hazard, QoS fairness, retry/timeout）。
- 增加 error injection（ECC/parity, poisoned data, malformed packet）。
- 建立覆盖率收敛策略：feature coverage + scenario coverage + assertion coverage。

## 运行示例（按你的仿真器调整）

```bash
# 以 VCS 为例（示意）
vcs -sverilog -ntb_opts uvm \
  uvm_chi/tb/chi_if.sv \
  uvm_chi/tb/chi_pkg.sv \
  uvm_chi/tb/top.sv \
  -o simv

./simv +UVM_TESTNAME=chi_full_func_test
```

> 说明：该仓库提供的是“可直接扩展的完整框架代码”，便于你快速落地 CHI 全功能验证平台。
