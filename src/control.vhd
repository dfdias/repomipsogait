library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control is
    Port ( opcode 	: in STD_LOGIC_VECTOR (5 downto 0);
           RegDst 	: out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           AluSrc 	: out STD_LOGIC;
           --PCSrc 	: out STD_LOGIC;
           MemRead 	: out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           MemToReg : out STD_LOGIC;
           Branch   : out STD_LOGIC;
           ALUop 	: out STD_LOGIC_VECTOR(1 downto 0));
end control;

architecture Behavioral of control is

--opcode : STD_LOGIC_VECTOR(5 downto 0);
begin

--opcode <= isntruction(31 downto 26);

opcode_handler: process(opcode)
begin
	if (opcode <= "000000") then---rtype op 
		RegDst <= '1';
		AluSrc <= '0';
		MemToReg <= '0';
		RegWrite <= '1';
		MemRead <= '0';
		MemWrite <= '0';
		Branch <= '0';
		ALUop <= "10";
	elsif opcode <= "100011" then --lw
		RegDst <= '0';
		AluSrc <= '1';
		MemToReg <= '1';
		RegWrite <= '1';
		MemRead <= '1';
		MemWrite <= '0';
		Branch <= '0';
		ALUop <= "00";
	elsif opcode <= "101011" then --sw
		RegDst <= 'X';
		AluSrc <= '1';
		MemToReg <= 'X';
		RegWrite <= '0';
		MemRead <= '0';
		MemWrite <= '1';
		Branch <= '0';
		ALUop <= "00";
	elsif opcode <= "000100" then  --beq
		RegDst <= 'X';
		AluSrc <= '0';
		MemToReg <= 'X';
		RegWrite <= '0';
		MemRead <= '0';
		MemWrite <= '0';
		Branch <= '1';
		ALUop <= "01";
	else 
		RegDst <= '0';
		AluSrc <= '0';
		MemToReg <= '0';
		RegWrite <= '0';
		MemRead <= '0';
		MemWrite <= '0';
		Branch <= '0';
		ALUop <= "11";
	end if;
end process;
end Behavioral;
