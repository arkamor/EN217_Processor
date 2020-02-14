proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common-41} -limit 4294967295
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7a100tcsg324-1
  set_property board_part digilentinc.com:nexys4:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.cache/wt [current_project]
  set_property parent.project_path C:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.xpr [current_project]
  set_property ip_repo_paths c:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.cache/ip [current_project]
  set_property ip_output_repo c:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.cache/ip [current_project]
  add_files -quiet C:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.runs/synth_1/CPU_8bits.dcp
  add_files -quiet C:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.runs/Clock_manager_synth_1/Clock_manager.dcp
  set_property netlist_only true [get_files C:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.runs/Clock_manager_synth_1/Clock_manager.dcp]
  read_xdc -mode out_of_context -ref Clock_manager -cells inst c:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.srcs/sources_1/ip/Clock_manager/Clock_manager_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.srcs/sources_1/ip/Clock_manager/Clock_manager_ooc.xdc]
  read_xdc -prop_thru_buffers -ref Clock_manager -cells inst c:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.srcs/sources_1/ip/Clock_manager/Clock_manager_board.xdc
  set_property processing_order EARLY [get_files c:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.srcs/sources_1/ip/Clock_manager/Clock_manager_board.xdc]
  read_xdc -ref Clock_manager -cells inst c:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.srcs/sources_1/ip/Clock_manager/Clock_manager.xdc
  set_property processing_order EARLY [get_files c:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.srcs/sources_1/ip/Clock_manager/Clock_manager.xdc]
  read_xdc C:/Users/maucher/Desktop/EN217_Processor/src/Nexys4_CPU.xdc
  link_design -top CPU_8bits -part xc7a100tcsg324-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force CPU_8bits_opt.dcp
  catch {report_drc -file CPU_8bits_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file CPU_8bits.hwdef}
  place_design 
  write_checkpoint -force CPU_8bits_placed.dcp
  catch { report_io -file CPU_8bits_io_placed.rpt }
  catch { report_utilization -file CPU_8bits_utilization_placed.rpt -pb CPU_8bits_utilization_placed.pb }
  catch { report_control_sets -verbose -file CPU_8bits_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force CPU_8bits_routed.dcp
  catch { report_drc -file CPU_8bits_drc_routed.rpt -pb CPU_8bits_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file CPU_8bits_timing_summary_routed.rpt -rpx CPU_8bits_timing_summary_routed.rpx }
  catch { report_power -file CPU_8bits_power_routed.rpt -pb CPU_8bits_power_summary_routed.pb }
  catch { report_route_status -file CPU_8bits_route_status.rpt -pb CPU_8bits_route_status.pb }
  catch { report_clock_utilization -file CPU_8bits_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

