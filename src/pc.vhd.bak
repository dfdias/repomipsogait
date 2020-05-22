library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc is
generic(k :integer :=5);
port(
	clk 	:	in std_logic;
	addr_in : 	in	std_logic_vector(k downto 0);


	addr_out :	out	std_logic_vector(k downto 0)
	);

end pc;

architecture b of pc is
signal previous_address : std_logic_vector(k downto 0);

begin
add_control:process(clk)
	begin
		previous_address <= addr_in;
		if rising_edge(clk) then
			addr_out <= addr_in; 	
		end if;
		if falling_edge(clk) then
			addr_out <= previous_address;
		end if;
	end process;
end b;