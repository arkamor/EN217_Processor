library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port ( 
        ce   : in STD_LOGIC;
        clk  : in STD_LOGIC;
        rst  : in STD_LOGIC;

        load : in STD_LOGIC;
        enable : in STD_LOGIC;
        
        PC_in  : in  STD_LOGIC_VECTOR (5 DOWNTO 0);
        PC_out : out STD_LOGIC_VECTOR (5 DOWNTO 0)
    );
end PC;

architecture Behavioral of PC is

signal count : unsigned(5 DOWNTO 0) := "000000"; 

begin
    process(clk, rst) IS
    begin
        IF (rst = '1') THEN
            count <= "000000";
        ELSIF (clk'event AND clk = '1') THEN
            IF (CE = '1') THEN
                IF (init = '1') THEN
                    count <= "000000";
                ELSIF (load = '1') THEN
                    count <= unsigned(PC_in);
                ELSIF (enable = '1') THEN
                    count <= count + 1;
                END IF;
            END IF;
        END IF;
        
    END process;

cpt_out <= std_logic_vector(count);

end Behavioral;
