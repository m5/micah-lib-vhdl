library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity 8bit_alu is
  port(
    A : in std_logic_vector(7 downto 0);
    B : in std_logic_vector(7 downto 0);
    op : in std_logic_vector(3 downto 0)
    ret : out std_logic_vector(7 downto 0);
    cc : out std_logic_vector(7 downto 0);
    );
end 8bit_alu;

architecture behavioral of 8bit_alu is
  process(A,B,op)
    case op is
      when '0000' => N <= (others=>0);
      when '0001' => N <= sll A;
      when '0010' => N <= srl A;
      when '0011' => N <= rol A;
      when '0100' => N <= ror A;
      when '0101' => N <= A + B;
    end case;
  end process;
end behavioral;
                   
