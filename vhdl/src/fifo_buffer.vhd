library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIFO_buffer is
    generic (
        N_FIFO_BUFFER       : positive  := 8;
        M_FIFO_BUFFER       : positive  := 8
    );
    port (
        resetn_FIFO_buffer  : in        std_logic;
        clock_FIFO_buffer   : in        std_logic;
        input_FIFO_buffer   : in        std_logic_vector(N_FIFO_BUFFER - 1 downto 0);
        output_FIFO_buffer  : out       std_logic_vector(N_FIFO_BUFFER - 1 downto 0)
    );
end entity;

architecture arch of FIFO_buffer is

    -----------------------------------------------------------------------------------
    -- Signals
    -----------------------------------------------------------------------------------
    signal en_int           : std_logic;
    type Q_TO_D_TYPE is array (0 to M_FIFO_BUFFER - 2) of std_logic_vector(N_FIFO_BUFFER - 1 downto 0);    
    signal q_TO_d           : Q_TO_D_TYPE;
    -----------------------------------------------------------------------------------
    -- Component declaration
    -----------------------------------------------------------------------------------
    component dff_N is 
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
    end component;

begin

    DFF_N_int : for i in 0 to (M_FIFO_BUFFER - 1) generate

        label_DFF_N_1 : if i = 0 generate 
            DFF_N_1: dff_N
                generic map (
                    DFF_N_BIT   => N_FIFO_BUFFER
                ) 
                port map (
                    resetn      => resetn_FIFO_buffer,
                    clock       => clock_FIFO_buffer,
                    en          => en_int,
                    d           => input_FIFO_buffer,
                    q           => q_TO_d(i)
                );
        end generate;

        label_DFF_N_i : if (i > 0 and i < (M_FIFO_BUFFER - 1))generate 
            DFF_N_i: dff_N
                generic map (
                    DFF_N_BIT   => N_FIFO_BUFFER
                ) 
                port map (
                    resetn      => resetn_FIFO_buffer,
                    clock       => clock_FIFO_buffer,
                    en          => en_int,
                    d           => q_TO_d(i - 1),
                    q           => q_TO_d(i)
                );
        end generate;

        label_DFF_N_M : if i = (M_FIFO_BUFFER - 1) generate 
            DFF_N_M: dff_N
                generic map (
                    DFF_N_BIT   => N_FIFO_BUFFER
                ) 
                port map (
                    resetn      => resetn_FIFO_buffer,
                    clock       => clock_FIFO_buffer,
                    en          => en_int,
                    d           => q_TO_d(i - 1),
                    q           => output_FIFO_buffer
                );
        end generate;

    end generate;

    en_int <= '1';

end architecture;