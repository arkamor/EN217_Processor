library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity REG_8 is
    Port (
        val_in  : in STD_LOGIC_VECTOR (7 downto 0);

        load    : in STD_LOGIC;
        clk     : in STD_LOGIC;
        rst     : in STD_LOGIC;

        val_out : out STD_LOGIC_VECTOR (7 downto 0)
    );
end REG_8;

architecture Behavioral of REG_8 is

signal reg : std_logic_vector(8 downto 0) := "00000000";

begin

process (clk, rst) is
begin

    IF (clk = '1' AND clk'event) THEN
        IF(rst = '0') THEN
            reg <= "00000000";
        ELSIF (load = '1') THEN
            reg <= val_in;
        END IF;
    END IF;

end process;

val_out <= reg;

end Behavioral;
