
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Acumulador_2_bits is
	generic(N: integer:=2);
	port(
	clk,reset: in std_logic;
	en: in std_logic;
	acum: out unsigned(N-1 downto 0)
	);
end Acumulador_2_bits;

architecture Behavioral of Acumulador_2_bits is
signal r_next, r_reg: unsigned(N-1 downto 0);

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
	--logica del estado siguiente
	r_next <= r_reg+1 when (en='1') else
				r_reg;
	--logica de salida
	acum <= r_reg;
				
end Behavioral;

