--------------------------------------------------------------------
-- Multiplier                                                     --
-- Input ports:                                                   --
--  + A    (N-bit wide)                                           --
--  + B    (N-bit wide)                                           --
-- Output ports:                                                  --
--  + S    (N-bit wide)                                           --
--------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.common_pkg.all;

entity mul is
    port (
        A_M   : in  std_logic_vector(N_BIT-1 downto 0);
        B_M   : in  std_logic_vector(N_BIT-1 downto 0);
        S_M   : out std_logic_vector(N_BIT-1 downto 0)
    );
end entity;

architecture logic of mul is
    --------------------------------------------------------------------
    -- Signals declaration
    --------------------------------------------------------------------
    signal s_temp : std_logic_vector((2*N_BIT)-1 downto 0);
    --------------------------------------------------------------------
    -- End signals declaration
    --------------------------------------------------------------------
begin
    S_M    <= s_temp(N_BIT-1 downto 0);
    s_temp <= std_logic_vector(unsigned(A_M) * unsigned(B_M));
end architecture;