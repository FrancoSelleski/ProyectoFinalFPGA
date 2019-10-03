library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.filtro_pkg.all;


entity Filtro_top is
	generic(
		N: natural := 20 -- Cantidad de coeficientes
	);
	port(
			clk, reset : in std_logic;
			data : in std_logic_vector(Bits_x_t-1-1 downto 0);
			start: in std_logic;
			data_filt : out std_logic_vector(Bits_x_t-1-1 downto 0);
			done : out std_logic
	);		
end Filtro_top;

architecture Behavioral of Filtro_top is
												
--	constant cte : cte_t (0 to N) := ("000000000000000000",
--												"111110111000000000",
--												"111111001101111100",
--												"000000111001001110",
--												"000001101100000000",
--												"000000000000000000",
--												"111101011110000000",
--												"111101111010100000",
--												"000011001000010000",
--												"001010001000000000",
--												"001101011000001101",
--												"001010001000000000",
--												"000011001000010000",
--												"111101111010100000",
--												"111101011110000000",
--												"000000000000000000",
--												"000001101100000000",
--												"000000111001001110",
--												"111111001101111100",
--												"111110111000000000",
--												"000000000000000000");

	constant cte : cte_t (0 to N) := ("111101111010000111",
												"111110111100011101",
												"000001100010011000",
												"000010111100111011",
												"000001000100111101",
												"111101000010101010",
												"111011000001101010",
												"111110111010001100",
												"001000011101100111",
												"010010101000111111",
												"010111000000001110",
												"010010101000111111",
												"001000011101100111",
												"111110111010001100",
												"111011000001101010",
												"111101000010101010",
												"000001000100111101",
												"000010111100111011",
												"000001100010011000",
												"111110111100011101",
												"111101111010000111");
												
	--constant cte : cte_t (0 to N) := "000000000000000001";
												
signal done_int : std_logic;
signal x_int : x_t (0 to N);
signal result_int : std_logic_vector(Bits_x_t-1 downto 0);
begin

Shift_Register_unit : entity work.Shift_register(Behavioral)
	port map (clk => clk, reset => reset, nuevo => data, start => start, salida => x_int, done => done_int);
Filt_sum_unit: entity work.filt_sum(Behavioral)
	port map (clk => clk, reset => reset, a => x_int, cte => cte, start => done_int, result =>result_int, done => done);
	
data_filt <= result_int(Bits_x_t-1-1 downto 0);


end Behavioral;

