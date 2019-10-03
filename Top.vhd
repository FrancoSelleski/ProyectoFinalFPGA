library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.filtro_pkg.all;


entity Top is
	port(
		clk,reset : in std_logic;
		tx : out std_logic;
		tx_full : out std_logic;
		sdata : in std_logic;
		sclk : out std_logic;
		ncs : out std_logic
		);
end Top;

architecture Behavioral of Top is
signal done_mic : std_logic;
signal data_mic : std_logic_vector(7 downto 0);

signal done_filtro : std_logic;
signal data_filtro : std_logic_vector(7 downto 0); 

begin
Receptor_unit : entity work.Modulo_receptor(Behavioral)
	port map(clk => clk, reset => reset, sdata => sdata, done => done_mic, data => data_mic, sclk => sclk, ncs => ncs);
Filtro_unit : entity work.Filtro_top(Behavioral)
	port map (clk => clk, reset => reset, data => data_mic, start => done_mic, data_filt => data_filtro, done => done_filtro);
uart_unit : entity work.uart_tx_unit(Behavioral)
	port map (clk => clk, reset => reset, wr_uart => done_filtro , w_data => data_filtro, tx_full => tx_full, tx => tx);

end Behavioral;

