set_property SRC_FILE_INFO {cfile:c:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.srcs/sources_1/ip/Clock_manager/Clock_manager.xdc rfile:../../../project_1.srcs/sources_1/ip/Clock_manager/Clock_manager.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:56 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in]] 0.1
