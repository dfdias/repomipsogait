library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity aluControl is 

port(
	 aluOp			:	in	std_logic_vector(1 downto 0);
	 instruction	:	in 	std_logic_vector(5 downto 0);

	 aluctl 		:	out std_logic_vector(2 downto 0)
	);
end aluControl;

architecture behavioral of aluControl is
  
 begin
 	
	aluctl(2) <= aluOp(0) OR (aluOp(1) AND instruction(1));
	aluctl(1) <= (NOT aluOp(1)) OR (NOT instruction(2));
	aluctl(0) <= (aluOp(1) AND instruction(0)) OR (aluOp(1) AND instruction(3));

 end behavioral; -- behvioral 
