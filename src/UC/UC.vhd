---------------------------------------------------------
-- VHDL top level for 8 bits processor				  
-- by Martin AUCHER, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity UC is
Port (

    ce     : in std_logic;
    clk    : in std_logic;
    
    M_addr : out std_logic_vector(7 downto 0);
    M_data : out std_logic_vector(7 downto 0)
    
);
            
end UC;

architecture Behavioral of UC is

    ----------------------------
    -- Components declaration --
    ----------------------------

    component UT
    PORT ( 
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC
    );
    end component;

    component UC
    PORT ( 
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC
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

    my_FSM: FSM port map (
        clk      => clk,
        rst      => rst
    );

    my_PC: PC port map (
        clk      => clk,
        rst      => rst
    );

    my_Reg: Reg port map (
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

