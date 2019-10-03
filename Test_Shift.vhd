LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.filtro_pkg.all;
 
ENTITY Test_Shift IS
END Test_Shift;
 
ARCHITECTURE behavior OF Test_Shift IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Shift_register
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         nuevo : IN  std_logic_vector(7 downto 0);
         start : IN  std_logic;
         salida : OUT  x_t (0 to 20);
         done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal nuevo : std_logic_vector(7 downto 0) := (others => '0');
   signal start : std_logic := '0';

 	--Outputs
   signal salida : x_t(0 to 20);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Shift_register PORT MAP (
          clk => clk,
          reset => reset,
          nuevo => nuevo,
          start => start,
          salida => salida,
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
		reset <='1';
		wait for 15 ns;
		reset <='0';
		
		start <='1';
		nuevo <= "00000001";
		wait until rising_edge(done);
		start <='0';
		
		wait for 10 ns;
		
		start <='1';
		nuevo <= "00000011";
		wait until rising_edge(done);
		start <='0';
		
		wait for 10 ns;
		
		start <='1';
		nuevo <= "00000010";
		wait until rising_edge(done);
		start <='0';
		
		wait for 10 ns;
		
		assert false report "aver" severity failure;

      wait;
   end process;

END;
