library IEEE;
use IEEE.STD_LOGIC_1164. all;
use IEEE.NUMERIC_STD.all;
use work.filtro_pkg.all;

entity filt_sum is
	generic (
		P: natural := 5;			-- Potencia de punto fijo
		N: natural := 20;		-- Cantidad de coeficientes
		N_bit: natural := 5	-- Cantidad de bits para contar coeficientes
	) ;
	port (
		clk, reset : in std_logic; 
	-- entradas del filtro: a son datos, cte son las ctes del filtro.
		a 		: in x_t (0 to N) ;
		cte 	: in cte_t (0 to N) ; 
		start	: in std_logic;
	-- salida
		result: out std_logic_vector (Bits_x_t-1 downto 0);
		done	: out std_logic	
	);
end filt_sum;

architecture Behavioral of filt_sum is
type state_type is (idle, opera ,listo);
signal acum_next, acum_reg: signed(Bits_cte_t+Bits_x_t-1 downto 0);
signal i_next, i_reg: unsigned(N_bit-1 downto 0);
signal state_next, state_reg : state_type;


begin
--Estado
	process(clk,reset)
	begin
		if(reset='1') then
			acum_reg <= (others=>'0');
			state_reg <= idle;
			i_reg <=  to_unsigned(0,N_bit);
		elsif(clk'event and clk='1') then
			acum_reg <= acum_next;
			state_reg <= state_next;
			i_reg <= i_next;
		end if;
	end process;
	
	--logica del estado siguiente
process(state_reg, acum_reg, i_reg,a,cte,start)
begin	
	state_next <= state_reg;
	i_next <= i_reg;
	acum_next <= acum_reg;
	case state_reg is
		when idle =>
			if start = '1' then
				state_next <= opera;
				i_next <= to_unsigned(N,N_bit);
				acum_next <= (others=>'0');
			end if;
		when opera =>
			acum_next <= acum_reg + signed(a(to_integer(i_reg)))*signed(cte(to_integer(i_reg)));
			i_next <= i_reg - 1;
			if i_reg = 0 then
				state_next <= listo;
			end if;
		when listo =>
			state_next <= idle;
	end case;
end process;
			
	--logica de salida
process(state_reg, acum_reg)
begin
done <='0';
result <= (others =>'0');
	case state_reg is
		when idle =>
		when opera =>
		when listo =>
			result <= std_logic_vector(acum_reg(Bits_cte_t+Bits_x_t-2 downto Bits_cte_t-1));
			done <= '1';
	end case;
	
end process;
	
end Behavioral;