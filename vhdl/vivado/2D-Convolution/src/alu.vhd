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


entity alu is 
    generic (
        K      : positive
    );
    port (
        INPUT0  : in  VECTOR((K*K)-1 downto 0);
        INPUT1  : in  VECTOR((K*K)-1 downto 0);
        OUTPUT : out std_logic_vector(N_BIT-1 downto 0)
    );
end entity;


architecture logic of alu is
    --------------------------------------------------------------------
    -- Components declaration
    --------------------------------------------------------------------
    component mul is
        port (
            A_M   : in  std_logic_vector(N_BIT-1 downto 0);
            B_M   : in  std_logic_vector(N_BIT-1 downto 0);
            S_M   : out std_logic_vector(N_BIT-1 downto 0)
        );
    end component mul;

    component full_adder is
        port (
            A_FA   : in  std_logic_vector(N_BIT-1 downto 0);
            B_FA   : in  std_logic_vector(N_BIT-1 downto 0);
            S_FA   : out std_logic_vector(N_BIT-1 downto 0)
        );
    end component full_adder;
    --------------------------------------------------------------------
    -- End components declaration
    --------------------------------------------------------------------

    --------------------------------------------------------------------
    -- Signals declaration
    --------------------------------------------------------------------
    signal mul_to_tree  : VECTOR((K*K)-1 downto 0);
    signal tree_to_tree : VECTOR((K*K)-2 downto 0); 
    signal temp         : VECTOR(2 downto 0);    
    --------------------------------------------------------------------
    -- End signals declaration
    --------------------------------------------------------------------
begin

    LABEL_MUL: for i in 0 to (K*K)-1 generate
        MUL_INST: mul 
            port map (
                A_M => INPUT0(i),
                B_M => INPUT1(i),
                S_M => mul_to_tree(i)
            );
    end generate;

    LABEL_KxK_FOR: for i in 0 to (K*K)-2 generate
        LABEL_ADDER_0: if i = 0 generate 
            ADDER_0: full_adder 
            port map (
                A_FA => mul_to_tree(0),
                B_FA => mul_to_tree(1),
                S_FA => tree_to_tree(0)
            );
        end generate;
        LABEL_ADDER_i: if i > 0 generate 
            ADDER_i: full_adder 
            port map (
                A_FA => mul_to_tree(i+1),
                B_FA => tree_to_tree(i-1),
                S_FA => tree_to_tree(i)
            );
        end generate; 
        LABEL_ADDER_LAST: if i = (K*K)-2 generate 
            ADDER_LAST: full_adder 
            port map (
                A_FA => mul_to_tree(i+1),
                B_FA => tree_to_tree(i-1),
                S_FA => OUTPUT
            );
        end generate;
    end generate;

end architecture;