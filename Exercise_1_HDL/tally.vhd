-- Michalis Iona Exercise 1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.NUMERIC_std.all;

entity tally is
    Port ( scoresA, scoresB : in std_logic_vector(2 downto 0);
           winner : out std_logic_vector(1 downto 0)
           );
end tally;

architecture loopy of tally is
begin
    process(scoresA, scoresB)
        variable player_A: integer range 0 to 2;
        variable player_B: integer range 0 to 2;
    begin
    player_A := 0;
    player_B := 0;
    --Loop going through positions in the array (0,0,0) positions 0 to 2
    
        for i in integer range 0 to 2 loop
            if scoresA(i) = '1' then 
                player_A := player_A + 1;
            end if;
            if scoresB(i)= '1' then 
                player_B := player_B + 1;
            end if;     
        end loop;
            
    -- Outputs: If A has more points then it wins, and for B vise-versa    
    --          If its tie and both have same points then score is 0 for both
        if player_A > player_B then
            winner <= "10";

        elsif player_B > player_A then
            winner <= "01";

        elsif player_A = player_B then
            if player_A = 0 then
                winner <= "00";
            else winner <= "11";
            end if;
        end if;
        
    end process;  
end loopy;