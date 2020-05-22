----------------------------------------------------------------------------------
-- Company: UA	
-- Engineer: Duarte Ferreira Dias
-- 
-- Create Date: 23.09.2016 12:02:02
-- Design Name: 
-- Module Name: alu - Behavioral
-- Project Name: MIPS-processor
-- Target Devices: Spartan 3E
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
generic(k : integer := 31);
port(
		aluOp 	: in std_logic_vector(3 downto 0);
		op1   	: in std_logic_vector(k downto 0);
		op2   	: in std_logic_vector(k downto 0);
		
		result 	: out std_logic_vector(k downto 0);
		zero 	: out std_logic);

end alu;

architecture Behavioral of alu is

signal s_zeros : std_logic_vector(31 downto 0);
signal s_result  : std_logic_vector(31 downto 0);


begin
s_zeros <= (others => '0');
operations: process(aluOp,op1,op2)
begin
    s_result <= (others => '0');
    if(aluOp = "0000") then
        s_result <= op1 and op2;
    elsif(aluOp = "0001") then 
        s_result <= op1 or op2;
    elsif(aluOp = "0010") then
        s_result <= std_logic_vector(unsigned(op1) + unsigned(op2));
    elsif(aluOp = "0110") then
        s_result <= std_logic_vector(signed(op1) - signed(op2));
    elsif(aluOp = "0111") then
    	s_result <= (others => '0');
    	if((op1 = op2) or (op1 > op2))then
    	s_result(0) <= '1';
    	end if;
    elsif(aluOp <= "1100")then
    	s_result <= op1 nor op2;
    end if;
end process;

zeros : process(s_result)
begin
	if (s_result <= s_zeros) then
		zero <= '1';
	else 
		zero <= '0';
	end if ;
end process;

result <= s_result;
end Behavioral;
