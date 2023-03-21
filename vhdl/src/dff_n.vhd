library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity dff_N is 
    generic (
        DFF_N_BIT   : positive := 8
    );
    port (
        resetn      : in    std_logic;
        clock       : in    std_logic;
        en          : in    std_logic;     
        d           : in    std_logic_vector(DFF_N_BIT - 1 downto 0);
        q           : out   std_logic_vector(DFF_N_BIT - 1 downto 0)
    );
end entity;

architecture structural_dataflow of dff_N is 

    component d_flip_flop is 
        port (
            resetn_dff  : in std_logic;
            d_dff       : in std_logic;
            clock_dff   : in std_logic;
            q_dff       : out std_logic
        );
    end component;  

    signal d_TO_d_dff  : std_logic_vector(DFF_N_BIT - 1 downto 0);
    signal q_feedback  : std_logic_vector(DFF_N_BIT - 1 downto 0);

begin

    DFF_N : for i in 0 to (DFF_N_BIT - 1) generate
        DFF_i : d_flip_flop port map (
            resetn_dff  => resetn,
            d_dff       => d_TO_d_dff(i),
            clock_dff   => clock,
            q_dff       => q_feedback(i)
        );
    end generate;

    q <= q_feedback;

    MULTIPLEXER: process(resetn, en, d, q_feedback) 
    begin
        if (en = '1' and resetn = '1') then
            d_TO_d_dff <= d;
        else
            d_TO_d_dff <= q_feedback;
        end if; 
    end process;    

end architecture;