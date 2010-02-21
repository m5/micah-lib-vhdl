library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity 8bit_matcher is
  port(
    pattern : std_logic_vector(7 downto 0);
    data : std_logic_vector(7 downto 0);
    matches : std_logic
    );
end 8bit_matcher;

architecture dataflow of 8bit_matcher is
  matches <= '1' when data = pattern else '0';
end dataflow;
