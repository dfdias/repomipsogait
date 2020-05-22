--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : datapath_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Thu May 21 22:47:11 2020
-- Last update : Fri May 22 22:09:40 2020
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2020 User Company Name
-------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use std.textio.all;
--use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity interconnect_tb is

end entity interconnect_tb;

-----------------------------------------------------------

architecture testbench of interconnect_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal EnPC     : std_logic;
	signal RegWr    : std_logic;
	signal RegDst   : std_logic;
	signal AluSrc   : std_logic;
	signal MemtoReg : std_logic;
	signal MemWr    : std_logic;
	signal RI       : std_logic;
	signal clk      : std_logic;
	signal AluOp    : std_logic_vector(3 downto 0);
	signal inst     : std_logic_vector(15 downto 0);
	signal rst 		: std_logic;



begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for 20 ns;
		clk <= '0';
		wait for 20 ns;
	end process CLK_GEN;

------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	--first instruction
	stim : process
	begin
	rst <= '1';
	wait for 50 ns;
	rst <= '0';
	wait for 1400 ns;
	end process;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.datapath(struct)
		port map (
			EnPC     => EnPC,
			RegWr    => RegWr,
			RegDst   => RegDst,
			rst      => rst,
			AluSrc   => AluSrc,
			MemtoReg => MemtoReg,
			MemWr    => MemWr,
			RI       => RI,
			clk      => clk,
			AluOp    => AluOp,
			inst     => inst
		);

	ControlUnit_1 : entity work.ControlUnit
		port map (
			clk      => clk,
			rst      => rst,
			opcode   => inst(15 downto 13),
			func     => inst(3 downto 0),
			EnPC     => EnPC,
			RI       => RI,
			RegWr    => RegWr,
			RegDst   => RegDst,
			ALUSrc   => ALUSrc,
			ALUOp    => ALUOp,
			MemWr    => MemWr,
			MemtoReg => MemtoReg
		);
end testbench;