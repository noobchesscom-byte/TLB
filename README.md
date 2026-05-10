1.How to run
iverilog -o sim.out \
 tb/cpu_tb.v \
 rtl/core/*.v \
 rtl/pipeline/*.v \
 rtl/top/*.v \
 rtl/memory/*.v
2.Structure 
.
├── rtl
│   ├── core
│   │   ├── alu.v
│   │   ├── control_unit.v
│   │   ├── control_unit.v.save
│   │   ├── forwarding_unit.v
│   │   ├── hazard_unit.v
│   │   ├── instruction_decode.v
│   │   ├── pc.v
│   │   ├── regfile.v
│   │   ├── regfile.v.save
│   │   ├── sign_extend.v
│   │   └── tlb.v
│   ├── memory
│   │   ├── dmem.v
│   │   ├── imem.v
│   │   └── instruction_memory_system.v
│   ├── pipeline
│   │   ├── ex_mem.v
│   │   ├── id_ex.v
│   │   ├── if_id.v
│   │   └── mem_wb.v
│   └── top
│       ├── cpu.v
│       ├── execute_stage.v
│       └── if_stage.v
├── sim.out
├── tb
│   ├── alu_tb.v
│   ├── cpu_tb.v
│   ├── decode_tb.v
│   ├── dmem_tb.v
│   ├── execute_stage_tb.v
│   ├── if_stage_tb.v
│   ├── imem_tb.v
│   ├── pc_tb.v
│   └── regfile_tb.v
└── waveforms
    ├── alu.vcd
    ├── cpu.vcd
    ├── decode.vcd
    ├── dmem.vcd
    ├── execute_stage.vcd
    ├── if_stage.vcd
    ├── imem.vcd
    ├── pc.vcd
    └── regfile.vcd
