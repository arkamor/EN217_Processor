library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity alu_tb is
end;

architecture bench of alu_tb is

  component alu
      Port (Sig_ctrl : in  STD_LOGIC;
            carry : out  STD_LOGIC;
            Reg_data : in STD_LOGIC_VECTOR (7 downto 0);
            Reg_accu : in STD_LOGIC_VECTOR (7 downto 0);
            Alu_out : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  signal Sig_ctrl: STD_LOGIC;
  signal carry: STD_LOGIC;
  signal Reg_data: STD_LOGIC_VECTOR (7 downto 0);
  signal Reg_accu: STD_LOGIC_VECTOR (7 downto 0);
  signal Alu_out: STD_LOGIC_VECTOR (7 downto 0);

begin

  uut: alu port map ( Sig_ctrl => Sig_ctrl,
                      carry    => carry,
                      Reg_data => Reg_data,
                      Reg_accu => Reg_accu,
                      Alu_out  => Alu_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
    Sig_ctrl<='0';
    Reg_data<="10101010";
    Reg_accu<="01010101";
    wait for 10ns;
    Sig_ctrl<='1';
    Reg_data<="00100111";
    Reg_accu<="00100111";
    wait for 10ns;
    Sig_ctrl<='0';
    Reg_data<="01001100";
    Reg_accu<="00100111";
    wait for 10ns;
    Sig_ctrl<='1';
    Reg_data<="10101010";
    Reg_accu<="11010101";
    wait for 10ns;

    -- Put test bench stimulus code here

    wait;
  end process;


end;