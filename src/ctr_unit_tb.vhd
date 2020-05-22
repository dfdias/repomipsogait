library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ctr_unit_tb is 
end ;

architecture Stimulus of ctr_unit_tb  is
	signal 	s_opcode 		: 	std_logic_vector(2 downto 0);
	signal 	s_func	 		:	std_logic_vector(3 downto 0);
	signal	s_ALUOp			:	std_logic_vector(3 downto 0);
	
	signal 	s_clk, s_rst	:	std_logic;
	signal 	s_EnPC			:	std_logic;
	signal	s_RI				:	std_logic;
	signal	s_RegWr			:	std_logic;
	signal	s_RegDst			:	std_logic;
	signal	s_ALUSrc			:	std_logic;	  
	signal	s_MemWr			:	std_logic;
	signal	s_MemtoReg		:	std_logic;	
begin

clk_process : process
	begin 
		s_clk <= '1';	wait for 10 ns;
		s_clk <= '0'; wait for 10 ns;
	end process ;
	
uut : entity work.ControlUnit(Behavioral)
		  port map(
		  clk			=> s_clk,
		  rst			=> s_rst,
		  func		=> s_func,
		  opcode		=> s_opcode,
		  EnPC		=> s_EnPC,
		  RI			=> s_RI,
		  RegWr		=> s_RegWr,
		  RegDst		=> s_RegDst,
		  ALUSrc		=>	s_ALUSrc,
		  ALUOp		=>	s_ALUOp,
		  MemWr		=>	s_MemWr,
		  MemtoReg	=>	s_MemtoReg);
		
cut : process
begin
	s_rst <= '1';
	wait for 0 ns;
	s_rst <= '0';
	s_opcode <= "001";
	s_func <= "0000";
	wait for 100 ns;
	s_opcode <= "100";
	wait for 100 ns;
	s_opcode <= "101";
	wait for 100 ns;
	s_opcode <= "110";
	wait for 100 ns;
	s_opcode <= "111";
	wait for 100 ns;

end process;						
end Stimulus;
