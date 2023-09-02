library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

-----------------------------------------------------------------
-- Entity Declaration
----------------------------------------------------------------- 

entity state_machine is 
        generic (
        DIM_KER : positive := 3;
        DIM_IMG : positive := 4
        ); 
        port (
        -- input
        clk : in  std_logic;
        reset : in  std_logic;
        i_f : in std_logic;
        x_valid : in std_logic;
        -- output 
        y_valid : out std_logic;
        stall_p : out std_logic;
        stall_k : out std_logic
  );
end state_machine;

architecture rtl of state_machine is
type t_control_logic_fsm is (
                          ST_S0      ,
                          ST_S1      ,
                          ST_S2      ,
                          ST_S3      );

signal counter_kernel : integer;
signal counter_img    : integer;
signal counter_out    : integer;


signal r_st_present    : t_control_logic_fsm;
signal w_st_next       : t_control_logic_fsm;
begin

-----------------------------------------------------------------
-- Next state logic
----------------------------------------------------------------- 

p_state : process(clk,reset)
begin
  if(reset='0') then
    r_st_present            <= ST_S0;
  elsif(rising_edge(clk)) then
    r_st_present            <= w_st_next;
  end if;
end process p_state;

-----------------------------------------------------------------
-- Current state logic
----------------------------------------------------------------- 

p_comb : process(clk, reset, r_st_present, i_f , x_valid)
begin
  case r_st_present is
    -- S0
    when ST_S0 => 
      if (i_f = '1') and (x_valid = '1') then  
        w_st_next  <= ST_S1;
        else                                                         
        w_st_next  <= ST_S0;
      end if;
    -- S1
    when ST_S1 => 
      if (counter_kernel > DIM_KER*DIM_KER-1) and (i_f = '0') then  
        w_st_next  <= ST_S2;
      elsif reset = '0' then                                                      
        w_st_next  <= ST_S0;
      else
        w_st_next <= ST_S1;
      end if;
    -- S2
    when ST_S2 =>  
        if counter_img > (DIM_KER-1) * DIM_IMG + DIM_KER-1 then
            w_st_next <= ST_S3;
        elsif reset = '0' or i_f = '1' then                                                      
            w_st_next  <= ST_S0;
        else
            w_st_next <= ST_S2;
        end if;    
    -- S3
    when ST_S3 =>  
        if counter_out = (DIM_IMG-DIM_KER+ 1)*(DIM_IMG-DIM_KER+1 + 1) then
            w_st_next <= ST_S0;
        elsif reset = '0' or i_f = '1' then                                                      
            w_st_next  <= ST_S0;
        else
            w_st_next <= ST_S3;
        end if;  
  end case;
end process p_comb;

p_state_out : process(clk,reset,x_valid,i_f)
begin
  if(reset='0') then
    y_valid   <= '0';
    stall_p   <= '0';
    stall_k   <= '0';

  elsif(rising_edge(clk)) then
    case r_st_present is

    when ST_S0 =>
        stall_p   <= '0';
        stall_k   <= '0'; 
        y_valid   <= '0';
        counter_kernel <= 0;
        counter_img <= 0;
        counter_out <= 1;
    
    when ST_S1 =>
        -- we increment only if input is valid, else we stall  
        if x_valid = '1' then
          counter_kernel <= counter_kernel + 1;
        end if;
        -- non stallo solamente se l'input è valido 
        stall_k <= x_valid;

    when ST_S2 => 
        -- we stall the kernel buffer and we take the input on the pipeline side
        stall_k <= '0';
        stall_p <= x_valid;  
        y_valid <= '0';
        
        -- we increment only if input is valid, else we stall  
        if x_valid = '1' then 
        counter_img <= counter_img + 1;
        end if;

    when ST_S3 => 
        -- counter_out mod DIM_OUTPUT + 1 
        if counter_out mod 4 = 0 then 
          y_valid <= '0';
        else
          y_valid <= x_valid; 
        end if; 
        
        stall_p <= x_valid;
        
        if x_valid = '1' then 
          counter_out <= counter_out + 1;
        end if;

    end case;
  end if;

end process p_state_out;
end rtl;