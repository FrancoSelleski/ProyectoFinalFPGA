library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Modulo_receptor is
	port(
			clk, reset : in std_logic;
			sdata : in std_logic;
			data : out std_logic_vector (7 downto 0);
			done : out std_logic;
			sclk : out std_logic;
			ncs : out std_logic
			);
end Modulo_receptor;

architecture Behavioral of Modulo_receptor is
signal data_int : std_logic_vector(11 downto 0);
signal done_int : std_logic;
signal tick : std_logic;
begin
Temporizador_8_unit : entity work.Temporizador_8clocks(Behavioral)
	port map (clk => clk, reset => reset, tick => tick, M => to_unsigned(5000,13));
Pmod_mic_unit : entity work.PmodMICRefComp(PmodMic)
	port map (clk => clk, rst => reset, sdata => sdata, start => tick, sclk =>sclk , ncs =>ncs , data => data_int, done => done_int);
Rising_edge_detector_unit : entity work.Rising_edge_detector(Behavioral)
	port map (clk => clk, reset => reset, level => done_int , tick => done);
	
data <= data_int(11 downto 4);
end Behavioral;

