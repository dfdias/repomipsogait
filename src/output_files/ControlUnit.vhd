library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;

entity ControlUnit is
	port(clk : in std_logic;
		rst : in std_logic;

		opcode : in std_logic_vector(2 downto 0);
		func   : in std_logic_vector(3 downto 0);

		EnPC   : out std_logic;
		RI     : out std_logic;
		RegWr  : out std_logic;
		RegDst : out std_logic;
		ALUSrc : out std_logic;

		ALUOp : out std_logic_vector(3 downto 0);

		MemWr    : out std_logic;
		MemtoReg : out std_logic);
end ControlUnit;


architecture Behavioral of ControlUnit is

	TYPE state IS (Reset, Fetch, Decode, Execute, RegUpdate, WriteMem);
	signal PS, NS : state;

	type optype IS (NOP,ARITH,ADDI,SW,LW,INVALID);
	signal op, op_next            : optype ;
	signal s_opcode,s_opcode_next : std_logic_vector(2 downto 0);

begin
	seq_proc : process(clk,PS,NS,rst)
	begin
		if rst = '1' then
			PS <= Reset;
		elsif rising_edge(clk) then
			PS       <= NS;
			s_opcode <= s_opcode_next;
			op       <= op_next;
		end if;
	end process;
	comb_proc : process(PS,s_opcode,op,func)
	begin
		NS            <= PS;
		s_opcode_next <= s_opcode;
		op_next       <= op;
		EnPC          <= '0';
		RI            <= '0';
		RegWr         <= '0';
		RegDst        <= '0';
		ALUSrc        <= '0';
		ALUOp         <= (others => '0');
		MemWr         <= '0';
		MemtoReg      <= '0';


		case PS is
			when Reset =>
				EnPC     <= '0';
				RI       <= '0';
				RegWr    <= '0';
				RegDst   <= '0';
				ALUSrc   <= '0';
				ALUOp    <= (others => '0');
				MemWr    <= '0';
				MemtoReg <= '0';
				NS       <= Fetch;
			when Fetch =>
				RI            <= '1';
				EnPC          <= '1';
				s_opcode_next <= opcode; --stores into flip flop
				NS            <= Decode;
			when Decode =>
				if s_opcode = "000" then
					op_next <= NOP;
				elsif s_opcode = "001" then
					op_next <= ARITH;
				elsif s_opcode = "100" then
					op_next <= ADDI;
				elsif s_opcode = "110" then
					op_next <= SW;
				elsif s_opcode <= "111" then
					op_next <= LW;
				else
					op_next <= INVALID;
				end if;
				NS <= Execute;

			when Execute =>
				case op is
					when NOP =>
						NS <= Fetch;
					when ARITH =>
						ALUSrc <= '0';
						ALUOp  <= func;
						NS     <= RegUpdate;
					when LW =>
						ALUSrc   <= '0';
						MemToReg <= '1';
						ALUOp    <= "0000";
						NS       <= RegUpdate;
					when SW =>
						ALUSrc <= '1';
						ALUOp  <= "0000";
						NS     <= WriteMem;
					when ADDI =>
						ALUSrc <= '1';
						ALUOp  <= "0000";
						NS     <= RegUpdate;
					when INVALID =>
						Null;
				end case;
			when RegUpdate =>
				EnPC     <= '0'; --regupdate
				RI       <= '0';
				RegWr    <= '1';
				RegDst   <= '1';
				MemtoReg <= '1';
				ALUSrc   <= '1';
				MemWr    <= '0';
				NS       <= Fetch ;

			when WriteMem =>
				MemWr  <= '1';
				ALUSrc <= '1';
				ALUOp  <= "0000";
				NS     <= Fetch;

		end case;
	end process;
end Behavioral;
