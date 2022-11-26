--------------------------------------------------------------------
-- RAM                                                            --
-- Input ports:                                                   --
--  + clock                                                       --
--  + write_en                                                    --
--  + read_en                                                     --
--  + address    (log_2(N*N) bit wide)                            --
--  + data_in    (input, 8 bit wide)                              --
-- Output ports:                                                  --
--  + data_out   (ouput, 8 bit wide)                              --
--------------------------------------------------------------------

library IEEE;
    use IEEE.std_logic_1164.all;
    use ieee.numeric_std.all;


entity RAM_NxNx8 is
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
end entity;

architecture arch of RAM_NxNx8 is
    --------------------------------------------------------------------
    -- Signals declaration
    --------------------------------------------------------------------
    type   ram_array is array (0 to N*N-1) of std_logic_vector (7 downto 0);
    signal ram      : ram_array := (others => b"00000000"); 
    --------------------------------------------------------------------
    -- End signals declaration
    --------------------------------------------------------------------
begin

    process(clock)
    begin
        if(rising_edge(clock)) then
            if(write_en = '1') then 
                ram(to_integer(unsigned(address))) <= data_in;
            end if;
        end if;
    end process;

    data_out <= ram(to_integer(unsigned(address))) when (read_en = '1') else b"00000000";

end architecture;