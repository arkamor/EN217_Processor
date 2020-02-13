---------------------------------------------------------
-- VHDL top level for 8 bits processor				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity processor_8b is
Port (

    ce     : in std_logic;
    clk    : in std_logic;
    rst    : in std_logic;
    
    M_addr : out std_logic_vector(7 downto 0);
    M_data : out std_logic_vector(7 downto 0)
    
);
            
end processor_8b;

architecture Behavioral of processor_8b is

    ----------------------------
    -- Components declaration --
    ----------------------------

    component UT
    PORT ( 

        clk : in std_logic;
        ce  : in std_logic;
        rst : in std_logic;
        
        -- UC
        Load_Accu  : in  std_logic;
        Sig_ctrl   : in  std_logic;
        Carry      : out std_logic;
        Load_Carry : in  std_logic;
        Load_data  : in  std_logic;
        Init_Carry : in  std_logic;
        
        -- RAM
        out_ram : in  std_logic_vector(7 DOWNTO 0);
        in_ram  : out std_logic_vector(7 DOWNTO 0)
    );
    end component;

    component UC
    PORT ( 
        clk : in std_logic;
        ce  : in std_logic;
        rst : in std_logic;
        
        -- UT
        Load_Accu  : out std_logic;
        Sig_ctrl   : out std_logic;
        Carry      : in  std_logic;
        Load_Carry : out std_logic;
        Load_data  : out std_logic;
        Init_Carry : out std_logic;
        
        -- RAM
        RAM_com : out std_logic_vector(1 downto 0);
        
        addr_ram : in  std_logic_vector(5 DOWNTO 0);
        data_ram : out std_logic_vector(7 DOWNTO 0)
    );
    end component;

    component UM
    PORT ( 
		clk		 : IN  STD_LOGIC;
		ce       : IN  STD_LOGIC;
		
		rw       : IN  STD_LOGIC;
		enable   : IN  STD_LOGIC;

		addr	 : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		data_in	 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    end component;

    -----------------------------------
    -- Internals signals declaration --
    -----------------------------------

    SIGNAL mem_a : std_logic_vector(5 downto 0) := (others=>'0'); 
    SIGNAL mem_d : std_logic_vector(7 downto 0) := (others=>'0');

    -- UC/UT --
    
    SIGNAL Load_Accu  : std_logic;
    SIGNAL Sig_ctrl   : std_logic;
    SIGNAL Carry      : std_logic;
    SIGNAL Load_Carry : std_logic;
    SIGNAL Load_data  : std_logic;
    SIGNAL Init_Carry : std_logic;
    
    -- RAM

    ---- UC ----    
    -- RAM
    RAM_com : out std_logic_vector(1 downto 0);
    

    ---- UM ----
    rw       : IN  STD_LOGIC;
    enable   : IN  STD_LOGIC;


begin

    ------------------------------
    -- Instantiate and port map --
    ------------------------------

    my_UC: UC port map (
        clk      => clk,
        rst      => rst
    );

    my_UT: UC port map (
        clk      => clk,
        rst      => rst
    );

    my_UM: UC port map (
        clk      => clk,
        rst      => rst
    );

    ----------------------
    -- Synchronous code --
    ----------------------

    process (clk, rst) is
    begin --process
        if (clk'event and clk='1') then
            if rst ='1' then
                mem_a  <= (others=>'0');
            end if;


        end if;
    end process

    -----------------------
    -- Asynchronous code --
    -----------------------
    
    M_addr <= mem_a;
    M_data <= mem_d;n  

end Behavioral;

