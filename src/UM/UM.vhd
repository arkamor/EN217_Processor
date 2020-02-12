LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ram IS
	GENERIC(
		d_width	:	INTEGER := 8;    --width of each data word
		size		:	INTEGER := 64);  --number of data words the memory can store
	PORT(
		clk		:	IN		STD_LOGIC;                             --system clock
		wr_ena	:	IN		STD_LOGIC;                             --write enable
		addr		:	IN		INTEGER RANGE 0 TO size-1;             --address to write/read
		data_in	:	IN		STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --input data to write
		data_out	:	OUT	STD_LOGIC_VECTOR(d_width-1 DOWNTO 0)); --output data read
END ram;

ARCHITECTURE logic OF ram IS
	TYPE memory IS ARRAY(size-1 DOWNTO 0) OF STD_LOGIC_VECTOR(d_width-1 DOWNTO 0); 
	SIGNAL ram			:	memory;                                                  
	SIGNAL addr_int	:	INTEGER RANGE 0 TO size-1;                               
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
	
END logic;
