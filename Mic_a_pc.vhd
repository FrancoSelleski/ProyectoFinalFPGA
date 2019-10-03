library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Mic_a_pc is
	port(
		clk,reset : in std_logic;
		tx : out std_logic;
		tx_full : out std_logic;
		sdata : in std_logic;
		sclk : out std_logic;
		ncs : out std_logic
		);
end Mic_a_pc;

architecture Behavioral of Mic_a_pc is
signal data_int : std_logic_vector(7 downto 0);
signal done_int : std_logic;

begin
Receptor_unit : entity work.Modulo_receptor(Behavioral)
	port map(clk => clk, reset => reset, sdata => sdata, done => done_int, data => data_int, sclk => sclk, ncs => ncs);
uart_unit : entity work.uart_tx_unit(Behavioral)
	port map (clk => clk, reset => reset, wr_uart => done_int , w_data => data_int, tx_full => tx_full, tx => tx);

end Behavioral;

