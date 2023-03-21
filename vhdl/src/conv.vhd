--------------------------------------------------------------------
-- Convolutional module                                           --
-- Input ports:                                                   --
--  + I    (K signals)x(N-bit wide)                               --
-- Output ports:                                                  --
--  + O    (N-bit wide)                                           --
---------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

library work;
    use work.common_pkg.all;


entity conv is
    generic (
        K    : positive
    );
    port (
        I   : in  VECTOR(K-1 downto 0);
        O   : out std_logic_vector(N_BIT-1 downto 0)
    );
end entity;