library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IMemory is
	 port ( 
			  EN 	: in  std_logic;
           	  RA 	: in  std_logic_vector(7 downto 0);
			  RD 	: out std_logic_vector(15 downto 0));
end IMemory;

architecture Behavioral of IMemory is
	subtype TDataWord is std_logic_vector(15 downto 0);
	type TROM is array (0 to 7) of TDataWord;
	constant rom: TROM := (X"E180", X"E201", X"2E51", X"2E45", X"31D6", X"21AF", X"C282", X"C283");
	
	--							 3bits	  3 bits   3 bits		 7 bits
	--							[opcode]		[rs]		[rt]		[address]
	--LW $0, $3, 0			  111			000		 011		 0000000
	--LW $0, $4, 1			  111		 	000		 100		 0000001


	--SUB $3, $4, $5		  001			011		 100		 101		 0001	
	--NOR $3, $4, $4		  001			011		 100		 100		 0101
	--MUU $4, $3, $5		  001			100		 011		 101		 0110		 
		--							 3bits	  3 bits	  3 bits		3 bits	4 bits
	--							[opcode]	  	[rs]		[rt]		 [rd]	 	[func]

	--SW	$0, $5, 2		  110			000		 101		 0000010
	--SW	$0, $5, 3		  110			000		 101		 0000011
								
begin
	process(EN)
		begin
			if(EN = '1') then 
				RD <= rom(to_integer(unsigned(RA(2 downto 0))));
			end if;
	end process;
end Behavioral;

