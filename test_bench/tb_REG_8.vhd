library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity REG_8_tb is
end;

architecture bench of REG_8_tb is

  component REG_8
      Port (
          val_in  : in STD_LOGIC_VECTOR (7 downto 0);
          load    : in STD_LOGIC;
          clk     : in STD_LOGIC;
          ce      : in STD_LOGIC;
          rst     : in STD_LOGIC;
          val_out : out STD_LOGIC_VECTOR (7 downto 0)
      );
  end component;

  signal val_in: STD_LOGIC_VECTOR (7 downto 0);
  signal load: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal ce: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal val_out: STD_LOGIC_VECTOR (7 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: REG_8 port map ( val_in  => val_in,
                        load    => load,
                        clk     => clk,
                        ce      => ce,
                        rst     => rst,
                        val_out => val_out );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

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