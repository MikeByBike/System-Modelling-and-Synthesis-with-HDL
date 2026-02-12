
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity edge_detect is
    Port ( 
           clock : in STD_LOGIC;
           alarm : in STD_LOGIC;
           detect_edge : out STD_LOGIC; 
           led_edge : out std_logic 
           );
end edge_detect;

architecture Behavioral of edge_detect is

signal reg1 :std_logic := '0';
signal reg2 :std_logic := '0';
signal reg_edge : std_logic := '0';
begin

reg: process(clock)
variable  count: integer := 0;
variable count_led : integer := 0;

begin

   if rising_edge(clock) then
      reg1  <= alarm;
      reg2  <= reg1;
      
      if count < 10000 then 
          if reg2 = '1' and reg1 = '0' then
                reg_edge <= '1';
          end  if;
          if reg_edge = '1' then
                reg_edge <= '1';
                count := count + 1;
          end if;
      else
         count := 0;
         reg_edge <= '0';
      end if;
       
      detect_edge <= reg_edge;
      
  end if;

end process;

end Behavioral;
