library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

library work;
    use work.utilities.all;

entity fsm_tb is
end entity;

    
architecture beh of  fsm_tb is 
    
        constant T_RESET : time := 25 ns;
        constant clk_period : time := 10 ns;
        constant N_image : positive := 4;
        constant M_kernel : positive := 2;
    
        component state_machine
            generic (
                DIM_KER : positive;
                DIM_IMG : positive
            );
            port (
                clk : in std_logic;
                reset: in std_logic; 
                i_f : in std_logic;
                x_valid : in std_logic;
                -- output 
                y_valid : out std_logic;
                stall_p : out std_logic;
                stall_k : out std_logic
            );
        end component;    
    
        signal clk_ext : std_logic := '0';
        signal reset_ext : std_logic := '0';
        signal end_sim : std_logic := '1'; 
        signal i_f_ext : std_logic := '1';
        signal stall_p_ext : std_logic := '1';
        signal stall_k_ext : std_logic := '1';
        signal y_valid_ext : std_logic := '0';
        signal x_valid_ext : std_logic := '0'; 

        begin 
            clk_ext <= (not clk_ext and end_sim) after clk_period/2;
            reset_ext <= '1' after T_RESET; 

            DUT: state_machine
                generic map (
                    DIM_KER => M_kernel,
                    DIM_IMG => N_image
                )
                port map (
                    clk => clk_ext,
                    reset => reset_ext,
                    i_f => i_f_ext,
                    x_valid => x_valid_ext,
                    y_valid => y_valid_ext,
                    stall_p => stall_p_ext,
                    stall_k => stall_k_ext 
                );

        STIMULI: process(clk_ext, reset_ext)  -- process used to make the testbench signals change synchronously with the rising edge of the clock
        variable t : integer := 0;  -- variable used to count the clock cycle after the reset
        begin
            if(reset_ext = '0') then
                t := 0;
            elsif(rising_edge(clk_ext)) then
                case(t) is
                    
                    when 30 =>
                        i_f_ext <= '0';
                        x_valid_ext <= '1';

                    when 50 => end_sim <= '0';  -- This command stops the simulation when t = 10
                    when others => null;        -- Specifying that nothing happens in the other cases
                end case;
            t := t + 1;  -- the variable is updated exactly here (try to move this statement before the "case(t) is" one and watch the difference in the simulation)
            end if;
        end process;

    end architecture;
