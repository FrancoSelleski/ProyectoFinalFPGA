library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.filtro_pkg.all;


entity Shift_register is
generic (
		N: natural := 20		-- Cantidad de coeficientes
	) ;
port(
		clk,reset : in std_logic;
		nuevo : in std_logic_vector (Bits_x_t-1-1 downto 0); --nueva entrada del registro
		start : in std_logic;
		salida : out x_t (0 to N);   --todos los registros 
		done : out std_logic
);
end Shift_register;

architecture Behavioral of Shift_register is
type state_type is (idle, opera, listo);
signal state_reg, state_next : state_type;
signal data_reg, data_next : x_t (0 to N);

begin
--Estado
process(clk,reset)
	begin
		if(reset='1') then
			data_reg <= (others =>(others => '0'));
			state_reg <= idle;
		elsif(clk'event and clk='1') then
			data_reg <= data_next;
			state_reg <= state_next;
		end if;
	end process;
	
-- logica de siguiente estado

process(state_reg,start,nuevo,data_reg)
begin
	state_next <= state_reg;
	data_next <= data_reg;
	case state_reg is 
		when idle =>
			if start ='1' then
				state_next <= opera;
			end if;
		when opera =>
			data_next(0)<= '0' & nuevo;
			data_next(1 to N) <= data_reg(0 to N-1);
			--data_next(0 to N) <= ('0' & nuevo)&data_reg(0 to N-1);
			state_next <= listo;
		when listo =>
			state_next <= idle; 
	end case;

end process;

--logica de salida

salida <= data_reg;

process(state_reg,data_reg)
begin

	case state_reg is 
		when idle => 
				done <= '0';
		when opera =>
				done <= '0';
		when listo =>
			done <='1';
	end case;
end process;

end Behavioral;

