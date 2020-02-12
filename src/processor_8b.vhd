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
        UT_com : out std_logic_vector(3 downto 0);
        
        -- RAM
        RAM_com : out std_logic_vector(1 downto 0);
        
        addr_ram : in  std_logic_vector(5 DOWNTO 0);
        data_ram : out std_logic_vector(7 DOWNTO 0)
    );
    end component;

    component UM
    PORT ( 
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC
    );
    end component;

    -----------------------------------
    -- Internals signals declaration --
    -----------------------------------

    SIGNAL mem_a : std_logic_vector(7 downto 0) := (others=>'0'); 
    SIGNAL mem_d : std_logic_vector(7 downto 0) := (others=>'0');

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

