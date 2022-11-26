library IEEE;
    use IEEE.std_logic_1164.all;
    use ieee.numeric_std.all;

entity R8_tb is
end entity;

architecture architecture_of_tb of R8_tb is
    -----------------------------------------------------------------------------------
    -- Testbench constants
    -----------------------------------------------------------------------------------
    constant T_CLK          : time     := 8 ns;   -- Clock period
    constant T_RESET        : time     := 25 ns;  -- Period before the reset deassertion
    -----------------------------------------------------------------------------------
    -- End testbench constants
    -----------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------
    -- Testbench signals
    -----------------------------------------------------------------------------------
    signal clk_tb       : std_logic := '0';  					
    signal arstn_tb     : std_logic := '0';  					
    signal enable_tb    : std_logic := '0';
    signal input_tb     : std_logic_vector(7 downto 0) := (others => '0');
    signal output_tb    : std_logic_vector(7 downto 0);         
    signal end_sim      : std_logic := '1';  					
    -----------------------------------------------------------------------------------
    -- End testbench signals
    -----------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------
    component R8 is
        port (
            resetn_R8   : in  std_logic;
            enable_R8   : in  std_logic;
            d_R8        : in  std_logic_vector(7 downto 0);
            q_R8        : out std_logic_vector(7 downto 0)
        ); 
    end component;
    -----------------------------------------------------------------------------------
    -- End component to test declaration
    -----------------------------------------------------------------------------------
begin

    DUT: R8 
        port map (
            resetn_R8   => arstn_tb,
            enable_R8   => enable_tb,
            d_R8        => input_tb,
            q_R8        => output_tb
        );

    clk_tb   <= not(clk_tb) and end_sim after T_CLK / 2; 
											                -- When end_sim is forced low, the clock stops toggling and the simulation ends.
    arstn_tb <= '1' after T_RESET;
    
    STIMULI : process(clk_tb, arstn_tb) 

        variable t : integer := 0;
        begin
            if arstn_tb = '0' then
                input_tb <= (others => '0');
                t := 0;
            elsif rising_edge(clk_tb) then
                case(t) is  								-- Specifying the input_tb and end_sim depending on the value 
											                -- of t (and so on the number of the passed clock cycles).
                when 1    => input_tb <= "10101010"; enable_tb <= '1';
                when 2    => enable_tb <= '0';
                when 100  => input_tb <= "11111111";
                when 200  => input_tb <= "01010101"; enable_tb <= '1';
                when 201  => enable_tb <= '0';
                when 300  => input_tb <= "11111111";
                when 400  => input_tb <= "10011001"; enable_tb <= '1';
                when 401  => enable_tb <= '0';
                when 600  => input_tb <= "11111111";
                when 800  => input_tb <= "00001111"; enable_tb <= '1';
                when 801  => enable_tb <= '0';
                when 1200 => input_tb <= "11110000"; enable_tb <= '1';
                when 1201 => enable_tb <= '0';
                when 1400 => input_tb <= "11111111";
                
                when 1600 => end_sim  <= '0';  				-- This command stops the simulation when t = 1000
                when others => null;        				-- Specifying that nothing happens in the other cases
                end case;

                t := t + 1;  								-- The variable is updated exactly here (try to move this 
											                -- statement before the "case(t) is" one and watch the difference 
											                -- in the simulation).
            end if;
    end process;

end architecture;
