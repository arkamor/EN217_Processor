LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ram IS
	PORT(
		clk		:	IN		STD_LOGIC;
		wr_ena	:	IN		STD_LOGIC;
		addr		:	IN		INTEGER(6 DOWNTO 0);
		data_in	:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
		data_out	:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0));
END ram;

ARCHITECTURE rtl OF ram IS
   TYPE memory IS ARRAY(63 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0); 
   
	SIGNAL ram			:	memory;                                                  
	SIGNAL addr_int	:	INTEGER(6 DOWNTO 0);                              
BEGIN

	PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN

			IF(wr_ena = '1') THEN  
				ram(addr) <= data_in; 
			END IF;
			
			addr_int <= addr;      

		END IF;	
	END PROCESS;
	
	data_out <= ram(addr_int);     
	
END rtl;
