--------------------------------------------------------------------
-- 8 bit Register                                                 --
-- Input ports:                                                   --
--  + resetn     (asynchronous, active low)                       --
--  + enable                                                      --
--  + d          (data, 8 bit wide)                               --
-- Output ports:                                                  --
--  + q          (ouput, 8 bit wide)                              --
--------------------------------------------------------------------

library IEEE;
    use IEEE.std_logic_1164.all;
    use ieee.numeric_std.all;

entity R8 is
    port (
        resetn_R8   : in  std_logic;
        enable_R8   : in  std_logic;
        d_R8        : in  std_logic_vector(7 downto 0);
        q_R8        : out std_logic_vector(7 downto 0)
    ); 
end entity;

architecture arch of R8 is 
    --------------------------------------------------------------------
    -- Components declaration
    --------------------------------------------------------------------
    component R1 is
        port (
            resetn_R1   : in  std_logic;
            enable_R1   : in  std_logic;
            d_R1        : in  std_logic;
            q_R1        : out std_logic
        ); 
    end component;
    --------------------------------------------------------------------
    -- End components declaration
    --------------------------------------------------------------------
begin

    R1_gen : for i in 0 to 7 generate
        R1_i : R1 
            port map (
                resetn_R1   => resetn_R8,
                enable_R1   => enable_R8,
                d_R1        => d_R8(i),
                q_R1        => q_R8(i)
            );
    end generate;

end architecture;