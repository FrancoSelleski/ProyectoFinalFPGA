library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Temporizador_8clocks is
generic (N: integer := 13);
port(
clk, reset: in std_logic;
tick: out std_logic;
M: in unsigned(N-1 downto 0)
);
end Temporizador_8clocks;

architecture Behavioral of Temporizador_8clocks is
signal r_reg, r_next : unsigned(N-1 downto 0);
--signal tick_int : std_logic;
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
	r_next <= r_reg + 1 when r_reg < M else
				(others=>'0');
				
				
				
	tick <= '1' when r_reg < 8 else
				'0';
				
--	tick <= '1' when M-9 < r_reg and r_reg < M else
--				'0';


	--tick_1_clk <= '1' when r_reg =
	--logica de salida
	--tick <= tick_int;

end Behavioral;



