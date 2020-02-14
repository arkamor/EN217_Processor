// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Fri Feb 14 11:31:18 2020
// Host        : zico running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/maucher/Desktop/EN217_Processor/vivado/project_1/project_1.srcs/sources_1/ip/Clock_manager/Clock_manager_stub.v
// Design      : Clock_manager
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module Clock_manager(clk_in, clk_out)
/* synthesis syn_black_box black_box_pad_pin="clk_in,clk_out" */;
  input clk_in;
  output clk_out;
endmodule
