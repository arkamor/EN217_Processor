library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ram_tb is
end;

architecture bench of ram_tb is

  component ram
  	PORT(
  		clk		 : IN  STD_LOGIC;
  		ce       : IN  STD_LOGIC;
  		rw       : IN  STD_LOGIC;
  		enable   : IN  STD_LOGIC;
  		addr	 : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
  		data_in	 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
  		data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  	);
  end component;

  signal clk: STD_LOGIC;
  signal ce: STD_LOGIC;
  signal rw: STD_LOGIC;
  signal enable: STD_LOGIC;
  signal addr: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal data_in: STD_LOGIC_VECTOR(7 DOWNTO 0);
  signal data_out: STD_LOGIC_VECTOR(7 DOWNTO 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: ram port map ( clk      => clk,
                      ce       => ce,
                      rw       => rw,
                      enable   => enable,
                      addr     => addr,
                      data_in  => data_in,
                      data_out => data_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
   ce <= '0';
   rw <= '0';
   enable <= '0';
   wait for clock_period;

    -- Put test bench stimulus code here
    ce <= '1';
    wait for clock_period;
    rw <= '1';
    addr <= STD_LOGIC_VECTOR(to_unsigned(31, 8));
    data_in <= STD_LOGIC_VECTOR(to_unsigned(05, 8));
    wait for clock_period;
    rw <= '1';
    addr <= STD_LOGIC_VECTOR(to_unsigned(12, 8));
    data_in <= STD_LOGIC_VECTOR(to_unsigned(08, 8));
    wait for clock_period;
    rw <= '0';
    enable <= '1';
    addr <= STD_LOGIC_VECTOR(to_unsigned(22, 8));
    wait for clock_period;
    addr <= STD_LOGIC_VECTOR(to_unsigned(31, 8));
    wait for clock_period;
    addr <= STD_LOGIC_VECTOR(to_unsigned(12, 8));

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