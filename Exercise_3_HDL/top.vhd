library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity top is
    Port (SW0 :in std_logic;
         SW1 :in std_logic;
         SW2 :in std_logic;
         SW3 :in std_logic;
         SW4 :in std_logic;
         SW5 :in std_logic;
         SW6 :in std_logic;
         SW7 :in std_logic;

         GCLK :in std_logic;

         LD0 : out std_logic;
         LD1 : out std_logic;
         LD2 : out std_logic;
         LD3 : out std_logic;
         LD4 : out std_logic;
         LD5 : out std_logic;
         LD7 : out std_logic);

end top;

architecture Behavioral of top is
                                              
    signal virtual_clock : std_logic;

    signal virtual_count : std_logic_vector(7 downto 0);
    signal virtual_enable : std_logic;

    component counter is
        Port (
            clk, enable, reset, load, down_up : in std_logic;
            data : in std_logic_vector(7 downto 0);

            count : out std_logic_vector(7 downto 0);
            over : out std_logic
        );
    end component counter;

    component pwm is port (
            clock : in std_logic;
            width : in std_logic_vector(3 downto 0);
            led : out std_logic);

    end component pwm;

begin



    process(GCLK) is
        variable counter : integer := 0;
    begin
        if rising_edge (GCLK ) then
            counter := counter + 1;

            if counter > 1000000 then
                virtual_clock <= '1';
                counter := 0;
            else
                virtual_clock <= '0';
            end if;
        end if;
    end process;


    counter_connections:
 Entity work.counter(Behavioral)
        Port map(
            clk => virtual_clock,
            count  =>virtual_count,
            data(0) => SW0,
            data(1) => SW1,
            data(2) => SW2,
            data(3) => SW3,
            data(4) => SW0,
            data(5) => SW1,
            data(6) => SW2,
            data(7) => SW3,
            enable => SW4,
            down_up => SW5,
            load => SW6,
            reset => SW7,
            over =>LD4
        );

    LD0 <= virtual_count(0);
    LD1 <= virtual_count(1);
    LD2 <= virtual_count(2);

    LD7 <= GCLK;

    pwm_connections:
 Entity work.pwm(Behavioral)
        Port map(
            enable=> SW4,
            clk => GCLK,
            width =>virtual_count,
            led => LD5
        );

end Behavioral;