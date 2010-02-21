-- $Id: $
-- File name:   tb_8bit_op_register.vhd
-- Created:     2/21/2010
-- Author:      Micah Fivecoate
-- Lab Section: 337-04
-- Version:     1.0  Initial Test Bench

library ieee;
--library gold_lib;   --UNCOMMENT if you're using a GOLD model
use ieee.std_logic_1164.all;
--use gold_lib.all;   --UNCOMMENT if you're using a GOLD model

entity tb_op_register_8b is
end tb_op_register_8b;

architecture TEST of tb_op_register_8b is

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

  component op_register_8b
    PORT(
         clk : in std_logic;
         rst : in std_logic;
         op : in std_logic_vector(2 downto 0);
         in_en : in std_logic_vector(7 downto 0);
         data_in : in std_logic_vector(7 downto 0);
         data_out : out std_logic_vector(7 downto 0)
    );
  end component;

-- Insert signals Declarations here
  signal clk : std_logic;
  signal rst : std_logic;
  signal op : std_logic_vector(2 downto 0);
  signal in_en : std_logic_vector(7 downto 0);
  signal data_in : std_logic_vector(7 downto 0);
  signal data_out : std_logic_vector(7 downto 0);

-- signal <name> : <type>;

begin
  DUT: op_register_8b port map(
                clk => clk,
                rst => rst,
                op => op,
                in_en => in_en,
                data_in => data_in,
                data_out => data_out
                );

--   GOLD: <GOLD_NAME> port map(<put mappings here>);

process
  procedure tick is
  begin
    wait for 2 ns;
    clk <= '1';
    wait for 2 ns;
    clk <= '0';
  end procedure;

  procedure multitick(
    constant count : integer)
  is begin
    for i in count downto 0 loop
      tick;
    end loop;
  end multitick;

  begin
-- Insert TEST BENCH Code Here

    clk <= '0';
    rst <= '1';
    op <= "000";
    in_en <= "00000000";
    data_in <= "00000000";

    tick;
    rst <= '0';

    -- shift left
    op <= "010";
    in_en <= "00000001";
    data_in <= "00000001";
    multitick(7);
    data_in <= "00000000";
    in_en <= "00001001";
    multitick(4);

    -- shift right
    op <= "011";
    in_en <=   "10001000";
    data_in <= "10001000";
    multitick(3);
    data_in <= "00000000";
    multitick(3);

    -- count up
    op <= "001";
    rst <= '1';
    tick;
    rst <= '0';
    in_en <= "00000000";
    multitick(20);

  end process;
end TEST;
