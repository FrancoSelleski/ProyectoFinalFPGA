library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Rising_edge_detector is
	port(
	 clk, reset : in std_logic;
	 level : in std_logic;
	 tick : out std_logic
	);
end Rising_edge_detector;

architecture Behavioral of Rising_edge_detector is
type state_type is (zero, one);
signal state_reg, state_next : state_type;
begin
--registro de estado
process (clk, reset)
begin 
	if (reset ='1') then
		state_reg <= zero;
	elsif (clk'event and clk ='1') then
		state_reg <=  state_next;
	end if;
end process;

--logica de proximo estado
process(state_reg, level)
begin 
	state_next <= state_reg;
	case state_reg is 
		when zero =>
			if level ='1' then
				state_next <= one;
			end if;
		when one =>
			if level ='0' then
				state_next <= zero;
			end if;
		end case;
end process;

-- logica de salida
process(state_reg, level)
begin 
	tick <= '0';
	case state_reg is 
		when zero => 
			if level = '1' then
				tick <= '1';
			end if;
		when others => 
			tick <= '0';
		end case;
end process;

end Behavioral;

