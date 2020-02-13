---------------------------------------------------------
-- VHDL top level for 8 bits processor's UT				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity UT is
Port (

    clk : in std_logic;
    ce  : in std_logic;
    rst : in std_logic;
    
    -- UC
    Load_Accu  : in  std_logic;
    Sig_ctrl   : in  std_logic;
    o_Carry    : out std_logic;
    Load_Carry : in  std_logic;
    Load_data  : in  std_logic;
    Init_Carry : in  std_logic;
    
    -- RAM
    out_ram : in  std_logic_vector(7 DOWNTO 0);
    in_ram  : out std_logic_vector(7 DOWNTO 0)
);    
    
end UT;

architecture Behavioral of UT is

    ----------------------------
    -- Components declaration --
    ----------------------------

    component ALU
    PORT ( 
        Sig_ctrl : in  std_logic;
        Carry    : out std_logic;
        
        Reg_data : in  std_logic_vector(7 downto 0);
        Reg_accu : in  std_logic_vector(7 downto 0);
        Alu_out  : out std_logic_vector(7 downto 0)
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

    component CARRY
    PORT (
        val_in  : in  std_logic;
        val_out : out std_logic;

        init    : in  std_logic;
        load    : in  std_logic;

        clk     : in  std_logic;
        ce      : in  std_logic;
        rst     : in  std_logic
    );
    end component;

    -----------------------------------
    -- Internals signals declaration --
    -----------------------------------

    signal ALU_A : std_logic_vector(7 downto 0) := (others=>'0');
    signal ALU_B : std_logic_vector(7 downto 0) := (others=>'0');
    signal ALU_O : std_logic_vector(7 downto 0) := (others=>'0');
    
    signal ALU_C  : std_logic;

begin

    ------------------------------
    -- Instantiate and port map --
    ------------------------------

    my_ALU: ALU port map (
        Sig_ctrl => Sig_ctrl,
        Carry    => ALU_C,
        
        Reg_data => ALU_A,
        Reg_accu => ALU_B,
        Alu_out  => ALU_O
    );

    my_carry: CARRY port map (
        val_in  => ALU_C,
        val_out => o_Carry,

        init    => Init_Carry,
        load    => Load_Carry,

        clk     => clk,
        ce      => ce,
        rst     => rst
    );

    reg_data: REG_8 port map ( 
        R_in  => out_ram,
        R_out => ALU_A,
        
        load  => Sig_ctrl,

        clk   => Sig_ctrl,
        ce    => Sig_ctrl,
        rst   => Sig_ctrl
    );

    reg_accu: REG_8 port map (
        Sig_ctrl => Sig_ctrl,
        Carry    => ALU_C,
        
        Reg_data => ALU_A,
        Reg_accu => ALU_B,
        Alu_out  => ALU_O
    );

end Behavioral;

