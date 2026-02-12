library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (SW0 :in std_logic; -- direction
         SW1 :in std_logic; -- IF SW1 & SW2 is 0 then 1 second, if SW1 & SW2 is 1 then 3 seconds ELSE is 5 Seconds
         SW2 :in std_logic;
         SW3 :in std_logic; -- reset
         SW4 :in std_logic; -- alarm
         SW6 :in std_logic; -- 1/10
         SW7 :in std_logic; -- 1/100

         GCLK : in std_logic;

         LD0 : out std_logic;
         LD1 : out std_logic;
         LD2 : out std_logic;
         LD3 : out std_logic;
         LD5 : out std_logic

        );
end top;

architecture Behavioral of top is

    signal virtual_clock : std_logic;
    signal virtual_state : std_logic_vector(2 downto 0);
    signal virtual_led1 : std_logic_vector(7 downto 0);
    signal virtual_led2 : std_logic_vector(7 downto 0);
    signal virtual_led3 : std_logic_vector(7 downto 0);
    signal virtual_edge: std_logic;
    signal virtual_freq: integer;

    component controller is
        Port (
            clock : in std_logic;
            direction : in std_logic;
            reset : in std_logic;
            edge: in std_logic;
            state : out std_logic_vector(2 downto 0);
            led1 : out std_logic_vector(7 downto 0);
            led2 : out std_logic_vector(7 downto 0);
            led3 : out std_logic_vector(7 downto 0);
            indication : out std_logic
        );

    end component controller;

    component time_clock is
        Port (GCLK : in std_logic;
             speed_1 : in std_logic;
             speed_2 : in std_logic;
             speed_10: in std_logic;
             speed_100: in std_logic;
	         state : in std_logic_vector(2 downto 0);
	         alarm: in std_logic;
	         freq: out integer;
             divided_clock : out std_logic
            );

    end component time_clock;
    
    component pwm is
        Port (
            clock : in std_logic;
            width : in std_logic_vector(3 downto 0);
            input: in std_logic_vector (2 downto 0);
            frequency: in integer;
            led : out std_logic
            );
    end component pwm;
    
    component edge_detect is
    Port ( 
           clock : in STD_LOGIC;
           alarm : in STD_LOGIC;
           detect_edge : out STD_LOGIC; 
           led_edge : out std_logic 
           );
    end component edge_detect;

begin

    control_edge_detector:
 entity work.edge_detect(Behavioral)
    port map (
           clock => GCLK,
           alarm => SW4,
           detect_edge =>  virtual_edge,
           led_edge => LD3
    );

    control_connections:
 entity work.controller(Behavioral)
        Port map(
            clock => virtual_clock,
            state => virtual_state,

            reset => SW3,
            direction => SW0,
--            edge => virtual_edge,

            led1  => virtual_led1,
            led2  => virtual_led2,
            led3  => virtual_led3,
            indication => LD5
        );
        
    pwm_connections:
 entity work.pwm(Behavioral)
        Port map(
            clock => GCLK,

            width1 =>virtual_led1,
            width2 =>virtual_led2,
            width3 =>virtual_led3,

            input => virtual_state,
            frequency => virtual_freq,
            
            led1 => LD0,
            led2 => LD1,
            led3 => LD2
        );


    time_clock_connections:
 entity work.time_clock(Behavioral)
        Port map(
            clock => GCLK,
            speed_1 =>SW1,
            speed_2 =>SW2,
            speed_10 => SW6,
            speed_100 => SW7,
            alarm => virtual_edge,
            divided_clock =>virtual_clock,
            freq => virtual_freq,
            state => virtual_state
        );
        
end Behavioral;