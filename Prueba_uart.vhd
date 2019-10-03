library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Prueba_uart is
generic (N :integer := 8);
	port (
			clk, reset : in std_logic ;
			tx : out std_logic ;
			tx_full : out std_logic
	);
end Prueba_uart;

architecture Behavioral of Prueba_uart is
signal tick_int : std_logic;
signal acum_int : std_logic_vector(N-1 downto 0);
begin
Temporizador_unit :entity work.Temporizador(Behavioral)
	port map (clk => clk, reset => reset, tick => tick_int, M => to_unsigned(5000,13));
Acumulador_unit : entity work.Acumulador_2_bits(Behavioral)
	generic map (N => 8)
	port map (clk => clk, reset => reset, en=> tick_int, acum=>acum_int);
uart_unit : entity work.uart_tx_unit(Behavioral)
	port map (clk => clk, reset => reset, wr_uart => tick, w_data => acum_int, tx_full => tx_full, tx => tx);

end Behavioral;

