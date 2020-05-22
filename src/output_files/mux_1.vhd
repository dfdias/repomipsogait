-- Copyright (C) 2019  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition"
-- CREATED		"Tue May 12 22:00:53 2020"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY altera;
USE altera.maxplus2.all; 

LIBRARY work;

ENTITY mux_1 IS 
PORT 
( 
	a	:	IN	 STD_LOGIC_VECTOR(7 DOWNTO 0);
	b	:	IN	 STD_LOGIC_VECTOR(7 DOWNTO 0);
	f	:	OUT	 STD_LOGIC_VECTOR(7 DOWNTO 0)
); 
END mux_1;

ARCHITECTURE bdf_type OF mux_1 IS 
BEGIN 

-- instantiate macrofunction 

b2v_inst17 : mux
GENERIC MAP(k => 8)
PORT MAP(a => a,
		 b => b,
		 f => f);

END bdf_type; 