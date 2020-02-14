# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {Common-41} -limit 4294967295
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.cache/wt [current_project]
set_property parent.project_path C:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys4:part0:1.1 [current_project]
add_files -quiet C:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.runs/Clock_manager_synth_1/Clock_manager.dcp
set_property used_in_implementation false [get_files C:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.runs/Clock_manager_synth_1/Clock_manager.dcp]
read_vhdl -library xil_defaultlib {
  C:/Users/maucher/Desktop/EN217_Processor/src/common/REG_8.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/UC/PC.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/UC/MUX_6.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/UC/FSM.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/UT/CARRY.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/UT/ALU.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/UT/UT.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/UC/UC.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/UM/UM.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/acces_carte.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/CPU.vhd
  C:/Users/maucher/Desktop/EN217_Processor/src/CPU_top_level.vhd
}
read_xdc C:/Users/maucher/Desktop/EN217_Processor/src/Nexys4_CPU.xdc
set_property used_in_implementation false [get_files C:/Users/maucher/Desktop/EN217_Processor/src/Nexys4_CPU.xdc]

synth_design -top CPU_8bits -part xc7a100tcsg324-1
write_checkpoint -noxdef CPU_8bits.dcp
catch { report_utilization -file CPU_8bits_utilization_synth.rpt -pb CPU_8bits_utilization_synth.pb }