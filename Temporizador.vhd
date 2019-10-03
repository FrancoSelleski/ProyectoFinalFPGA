		
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Temporizador is
generic (N: integer := 13);
port(
clk, reset: in std_logic;
tick: out std_logic;
M: in unsigned(N-1 downto 0)
);
end Temporizador;

architecture Behavioral of Temporizador is
signal r_reg, r_next : unsigned(N-1 downto 0);
signal tick_int : std_logic;
begin
	--Estado
	process(clk,reset)
	begin
		if(reset='1') then
			r_reg <= (others=>'0');
		elsif(clk'event and clk='1') then
			r_reg <= r_next;
		end if;
	end process;
	
	
	--logica del siguiente estado
	r_next <= r_reg + 1 when (tick_int='0') else
				(others=>'0');
	tick_int <= '1' when r_reg = M else
				'0';
	--logica de salida
	tick <= tick_int;

end Behavioral;

