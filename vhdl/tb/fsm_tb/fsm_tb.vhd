library IEEE;
    use IEEE.std_logic_1164.all;
    use ieee.numeric_std.all;

entity fsm_tb is
end entity;

architecture architecture_of_tb of fsm_tb is
    -----------------------------------------------------------------------------------
    -- Testbench constants
    -----------------------------------------------------------------------------------
    constant T_CLK          : time     := 8 ns;   -- Clock period
    constant T_RESET        : time     := 100 ns;  -- Period before the reset deassertion
    -----------------------------------------------------------------------------------
    -- End testbench constants
    -----------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------
    -- Testbench signals
    -----------------------------------------------------------------------------------
    signal clk_tb       : std_logic := '0';  					
    signal arstn_tb     : std_logic := '0';  					
    signal enable_tb    : std_logic := '0';
    signal end_sim      : std_logic := '1';
    -----------------------------------------------------------------------------------
    -- End testbench signals
    -----------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------
    component fsm is 
    port (
        clk : in std_logic;
        reset : in std_logic
    );
    end component fsm;
    -----------------------------------------------------------------------------------
    -- End component to test declaration
    -----------------------------------------------------------------------------------
begin

    DUT: fsm 
        port map (
            clk     => clk_tb,
            reset   => arstn_tb
        );

    clk_tb   <= not(clk_tb) and end_sim after T_CLK / 2; 
											                -- When end_sim is forced low, the clock stops toggling and the simulation ends.
    arstn_tb <= '1' after T_RESET;
    
    STIMULI : process(clk_tb, arstn_tb) 

        variable t : integer := 0;
        begin
            if arstn_tb = '0' then
                t := 0;
            elsif rising_edge(clk_tb) then
                case(t) is  								-- Specifying the input_tb and end_sim depending on the value 
                    when 1600 => end_sim  <= '0';  				-- This command stops the simulation when t = 1000                                                				-- Specifying that nothing happens in the other cases
                    when others => null;            
                    end case;
                t := t + 1;  								             
            end if;
    end process;
end architecture;
