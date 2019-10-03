LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.filtro_pkg.all;
 
ENTITY Test_filtro_fsmd IS
END Test_filtro_fsmd;
 
ARCHITECTURE behavior OF Test_filtro_fsmd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT filt_sum
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         a : IN  x_t (0 to 20);
         cte : IN  cte_t(0 to 20);
         start : IN  std_logic;
         result : OUT  std_logic_vector(8 downto 0);
         done : OUT  std_logic 
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal a : x_t(0 to 20) := (others =>(others => '0'));
   signal cte : cte_t(0 to 20) := (others =>(others => '0'));
   signal start : std_logic := '0';

 	--Outputs
   signal result : std_logic_vector(8 downto 0);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: filt_sum PORT MAP (
          clk => clk,
          reset => reset,
          a => a,
          cte => cte,
          start => start,
          result => result,
          done => done
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <='1';
      wait for 10 ns;	
		reset <='0';
		
		cte (0) <= "000000000000000000";
		cte (1) <="111110111000000000";
		cte (2) <="111111001101111100";
		cte (3) <="000000111001001110";
		cte (4) <="000001101100000000";
		cte (5) <="000000000000000000";
		cte (6) <="111101011110000000";
		cte (7) <="111101111010100000";
		cte (8) <="000011001000010000";
		cte (9) <="001010001000000000";
		cte (10) <="001101011000001101";
		cte (11) <="001010001000000000";
		cte (12) <="000011001000010000";
		cte (13) <="111101111010100000";
		cte (14) <="111101011110000000";
		cte (15) <="000000000000000000";
		cte (16) <="000001101100000000";
		cte (17) <="000000111001001110";
		cte (18) <="111111001101111100";
		cte (19) <="111110111000000000";
		cte (20) <="000000000000000000";
		a(0) <= "000000000";
		a(1) <= "000000000";
		a(2) <= "000000000";
		a(3) <= "000000001";
		a(4) <= "000000000";
		a(5) <= "000000000";
		a(6) <= "000000000";
		a(7) <= "000000000";
		a(8) <= "000000000";
		a(9) <= "000000000";
		a(10) <= "000000000";
		a(11) <= "000000000";
		a(12) <= "000000000";
		a(13) <= "000000000";
		a(14) <= "000000000";
		a(15) <= "000000000";
		a(16) <= "000000000";
		a(17) <= "000000000";
		a(18) <= "000000000";
		a(19) <= "000000000";
		a(20) <= "000000000";
		
		start <= '1'; 
		wait until rising_edge(done);
		start <= '0'; 
		
		wait for 15 ns;
		
		assert false report "a ver" severity failure;

      wait;
   end process;

END;
