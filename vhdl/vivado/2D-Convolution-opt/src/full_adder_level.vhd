--------------------------------------------------------------------
-- Full adder level                                               --
-- Input ports:                                                   --
--  + A    (M signals)x(N-bit wide)                               --
--  + B    (M signals)x(N-bit wide)                               --
-- Output ports:                                                  --
--  + S    (M/2 signals)x(N-bit wide)                             --
--------------------------------------------------------------------
-- M must be odd                                                  --
--------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

library work;
    use work.common_pkg.all;


entity full_adder_level is
    generic (
        M_L   : positive
    );
    port (
        A_L   : in  VECTOR(M_L-1 downto 0);
        B_L   : in  VECTOR(M_L-1 downto 0);
        S_L   : out VECTOR(M_L-1 downto 0)
    );
end entity;

architecture logic of full_adder_level is
    --------------------------------------------------------------------
    -- Components declaration
    --------------------------------------------------------------------
    component full_adder is
        port (
            A_FA   : in  std_logic_vector(N_BIT-1 downto 0);
            B_FA   : in  std_logic_vector(N_BIT-1 downto 0);
            S_FA   : out std_logic_vector(N_BIT-1 downto 0)
        );
    end component;
    --------------------------------------------------------------------
    -- End components declaration
    --------------------------------------------------------------------
begin

    TREE: for i in 0 to M_L-1 generate    
        FA: full_adder 
            port map (
                A_FA => A_L(i),
                B_FA => B_L(i),
                S_FA => S_L(i) 
            );
    end generate;
    
end architecture;