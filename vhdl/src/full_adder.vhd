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

entity full_adder is
    generic (
        N_FA  : positive
    );
    port (
        A_FA   : in std_logic_vector(N_FA-1 downto 0);
        B_FA   : in std_logic_vector(N_FA-1 downto 0);
        S_FA   : out std_logic_vector(N_FA-1 downto 0)
    );
end entity;

architecture logic of full_adder is
begin
    S_FA    <= std_logic_vector(resize(unsigned(A_FA), N_FA) + resize(unsigned(B_FA), N_FA));
end architecture;