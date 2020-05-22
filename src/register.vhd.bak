----------------------------------------------------------------------------------
-- Company: UA	
-- Engineer: Duarte Ferreira Dias
-- 
-- Create Date: 23.09.2016 12:02:02
-- Design Name: 
-- Module Name: SingleCycleCpu - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity register is				--will work as a dual port ram.

port(
	clk				 	: 	in std_logic; --for multycycle
	RegWrite			:	in std_logic;  --control bit defines the data direction on the register

	data_1_adrr			:	in std_logic_vector(4 downto 0);
	data_2_adrr			:	in std_logic_vector(4 downto 0);
	write_adrr			:	in std_logic_vector(4 downto 0);	

	write_data			:	in std_logic_vector(31 downto 0);

	data_1				:	out std_logic_vector(31 downto 0);
	data_2				:	out std_logic_vector(31 downto 0)

	); 

end register;

architecture RTL of register is

type reg is array (0 to 31 ) of std_logic_vector(5 downto 0);
signal s_ram : st;

signal s_addr1,s_addr2 : std_logic_vector(5 downto 0);

begin
	s_addr1 <= data_1_adrr;
	s_addr2 <= data_2_adrr;

memory_IO: process(RegWrite,clk);
begin	
	if rising_edge(clk) then
		if (RegWrite = '1')then
			s_ram(write_adrr) <= write_data;
		end if;
	else
		data_1 <= s_ram(s_addr1);
		data_2 <= s_ram(s_addr2);
	
	end if ;
end process;

end RTL;