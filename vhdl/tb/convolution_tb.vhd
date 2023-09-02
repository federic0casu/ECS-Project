library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

library work;
    use work.utilities.all;
    use work.common_pkg.all;

entity convolution_tb  is
    end entity;
    
    architecture beh of convolution_tb is 
    
        constant T_RESET : time := 25 ns;
        constant clk_period : time := 10 ns;
        constant N_image : positive := 4;
        constant M_kernel : positive := 2;

        component convolution is 
        generic (
            DIM_KER : positive := 2;
            DIM_IMG : positive := 4;
            N_BIT : positive := 8
        );
        port (
            clk : in std_logic;
            reset : in std_logic; 
            x : in std_logic_vector(N_BIT - 1 downto 0);
            if_signal : in std_logic;
            x_valid : in std_logic;
            y_valid : out std_logic;
            y : out std_Logic_vector(N_BIT - 1 downto 0)
        );
        end component;
    
        signal clk_ext : std_logic := '0';
        signal reset_ext : std_logic := '0';
        signal input_ext :  std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(0,8));
        signal out_ext : std_logic_vector(7 downto 0);
        signal if_ext : std_logic := '0'; 
        signal x_valid_ext : std_logic := '0'; 
        signal end_sim : std_logic := '1'; 
        signal y_valid_ext : std_logic ;

        begin 
            clk_ext <= (not clk_ext and end_sim) after clk_period/2;
            reset_ext <= '1' after T_RESET; 

            DUT: convolution
                generic map (
                    DIM_IMG => N_image,
                    DIM_KER => M_kernel,
                    N_BIT => 8
                )
                port map (
                    clk => clk_ext,
                    reset => reset_ext,
                    x => input_ext,
                    if_signal => if_ext,
                    x_valid => x_valid_ext,
                    y_valid => y_valid_ext,
                    y => out_ext
                );

        STIMULI: process(clk_ext, reset_ext)  -- process used to make the testbench signals change synchronously with the rising edge of the clock
        variable t : integer := 0;  -- variable used to count the clock cycle after the reset
        begin
            if(reset_ext = '0') then
                input_ext <= (others => '0');
                t := 0;

            elsif(rising_edge(clk_ext)) then
                case(t) is

                    -- load filter elements 
                    when 22 =>    
                        if_ext <= '1';
                        x_valid_ext <= '1';
                    
                    when 23 => input_ext   <= std_logic_vector(to_unsigned(1,8));
                    when 24 => input_ext   <= std_logic_vector(to_unsigned(1,8));
                    when 25 => input_ext   <= std_logic_vector(to_unsigned(1,8));
                    when 26 => input_ext   <= std_logic_vector(to_unsigned(1,8));
                    
                    when 27 => if_ext <= '0'; 

                    -- load image elements
                    when 30 => input_ext   <= std_logic_vector(to_unsigned(1,8));
                    when 31 => input_ext   <= std_logic_vector(to_unsigned(2,8));
                    when 32 => input_ext   <= std_logic_vector(to_unsigned(3,8));
                    when 33 => input_ext   <= std_logic_vector(to_unsigned(4,8));
                    when 34 => input_ext   <= std_logic_vector(to_unsigned(5,8));
                    when 35 => input_ext   <= std_logic_vector(to_unsigned(6,8));
                    when 36 => input_ext   <= std_logic_vector(to_unsigned(7,8));
                    when 37 => input_ext   <= std_logic_vector(to_unsigned(8,8));
                    when 38 => input_ext   <= std_logic_vector(to_unsigned(9,8));
                    when 39 => input_ext   <= std_logic_vector(to_unsigned(10,8));
                    when 40 => input_ext   <= std_logic_vector(to_unsigned(11,8));
                    when 41 => input_ext   <= std_logic_vector(to_unsigned(12,8));
                    when 42 => input_ext   <= std_logic_vector(to_unsigned(13,8));
                    when 43 => input_ext   <= std_logic_vector(to_unsigned(14,8));
                    when 44 => input_ext   <= std_logic_vector(to_unsigned(15,8));
                    when 45 => input_ext   <= std_logic_vector(to_unsigned(16,8));

                    when 50 => end_sim <= '0';  -- This command stops the simulation when t = 10
                    when others => null;        -- Specifying that nothing happens in the other cases
                end case;
            t := t + 1;  
            end if;
        end process;

    end architecture;
