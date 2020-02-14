LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.Numeric_Std.all;

ENTITY ram IS
	PORT(
		clk		 : IN  STD_LOGIC;
		ce       : IN  STD_LOGIC;
		
		rw       : IN  STD_LOGIC;
		enable   : IN  STD_LOGIC;

		addr	 : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
		data_in	 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ram;

ARCHITECTURE rtl OF ram IS
    TYPE memory IS ARRAY(63 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0); 
                                         
    SIGNAL ram : memory := (
        X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", 
        X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", 
        X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", 
        X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", 
        X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", 
        X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", 
        X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", 
        X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"
    );

BEGIN
    PROCESS(clk)
    BEGIN
        IF(clk'EVENT AND clk = '0') THEN
            IF(ce = '1') THEN
                IF(rw = '1') THEN
                    ram(to_integer(unsigned(addr))) <= data_in;
                ELSIF(enable = '1') THEN
                    data_out <= ram(to_integer(unsigned(addr)));
                END IF;
            END IF;
        END IF;	
    END PROCESS;
END rtl;