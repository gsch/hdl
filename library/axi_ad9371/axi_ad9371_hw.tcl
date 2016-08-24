

package require -exact qsys 13.0
source ../scripts/adi_env.tcl
source ../scripts/adi_ip_alt.tcl

set_module_property NAME axi_ad9371
set_module_property DESCRIPTION "AXI AD9371 Interface"
set_module_property VERSION 1.0
set_module_property GROUP "Analog Devices"
set_module_property DISPLAY_NAME axi_ad9371

# files

add_fileset quartus_synth QUARTUS_SYNTH "" "Quartus Synthesis"
set_fileset_property quartus_synth TOP_LEVEL axi_ad9371
add_fileset_file ad_rst.v                   VERILOG PATH $ad_hdl_dir/library/common/ad_rst.v
add_fileset_file ad_mul.v                   VERILOG PATH $ad_hdl_dir/library/altera/common/ad_mul.v
add_fileset_file ad_dds_sine.v              VERILOG PATH $ad_hdl_dir/library/common/ad_dds_sine.v
add_fileset_file ad_dds_1.v                 VERILOG PATH $ad_hdl_dir/library/common/ad_dds_1.v
add_fileset_file ad_dds.v                   VERILOG PATH $ad_hdl_dir/library/common/ad_dds.v
add_fileset_file ad_datafmt.v               VERILOG PATH $ad_hdl_dir/library/common/ad_datafmt.v
add_fileset_file ad_dcfilter.v              VERILOG PATH $ad_hdl_dir/library/altera/common/ad_dcfilter.v
add_fileset_file ad_iqcor.v                 VERILOG PATH $ad_hdl_dir/library/common/ad_iqcor.v
add_fileset_file up_axi.v                   VERILOG PATH $ad_hdl_dir/library/common/up_axi.v
add_fileset_file up_xfer_cntrl.v            VERILOG PATH $ad_hdl_dir/library/common/up_xfer_cntrl.v
add_fileset_file up_xfer_status.v           VERILOG PATH $ad_hdl_dir/library/common/up_xfer_status.v
add_fileset_file up_clock_mon.v             VERILOG PATH $ad_hdl_dir/library/common/up_clock_mon.v
add_fileset_file up_adc_common.v            VERILOG PATH $ad_hdl_dir/library/common/up_adc_common.v
add_fileset_file up_adc_channel.v           VERILOG PATH $ad_hdl_dir/library/common/up_adc_channel.v
add_fileset_file up_dac_common.v            VERILOG PATH $ad_hdl_dir/library/common/up_dac_common.v
add_fileset_file up_dac_channel.v           VERILOG PATH $ad_hdl_dir/library/common/up_dac_channel.v
add_fileset_file axi_ad9371_if.v            VERILOG PATH axi_ad9371_if.v
add_fileset_file axi_ad9371_rx_channel.v    VERILOG PATH axi_ad9371_rx_channel.v
add_fileset_file axi_ad9371_rx.v            VERILOG PATH axi_ad9371_rx.v
add_fileset_file axi_ad9371_rx_os.v         VERILOG PATH axi_ad9371_rx_os.v
add_fileset_file axi_ad9371_tx_channel.v    VERILOG PATH axi_ad9371_tx_channel.v
add_fileset_file axi_ad9371_tx.v            VERILOG PATH axi_ad9371_tx.v
add_fileset_file axi_ad9371.v               VERILOG PATH axi_ad9371.v TOP_LEVEL_FILE
add_fileset_file ad_axi_ip_constr.sdc       SDC     PATH $ad_hdl_dir/library/common/ad_axi_ip_constr.sdc

# parameters

add_parameter ID INTEGER 0
set_parameter_property ID DEFAULT_VALUE 0
set_parameter_property ID DISPLAY_NAME ID
set_parameter_property ID TYPE INTEGER
set_parameter_property ID UNITS None
set_parameter_property ID HDL_PARAMETER true

add_parameter DAC_DATAPATH_DISABLE INTEGER 0
set_parameter_property DAC_DATAPATH_DISABLE DEFAULT_VALUE 0
set_parameter_property DAC_DATAPATH_DISABLE DISPLAY_NAME DAC_DATAPATH_DISABLE
set_parameter_property DAC_DATAPATH_DISABLE TYPE INTEGER
set_parameter_property DAC_DATAPATH_DISABLE UNITS None
set_parameter_property DAC_DATAPATH_DISABLE HDL_PARAMETER true

add_parameter ADC_DATAPATH_DISABLE INTEGER 0
set_parameter_property ADC_DATAPATH_DISABLE DEFAULT_VALUE 0
set_parameter_property ADC_DATAPATH_DISABLE DISPLAY_NAME ADC_DATAPATH_DISABLE
set_parameter_property ADC_DATAPATH_DISABLE TYPE INTEGER
set_parameter_property ADC_DATAPATH_DISABLE UNITS None
set_parameter_property ADC_DATAPATH_DISABLE HDL_PARAMETER true

# axi4 slave

add_interface s_axi_clock clock end
add_interface_port s_axi_clock s_axi_aclk clk Input 1

add_interface s_axi_reset reset end
set_interface_property s_axi_reset associatedClock s_axi_clock
add_interface_port s_axi_reset s_axi_aresetn reset_n Input 1

add_interface s_axi axi4lite end
set_interface_property s_axi associatedClock s_axi_clock
set_interface_property s_axi associatedReset s_axi_reset
add_interface_port s_axi s_axi_awvalid awvalid Input 1
add_interface_port s_axi s_axi_awaddr awaddr Input 16
add_interface_port s_axi s_axi_awprot awprot Input 3
add_interface_port s_axi s_axi_awready awready Output 1
add_interface_port s_axi s_axi_wvalid wvalid Input 1
add_interface_port s_axi s_axi_wdata wdata Input 32
add_interface_port s_axi s_axi_wstrb wstrb Input 4
add_interface_port s_axi s_axi_wready wready Output 1
add_interface_port s_axi s_axi_bvalid bvalid Output 1
add_interface_port s_axi s_axi_bresp bresp Output 2
add_interface_port s_axi s_axi_bready bready Input 1
add_interface_port s_axi s_axi_arvalid arvalid Input 1
add_interface_port s_axi s_axi_araddr araddr Input 16
add_interface_port s_axi s_axi_arprot arprot Input 3
add_interface_port s_axi s_axi_arready arready Output 1
add_interface_port s_axi s_axi_rvalid rvalid Output 1
add_interface_port s_axi s_axi_rresp rresp Output 2
add_interface_port s_axi s_axi_rdata rdata Output 32
add_interface_port s_axi s_axi_rready rready Input 1

# transceiver interface

ad_alt_intf clock   adc_clk         input   1
ad_alt_intf signal  adc_rx_data     input   64  data

ad_alt_intf clock   adc_os_clk      input   1
ad_alt_intf signal  adc_rx_os_data  input   64  data

ad_alt_intf clock   dac_clk         input   1
ad_alt_intf signal  dac_tx_data     output  128 data

# master/slave

ad_alt_intf signal  dac_sync_in     input   1
ad_alt_intf signal  dac_sync_out    output  1

# adc-channel interface

add_interface adc_ch_0 conduit end
add_interface_port adc_ch_0  adc_enable_i0  enable   Output  1
add_interface_port adc_ch_0  adc_valid_i0   valid    Output  1
add_interface_port adc_ch_0  adc_data_i0    data     Output  16

set_interface_property adc_ch_0 associatedClock if_adc_clk
set_interface_property adc_ch_0 associatedReset none

add_interface adc_ch_1 conduit end
add_interface_port adc_ch_1  adc_enable_q0  enable   Output  1
add_interface_port adc_ch_1  adc_valid_q0   valid    Output  1
add_interface_port adc_ch_1  adc_data_q0    data     Output  16

set_interface_property adc_ch_1 associatedClock if_adc_clk
set_interface_property adc_ch_1 associatedReset none

add_interface adc_ch_2 conduit end
add_interface_port adc_ch_2  adc_enable_i1  enable   Output  1
add_interface_port adc_ch_2  adc_valid_i1   valid    Output  1
add_interface_port adc_ch_2  adc_data_i1    data     Output  16

set_interface_property adc_ch_2 associatedClock if_adc_clk
set_interface_property adc_ch_2 associatedReset none

add_interface adc_ch_3 conduit end
add_interface_port adc_ch_3  adc_enable_q1  enable   Output  1
add_interface_port adc_ch_3  adc_valid_q1   valid    Output  1
add_interface_port adc_ch_3  adc_data_q1    data     Output  16

set_interface_property adc_ch_3 associatedClock if_adc_clk
set_interface_property adc_ch_3 associatedReset none

ad_alt_intf signal  adc_dovf      input   1 ovf
ad_alt_intf signal  adc_dunf      input   1 unf

# adc-os-channel interface

add_interface adc_os_ch_0 conduit end
add_interface_port adc_os_ch_0  adc_os_enable_i0  enable   Output  1
add_interface_port adc_os_ch_0  adc_os_valid_i0   valid    Output  1
add_interface_port adc_os_ch_0  adc_os_data_i0    data     Output  32

set_interface_property adc_os_ch_0 associatedClock if_adc_os_clk
set_interface_property adc_os_ch_0 associatedReset none

add_interface adc_os_ch_1 conduit end
add_interface_port adc_os_ch_1  adc_os_enable_q0  enable   Output  1
add_interface_port adc_os_ch_1  adc_os_valid_q0   valid    Output  1
add_interface_port adc_os_ch_1  adc_os_data_q0    data     Output  32

set_interface_property adc_os_ch_1 associatedClock if_adc_os_clk
set_interface_property adc_os_ch_1 associatedReset none

ad_alt_intf signal  adc_os_dovf      input   1 ovf
ad_alt_intf signal  adc_os_dunf      input   1 unf

# dac-channel interface

add_interface dac_ch_0 conduit end
add_interface_port dac_ch_0  dac_enable_i0  enable   Output  1
add_interface_port dac_ch_0  dac_valid_i0   valid    Output  1
add_interface_port dac_ch_0  dac_data_i0    data     Input   32

set_interface_property dac_ch_0 associatedClock if_dac_clk
set_interface_property dac_ch_0 associatedReset none

add_interface dac_ch_1 conduit end
add_interface_port dac_ch_1  dac_enable_q0  enable   Output  1
add_interface_port dac_ch_1  dac_valid_q0   valid    Output  1
add_interface_port dac_ch_1  dac_data_q0    data     Input   32

set_interface_property dac_ch_1 associatedClock if_dac_clk
set_interface_property dac_ch_1 associatedReset none

add_interface dac_ch_2 conduit end
add_interface_port dac_ch_2  dac_enable_i1  enable   Output  1
add_interface_port dac_ch_2  dac_valid_i1   valid    Output  1
add_interface_port dac_ch_2  dac_data_i1    data     Input   32

set_interface_property dac_ch_2 associatedClock if_dac_clk
set_interface_property dac_ch_2 associatedReset none

add_interface dac_ch_3 conduit end
add_interface_port dac_ch_3  dac_enable_q1  enable   Output  1
add_interface_port dac_ch_3  dac_valid_q1   valid    Output  1
add_interface_port dac_ch_3  dac_data_q1    data     Input   32

set_interface_property dac_ch_3 associatedClock if_dac_clk
set_interface_property dac_ch_3 associatedReset none

ad_alt_intf signal  dac_dovf      input   1 ovf
ad_alt_intf signal  dac_dunf      input   1 unf
