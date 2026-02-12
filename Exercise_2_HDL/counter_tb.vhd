-- Michalis Iona testbench
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.numeric_std.all;


entity counter_tb is
end counter_tb;

architecture Behavioral of counter_tb is
    component counter
        Port (
        clk, enable, reset, load, down_up : in std_logic;
        data : in std_logic_vector(3 downto 0);
        count : out std_logic_vector(3 downto 0);
        over : out std_logic
        );
    end component;

--architecture Behavioral of counter_tb is
--    component counter_another_way
--        Port (
--        clk, enable, reset, load, down_up : in std_logic;
--        data : in std_logic_vector(3 downto 0);
--        count : out std_logic_vector(3 downto 0);
--        over : out std_logic
--        );
--    end component;

    signal test_clk, test_enable, test_reset, test_load, test_down_up : std_logic := '0';
    signal test_data : std_logic_vector(3 downto 0) := "0000";
    signal test_count : std_logic_vector(3 downto 0) := "0000";
    signal test_over : std_logic := '0';

begin
    DUT: counter port map (
    clk => test_clk, 
    enable => test_enable, 
    reset => test_reset,
    load => test_load,
    down_up => test_down_up, 
    data => test_data, 
    count => test_count, 
    over => test_over);

--begin
--    DUT: counter_another_way port map (
--    clk => test_clk, 
--    enable => test_enable, 
--    reset => test_reset,
--    load => test_load,
--    down_up => test_down_up, 
--    data => test_data, 
--    count => test_count, 
--    over => test_over);
    
    test_reset <= '1' after 0 ns, '0' after 50 ns;
    test_enable <= '1' after 0 ns, '1' after 100 ns;
    test_load <= '0' after 0 ns, '1' after 50 ns, '0' after 150 ns;
    test_down_up <= '0' after 0 ns, '1' after 200 ns;
    test_data <= "1011" after 100 ms, "1100" after 200 ns;
    test_clk <= not test_clk after 50 ns;

end Behavioral;