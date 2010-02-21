library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity 8bit_op_register is
  port(
    clk : in std_logic;
    rst : in std_logic;
    op : in std_logic_vector(2 downto 0);
    in_en : in std_logic_vector(7 downto 0);
    data_in : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0)
    );
end 8bit_op_register;

architecture behavioral of 8bit_op_register is
  signal reg_bus : std_logic_vector(7 downto 0);
  signal reg_state: std_logic_vector(7 downto 0);

  for i in reg_bus'length-1 downto 0 loop
    reg_bus(i) = data_in(i) when in_en(i) = '1' else reg_state(i);
  end loop;

  process(clk, rst, op, reg_bus) is
    if rst = '1' then
      reg_state <= (others => '0');
    elsif clk'event and clk = '1' then
      case op is
        "000" => reg_state <= reg_state;
        "001" => reg_state <= reg_bus + 1;
        "010" => reg_state <= sll reg_bus;
        "011" => reg_state <= srl reg_bus;
        "100" => reg_state <= rol reg_bus;
        "101" => reg_state <= ror reg_bus;
        "110" => reg_state <= reg_bus;
        others => reg_state <= reg_state;
      end case;
    end if;
  end process;
end behavioral;
