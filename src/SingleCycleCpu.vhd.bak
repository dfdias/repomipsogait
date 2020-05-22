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


entity SingleCycleCpu is

port(
	clk  	: in std_logic;

	result	: out std_logic_vector(31 downto 0)
	); 

end SingleCycleCpu;

architecture struct of SingleCycleCpu is

    signal s_clk                                        :   std_logic;

	signal s_aluOp										:	std_logic_vector(1 downto 0);
	signal s_instruction 								: 	std_logic_vector(31 downto 0);
	signal s_aluCtl 									: 	std_logic_vector(2 downto 0);
	signal s_result 									: 	std_logic_vector(31 downto 0);
	signal s_zero 										: 	std_logic;
	signal s_data1,s_data2,s_write_data					: 	std_logic_vector(31 downto 0);
	signal s_alu_op2, s_signext_out 					: 	std_logic_vector(31 downto 0);


	signal s_RegWrite									:	std_logic;
	signal s_RegDst										:	std_logic;
	signal s_AluSrc										:	std_logic; 
	signal s_Branch										:	std_logic;
	signal s_MemReg										:	std_logic;
	signal s_MemWrite									:	std_logic;
	signal s_MemRead									:	std_logic;	

	signal s_memReadData								: 	std_logic_vector(31 downto 0);

	signal s_data_1_addr, s_data_2_addr, s_write_addr 	:	std_logic_vector(4 downto 0);

	signal s_rs,s_rd,s_rt,s_shmnt 						: 	std_logic_vector(4 downto 0);
	signal s_opcode,s_funct 							:	std_logic_vector(5 downto 0);

	signal s_adder4,s_alupc,s_pcmux,s_pc_out			:	std_logic_vector(31 downto 0);
    signal s_shifted                                    :   std_logic_vector(31 downto 0);

    signal mem_adress_shifted							:	std_logic_vector(15 downto 0);


begin

	--s_instrucion <= instruction;

--instruction  fetch area
pc :	entity work.pc(b)
		generic map(k => 31)
		port map(
				clk => s_clk,
				addr_in => s_pcmux,
				addr_out => s_pc_out
				);

adder_4 : entity work.alu(Behavioral)
	generic map( k => 31)
	port map(
			aluOp  => "0010",
			op1    => s_pc_out,
			op2    => std_logic_vector(to_signed(4,32)),

			result => s_adder4);
			
			s_shifted <= s_signext_out(29 downto 0) &  "00";

alu_pc : entity work.alu(Behavioral)
	generic map(k => 31)
	port map(
			aluOp  => "0010",
			op1    => s_adder4,
			op2    => s_shifted,

			result => s_alupc);

pc_mux	:	entity	work.mux(b)
	generic map(k => 31)
	port map(
			a => s_adder4,
			b => s_alupc,
			s => (s_Branch and s_zero),

			f => s_pcmux 	
		);



--instruction execution section

instruction_split : entity work.instruction_split(Behavioral)
	port map (	instruction => s_instruction,
				
				opcode	=> s_opcode,			
				rs		=> s_rs,	
				rd		=> s_rd,		
				rt		=> s_rt,	
				shmnt	=> s_shmnt,
				funct 	=> s_funct);

regdst_mux : entity work.mux(b)
	generic map (k => 4)
	port map(	a => s_rt,
				b => s_rd,
				--c => (others => '1'),---jum operation
				s => s_RegDst,

				f => s_write_addr
				);
	
s_data_1_addr <= s_rs;
s_data_2_addr <= s_rt;


registers	:	entity work.registers(RTL)
	port map(
	            clk => s_clk,
				RegWrite => s_RegWrite,

				data_1_adrr => s_data_1_addr,
				data_2_adrr => s_data_2_addr,
				write_adrr	=> s_write_addr,		

				write_data => s_write_data,

				data_1 => s_data1,
				data_2 => s_data2
			);


control 	: entity work.control(Behavioral)
	port map (
				opcode => s_opcode,

				RegWrite => s_RegWrite,
				RegDst => s_RegDst,
				AluSrc => s_AluSrc,
				ALUop => s_aluOp,
				MemToReg => s_MemReg,
				MemRead => s_MemRead,
				MemWrite => s_MemWrite,
				Branch => s_Branch
			);
aluControl 	: entity work.aluControl(behavioral)
	port map(
			aluOp => s_aluOp,
			instruction => s_funct,

			aluctl =>  s_aluCtl
			);
signal_extender	: entity work.signal_extender(b)
	port map(
				unext => s_instruction(15 downto 0),
				extndd => s_signext_out
			);
alusrc_mux : entity work.mux(b)
	generic map (k => 31)
	port map(	a => s_data2,
				b => s_signext_out,
				s => s_AluSrc,

				f => s_alu_op2
				);	


alu: entity work.alu(Behavioral)
	generic map(k => 31)
	port map(
			aluOp  => '0' & s_aluCtl,
			op1    => s_data1,
			op2    => s_alu_op2,

			result => s_result,
			zero => s_zero);


	result <= s_result;


--memory access
mem2reg: entity work.mux(b)
	generic map (k => 31)
	port map(
				a => s_result,
				b => s_memReadData,
				s => s_MemReg,

				f => s_write_data
			);

--memory cheat

memory_cheat : entity work.memory_cheat(b)
	port map(
			address_in => s_result,
			address_out =>mem_adress_shifted
			);

	
--memory block(RTL)

data_memory : entity work.data_memory(RTL)
	port map(
		clk => s_clk,

		MemRead => s_MemRead,
		MemWrite => s_MemWrite,

		address => mem_adress_shifted,

		data_in => s_data2,
		data_out => s_memReadData
		);


end architecture ; -- struct
