library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity registers is

	port( clk : in std_logic;
		RA1 : in  std_logic_vector(2 downto 0);
		RA2 : in  std_logic_vector(2 downto 0);
		RD1 : out std_logic_vector(7 downto 0);
		RD2 : out std_logic_vector(7 downto 0);
		WA  : in  std_logic_vector(2 downto 0);
		WD  : in  std_logic_vector(7 downto 0);

		WE : in std_logic);

end registers;

architecture Behavioral of registers is

	type reg is array (0 to 7 ) of std_logic_vector(7 downto 0);
	signal s_ram       : reg := (others=>x"00");
	signal s_RA1,s_RA2 : std_logic_vector(2 downto 0);

begin
	memory_IO : process(WE,clk)
	begin
		if rising_edge(clk) then
			if (WE = '1')then
				s_ram(to_integer(unsigned(WA))) <= WD;
			end if;
		end if;
	end process;		
		RD1 <= s_ram(to_integer(unsigned(RA1)));
		RD2 <= s_ram(to_integer(unsigned(RA2)));
end Behavioral;