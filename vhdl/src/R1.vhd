--------------------------------------------------------------------
-- 1 bit Register                                                 --
-- Input ports:                                                   --
--  + resetn     (asynchronous, active low)                       --
--  + enable                                                      --
--  + d          (data)                                           --
-- Output ports:                                                  --
--  + q          (ouput)                                          --
--------------------------------------------------------------------

library IEEE;
    use IEEE.std_logic_1164.all;
    use ieee.numeric_std.all;

entity R1 is
    port (
        resetn_R1   : in  std_logic;
        enable_R1   : in  std_logic;
        d_R1        : in  std_logic;
        q_R1        : out std_logic
    ); 
end entity;

architecture arch of R1 is
begin

    R1_process: process(resetn_R1, enable_R1)
    begin
        if(resetn_R1 = '0') then
            q_R1 <= '0';
        elsif (enable_R1 = '1') then
            q_R1 <= d_R1;
        end if;
    end process;

end architecture;