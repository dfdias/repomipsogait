library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxreg is

port(
	a 	: 	in	std_logic_vector(15 downto 0);
	b 	:	in	std_logic_vector(15 downto 0);
	s 	: 	in	std_logic;

	f	:	out	std_logic_vector(2 downto 0)
	);

end muxreg;

architecture b of muxreg is
begin

process(s)
begin
	if (s = '1') then
		f <= a(6 downto 4);
	else
		f <= b(9 downto 7) ;
	end if;
end process;
end b;
