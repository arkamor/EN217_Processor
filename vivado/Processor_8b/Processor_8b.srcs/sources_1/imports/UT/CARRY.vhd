library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CARRY is
    Port (
        val_in  : in STD_LOGIC;

        init    : in STD_LOGIC;

        load    : in STD_LOGIC;
        clk     : in STD_LOGIC;
        rst     : in STD_LOGIC;
        ce      : in STD_LOGIC;

        val_out : out STD_LOGIC
    );
end CARRY;

architecture Behavioral of CARRY is

signal reg : STD_LOGIC := '0';

begin

process (clk, rst) is
begin

   IF (rst = '1') THEN
      reg <= '0';
   ELSIF( clk = '1' AND clk'event) THEN
      IF ( ce = '1') THEN
         IF (init = '1') THEN
            reg <= '0';
         IF (load = '1') THEN
            reg <= val_in;
         END IF;
      END IF;
   END IF;

end process;

val_out <= reg;

end Behavioral;
