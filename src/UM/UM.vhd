LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ram IS
	PORT(
		clk		 : IN  STD_LOGIC;
		ce       : IN  STD_LOGIC;
		
		rw       : IN  STD_LOGIC;
		enable   : IN  STD_LOGIC;

		addr	 : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		data_in	 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ram;

ARCHITECTURE rtl OF ram IS
   TYPE memory IS ARRAY(63 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0); 
   
	SIGNAL ram      : memory;                                                  
	SIGNAL addr_int	: INTEGER(6 DOWNTO 0);                              
BEGIN

	PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN
			IF(ce = '1') THEN
				IF(rw = '1') THEN
					ram(addr) <= data_in;
				ELSIF(enable = '1') THEN
					data_out <= ram(addr_int);
				END IF;
			
				addr_int <= integer(addr);

		END IF;	
	END PROCESS;
END rtl;
