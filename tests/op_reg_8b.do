rm -rf work
vlib work
vcom +cover=sbceft op_register_8b.vhd
vcom +cover=bceft tests/tb_op_register_8b.vhd
vsim -i -coverage work.tb_op_register_8b
add wave *
run 60000 ns
