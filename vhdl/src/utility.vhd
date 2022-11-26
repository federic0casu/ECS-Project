package utility is
    function log2(x : positive)         return natural;
    function ceil_log2 (x : positive)   return natural;
end package utility;

package body utility is
    --------------------------------------------------------------------
    -- log2(x)
    --------------------------------------------------------------------
    function log2(x : positive) return natural is
        variable temp  : positive := x;
        variable ret   : natural  := 1;
    begin
        while temp > 1 loop
            temp := temp / 2;
            ret  := ret + 1;
        end loop;
        return ret;
    end function log2;
    --------------------------------------------------------------------
    -- End log2(x)
    --------------------------------------------------------------------

    --------------------------------------------------------------------
    -- ceil_log2(x) gives the minimum number of bits required to 
    -- represent 'x'.  ceil_log2(4) = 2, ceil_log2(5) = 3, etc.
    --------------------------------------------------------------------
    function ceil_log2 (x : positive) return natural is
        variable ret_val    :    natural;
    begin
        ret_val := log2(x);
        if (x > (2**ret_val)) then
            return (ret_val + 1);
        else
            return ret_val;
        end if;
    end function ceil_log2;
    --------------------------------------------------------------------
    -- End ceil_log2(x)
    --------------------------------------------------------------------
end package body utility;
    