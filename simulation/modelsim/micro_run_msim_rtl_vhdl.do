transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {/home/duarte/repomipsogait/src/datapath.vhd}
vcom -93 -work work {/home/duarte/repomipsogait/src/mux.vhd}
vcom -93 -work work {/home/duarte/repomipsogait/src/pc.vhd}
vcom -93 -work work {/home/duarte/repomipsogait/src/registers.vhd}
vcom -93 -work work {/home/duarte/repomipsogait/src/alu.vhd}
vcom -93 -work work {/home/duarte/repomipsogait/src/signal_extender.vhd}
vcom -93 -work work {/home/duarte/repomipsogait/src/IMemory.vhd}
vcom -93 -work work {/home/duarte/repomipsogait/src/DMemory.vhd}

vcom -93 -work work {/home/duarte/repomipsogait/src/datapath_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  datapath_tb

add wave *
view structure
view signals
run -all
