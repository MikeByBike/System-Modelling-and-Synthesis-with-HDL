-- Michalis Iona top
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.numeric_std.all;


entity top is
    -- opening ports for switches 
    Port (SW0 :in std_logic;
         SW1 :in std_logic;
         SW2 :in std_logic;
         SW3 :in std_logic;
         SW4 :in std_logic;
         SW5 :in std_logic;
         SW6 :in std_logic;
         SW7 :in std_logic;
        
        -- system clock
         GCLK :in std_logic;

         --leds
         LD0 : out std_logic;
         LD1 : out std_logic;
         LD2 : out std_logic;
         LD3 : out std_logic;
         LD4 : out std_logic);

end top;

architecture Behavioral of top is
    component counter is
        Port (
            clk, enable, reset, load, down_up : in std_logic;
            data : in std_logic_vector(3 downto 0);
            count : out std_logic_vector(3 downto 0);
            over : out std_logic
        );
    end component counter;

    signal div_out : STD_LOGIC := '0';
    
begin
    process(GCLK)
    variable div_count : integer range 0 to 100000000 := 0;
    begin
        if rising_edge(GCLK) then
            div_count := div_count +1;
            if ( div_count = 100000000 ) then
                div_out <= not div_out;
                div_count := 0;
            end if;
         end if;
     end process;

            
DUT: counter port map(
            clk => div_out,
            reset => SW0,
            enable => SW1,
            load => SW2,
            down_up => SW3,
            data(0) => SW4,
            data(1) => SW5,
            data(2) => SW6,
            data(3) => SW7,
            count(0) => LD0,
            count(1) => LD1,
            count(2) => LD2,
            count(3) => LD3,
            over => LD4
        );

end Behavioral;