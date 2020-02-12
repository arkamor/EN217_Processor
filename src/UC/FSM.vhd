---------------------------------------------------------
-- VHDL top level for 8 bits processor's FSM				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY FSM IS
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

END FSM;

architecture moore of FSM is

    type fsm_state IS(init, fetch_instruction, decode, fetch_operand, s_NOR, s_ADD, s_JCC, s_STA);    
    signal next_state ,current_state: fsm_state;

begin
  
    PROCESS(clk,rst) IS
    BEGIN  -- PROCESS
        IF rst = '1' THEN -- asynchronous reset
            current_state <= init;
        ELSIF clk'event AND clk = '1' THEN  -- rising clock edge
            current_state <= next_state;
        END IF;
    END PROCESS;


    PROCESS(current_state) IS
    BEGIN
        case current_state IS

            when init =>
                next_state => fetch_instruction;

            when fetch_instruction =>
                next_state => decode;
            
            when decode =>

                case OP is
                    when "11" =>
                        next_state => s_JCC;
                    when "10" =>
                        next_state => s_STA;
                    when others =>
                        next_state => fetch_operand;
                end case;
            
            when fetch_operand =>

                if(OP(0) = '0') then
                    next_state => s_NOR;
                else
                    next_state => s_ADD;
                end if;
        
            --when s_NOR =>
            --    next_state => fetch_instruction;
            
            --when s_ADD =>
            --    next_state => fetch_instruction;
            
            --when s_JCC =>
            --    next_state => fetch_instruction;
            
            --when s_STA =>
            --    next_state => fetch_instruction;
                
            when others => fetch_instruction;

        end case;
end PROCESS;

PROCESS (current_state) IS
    BEGIN  -- PROCESS
    CASE current_state IS
        when init =>

            Load_Accu  <= '0'; --1
            Sig_ctrl   <= '0'; --2
            Init_Carry <= '1'; --3
            Load_Carry <= '0'; --4
            Load_data  <= '0'; --5
            RAM_EN     <= '0'; --6
            RAM_RW     <= '0'; --7
            Reg_load   <= '0'; --8
            Mux_sel    <= '0'; --9
            PC_load    <= '0'; --10
            PC_en      <= '0'; --11
            PC_rst     <= '1'; --12

        when fetch_instruction =>

            Load_Accu  <= '0'; --1
            Sig_ctrl   <= '0'; --2
            Init_Carry <= '0'; --3
            Load_Carry <= '0'; --4
            Load_data  <= '0'; --5
            RAM_EN     <= '1'; --6
            RAM_RW     <= '0'; --7
            Reg_load   <= '1'; --8
            Mux_sel    <= '0'; --9
            PC_load    <= '0'; --10
            PC_en      <= '1'; --11
            PC_rst     <= '0'; --12
            
        when decode =>

            Load_Accu  <= '0'; --1
            Sig_ctrl   <= '0'; --2
            Init_Carry <= '0'; --3
            Load_Carry <= '0'; --4
            Load_data  <= '0'; --5
            RAM_EN     <= '0'; --6
            RAM_RW     <= '0'; --7
            Reg_load   <= '0'; --8
            Mux_sel    <= '1'; --9
            PC_load    <= '0'; --10
            PC_en      <= '0'; --11
            PC_rst     <= '0'; --12
        
        when fetch_operand =>

            Load_Accu  <= '0'; --1
            Sig_ctrl   <= '0'; --2
            Init_Carry <= '0'; --3
            Load_Carry <= '0'; --4
            Load_data  <= '1'; --5
            RAM_EN     <= '1'; --6
            RAM_RW     <= '0'; --7
            Reg_load   <= '0'; --8
            Mux_sel    <= '1'; --9
            PC_load    <= '0'; --10
            PC_en      <= '0'; --11
            PC_rst     <= '0'; --12
    
        when s_NOR =>

            Load_Accu  <= '1'; --1
            Sig_ctrl   <= '0'; --2
            Init_Carry <= '0'; --3
            Load_Carry <= '0'; --4
            Load_data  <= '0'; --5
            RAM_EN     <= '0'; --6
            RAM_RW     <= '0'; --7
            Reg_load   <= '0'; --8
            Mux_sel    <= '1'; --9
            PC_load    <= '0'; --10
            PC_en      <= '0'; --11
            PC_rst     <= '0'; --12
        
        when s_ADD =>

            Load_Accu  <= '1'; --1
            Sig_ctrl   <= '1'; --2
            Init_Carry <= '0'; --3
            Load_Carry <= '1'; --4
            Load_data  <= '0'; --5
            RAM_EN     <= '0'; --6
            RAM_RW     <= '0'; --7
            Reg_load   <= '0'; --8
            Mux_sel    <= '1'; --9
            PC_load    <= '0'; --10
            PC_en      <= '0'; --11
            PC_rst     <= '0'; --12
        
        when s_JCC =>

            Load_Accu  <= '0'; --1
            Sig_ctrl   <= '0'; --2
            Init_Carry <= NOT Carry; --3
            Load_Carry <= '0'; --4
            Load_data  <= '0'; --5
            RAM_EN     <= '0'; --6
            RAM_RW     <= '0'; --7
            Reg_load   <= '0'; --8
            Mux_sel    <= '1'; --9
            PC_load    <= Carry; --10
            PC_en      <= '0'; --11
            PC_rst     <= '0'; --12
        
        when s_STA =>

            Load_Accu  <= '0'; --1
            Sig_ctrl   <= '0'; --2
            Init_Carry <= '0'; --3
            Load_Carry <= '0'; --4
            Load_data  <= '0'; --5
            RAM_EN     <= '1'; --6
            RAM_RW     <= '1'; --7
            Reg_load   <= '0'; --8
            Mux_sel    <= '1'; --9
            PC_load    <= '0'; --10
            PC_en      <= '0'; --11
            PC_rst     <= '0'; --12
            
        when others => NULL;

    END CASE;
END PROCESS;
end moore;