library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;

entity signal_extender is 
port(

	unext		:	in	std_logic_vector(15 downto 0);
	
	extndd 	: 	out	std_logic_vector(31 downto 0)
	);

end signal_extender;

architecture b of signal_extender is

signal hi : std_logic_vector(15 downto 0);
signal lo : std_logic_vector(15 downto 0);

begin 

	lo <= unext;
	hi <= (others => lo(15));

	extndd <= hi & lo;

end b;
