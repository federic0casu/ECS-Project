
-- Full adder tree                                                --
-- Input ports:                                                   --
--  + A    (M signals)x(N-bit wide)                               --
--  + B    (M signals)x(N-bit wide)                               --
-- Output ports:                                                  --
--  + S    (N-bit wide)                                           --
--------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

library work;
    use work.common_pkg.all;


entity full_adder_tree is
    generic (
        M    : positive
    );
    port (
        A   : in  VECTOR(M-1 downto 0);
        B   : in  VECTOR(M-1 downto 0);
        S   : out std_logic_vector(N_BIT-1 downto 0)
    );
end entity;

architecture logic of full_adder_tree is
    --------------------------------------------------------------------
    -- Components declaration
    --------------------------------------------------------------------
    component full_adder_level is
        generic (
            M_L    : positive
        );
        port (
            A_L   : in  VECTOR(M_L-1 downto 0);
            B_L   : in  VECTOR(M_L-1 downto 0);
            S_L   : out VECTOR(M_L-1 downto 0)
        );
    end component;

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


    --------------------------------------------------------------------
    -- Signals declaration
    --------------------------------------------------------------------
    type S_SIGN_TYPE is array (natural range <>) of VECTOR(M-1 downto 0);
    signal s_sign : S_SIGN_TYPE(log2(M)-1 downto 0);
    --------------------------------------------------------------------
    -- End signals declaration
    --------------------------------------------------------------------
begin
    
    LEVELS: for i in 0 to log2(M) generate
        LABEL_FIRST_LEVEL: if i = 0 generate
            FIRST_LEVEL: full_adder_level
                generic map (
                    M_L => M
                )
                port map (
                    A_L => A,
                    B_L => B,
                    S_L => s_sign(i)
                );
        end generate;

        LABEL_SECOND_LEVEL: if i = 1 and log2(M) > 1 generate
            SECOND_LEVEL: full_adder_level
                generic map (
                    M_L => M/2
                )
                port map (
                    A_L => s_sign(i-1)((M/2)-1 downto 0),
                    B_L => s_sign(i-1)(M-1 downto (M/2)),
                    S_L => s_sign(i)((M/2)-1 downto 0)
                );
        end generate;

        LABEL_INTERMEDIATE_LEVEL: if (i > 1 and i < log2(M)) generate
            INTERMEDIATE_LEVEL: full_adder_level
                generic map (
                    M_L => M/(2*i)
                )
                port map (
                    A_L => s_sign(i-1)((M/(2*i))-1 downto 0),
                    B_L => s_sign(i-1)((M/(2*(i-1)))-1 downto (M/(2*i))),
                    S_L => s_sign(i)((M/(2*i))-1 downto 0)
                );
        end generate;

        LABEL_LAST_LEVEL: if i = log2(M) generate
            LAST_LEVEL: full_adder
                port map (
                    A_FA => s_sign(i-1)(0),
                    B_FA => s_sign(i-1)(1),
                    S_FA => S
                );
        end generate;
    end generate; 

end architecture;