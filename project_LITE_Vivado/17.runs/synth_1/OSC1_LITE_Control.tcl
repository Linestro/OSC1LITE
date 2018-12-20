# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7a15tftg256-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.cache/wt [current_project]
set_property parent.project_path C:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.srcs/sources_1/imports/imports/DAC_spi_master.v
  {C:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.srcs/sources_1/imports/Program Files/Opal Kelly/FrontPanelUSB/FrontPanelHDL/XEM7001-A15/okCoreHarness.v}
  {C:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.srcs/sources_1/imports/Program Files/Opal Kelly/FrontPanelUSB/FrontPanelHDL/XEM7001-A15/okLibrary.v}
  {C:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.srcs/sources_1/imports/Program Files/Opal Kelly/FrontPanelUSB/FrontPanelHDL/XEM7001-A15/okWireIn.v}
  {C:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.srcs/sources_1/imports/Program Files/Opal Kelly/FrontPanelUSB/FrontPanelHDL/XEM7001-A15/okWireOut.v}
  C:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.srcs/sources_1/imports/imports/OSC1_LITE_one_channel_control.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.srcs/constrs_1/imports/Desktop/xem7001.xdc
set_property used_in_implementation false [get_files C:/Users/yoongroup/Documents/Adam/vivado/project_LITE/17.srcs/constrs_1/imports/Desktop/xem7001.xdc]


synth_design -top OSC1_LITE_Control -part xc7a15tftg256-1


write_checkpoint -force -noxdef OSC1_LITE_Control.dcp

catch { report_utilization -file OSC1_LITE_Control_utilization_synth.rpt -pb OSC1_LITE_Control_utilization_synth.pb }
