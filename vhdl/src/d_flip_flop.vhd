library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity d_flip_flop is 
    port (
        resetn_dff  : in std_logic;
        d_dff       : in std_logic;
        clock_dff   : in std_logic;
        q_dff       : out std_logic
    );
end entity;

architecture dataflow of d_flip_flop is
begin

    D_FLIP_FLOP_PROCESS: process(clock_dff, resetn_dff)
    begin
        if resetn_dff = '0' then
            q_dff <= '0';
        elsif rising_edge(clock_dff) then
            q_dff <= d_dff;
        end if;
    end process; 

end architecture;