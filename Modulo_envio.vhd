library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Modulo_envio is
	generic (N :integer := 8);
	port (
			clk, reset : in std_logic ;
			tx : out std_logic ;
			tx_full : out std_logic;
			w_data : in std_logic_vector(7 downto 0)
	);
end Modulo_envio;

architecture Behavioral of Modulo_envio is
signal tick : std_logic; 

begin
Temporizador_unit :entity work.Temporizador(Behavioral)
	port map (clk => clk, reset => reset, tick => tick, M => to_unsigned(5000,13));
uart_unit : entity work.uart_tx_unit(Behavioral)
	port map (clk => clk, reset => reset, wr_uart => tick, w_data => w_data, tx_full => tx_full, tx => tx);

end Behavioral;

