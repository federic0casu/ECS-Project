library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;


package common_pkg is
    --------------------------------------------------------------------
    -- Constants declaration
    --------------------------------------------------------------------
    constant N_BIT : positive := 8;
    --------------------------------------------------------------------
    -- End constants declaration
    --------------------------------------------------------------------

    
    --------------------------------------------------------------------
    -- Types declaration
    --------------------------------------------------------------------
    type VECTOR is array (natural range <>) of std_logic_vector(N_BIT-1 downto 0);
    --------------------------------------------------------------------
    -- End types declaration
    --------------------------------------------------------------------


    --------------------------------------------------------------------
    -- Functions declaration
    --------------------------------------------------------------------
    function log2 (x : natural) return natural;
    --------------------------------------------------------------------
    -- End functions declaration
    --------------------------------------------------------------------
end common_pkg;


package body common_pkg is 

    function log2 (x : natural) return natural is
        variable temp : natural := x ;
        variable n : natural := 0 ;
    begin
        while temp > 1 loop
            temp := (temp / 2);
            n := (n + 1);
        end loop ;
        if x > 2**n then
            return (n + 1); 
        else
            return (n); 
        end if ;
    end function log2;

end package body common_pkg;