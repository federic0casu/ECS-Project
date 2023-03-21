library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

library work;
    use work.common_pkg.all;

entity full_adder_tb is
end entity;

architecture architecture_of_tb of full_adder_tb is
    -----------------------------------------------------------------------------------
    -- Testbench constants
    -----------------------------------------------------------------------------------
    constant T_CLK          : time     := 8 ns;   -- Clock period
    constant T_RESET        : time     := 100 ns; -- Period before the reset deassertion
    constant M_TB           : positive := 8;
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
    signal a_tb         : VECTOR(M_TB-1 downto 0);
    signal b_tb         : VECTOR(M_TB-1 downto 0);
    signal s_tb         : std_logic_vector(M_TB-1 downto 0);
    -----------------------------------------------------------------------------------
    -- End testbench signals
    -----------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------
    component full_adder_tree is
        generic (
            N    : positive;
            M    : positive
        );
        port (
            A   : in  VECTOR(M-1 downto 0);
            B   : in  VECTOR(M-1 downto 0);
            S   : out std_logic_vector(N-1 downto 0)
        );
    end component;
    -----------------------------------------------------------------------------------
    -- End component to test declaration
    -----------------------------------------------------------------------------------
begin

    DUT: full_adder_tree
        generic map (
            N => 8,
            M => 8
        )
        port map (
            A => a_tb,
            B => b_tb,
            S => s_tb
        );

    clk_tb   <= not(clk_tb) and end_sim after T_CLK / 2; 
											                -- When end_sim is forced low, the clock stops toggling and the simulation ends.
    arstn_tb <= '1' after T_RESET;
    
    STIMULI : process(clk_tb, arstn_tb) 

        variable t : integer := 0;
        begin
            if (log2(M_TB) > 3 or log2(M_TB) < 3) then
                report "log2(M) = " & natural'image(log2(M_TB));
            elsif arstn_tb = '0' then
                t := 0;
            elsif rising_edge(clk_tb) then
                case(t) is  								-- Specifying the input_tb and end_sim depending on the value 
                    when 1000 => end_sim  <= '0';  		    -- This command stops the simulation when t = 1000
                    when 10 => a_tb(0) <= "00000010";
                    when 11 => a_tb(1) <= "00000010";
                    when 12 => a_tb(2) <= "00000010";
                    when 13 => a_tb(3) <= "00000010";
                    when 14 => a_tb(4) <= "00000010";
                    when 15 => a_tb(5) <= "00000010";
                    when 16 => a_tb(6) <= "00000010";
                    when 17 => a_tb(7) <= "00000010"; 
                    when 18 => b_tb(0) <= "00000010";
                    when 19 => b_tb(1) <= "00000010";
                    when 20 => b_tb(2) <= "00000010";
                    when 21 => b_tb(3) <= "00000010";
                    when 22 => b_tb(4) <= "00000010";
                    when 23 => b_tb(5) <= "00000010";
                    when 24 => b_tb(6) <= "00000010";
                    when 25 => b_tb(7) <= "00000010";
                    when 26 => report "S(0) must be 0 - S(0) = " & std_logic'image(s_tb(0));
                               report "S(1) must be 0 - S(1) = " & std_logic'image(s_tb(1));
                               report "S(2) must be 0 - S(2) = " & std_logic'image(s_tb(2));
                               report "S(3) must be 0 - S(3) = " & std_logic'image(s_tb(3));
                               report "S(4) must be 1 - S(4) = " & std_logic'image(s_tb(4));
                               report "S(5) must be 0 - S(5) = " & std_logic'image(s_tb(5));
                               report "S(6) must be 0 - S(6) = " & std_logic'image(s_tb(6));  
                               report "S(7) must be 0 - S(7) = " & std_logic'image(s_tb(7));                                        				
                    when others => null;                    -- Specifying that nothing happens in the other cases
                    end case;
                t := t + 1;  								             
            end if;
    end process;
end architecture;
