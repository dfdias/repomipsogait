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

LIBRARY work;

ENTITY micro IS 
	PORT
	(
		pin_name1 :  IN  STD_LOGIC
	);
END micro;

ARCHITECTURE bdf_type OF micro IS 

ATTRIBUTE black_box : BOOLEAN;
ATTRIBUTE noopt : BOOLEAN;

COMPONENT mux_0
	PORT(a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 f : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END COMPONENT;
ATTRIBUTE black_box OF mux_0: COMPONENT IS true;
ATTRIBUTE noopt OF mux_0: COMPONENT IS true;

COMPONENT mux_1
	PORT(a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 f : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END COMPONENT;
ATTRIBUTE black_box OF mux_1: COMPONENT IS true;
ATTRIBUTE noopt OF mux_1: COMPONENT IS true;

COMPONENT registers
	PORT(WE : IN STD_LOGIC;
		 RA1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 RA2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 WA : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 WD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 RD1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 RD2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu
GENERIC (k : INTEGER
			);
	PORT(aluOp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 op1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 op2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dmemory
	PORT(WE : IN STD_LOGIC;
		 Addr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 WD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 RD : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT signal_extender
	PORT(unext : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 extended : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pc
	PORT(EN : IN STD_LOGIC;
		 Cnt : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT imemory
	PORT(EN : IN STD_LOGIC;
		 RA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 RD : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT muxreg
	PORT(s : IN STD_LOGIC;
		 a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 f : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN 



b2v_inst : registers
PORT MAP(WA => SYNTHESIZED_WIRE_0,
		 WD => SYNTHESIZED_WIRE_1,
		 RD1 => SYNTHESIZED_WIRE_4,
		 RD2 => SYNTHESIZED_WIRE_14);


b2v_inst10 : mux_0
PORT MAP(a => SYNTHESIZED_WIRE_14,
		 b => SYNTHESIZED_WIRE_3,
		 f => SYNTHESIZED_WIRE_5);


b2v_inst11 : alu
GENERIC MAP(k => 8
			)
PORT MAP(op1 => SYNTHESIZED_WIRE_4,
		 op2 => SYNTHESIZED_WIRE_5,
		 result => SYNTHESIZED_WIRE_15);


b2v_inst16 : dmemory
PORT MAP(Addr => SYNTHESIZED_WIRE_15,
		 WD => SYNTHESIZED_WIRE_14,
		 RD => SYNTHESIZED_WIRE_8);


b2v_inst17 : mux_1
PORT MAP(a => SYNTHESIZED_WIRE_8,
		 b => SYNTHESIZED_WIRE_15,
		 f => SYNTHESIZED_WIRE_1);


b2v_inst3 : signal_extender
PORT MAP(unext => SYNTHESIZED_WIRE_16,
		 extended => SYNTHESIZED_WIRE_3);


b2v_inst4 : pc
PORT MAP(		 Cnt => SYNTHESIZED_WIRE_11);


b2v_inst5 : imemory
PORT MAP(EN => pin_name1,
		 RA => SYNTHESIZED_WIRE_11,
		 RD => SYNTHESIZED_WIRE_16);


b2v_inst8 : muxreg
PORT MAP(a => SYNTHESIZED_WIRE_16,
		 b => SYNTHESIZED_WIRE_16,
		 f => SYNTHESIZED_WIRE_0);


END bdf_type;