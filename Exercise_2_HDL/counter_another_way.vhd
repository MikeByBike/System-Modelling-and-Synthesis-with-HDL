--Michalis Iona 2nd different counter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.numeric_std.all;

entity counter_another_way is
    Port (
        clk, enable, reset, load, down_up : in std_logic;
        data : in std_logic_vector(3 downto 0);
        count : out std_logic_vector(3 downto 0);
        over : out std_logic
    );
end counter_another_way;

architecture Behavioral of counter_another_way is
    
begin
process
    variable count_var : std_logic_vector (3 downto 0) := "0000";
    variable over_var : std_logic := '0';
begin
    wait until clk='1';
    over_var:= '0';
    if (reset = '1') then count_var := "0000";
        elsif (enable='1') then
            if (load='0') then
                if (down_up='1') then
                    if (count_var = "0000") then over_var := '1';
                    end if;
                    if (over_var='1') then count_var := "1111";
                    else count_var := count_var - 1;
                    end if;
                else if (count_var = "1111") then over_var:= '1';
                end if;
                    if (over_var='1') then count_var := "0000";
                    else count_var := count_var + 1;
                    end if;
                end if;
             else count_var := data;
             end if;
        end if;    

        count <= count_var; 
        over <= over_var; 

end process;
end Behavioral;
