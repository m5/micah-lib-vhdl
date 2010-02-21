-- $Id: $
-- File name:   tb_matcher_8b.vhd
-- Created:     2/21/2010
-- Author:      Micah Fivecoate
-- Lab Section: 337-04
-- Version:     1.0  Initial Test Bench

library ieee;
--library gold_lib;   --UNCOMMENT if you're using a GOLD model
use ieee.std_logic_1164.all;
--use gold_lib.all;   --UNCOMMENT if you're using a GOLD model

entity tb_matcher_8b is
end tb_matcher_8b;

architecture TEST of tb_matcher_8b is

  function INT_TO_STD_LOGIC( X: INTEGER; NumBits: INTEGER )
     return STD_LOGIC_VECTOR is
    variable RES : STD_LOGIC_VECTOR(NumBits-1 downto 0);
    variable tmp : INTEGER;
  begin
    tmp := X;
    for i in 0 to NumBits-1 loop
      if (tmp mod 2)=1 then
        res(i) := '1';
      else
        res(i) := '0';
      end if;
      tmp := tmp/2;
    end loop;
    return res;
  end;

  component matcher_8b
    PORT(
         pattern : in std_logic_vector(7 downto 0);
         data : in std_logic_vector(7 downto 0);
         matches : out std_logic
    );
  end component;

-- Insert signals Declarations here
  signal pattern : std_logic_vector(7 downto 0);
  signal data : std_logic_vector(7 downto 0);
  signal matches : std_logic;

-- signal <name> : <type>;

begin
  DUT: matcher_8b port map(
                pattern => pattern,
                data => data,
                matches => matches
                );

--   GOLD: <GOLD_NAME> port map(<put mappings here>);

process is
  procedure test_pattern(
    constant mpat : std_logic_vector(7 downto 0);
    constant mmat : std_logic_vector(7 downto 0)
    ) is
  begin
    pattern <= mpat;
    wait for 2 ns;
    data <= mmat;
    wait for 2 ns;
  end test_pattern;

  begin

    pattern <= b"00000000";
    data <= b"00000000";

    test_pattern(b"00000000",b"11111111");
    test_pattern(b"11111111",b"00000000");
    test_pattern(b"01010101",b"10101010");
    test_pattern(b"11001100",b"11001100");
    test_pattern(b"00101101",b"00101100");
    test_pattern(b"00101100",b"01000010");
    wait;
  end process;
end TEST;
