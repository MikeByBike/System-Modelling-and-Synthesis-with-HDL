library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debouncer is
  Port (
    btn_raw : in STD_LOGIC;    -- Raw button signal
    btn_deb : out STD_LOGIC    -- Debounced button signal
  );
end debouncer;

architecture Behavioral of debouncer is
  -- Define states for the state machine
  type state_type is (IDLE, WAIT_PRESS, WAIT_RELEASE);
  signal state : state_type := IDLE;

  -- Define debouncing parameters
  constant DEBOUNCE_TIME : integer := 25;  -- Adjust this based on your clock frequency

  -- Internal signals
  signal debounce_counter : integer range 0 to DEBOUNCE_TIME := 0;

begin
  -- Debouncing process
  process(btn_raw)
  begin
    if rising_edge(btn_raw) then
      case state is
        when IDLE =>
          if btn_raw = '0' then
            state <= WAIT_PRESS;
            debounce_counter <= DEBOUNCE_TIME;
          else
            btn_deb <= '0';
          end if;

        when WAIT_PRESS =>
          if btn_raw = '0' then
            if debounce_counter > 0 then
              debounce_counter <= debounce_counter - 1;
            else
              state <= IDLE;
              btn_deb <= '1';
            end if;
          else
            state <= IDLE;
          end if;

        when WAIT_RELEASE =>
          if btn_raw = '1' then
            if debounce_counter > 0 then
              debounce_counter <= debounce_counter - 1;
            else
              state <= IDLE;
            end if;
          else
            state <= IDLE;
          end if;

        when others =>
          state <= IDLE;
      end case;
    end if;
  end process;

end Behavioral;

