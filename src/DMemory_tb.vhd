--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : DMemory_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Fri May 22 02:11:03 2020
-- Last update : Fri May 22 02:33:51 2020
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

entity DMemory_tb is

end entity DMemory_tb;

-----------------------------------------------------------

architecture testbench of DMemory_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal clk  : std_logic;
	signal Addr : std_logic_vector(7 downto 0);
	signal WD   : std_logic_vector(7 downto 0);
	signal WE   : std_logic;
	signal RD   : std_logic_vector(7 downto 0);

	-- Other constants


begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process CLK_GEN;



	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	stimul : process
	begin
		Addr <= "00000000";
		WE <= '0';
		wait for 2 ns;
		Addr <= "00000001";
		WE <= '0';
		wait for 2 ns;
	end process; 
	----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.DMemory(Behavioral)
		port map (
			clk  => clk,
			Addr => Addr,
			WD   => WD,
			WE   => WE,
			RD   => RD
		);

end architecture testbench;