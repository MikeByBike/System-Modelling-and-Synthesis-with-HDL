library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.numeric_std.all;


entity counter_test is
end counter_test;

architecture Behavioral of counter_test is
    component counter
        Port (
            clk, enable, reset, load, down_up : in std_logic;
            data : in std_logic_vector(7 downto 0);

            count : out std_logic_vector(7 downto 0);
            over : out std_logic
        );
    end component;

    signal test_clk, test_enable, test_reset, test_load, test_down_up : std_logic := '0';
    signal test_data : std_logic_vector(7 downto 0) := "00001111";

    signal test_count : std_logic_vector(7 downto 0) := "00000000";
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
    
    process
        begin
            test_clk <=  '0';
            wait for 10ns;
            test_clk <=  '1';
            wait for 10ns;
        end process;
    
        process
        begin
            test_reset <= '1';
            wait for 50ns;
            test_reset <= '0';
            wait for 50ns;
            test_enable <= '1';
            wait for 200ns;
            
            test_down_up <= '1';
            wait for 200ns;
            
            test_load <= '1';
            wait for 50ns;
            
            test_load <= '0';
            wait for 200ns;
            test_enable <= '0';

    end process;
end Behavioral;