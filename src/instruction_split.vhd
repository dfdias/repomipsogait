library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity instruction_split is				--will work as a dual port ram.

port(
	instruction			:	in std_logic_vector(31 downto 0);

	opcode				:	out std_logic_vector(5 downto 0);
	rs					:	out std_logic_vector(4 downto 0); 
	rd					:	out std_logic_vector(4 downto 0);
	rt					:	out std_logic_vector(4 downto 0);
	shmnt				: 	out	std_logic_vector(4 downto 0);
	funct 				:   out std_logic_vector(5 downto 0)
	); 

end instruction_split;

architecture Behavioral of instruction_split is

signal s_opcode : std_logic_vector(5 downto 0);

begin

s_opcode <= instruction(31 downto 26);
s_opcode <= instruction(31 downto 26);

opcode_process : process(s_opcode,instruction)
begin
	if (s_opcode ="000000" ) then
		opcode <= s_opcode;
		rs <= instruction(25 downto 21);
		rt <= instruction(20 downto 16);
		rd <= instruction(15 downto 11);
		shmnt <= instruction(11 downto 11-4 );
		funct <= instruction(5 downto 0);

	else 
		opcode <= (others => '-');
		rs <= (others=> '0');
		rt <= (others=> '0');
		rd <= (others=> '0');
		shmnt <= (others=> '0'); 
		funct <= (others=> '0');
	end if ;
end process;

end architecture;
