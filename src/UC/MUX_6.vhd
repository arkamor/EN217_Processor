library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_6 is
    Port ( 
        sel    : in  STD_LOGIC;
        M_in_a : in  STD_LOGIC_VECTOR (5 downto 0);
        M_in_b : in  STD_LOGIC_VECTOR (5 downto 0);
        M_out  : out STD_LOGIC_VECTOR (5 downto 0)
    );
end MUX_6;

architecture Behavioral of MUX_6 is
begin

   M_out <= M_in_a when (sel = '1') else M_in_b;

end Behavioral;