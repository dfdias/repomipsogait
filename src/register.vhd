library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.NUMERIC_STD.ALL;


entity regimemory is			

port(
	RegWrite			:	in std_logic;  --control bit defines the data direction on the register

	data_1_adrr			:	in std_logic_vector(4 downto 0);

	write_adrr			:	in std_logic_vector(4 downto 0);	

	write_data			:	in std_logic_vector(31 downto 0);

	data_1				:	out std_logic_vector(31 downto 0)

	); 

end regimemory;

architecture RTL of regimemory is

type reg is array (0 to 31 ) of std_logic_vector(5 downto 0);
signal s_ram : reg;

signal s_addr1,s_addr2 : std_logic_vector(5 downto 0);

begin
	s_addr1 <= data_1_adrr;


memory_IO: process(RegWrite,clk)
begin	
	if (RegWrite = '1')then
		s_ram(to_integer(unsigned(write_adrr))) <= write_data;
	else
		data_1 <= s_ram(to_integer(unsigned(s_addr1)));
	end if ;
end process;

end RTL;
