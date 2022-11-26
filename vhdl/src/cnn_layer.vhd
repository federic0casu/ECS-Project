--------------------------------------------------------------------
-- CNN Layer                                                      --
-- Input ports:                                                   --
--  + clock                                                       --
--  + rst       (asynchronous, active high)                       --
--  + x         (8-bit wide)                                      --
--  + i/f       (i/f = 0 -> input channel, i/f = 1 -> filter)     --
--  + x_valid                                                     --
-- Output ports:                                                  --
--  + y         (8-bit wide)                                      --
--  + y_valid                                                     --
--------------------------------------------------------------------

library IEEE;
    use IEEE.std_logic_1164.all;
    use ieee.numeric_std.all;

entity cnn_layer is
    generic (
        DIM_INPUT   : positive;         -- Number of rows/columns of input matrix
        DIM_FILTER  : positive;         -- Number of rows/columns of filter matrix
        DIM_OUTPUT  : positive;         -- Number of rows/columns of output matrix
        DIM_ELEM    : positive          -- Number of bits wich compose each matrix's element
    );
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        x           : in  std_logic_vector(DIM_ELEM - 1  downto 0);
        i_f         : in  std_logic;
        x_valid     : in  std_logic;
        y           : out std_logic_vector(DIM_ELEM - 1  downto 0);
        y_valid     : out std_logic;
    ); 
end entity;

architecture arch of cnn_layer is
    --------------------------------------------------------------------
    -- Signals declaration
    --------------------------------------------------------------------

    --------------------------------------------------------------------
    -- End signals declaration
    --------------------------------------------------------------------


    --------------------------------------------------------------------
    -- Components declaration
    --------------------------------------------------------------------

    --------------------------------------------------------------------
    -- End components declaration
    --------------------------------------------------------------------
begin
end architecture;