---------------------------------------------------------
-- VHDL top level for 8 bits processor's UC				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity UC is
Port (

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
            
end UC;

architecture Behavioral of UC is

    ----------------------------
    -- Components declaration --
    ----------------------------

    component FSM
    PORT ( 
        F_out : out std_logic_vector(11 downto 0);
        F_in  : in  std_logic_vector(1 downto 0);

        clk   : in  std_logic;
        ce    : in  std_logic;
        rst   : in  std_logic
    );
    end component;

    component REG_8
    PORT ( 
        R_in  : in  std_logic_vector(7 downto 0);
        R_out : out std_logic_vector(7 downto 0);
        
        load  : in  std_logic;

        clk   : in  std_logic;
        ce    : in  std_logic;
        rst   : in  std_logic
    );
    end component;

    component MUX_6
    PORT (
        M_in_a : in  std_logic_vector(5 downto 0);
        M_in_b : in  std_logic_vector(5 downto 0);
        M_out  : out std_logic_vector(5 downto 0);

        sel   : in  std_logic
    );
    end component;

    -----------------------------------
    -- Internals signals declaration --
    -----------------------------------

    signal PC_MUX  : std_logic_vector(5 downto 0) := (others=>'0');
    signal dat_bus : std_logic_vector(7 downto 0) := (others=>'0');
    
    signal Reg_load : std_logic;
    signal PC_load  : std_logic;
    signal PC_en    : std_logic;
    signal PC_rst   : std_logic;
    signal Mux_sel  : std_logic;

begin

    ------------------------------
    -- Instantiate and port map --
    ------------------------------

    my_FSM: FSM port map (
        clk => clk,
        ce  => ce,
        rst => rst,

        F_out(4 downto 0)  => UT_com,
        F_out(6 downto 5)  => RAM_com,
        F_out(7)  => Reg_load,
        F_out(8)  => PC_load,
        F_out(9)  => PC_en,
        F_out(10) => PC_rst,
        F_out(11) => Mux_sel,

        F_in => dat_bus(8 downto 7)
    );

    PC: PC port map (
        clk   => clk,
        ce    => PC_en,
        rst   => PC_rst,
        load  => PC_load,

        PC_in(5 downto 0)  => dat_bus(5 downto 0),
        PC_out(5 downto 0) => PC_MUX
        
    );

    Reg_ins: REG_8 port map (
        clk   => clk,
        ce    => ce,
        rst   => rst,
        load  => Reg_load,

        R_in  => data_ram,
        R_out => dat_bus

    );

    mux: MUX_6 port map (
        M_in_a => dat_bus(5 downto 0),
        M_in_b => PC_MUX,
        M_out  => addr_ram,

        sel    => Mux_sel
    );

    ----------------------
    -- Synchronous code --
    ----------------------

    -- process (clk, rst) is
    -- begin --process
    --     if (clk'event and clk='1') then
    --         if rst ='1' then
    --             mem_a  <= (others=>'0');
    --         end if;


    --     end if;
    -- end process

    -----------------------
    -- Asynchronous code --
    -----------------------
    
    -- M_addr <= mem_a;
    -- M_data <= mem_d;

end Behavioral;

