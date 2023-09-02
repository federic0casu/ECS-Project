library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

library work;
    use work.utilities.all;


entity pipeline_tb  is
    end entity;
    
    architecture beh of pipeline_tb is 
    
        constant T_RESET : time := 25 ns;
        constant clk_period : time := 10 ns;
        constant N_image : positive := 4;
        constant M_kernel : positive := 2;
    
        component pipeline 
            generic (
                DIM_IMG : positive;
                DIM_KER : positive
            );
            port (
                clk : in std_logic;
                reset: in std_logic;
                stall: in std_logic; 
                in_image: in std_logic_vector(7 downto 0);
                in_kernel: in std_logic_vector(7 downto 0);
                out_conv: out arr(M_kernel*M_kernel-1 downto 0)
            );
        end component;    
    
        signal clk_ext : std_logic := '0';
        signal reset_ext : std_logic := '0';
        signal image_ext :  std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(0,8));
        signal kernel_ext :  std_logic_vector(7 downto 0);
        signal out_ext : arr(M_kernel*M_kernel - 1 downto 0);
        signal stall_ext : std_logic := '1';
        signal end_sim : std_logic := '1'; 

        begin 
            clk_ext <= (not clk_ext and end_sim) after clk_period/2;
            reset_ext <= '1' after T_RESET; 

            DUT: pipeline
                generic map (
                    DIM_IMG => N_image,
                    DIM_KER => M_kernel
                )
                port map (
                    clk => clk_ext,
                    reset => reset_ext,
                    stall => stall_ext,
                    in_image => image_ext,
                    in_kernel => kernel_ext,
                    out_conv => out_ext
                );

        STIMULI: process(clk_ext, reset_ext)  -- process used to make the testbench signals change synchronously with the rising edge of the clock
        variable t : integer := 0;  -- variable used to count the clock cycle after the reset
        begin
            if(reset_ext = '0') then
                image_ext <= (others => '0');
                t := 0;
            elsif(rising_edge(clk_ext)) then
                case(t) is
                    when 30 => image_ext   <= std_logic_vector(to_unsigned(1,8));
                    when 31 => image_ext   <= std_logic_vector(to_unsigned(2,8));
                    when 32 => image_ext   <= std_logic_vector(to_unsigned(3,8));
                    when 33 => image_ext   <= std_logic_vector(to_unsigned(4,8));
                    when 34 => image_ext   <= std_logic_vector(to_unsigned(5,8));
                    when 35 => image_ext   <= std_logic_vector(to_unsigned(6,8));
                    when 36 => image_ext   <= std_logic_vector(to_unsigned(7,8));
                    when 37 => image_ext   <= std_logic_vector(to_unsigned(8,8));
                    when 38 => image_ext   <= std_logic_vector(to_unsigned(9,8));
                    when 39 => image_ext   <= std_logic_vector(to_unsigned(10,8));
                    when 40 => image_ext   <= std_logic_vector(to_unsigned(11,8));
                    when 41 => image_ext   <= std_logic_vector(to_unsigned(12,8));
                    when 42 => image_ext   <= std_logic_vector(to_unsigned(13,8));
                    when 43 => image_ext   <= std_logic_vector(to_unsigned(14,8));
                    when 44 => image_ext   <= std_logic_vector(to_unsigned(15,8));
                    when 45 => image_ext   <= std_logic_vector(to_unsigned(16,8));

                    when 50 => end_sim <= '0';  -- This command stops the simulation when t = 10
                    when others => null;        -- Specifying that nothing happens in the other cases
                end case;
            t := t + 1;  -- the variable is updated exactly here (try to move this statement before the "case(t) is" one and watch the difference in the simulation)
            end if;
        end process;

    end architecture;
