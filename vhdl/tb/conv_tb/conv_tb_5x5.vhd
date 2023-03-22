library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

library work;
    use work.common_pkg.all;

entity conv_tb_5x5 is
end entity;

architecture architecture_of_tb of conv_tb_5x5 is
    -----------------------------------------------------------------------------------
    -- Testbench constants
    -----------------------------------------------------------------------------------
    constant T_CLK          : time     := 8 ns;   -- Clock period
    constant T_RESET        : time     := 100 ns; -- Period before the reset deassertion
    constant T_K            : positive := 5;
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
                k_tb(9)  <= "00000000"; 
                k_tb(10) <= "00000000"; 
                k_tb(11) <= "00000000";
                k_tb(12) <= "00000000"; 
                k_tb(13) <= "00000000"; 
                k_tb(14) <= "00000000"; 
                k_tb(15) <= "00000000";
                k_tb(16) <= "00000000"; 
                k_tb(17) <= "00000000";
                k_tb(18) <= "00000000"; 
                k_tb(19) <= "00000000"; 
                k_tb(20) <= "00000000"; 
                k_tb(21) <= "00000000";
                k_tb(22) <= "00000000"; 
                k_tb(23) <= "00000000"; 
                k_tb(24) <= "00000000"; 
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
                i_tb(9)  <= "00000000"; 
                i_tb(10) <= "00000000"; 
                i_tb(11) <= "00000000";
                i_tb(12) <= "00000000"; 
                i_tb(13) <= "00000000"; 
                i_tb(14) <= "00000000"; 
                i_tb(15) <= "00000000";
                i_tb(16) <= "00000000"; 
                i_tb(17) <= "00000000";
                i_tb(18) <= "00000000"; 
                i_tb(19) <= "00000000"; 
                i_tb(20) <= "00000000"; 
                i_tb(21) <= "00000000";
                i_tb(22) <= "00000000"; 
                i_tb(23) <= "00000000"; 
                i_tb(24) <= "00000000";
            elsif rising_edge(clk_tb) then
                case(t) is  								-- Specifying the input_tb and end_sim depending on the value 
                    when 5000 => end_sim  <= '0';  		    -- This command stops the simulation when t = 5000
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
                    when 1000 => k_tb(0)  <= std_logic_vector(to_unsigned(1, 8)); k_tb(8)  <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(1)  <= std_logic_vector(to_unsigned(1, 8)); k_tb(9)  <= std_logic_vector(to_unsigned(1, 8));  
                                 k_tb(2)  <= std_logic_vector(to_unsigned(1, 8)); k_tb(10) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(3)  <= std_logic_vector(to_unsigned(1, 8)); k_tb(11) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(4)  <= std_logic_vector(to_unsigned(1, 8)); k_tb(12) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(5)  <= std_logic_vector(to_unsigned(1, 8)); k_tb(13) <= std_logic_vector(to_unsigned(1, 8));  
                                 k_tb(6)  <= std_logic_vector(to_unsigned(1, 8)); k_tb(14) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(7)  <= std_logic_vector(to_unsigned(1, 8)); k_tb(15) <= std_logic_vector(to_unsigned(1, 8));
                                 
                                 k_tb(16) <= std_logic_vector(to_unsigned(1, 8)); k_tb(24) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(17) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(18) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(19) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(20) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(21) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(22) <= std_logic_vector(to_unsigned(1, 8));
                                 k_tb(23) <= std_logic_vector(to_unsigned(1, 8)); 
                               
                                 i_tb(0)  <= std_logic_vector(to_unsigned(1, 8)); i_tb(8)  <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(1)  <= std_logic_vector(to_unsigned(1, 8)); i_tb(9)  <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(2)  <= std_logic_vector(to_unsigned(1, 8)); i_tb(10) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(3)  <= std_logic_vector(to_unsigned(1, 8)); i_tb(11) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(4)  <= std_logic_vector(to_unsigned(1, 8)); i_tb(12) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(5)  <= std_logic_vector(to_unsigned(1, 8)); i_tb(13) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(6)  <= std_logic_vector(to_unsigned(1, 8)); i_tb(14) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(7)  <= std_logic_vector(to_unsigned(1, 8)); i_tb(15) <= std_logic_vector(to_unsigned(1, 8));

                                 i_tb(16) <= std_logic_vector(to_unsigned(1, 8)); i_tb(24) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(17) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(18) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(19) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(20) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(21) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(22) <= std_logic_vector(to_unsigned(1, 8));
                                 i_tb(23) <= std_logic_vector(to_unsigned(1, 8));
                    when 1001 => report "O must be '00011001' - O = " & std_logic'image(o_tb(7)) & std_logic'image(o_tb(6)) 
                                                                      & std_logic'image(o_tb(5)) & std_logic'image(o_tb(4))
                                                                      & std_logic'image(o_tb(3)) & std_logic'image(o_tb(2))
                                                                      & std_logic'image(o_tb(1)) & std_logic'image(o_tb(0));
                    --------------------------------------------------------------------------------------------------------
                    -- End 1st test 
                    --------------------------------------------------------------------------------------------------------
                    when others => null;                    -- Specifying that nothing happens in the other cases
                    end case;
                t := t + 1;  								             
            end if;
    end process;
end architecture;
