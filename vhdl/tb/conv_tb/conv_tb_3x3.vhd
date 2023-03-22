library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

library work;
    use work.common_pkg.all;

entity conv_tb_3x3 is
end entity;

architecture architecture_of_tb of conv_tb_3x3 is
    -----------------------------------------------------------------------------------
    -- Testbench constants
    -----------------------------------------------------------------------------------
    constant T_CLK          : time     := 8 ns;   -- Clock period
    constant T_RESET        : time     := 100 ns; -- Period before the reset deassertion
    constant T_K            : positive := 3;
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
    signal k_tb         : VECTOR((T_K*T_K)-1 downto 0);       -- kernel
    signal i_tb         : VECTOR((T_K*T_K)-1 downto 0);       -- image
    signal o_tb         : std_logic_vector(N_BIT-1 downto 0); -- output
    -----------------------------------------------------------------------------------
    -- End testbench signals
    -----------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------
    component conv is
        generic (
            K      : positive
        );
        port (
            INPUT  : in  VECTOR((2*K*K)-1 downto 0);
            OUTPUT : out std_logic_vector(N_BIT-1 downto 0)
        );
    end component;
    -----------------------------------------------------------------------------------
    -- End component to test declaration
    -----------------------------------------------------------------------------------
begin

    DUT: conv
        generic map (
            K => T_K
        )
        port map (
            INPUT((T_K*T_K)-1 downto 0)           => k_tb,
            INPUT((2*T_K*T_K)-1 downto (T_K*T_K)) => i_tb,
            OUTPUT                                => o_tb
        );

    clk_tb   <= not(clk_tb) and end_sim after T_CLK / 2; 
											                -- When end_sim is forced low, the clock stops toggling and the simulation ends.
    arstn_tb <= '1' after T_RESET;

    
    STIMULI : process(clk_tb, arstn_tb) 

        variable t : integer := 0;
        begin
            if arstn_tb = '0' then
                t := 0;
                k_tb(0)  <= "00000000"; 
                k_tb(1)  <= "00000000"; 
                k_tb(2)  <= "00000000"; 
                k_tb(3)  <= "00000000";
                k_tb(4)  <= "00000000"; 
                k_tb(5)  <= "00000000"; 
                k_tb(6)  <= "00000000"; 
                k_tb(7)  <= "00000000";
                k_tb(8)  <= "00000000";
            ------------------------------
                i_tb(0)  <= "00000000"; 
                i_tb(1)  <= "00000000"; 
                i_tb(2)  <= "00000000"; 
                i_tb(3)  <= "00000000";
                i_tb(4)  <= "00000000"; 
                i_tb(5)  <= "00000000"; 
                i_tb(6)  <= "00000000"; 
                i_tb(7)  <= "00000000";
                i_tb(8)  <= "00000000";
            elsif rising_edge(clk_tb) then
                case(t) is  								-- Specifying the input_tb and end_sim depending on the value 
                    when 6000 => end_sim  <= '0';  		    -- This command stops the simulation when t = 6000
                    --------------------------------------------------------------------------------------------------------
                    -- Initial condition 
                    --------------------------------------------------------------------------------------------------------
                    when  1 => report "O must be '00000000' - O = " & std_logic'image(o_tb(7)) & std_logic'image(o_tb(6)) 
                                                                    & std_logic'image(o_tb(5)) & std_logic'image(o_tb(4))
                                                                    & std_logic'image(o_tb(3)) & std_logic'image(o_tb(2))
                                                                    & std_logic'image(o_tb(1)) & std_logic'image(o_tb(0));
                    --------------------------------------------------------------------------------------------------------
                    -- End initial condition 
                    --------------------------------------------------------------------------------------------------------

                    --------------------------------------------------------------------------------------------------------
                    -- 1st test
                    --------------------------------------------------------------------------------------------------------
                    when 1000 => k_tb(0) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(1) <= std_logic_vector(to_unsigned(2, 8));
                                 k_tb(2) <= std_logic_vector(to_unsigned(1, 8));   
                                 k_tb(3) <= std_logic_vector(to_unsigned(2, 8));
                                 k_tb(4) <= std_logic_vector(to_unsigned(4, 8));   
                                 k_tb(5) <= std_logic_vector(to_unsigned(2, 8));
                                 k_tb(6) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(7) <= std_logic_vector(to_unsigned(2, 8));
                                 k_tb(8) <= std_logic_vector(to_unsigned(1, 8)); 
                                 -----------------------------------------------
                                 i_tb(0) <= std_logic_vector(to_unsigned(50, 8));
                                 i_tb(1) <= std_logic_vector(to_unsigned(46, 8));   
                                 i_tb(2) <= std_logic_vector(to_unsigned(100,8));   
                                 i_tb(3) <= std_logic_vector(to_unsigned(48, 8));
                                 i_tb(4) <= std_logic_vector(to_unsigned(50, 8));   
                                 i_tb(5) <= std_logic_vector(to_unsigned(105,8));   
                                 i_tb(6) <= std_logic_vector(to_unsigned(46, 8));   
                                 i_tb(7) <= std_logic_vector(to_unsigned(48, 8));
                                 i_tb(8) <= std_logic_vector(to_unsigned(101,8));   
                    when 1001 => report "O must be '11011111' - O = " & std_logic'image(o_tb(7)) & std_logic'image(o_tb(6)) 
                                                                      & std_logic'image(o_tb(5)) & std_logic'image(o_tb(4))
                                                                      & std_logic'image(o_tb(3)) & std_logic'image(o_tb(2))
                                                                      & std_logic'image(o_tb(1)) & std_logic'image(o_tb(0));
                    --------------------------------------------------------------------------------------------------------
                    -- End 1st test 
                    --------------------------------------------------------------------------------------------------------

                    --------------------------------------------------------------------------------------------------------
                    -- 2nd test
                    --------------------------------------------------------------------------------------------------------
                    when 2000 => k_tb(0) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(1) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(2) <= std_logic_vector(to_unsigned(2, 8));   
                                 k_tb(3) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(4) <= std_logic_vector(to_unsigned(5, 8));   
                                 k_tb(5) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(6) <= std_logic_vector(to_unsigned(4, 8));
                                 k_tb(7) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(8) <= std_logic_vector(to_unsigned(3, 8));   
                    when 2001 => report "O must be '00000000' - O = " & std_logic'image(o_tb(7)) & std_logic'image(o_tb(6)) 
                                                                      & std_logic'image(o_tb(5)) & std_logic'image(o_tb(4))
                                                                      & std_logic'image(o_tb(3)) & std_logic'image(o_tb(2))
                                                                      & std_logic'image(o_tb(1)) & std_logic'image(o_tb(0));
                    --------------------------------------------------------------------------------------------------------
                    -- End 2nd test 
                    --------------------------------------------------------------------------------------------------------

                    --------------------------------------------------------------------------------------------------------
                    -- 3rd test
                    --------------------------------------------------------------------------------------------------------
                    when 3000 => k_tb(0) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(1) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(2) <= std_logic_vector(to_unsigned(2, 8));   
                                 k_tb(3) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(4) <= std_logic_vector(to_unsigned(7, 8));   
                                 k_tb(5) <= std_logic_vector(to_unsigned(5, 8));
                                 k_tb(6) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(7) <= std_logic_vector(to_unsigned(4, 8));
                                 k_tb(8) <= std_logic_vector(to_unsigned(1, 8));   
                    when 3001 => report "O must be '00110110' - O = " & std_logic'image(o_tb(7)) & std_logic'image(o_tb(6)) 
                                                                      & std_logic'image(o_tb(5)) & std_logic'image(o_tb(4))
                                                                      & std_logic'image(o_tb(3)) & std_logic'image(o_tb(2))
                                                                      & std_logic'image(o_tb(1)) & std_logic'image(o_tb(0));
                    --------------------------------------------------------------------------------------------------------
                    -- End 3rd test 
                    --------------------------------------------------------------------------------------------------------

                    --------------------------------------------------------------------------------------------------------
                    -- 4th test
                    --------------------------------------------------------------------------------------------------------
                    when 4000 => k_tb(0) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(1) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(2) <= std_logic_vector(to_unsigned(2, 8));   
                                 k_tb(3) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(4) <= std_logic_vector(to_unsigned(5, 8));   
                                 k_tb(5) <= std_logic_vector(to_unsigned(5, 8));
                                 k_tb(6) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(7) <= std_logic_vector(to_unsigned(4, 8));
                                 k_tb(8) <= std_logic_vector(to_unsigned(1, 8));   
                    when 4001 => report "O must be '11001010' - O = " & std_logic'image(o_tb(7)) & std_logic'image(o_tb(6)) 
                                                                      & std_logic'image(o_tb(5)) & std_logic'image(o_tb(4))
                                                                      & std_logic'image(o_tb(3)) & std_logic'image(o_tb(2))
                                                                      & std_logic'image(o_tb(1)) & std_logic'image(o_tb(0));
                    --------------------------------------------------------------------------------------------------------
                    -- End 4th test 
                    --------------------------------------------------------------------------------------------------------

                    --------------------------------------------------------------------------------------------------------
                    -- 5th test
                    --------------------------------------------------------------------------------------------------------
                    when 5000 => k_tb(0) <= std_logic_vector(to_unsigned(2, 8));
                                 k_tb(1) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(2) <= std_logic_vector(to_unsigned(2, 8));   
                                 k_tb(3) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(4) <= std_logic_vector(to_unsigned(5, 8));   
                                 k_tb(5) <= std_logic_vector(to_unsigned(2, 8));
                                 k_tb(6) <= std_logic_vector(to_unsigned(3, 8));
                                 k_tb(7) <= std_logic_vector(to_unsigned(2, 8));
                                 k_tb(8) <= std_logic_vector(to_unsigned(1, 8));   
                    when 5001 => report "O must be '01100001' - O = " & std_logic'image(o_tb(7)) & std_logic'image(o_tb(6)) 
                                                                      & std_logic'image(o_tb(5)) & std_logic'image(o_tb(4))
                                                                      & std_logic'image(o_tb(3)) & std_logic'image(o_tb(2))
                                                                      & std_logic'image(o_tb(1)) & std_logic'image(o_tb(0));
                    --------------------------------------------------------------------------------------------------------
                    -- End 5th test 
                    --------------------------------------------------------------------------------------------------------
                    when others => null;                    -- Specifying that nothing happens in the other cases
                    end case;
                t := t + 1;  								             
            end if;
    end process;
end architecture;
