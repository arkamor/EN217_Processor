library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    Port (Sig_ctrl : in  STD_LOGIC;
          carry : out  STD_LOGIC;
          Reg_data : in STD_LOGIC_VECTOR (7 downto 0);
          Reg_accu : in STD_LOGIC_VECTOR (7 downto 0);
          Alu_out : out STD_LOGIC_VECTOR (7 downto 0));
end alu;

architecture Behavioral of alu is

   signal reg : std_logic_vector(8 downto 0) := '000000000';

begin

   alu : process(Sig_ctrl, Reg_data, Reg_accu)
   begin

      if(Sig_ctrl == '1') then
         -- NOR
         Reg_accu <= Reg_accu NOR Reg_data;
      else then
         -- ADD
         reg <= Reg_accu + Reg_data;
         carry <= reg(8);
         Reg_accu <= reg(7 downto 0);
      end if;

   end process alu;

end Behavioral;