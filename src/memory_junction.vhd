library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_junction is 

port(
	clk			: in std_logic;

	MemRead		: in std_logic;
	MemWrite	: in std_logic;

	address_in	: in std_logic_vector(31 downto 0);
	data_in		: in std_logic_vector(31 downto 0);
	

	data_out	: out std_logic_vector(31 downto 0)
	);


end memory_junction;

architecture struct of memory_junction is

signal address_hi : std_logic_vector(15 downto 0);
signal address_lo : std_logic_vector(15 downto 0);
signal s_address  : std_logic_vector(15 downto 0);
signal s_mem1_addr,s_mem2_addr : std_logic_vector(15 downto 0);
signal s_data_1,s_data_2 : std_logic_vector(31 downto 0);
signal s_mem1_MemRead,s_mem2_MemRead,s_mem1_MemWrite,s_mem2_MemWrite : std_logic;

begin

address_lo <= address_in(15 downto 0);
address_hi <= address_in(31 downto 16);

ram1map: entity work.data_memory(RTL)

	port map(
		clk	=> clk,

		MemRead => s_mem1_MemRead,
		MemWrite => s_mem1_MemWrite,

		address => s_address,

		data_in => data_in,

		data_out => s_data_1

		);

ram2map: entity work.data_memory(RTL)

	port map(
		clk	=> clk,

		MemRead => s_mem2_MemRead,
		MemWrite => s_mem2_MemWrite,

		address => s_address,

		data_in => data_in,

		data_out => s_data_2

		);

memory_switch: process (address_hi,MemRead,MemWrite)
begin
	s_address <= address_lo;
	s_mem2_MemWrite <= '0';
	s_mem2_MemRead <= '0';
	s_mem1_MemWrite <= '0';
	s_mem1_MemRead <= '0';
	data_out <= (others => '0');

if MemRead = '1' then
	if address_hi >= x"00000001"  then
		s_mem1_MemRead <= '0';
		s_mem2_MemRead <= '1';
		data_out <= s_data_2;
	else
		s_mem1_MemRead <= '1';
		s_mem2_MemRead <= '0';
		data_out  <= s_data_1;
	end if;
elsif MemWrite = '1' then
	if	address_hi >= x"00000001" then
		s_mem1_MemWrite <= '0';
		s_mem2_MemWrite <= '1';		
	else
		s_mem1_MemWrite <= '0';
		s_mem2_MemWrite <= '1';	
	end if;
end if;

end process;

end struct;


