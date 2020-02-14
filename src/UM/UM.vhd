LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.Numeric_Std.all;

ENTITY UM IS
	PORT(
		clk		 : IN  STD_LOGIC;
		ce       : IN  STD_LOGIC;
		
		rw       : IN  STD_LOGIC;
		enable   : IN  STD_LOGIC;

		addr	 : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
		data_in	 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END UM;

ARCHITECTURE rtl OF UM IS
    TYPE memory IS ARRAY(0 to 63) OF STD_LOGIC_VECTOR(7 DOWNTO 0); 
                                         
    SIGNAL ram : memory := ( X"08",
        X"47",
        X"86",
        X"C4",
        X"00",
        X"00",
        X"7E",
        X"FE",
        others=>X"00");

BEGIN
    PROCESS(clk)
    BEGIN
        IF(clk'EVENT AND clk = '0') THEN
            IF(ce = '1') THEN
             IF(enable = '1') THEN
                IF(rw = '1') THEN
                    ram(to_integer(unsigned(addr))) <= data_in;
                ELSE
                    data_out <= ram(to_integer(unsigned(addr)));
                END IF;
               END IF;
            END IF;
        END IF;	
    END PROCESS;
END rtl;