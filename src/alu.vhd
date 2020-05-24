library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity alu is
	generic(size : integer := 8);
	port(
		aluOp  : in  std_logic_vector(3 downto 0);
		op1    : in  std_logic_vector(size-1 downto 0);
		op2    : in  std_logic_vector(size-1 downto 0);

		branch : out std_logic;
		result : out std_logic_vector(size-1 downto 0));

end alu;

architecture Behavioral of alu is

	signal s_result    : std_logic_vector(size-1 downto 0);
	signal s_resultaux : integer := 0;


begin
	operations : process(aluOp,op1,op2,s_resultaux)
	begin
		s_resultaux <= 0;
		branch <= '0';
		if(aluOp = "0000") then
			s_resultaux <= to_integer(unsigned(op1)) + to_integer(unsigned(op2));
			s_result    <= std_logic_vector(to_signed(s_resultaux,8));
		elsif(aluOp = "0001") then
			s_resultaux <= to_integer(unsigned(op1)) - to_integer(unsigned(op2));
			s_result    <= std_logic_vector(to_signed(s_resultaux,8));
		elsif(aluOp = "0010") then
			s_result <= op1 and op2;
		elsif(aluOp = "0011") then
			s_result <= op1 or op2;
		elsif(aluOp = "0100") then
			s_result <= op1 xor op2;
		elsif(aluOp = "0101") then
			s_result <= op1 nor op2;
		elsif(aluOp = "0110") then
			s_resultaux <= to_integer(unsigned(op1)) * to_integer(unsigned(op2));
			s_result    <= std_logic_vector(to_unsigned(s_resultaux,8));
		elsif(aluOp = "0111") then
			s_resultaux <= to_integer(signed(op1)) * to_integer(signed(op2));
			s_result    <= std_logic_vector(to_signed(s_resultaux,8));
		elsif(aluOp = "1000") then
			s_result <= std_logic_vector(unsigned(op1) sll to_integer(unsigned(op2)));
		elsif(aluOp = "1001") then
			s_result <= std_logic_vector(unsigned(op1) srl to_integer(unsigned(op2)));
		elsif(aluOp = "1010") then
			s_result <= to_stdlogicvector(to_bitvector(std_logic_vector(op1)) sra to_integer(unsigned(op2)));
		elsif(aluOp = "1011") then
			if(op1 = op2) then
				s_result <= "00000001";
			else
				s_result <= X"00";
			end if;
		elsif(aluOp = "1100") then
			if(signed(op1) < signed(op2)) then
				s_result <= "00000001";
			else
				s_result <= X"00";
			end if;
		elsif(aluOp = "1101")then
			if(unsigned(op1) < unsigned(op2)) then
				s_result <= "00000001";
				branch 	 <= '1';
			else
				s_result <= X"00";
			end if;
		elsif(aluOp = "1110") then
			if(signed(op1) > signed(op2)) then
				s_result <= "00000001";
			else
				s_result <= X"00";
			end if;
		elsif(aluOp = "1111")then
			if(unsigned(op1) > unsigned(op2)) then
				s_result <= "00000001";
			else
				s_result <= X"00";
			end if;
		else
			s_result <= (others => '0');
		end if;
	end process;

	result <= s_result;
end Behavioral;