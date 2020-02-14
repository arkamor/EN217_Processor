-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FSM_tb is
end;

architecture bench of FSM_tb is

  component FSM
      PORT (
          clk : in std_logic;
          ce  : in std_logic;
          rst : in std_logic;
          OP  : in std_logic_vector(1 downto 0);
          Load_Accu  : out std_logic;
          Sig_ctrl   : out std_logic;
          Init_Carry : out std_logic;
          Load_Carry : out std_logic;
          Load_data  : out std_logic;
          Carry      : in  std_logic;
          Reg_load   : out std_logic;
          Mux_sel    : out std_logic;
          PC_load    : out std_logic;
          PC_en      : out std_logic;
          PC_rst     : out std_logic;
          RAM_RW     : out std_logic;
          RAM_EN     : out std_logic
      );
  end component;

  signal clk: std_logic;
  signal ce: std_logic;
  signal rst: std_logic;
  signal OP: std_logic_vector(1 downto 0);
  signal Load_Accu: std_logic;
  signal Sig_ctrl: std_logic;
  signal Init_Carry: std_logic;
  signal Load_Carry: std_logic;
  signal Load_data: std_logic;
  signal Carry: std_logic;
  signal Reg_load: std_logic;
  signal Mux_sel: std_logic;
  signal PC_load: std_logic;
  signal PC_en: std_logic;
  signal PC_rst: std_logic;
  signal RAM_RW: std_logic;
  signal RAM_EN: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: FSM port map ( clk        => clk,
                      ce         => ce,
                      rst        => rst,
                      OP         => OP,
                      Load_Accu  => Load_Accu,
                      Sig_ctrl   => Sig_ctrl,
                      Init_Carry => Init_Carry,
                      Load_Carry => Load_Carry,
                      Load_data  => Load_data,
                      Carry      => Carry,
                      Reg_load   => Reg_load,
                      Mux_sel    => Mux_sel,
                      PC_load    => PC_load,
                      PC_en      => PC_en,
                      PC_rst     => PC_rst,
                      RAM_RW     => RAM_RW,
                      RAM_EN     => RAM_EN );

  stimulus: process
  begin
  
    -- Put initialisation code here

    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 5 ns;
    
    -- Put test bench stimulus code here

    wait for clock_period;
    while (PC_en = '0') loop
        wait for clock_period;
    end loop;
    OP <= "00";
    
    wait for clock_period;
    while (PC_en = '0') loop
        wait for clock_period;
    end loop;
    OP <= "01";
    
    wait for clock_period;
    while (PC_en = '0') loop
        wait for clock_period;
    end loop;
    OP <= "10";

    wait for clock_period;
    while (PC_en = '0') loop
        wait for clock_period;
    end loop;
    OP <= "11";
    
    
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