library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is

port(	
		clk		:	in std_logic;

		MemRead	:	in std_logic;
		MemWrite:	in std_logic;

		address	:	in std_logic_vector(15 downto 0);

		data_in : 	in std_logic_vector(31 downto 0);

		data_out:	out std_logic_vector(31 downto 0)
		);
end data_memory;

architecture RTL of data_memory is

type st is array(0 to 65536) of std_logic_vector(31 downto 0);

signal s_ram :st;
signal s_addr : std_logic_vector(15 downto 0);

begin

s_addr <= address;

MemoryIO: process(MemRead,MemWrite,clk)

begin	
	if rising_edge(clk) then
		if (MemWrite = '1')then
			s_ram(to_integer(unsigned(s_addr))) <= data_in;
		end if;
    end if;
    if (MemRead = '1') then
	 	data_out <= s_ram(to_integer(unsigned(s_addr)));
	else
		data_out <= (others => '0');
	end if;
end process;

end RTL;
