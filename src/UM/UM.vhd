---------------------------------------------------------
-- VHDL top level for 8 bits processor's UM                  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

ENTITY ram IS
    PORT(
        clk    : IN  STD_LOGIC;
        ce     : IN  STD_LOGIC;
        
        rw     : IN  STD_LOGIC;
        enable : IN  STD_LOGIC;

        addr   : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
        data   : INOUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ram;

ARCHITECTURE rtl OF ram IS
    TYPE memory IS ARRAY(63 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0); 
                                         
    SIGNAL addr_int : integer range 0 to 63;
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
        IF(clk'EVENT AND clk = '1') THEN
            IF(ce = '1') THEN
                 addr_int <= to_integer(unsigned(addr));
                IF(enable = '1') THEN
                    IF(rw = '1') THEN
                        ram(addr_int) <= data;
                    ELSE
                        data <= ram(addr_int);
                    END IF;
                END IF;
            END IF;    
        END IF;    
    END PROCESS;
END rtl;
