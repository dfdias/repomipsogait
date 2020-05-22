--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : datapath_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Thu May 21 22:47:11 2020
-- Last update : Fri May 22 21:06:18 2020
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

entity datapath_tb is

end entity datapath_tb;

-----------------------------------------------------------

architecture testbench of datapath_tb is

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
	Stim : process
	begin
		--state reset 
		EnPC     <= '0';
		RI       <= '0';
		EnPC     <= '0';
		RI       <= '0';
		RegWr    <= '0';
		RegDst   <= '0';
		ALUSrc   <= '0';
		ALUOp    <= (others => '0');
		MemWr    <= '0';
		MemtoReg <= '0';
		wait for 80 ns;

		--first instruction
		EnPC 	<= '1';--fetch
		RI 		<= '1';
		RegWr 	<= '0';
		wait for 30 ns;

		EnPC 	<= '0';--decode
		RI 		<= '0';
		wait for 30 ns;

		EnPC 	<= '0';--execute
		RI 		<= '0';
		ALUOp		<= "0000";
		wait for 30 ns;	

		EnPC 	<= '0';--regupdate
		RI 		<= '0';
		RegWr 	<= '1';
		RegDst 	<= '1';
		MemtoReg <= '1';
		ALUSrc 	<=	'1';
		MemWr	<=	'0';
		wait for 30 ns;

		--second instruction
		EnPC 	<= '1';--fetch
		RI 		<= '1';
		RegWr 	<= '0';
		wait for 30 ns;

		EnPC 	<= '0';--decode
		RI 		<= '0';
		wait for 30 ns;

		EnPC 	<= '0';--execute
		RI 		<= '0';
		ALUOp		<= "0000";
		wait for 30 ns;	

		EnPC 	<= '0';--regupdate
		RI 		<= '0';
		RegWr 	<= '1';
		RegDst 	<= '1';
		MemtoReg <= '1';
		ALUSrc 	<=	'1';
		MemWr	<=	'0';
		wait for 30 ns;
				--second instruction
		EnPC 	<= '1';--fetch
		RI 		<= '1';
		wait for 30 ns;

		EnPC 	<= '0';--decode
		RI 		<= '0';
		wait for 30 ns;

		EnPC 	<= '0';--execute
		RI 		<= '0';
		ALUOp		<= "0000";
		wait for 30 ns;	

		EnPC 	<= '0';--regupdate
		RI 		<= '0';
		RegWr 	<= '0';
		RegDst 	<= '1';
		MemtoReg <= '1';
		ALUSrc 	<=	'1';
		MemWr	<=	'0';
		wait for 30 ns;

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

end testbench;