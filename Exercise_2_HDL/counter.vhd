--Michalis Iona counter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.numeric_std.all;

entity counter is
    Port (
        clk, enable, reset, load, down_up : in std_logic;
        data : in std_logic_vector(3 downto 0);
        count : out std_logic_vector(3 downto 0);
        over : out std_logic
    );
end counter;

architecture Behavioral of Counter is
        
begin

    process(enable, reset, down_up, load, clk) is
        variable count_var : std_logic_vector(3 downto 0) := "0000";
        variable over_var : std_logic := '0';
    begin
        over_var := '0';
        if(reset = '1') then
            count_var := "0000";
            over_var := '0';
        
        -- when enabled the counter = works
        elsif enable = '1' and rising_edge(clk) then
        
            if(down_up = '0') then -- + if 0
                if(count_var = "1111") then -- if overflow, reset = 0. Over_var = 1.
                    over_var := '1';
                    count_var := "0000";
                else -- if not overflow continue +
                   count_var := count_var + 1;
                end if;
            elsif(down_up = '1') then -- - if 1
                if(count_var = "0000") then -- if underflow, reset = 15. Over_var = 1
                    over_var := '1';
                    count_var := "1111";
                else -- if not overflow continue +
                    count_var := count_var - 1;
                end if;
            end if;

            if(load = '1') then -- load data from input
                count_var := data;
            end if;
            
        end if;
        count <= count_var; 
        over <= over_var; 
    end process;
end Behavioral;