library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DMemory is				
	port( clk				: in std_logic;
		  Addr				:	in  std_logic_vector(7 downto 0);	
		  WD 					:	in  std_logic_vector(7 downto 0);
		  WE					:	in  std_logic;  
		  RD					:	out std_logic_vector(7 downto 0)); 
end DMemory;

architecture Behavioral of DMemory is

	type reg is array (0 to 255 ) of std_logic_vector(7 downto 0);
	signal s_ram : reg := (X"04",X"05",others => X"00");

begin	
memory_IO: process(WE,clk)
begin
	if rising_edge(clk) then		
		if (WE = '1')then
			s_ram(to_integer(unsigned(Addr))) <= WD;
		end if;		
	end if;
end process;
	RD <= s_ram(to_integer(unsigned(Addr)));
end Behavioral;