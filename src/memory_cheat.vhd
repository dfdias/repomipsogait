library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_cheat is 

port (
		address_in 		: in std_logic_vector(31 downto 0);
		address_out 	: out std_logic_vector(15 downto 0)
	);

end memory_cheat;

architecture b of memory_cheat is


begin
address_decision:process(address_in)
begin
	if address_in(31 downto 16) = X"1001" then
		address_out <= address_in(15 downto 0);
	else
		address_out <= (others => '0');
	end if ;
end process;

end b;