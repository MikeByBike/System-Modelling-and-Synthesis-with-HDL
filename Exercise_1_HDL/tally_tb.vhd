-- Michalis Iona Exercise 1 testbench
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.NUMERIC_std.all;


entity tally_testbench is
end tally_testbench;

architecture testbench of tally_testbench is
    component tally
        Port(
           scoresA,scoresB : in std_logic_vector(2 downto 0);
           winner : out std_logic_vector(1 downto 0)
           );
    end component;
    
    signal test_A , test_B : std_logic_vector (2 downto 0);
    signal test_winner : std_logic_vector (1 downto 0);
    
    -- function which makes all binaries to integers to know in the end what is the result of the tally.
    function output (votes : std_logic_vector (2 downto 0))
        return integer is variable score : integer;
        begin
            case votes is
                when "000" => score := 0;
                when "001" => score := 1;
                when "010" => score := 1;
                when "100" => score := 1;
                when "101" => score := 2;
                when "110" => score := 2;
                when "011" => score := 2;
                when "111" => score := 3;
            end case;
        return score;
     end output;
     
     -- Comparison of results.
     function compare (voteA : std_logic_vector (2 downto 0); voteB : std_logic_vector (2 downto 0))
        return std_logic_vector is variable winner : std_logic_vector (2 downto 0);
        begin
            if output(voteA) > output(voteB) then
                winner := "10";
            elsif output(voteB) > output(voteA) then
                winner := "01";
            elsif output(voteA) = output(voteB) then
                winner := "11";
            elsif voteA = "000" then
                winner := "00";
            elsif voteB = "000" then
                winner := "00";
            end if;
            return winner;
        end compare;
        
        
    begin
    DUT: tally port map (scoresA => test_A, scoresB => test_B, winner => test_winner);
    
    --Loop going through all results and pick out a winner.
    process 
    begin
        for i in 0 to 7 loop
            for j in 0 to 7 loop
                test_A <= std_logic_vector(to_unsigned(i, test_A'length));
                test_B <= std_logic_vector(to_unsigned(j, test_B'length));
                wait for 10ns;
                assert test_winner = compare(test_A, test_B);
                    report "ERROR"
                    severity error;
                
            end loop;
        end loop;
    end process;
end testbench;