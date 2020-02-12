library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PC_tb is
end;

architecture bench of PC_tb is

  component PC
      Port ( 
          ce   : in STD_LOGIC;
          clk  : in STD_LOGIC;
          rst  : in STD_LOGIC;
          load : in STD_LOGIC;
          enable : in STD_LOGIC;
          PC_in  : in  STD_LOGIC_VECTOR (5 DOWNTO 0);
          PC_out : out STD_LOGIC_VECTOR (5 DOWNTO 0)
      );
  end component;

  signal ce: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal load: STD_LOGIC;
  signal enable: STD_LOGIC;
  signal PC_in: STD_LOGIC_VECTOR (5 DOWNTO 0);
  signal PC_out: STD_LOGIC_VECTOR (5 DOWNTO 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: PC port map ( ce     => ce,
                     clk    => clk,
                     rst    => rst,
                     load   => load,
                     enable   => enable,
                     PC_in  => PC_in,
                     PC_out => PC_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
      load <= '0';
      rst<='0';

    -- Put test bench stimulus code here
    rst<='1';
    wait for clock_period;
    rst<='0';
    wait for clock_period;
    enable <= '1';
    wait for clock_period;
    enable <= '0';
    PC_in <= "101010";
    load <= '1';
    wait for clock_period;
    load <= '0';
    enable <= '1';

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
  
