library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity registers_tb is
end;

architecture TB of registers_tb is
		signal s_clk   		: std_logic;
		signal s_WE				: std_logic;
		signal s_RA1			: std_logic_vector(4 downto 0);
		signal s_RA2			: std_logic_vector(4 downto 0);
		signal s_WD				: std_logic_vector(4 downto 0);	

		signal s_WA				: std_logic_vector(31 downto 0);

		signal s_RD1			: std_logic_vector(31 downto 0);
		signal s_RD2			: std_logic_vector(31 downto 0);

begin

uut: entity work.registers(Behavioral)
	port map(clk       	  => s_clk,
				WE 	  		  => s_WE,
				RA1   		  => s_RA1,
				RA2   		  => s_RA2,
				WA    		  => s_WA,
				WD    		  => s_WD,
				RD1        	  => s_RD1,
				RD2        	  => s_RD2);

process
begin
	s_clk <= '1'; wait for 10 ns;
	s_clk <= '0'; wait for 10 ns;
end process;

	process
	begin
		s_WE <= '1';
		s_WD <= "00010";
		s_WA <= X"01100100";

		wait for 100 ns;

		s_WE <= '0';
		wait for 25 ns;
      s_WE <= '0';
      s_RD1 <= "00010";
      s_RD2 <= "00011";
        
		wait for 50 ns;
		s_WE <= '1';
		s_WA <= "00011";
		s_WD <= X"01100110";

		wait for 25 ns;
		s_WE <= '0';
		s_RD1 <= "00010";
		s_RD2 <= "00011";
		wait;
	end process;

end;
