--------------------------------------------------------------------
-- Full adder                                                     --
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

entity full_adder is
    port (
        A_FA   : in  std_logic_vector(N_BIT-1 downto 0);
        B_FA   : in  std_logic_vector(N_BIT-1 downto 0);
        S_FA   : out std_logic_vector(N_BIT-1 downto 0)
    );
end entity;

architecture logic of full_adder is
begin
    S_FA    <= std_logic_vector(unsigned(A_FA) + unsigned(B_FA));
end architecture;