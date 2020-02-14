library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port (
        Sig_ctrl : in  STD_LOGIC;
        carry : out  STD_LOGIC;
        Reg_data : in STD_LOGIC_VECTOR (7 downto 0);
        Reg_accu : in STD_LOGIC_VECTOR (7 downto 0);
        Alu_out : out STD_LOGIC_VECTOR (7 downto 0)
    );
end ALU;

architecture Behavioral of ALU is

   signal reg : std_logic_vector(8 downto 0) := '000000000';

begin

    process(Sig_ctrl, Reg_data, Reg_accu)
    begin

        if(Sig_ctrl == '0') then
            -- NOR
            reg(7 downto 0) <= Reg_accu NOR Reg_data;
            reg(8) <= '0';
        else then
            -- ADD
            reg <= std_logic_vector(resize(unsigned(Reg_data), 9) + resize(unsigned(Reg_accu), 9));
        end if;

    end process;

    Reg_accu <= reg(7 downto 0);
    carry <= reg(8);

end Behavioral;