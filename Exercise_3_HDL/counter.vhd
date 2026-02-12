library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.numeric_std.all;

entity counter is
    Port (
        clk, enable, reset, load, down_up : in std_logic;
        data : in std_logic_vector(7 downto 0);

        count : out std_logic_vector(7 downto 0);
        over : out std_logic
    );
end counter;

architecture Behavioral of Counter is

begin

    process(enable, reset, down_up, load, clk) is
        variable count_var : std_logic_vector(7 downto 0) := "00000000";
        variable over_var : std_logic := '0';


    begin

        count <= count_var;
        over <= over_var;
        over_var := '0';
        if(reset = '1') then
            count_var := "00000000";
            over_var := '0';

        elsif enable = '1' and rising_edge(clk) then
            if(down_up = '0') then -- add if 0
                if(count_var = "11111111") then
                over_var := '1';
                count_var := "00000000";
                else -- if not overflowing +
                    count_var := count_var + 1;
                end if;
            elsif(down_up = '1') then -- - if 1
                if(count_var = "00000000") then
                over_var := '1';
                count_var := "11111111";
                else -- if not overflowing -
                    count_var := count_var - 1;
                end if;
            end if;

            if(load = '1') then -- loading the data from input
                count_var := data(7 downto 0);
            end if;
        end if;
    end process;
end Behavioral;