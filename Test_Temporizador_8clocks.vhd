LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Test_Temporizador_8clocks IS
END Test_Temporizador_8clocks;
 
ARCHITECTURE behavior OF Test_Temporizador_8clocks IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Temporizador_8clocks
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         tick : OUT  std_logic;
         M : IN  unsigned(12 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal M : unsigned(12 downto 0) := (others => '0');

 	--Outputs
   signal tick : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Temporizador_8clocks PORT MAP (
          clk => clk,
          reset => reset,
          tick => tick,
          M => M
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
		reset <= '1';
		wait for 15 ns;
		reset <= '0';
		
		wait until rising_edge(clk);
      M<= to_unsigned(50,13);

      -- insert stimulus here 

      wait;
   end process;

END;
