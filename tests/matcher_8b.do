rm -rf work
vlib work
vcom +cover=sbceft matcher_8b.vhd
vcom +cover=bceft tests/tb_matcher_8b.vhd
vsim -i -coverage work.tb_matcher_8b
add wave *
run 60000 ns
