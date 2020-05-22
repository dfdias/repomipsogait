library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;

entity pc is

	port( EN 	:	in 	std_logic;
			Cnt	:	out	std_logic_vector(7 downto 0)
		 );
end pc;

architecture Behavioral of pc is
signal addr : unsigned(7 downto 0) := (others => '0');
begin
process(EN)
	begin
		--if rst = '1' then
			--Cnt <= (others => '0');
		if rising_edge(EN) then 
			addr <= addr + '1';	
		end if;
	end process;
		Cnt <= std_logic_vector(addr);
end Behavioral;
