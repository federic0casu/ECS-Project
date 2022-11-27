-- edgeDetector.vhd
-- Moore and Mealy Implementation

library ieee;
use ieee.std_logic_1164.all; 

entity fsm is
port(
    clk, reset : in std_logic
);
end fsm;

architecture arch of fsm is 

-- S0, S1, S2, S3, W0, W1, PAD0, PAD1

    type state_type is (S0,S1,S2); 
    signal state_reg, state_next : state_type;
    
begin   
    process(clk, reset)
    begin
        if (reset = '1') then 
            state_reg <= S0;
        elsif (clk'event and clk = '1') then 
            state_reg <= state_next;
        else
            null;
        end if; 
    end process;


    process(state_reg)
    begin 
            -- store current state as next
            state_next <= state_reg; -- required: when no case statement is satisfied
            
            case state_reg is 
                when S0 => -- if state is zero, 
                    state_next <= S1;
                when S1 => 
                    state_next <= S2;      
                when S2 =>
                    state_next <= S0;            
                end case; 
        end process;

end architecture; 
        
