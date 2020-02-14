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
    Load_Accu  : out std_logic;
    Sig_ctrl   : out std_logic;
    Carry      : in  std_logic;
    Load_Carry : out std_logic;
    Load_data  : out std_logic;
    Init_Carry : out std_logic;
    
    -- RAM
    RAM_EN : out std_logic;
    RAM_RW : out std_logic;
    
    addr_ram : out std_logic_vector(5 DOWNTO 0);
    data_ram : in  std_logic_vector(7 DOWNTO 0)
        
);
            
end UC;

architecture Behavioral of UC is

    ----------------------------
    -- Components declaration --
    ----------------------------

    component FSM
    PORT ( 

        clk : in std_logic;
        ce  : in std_logic;
        rst : in std_logic;

        OP  : in std_logic_vector(1 downto 0);

        --UT

        Load_Accu  : out std_logic; --1
        Sig_ctrl   : out std_logic; --2
        Init_Carry : out std_logic; --3
        Load_Carry : out std_logic; --4
        Load_data  : out std_logic; --5
        Carry      : in  std_logic; --13

        --UC
        
        Reg_load   : out std_logic; --8
        Mux_sel    : out std_logic; --9
        PC_load    : out std_logic; --10
        PC_en      : out std_logic; --11
        PC_rst     : out std_logic; --12

        --RAM

        RAM_RW     : out std_logic; --7
        RAM_EN     : out std_logic --6
    );
    end component;

    component REG_8
    PORT ( 
        val_in  : in  std_logic_vector(7 downto 0);
        val_out : out std_logic_vector(7 downto 0);
        
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

    component PC
    Port ( 
        ce   : in STD_LOGIC;
        clk  : in STD_LOGIC;
        rst  : in STD_LOGIC;

        load : in STD_LOGIC;
        enable : in STD_LOGIC;
        init : in STD_LOGIC;
        
        PC_in  : in  STD_LOGIC_VECTOR (5 DOWNTO 0);
        PC_out : out STD_LOGIC_VECTOR (5 DOWNTO 0)
    );
    end component;

    -----------------------------------
    -- Internals signals declaration --
    -----------------------------------

    signal int_PC_MUX  : std_logic_vector(5 downto 0) := (others=>'0');
    signal int_dat_bus : std_logic_vector(7 downto 0) := (others=>'0');
    
    signal int_Reg_load : std_logic;
    signal int_PC_load  : std_logic;
    signal int_PC_en    : std_logic;
    signal int_PC_rst   : std_logic;
    signal int_Mux_sel  : std_logic;

    signal int_Load_Accu  : std_logic;
    signal int_Sig_ctrl   : std_logic;
    signal int_Init_Carry : std_logic;
    signal int_Load_Carry : std_logic;
    signal int_Load_data  : std_logic;
    signal int_Carry      : std_logic;

    signal int_RAM_RW     : std_logic;
    signal int_RAM_EN     : std_logic;

begin

    ------------------------------
    -- Instantiate and port map --
    ------------------------------

    my_FSM: FSM port map (

        clk => clk,
        ce  => ce,
        rst => rst,

        OP => int_dat_bus(7 downto 6),

        Load_Accu  => int_Load_Accu,
        Sig_ctrl   => int_Sig_ctrl,
        Init_Carry => int_Init_Carry,
        Load_Carry => int_Load_Carry,
        Load_data  => int_Load_data,

        Carry => int_Carry,
                
        Reg_load => int_Reg_load,
        Mux_sel  => int_Mux_sel,
        
        PC_load  => int_PC_load,
        PC_en    => int_PC_en,
        PC_rst   => int_PC_rst,

        RAM_RW => int_RAM_RW,
        RAM_EN => int_RAM_EN
        
    );

    my_PC: PC port map (
        clk   => clk,
        ce    => ce,
        rst   => rst,

        load  => int_PC_load,
        enable  => int_PC_en,
        init  => int_PC_rst,

        PC_in(5 downto 0)  => int_dat_bus(5 downto 0),
        PC_out(5 downto 0) => int_PC_MUX
        
    );

    Reg_ins: REG_8 port map (
        clk   => clk,
        ce    => ce,
        rst   => rst,
        
        load  => int_Reg_load,

        val_in  => data_ram,
        val_out => int_dat_bus

    );

    mux: MUX_6 port map (
        M_in_a => int_dat_bus(5 downto 0),
        M_in_b => int_PC_MUX,
        M_out  => addr_ram,

        sel    => int_Mux_sel
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
    RAM_EN <= int_RAM_EN;
    RAM_RW <= int_RAM_RW;

end Behavioral;

