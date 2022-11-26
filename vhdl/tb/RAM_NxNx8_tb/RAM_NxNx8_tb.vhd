library IEEE;
    use IEEE.std_logic_1164.all;
    use ieee.numeric_std.all;


entity RAM_NxNx8_tb is
end entity;

architecture architecture_of_tb of RAM_NxNx8_tb is
    -----------------------------------------------------------------------------------
    -- Testbench constants
    -----------------------------------------------------------------------------------
    constant T_CLK          : time     := 8 ns;   -- Clock period
    constant T_RESET        : time     := 10 ns;  -- Period before the reset deassertion
    constant N_TB           : positive := 8;
    constant M_TB           : positive := 6;
    -----------------------------------------------------------------------------------
    -- End testbench constants
    -----------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------
    -- Testbench signals
    -----------------------------------------------------------------------------------
    signal clk_tb       : std_logic := '0';  	
    signal arstn_tb     : std_logic := '0';				
    signal write_tb     : std_logic := '0';
    signal read_tb      : std_logic := '0';
    signal address_tb   : std_logic_vector(M_TB - 1 downto 0) := (others => '0');
    signal input_tb     : std_logic_vector(7 downto 0)        := (others => '0');
    signal output_tb    : std_logic_vector(7 downto 0);         
    signal end_sim      : std_logic := '1';  					
    -----------------------------------------------------------------------------------
    -- End testbench signals
    -----------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------
    component RAM_NxNx8 is
        generic (
            N           : positive;
            M           : positive
        );
        port (
            clock       : in  std_logic;
            write_en    : in  std_logic; 
            read_en     : in  std_logic;
            address     : in  std_logic_vector(M - 1 downto 0); 
            data_in     : in  std_logic_vector(7 downto 0); 
            data_out    : out std_logic_vector(7 downto 0)
        );
    end component;
    -----------------------------------------------------------------------------------
    -- End component to test declaration
    -----------------------------------------------------------------------------------
begin

    DUT: RAM_NxNx8
        generic map (
            N           => N_TB,
            M           => M_TB
        )
        port map (
            clock       => clk_tb,
            write_en    => write_tb, 
            read_en     => read_tb,
            address     => address_tb, 
            data_in     => input_tb, 
            data_out    => output_tb
        );

    clk_tb   <= not(clk_tb) and end_sim after T_CLK / 2;    -- When end_sim is forced low, the clock stops toggling and the simulation ends.
											                
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
                when 1    => input_tb <= "00000001"; address_tb <= "000000"; write_tb <= '1';
                when 2    => write_tb <= '0';
                when 3    => input_tb <= "11111111";
                when 4    => read_tb <= '1';
                when 5    => read_tb <= '0';
                when 6    => input_tb <= "00000010"; address_tb <= "000001"; write_tb <= '1';
                when 7    => write_tb <= '0';
                when 8    => input_tb <= "11111111";
                when 9    => read_tb <= '1';
                when 10   => read_tb <= '0';
                when 11   => input_tb <= "00000011"; address_tb <= "000010"; write_tb <= '1';
                when 12   => write_tb <= '0';
                when 13   => input_tb <= "11111111";
                when 14   => read_tb <= '1';
                when 15   => read_tb <= '0';
                when 16   => input_tb <= "00000100"; address_tb <= "000011"; write_tb <= '1';
                when 17   => write_tb <= '0';
                when 18   => input_tb <= "11111111";
                when 19   => read_tb <= '1';
                when 20   => read_tb <= '0';
                when 21   => input_tb <= "00000101"; address_tb <= "000100"; write_tb <= '1';
                when 22   => write_tb <= '0';
                when 23   => input_tb <= "11111111";
                when 24   => read_tb <= '1';
                when 25   => read_tb <= '0';
                when 26   => input_tb <= "00000110"; address_tb <= "000101"; write_tb <= '1';
                when 27   => write_tb <= '0';
                when 28   => input_tb <= "11111111";
                when 29   => read_tb <= '1';
                when 30   => read_tb <= '0';
                when 31   => input_tb <= "00000111"; address_tb <= "000110"; write_tb <= '1';
                when 32   => write_tb <= '0';
                when 33   => input_tb <= "11111111";
                when 34   => read_tb <= '1';
                when 35   => read_tb <= '0';
                when 36   => input_tb <= "0001000"; address_tb <= "000111"; write_tb <= '1';
                when 37   => write_tb <= '0';
                when 38   => input_tb <= "11111111";
                when 39   => read_tb <= '1';
                when 40   => read_tb <= '0';
                when 41   => input_tb <= "0001001"; address_tb <= "001000"; write_tb <= '1';
                when 42   => write_tb <= '0';
                when 43   => input_tb <= "11111111";
                when 44   => read_tb <= '1';
                when 45   => read_tb <= '0';
                when 46   => input_tb <= "0001010"; address_tb <= "001001"; write_tb <= '1';
                when 47   => write_tb <= '0';
                when 48   => input_tb <= "11111111";
                when 49   => read_tb <= '1';
                when 50   => read_tb <= '0';
                when 51   => input_tb <= "0001011"; address_tb <= "001010"; write_tb <= '1';
                when 52   => write_tb <= '0';
                when 53   => input_tb <= "11111111";
                when 54   => read_tb <= '1';
                when 55   => read_tb <= '0';
                when 56   => input_tb <= "0001100"; address_tb <= "001011"; write_tb <= '1';
                when 57   => write_tb <= '0';
                when 58   => input_tb <= "11111111";
                when 59   => read_tb <= '1';
                when 60   => read_tb <= '0';
                when 61   => input_tb <= "0001101"; address_tb <= "001100"; write_tb <= '1';
                when 62   => write_tb <= '0';
                when 63   => input_tb <= "11111111";
                when 64   => read_tb <= '1';
                when 65   => read_tb <= '0';
                when 66   => input_tb <= "0001110"; address_tb <= "001101"; write_tb <= '1';
                when 67   => write_tb <= '0';
                when 68   => input_tb <= "11111111";
                when 69   => read_tb <= '1';
                when 70   => read_tb <= '0';
                when 71   => input_tb <= "0001111"; address_tb <= "001110"; write_tb <= '1';
                when 72   => write_tb <= '0';
                when 73   => input_tb <= "11111111";
                when 74   => read_tb <= '1';
                when 75   => read_tb <= '0';
                when 76   => input_tb <= "00100000"; address_tb <= "001111"; write_tb <= '1';
                when 77   => write_tb <= '0';
                when 78   => input_tb <= "11111111";
                when 79   => read_tb <= '1';
                when 80   => read_tb <= '0';
                when 81   => input_tb <= "00100001"; address_tb <= "010000"; write_tb <= '1';
                when 82   => write_tb <= '0';
                when 83   => input_tb <= "11111111";
                when 84   => read_tb <= '1';
                when 85   => read_tb <= '0';
                when 86   => input_tb <= "00100010"; address_tb <= "010001"; write_tb <= '1';
                when 87   => write_tb <= '0';
                when 88   => input_tb <= "11111111";
                when 89   => read_tb <= '1';
                when 90   => read_tb <= '0';
                when 91   => input_tb <= "00100011"; address_tb <= "010010"; write_tb <= '1';
                when 92   => write_tb <= '0';
                when 93   => input_tb <= "11111111";
                when 94   => read_tb <= '1';
                when 95   => read_tb <= '0';
                when 96   => read_tb <= '1';
                when 97   => input_tb <= "11000011";
                when 98   => input_tb <= "00111100";
                when 99   => read_tb <= '0';
                
                when 100  => end_sim  <= '0';  				-- This command stops the simulation when t = 1000
                when others => null;        				-- Specifying that nothing happens in the other cases
                end case;

                t := t + 1;  								-- The variable is updated exactly here (try to move this 
											                -- statement before the "case(t) is" one and watch the difference 
											                -- in the simulation).
            end if;
    end process;

end architecture;
