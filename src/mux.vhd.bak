library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
generic(k :integer :=5);
port(
	a 	: 	in	std_logic_vector(k downto 0);
	b 	:	in	std_logic_vector(k downto 0);
	s 	: 	in	std_logic;

	f	:	out	std_logic_vector(k downto 0)
	);

end mux;

architecture b of mux is
begin

process(s)
begin
	if (s = '1') then
		f <= a;
	else
		f <= b;
	end if;
end process;
end b;
