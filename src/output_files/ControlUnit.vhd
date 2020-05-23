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
	signal op, op_next : optype ;

	signal s_aluop, s_aluop_next : std_logic_vector(3 downto 0);
	signal s_alusrc,s_alusrc_next,s_regdst,s_regdst_next,s_memtoreg,s_memtoreg_next : std_logic;

begin
	seq_proc : process(clk,rst)
	begin
		if rst = '1' then
			PS <= Reset;
		elsif rising_edge(clk) then
			PS <= NS;
			s_aluop <= s_aluop_next;
			s_regdst <= s_regdst_next;
			s_memtoreg <= s_memtoreg_next;
			s_alusrc <= s_alusrc_next;
			op <= op_next;
		end if;
	end process;
	comb_proc : process(PS,opcode,op,func)
	begin
		NS       <= PS;
		op_next  <= op;
		s_regdst_next <=	s_regdst ;
		s_memtoreg_next <=	s_memtoreg; 
		s_alusrc_next <=	s_alusrc; 
		EnPC     <= '0';
		RI       <= '0';
		RegWr    <= '0';
		RegDst   <= '0';
		ALUSrc   <= '0';
		ALUOp    <= (others => '0');
		MemWr    <= '0';
		MemtoReg <= '0';


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
				RI   <= '1';
				EnPC <= '1';
				NS   <= Decode;
			when Decode =>
				if opcode = "000" then
					op_next <= NOP;
				elsif opcode = "001" then
					op_next <= ARITH;
				elsif opcode = "100" then
					op_next <= ADDI;
				elsif opcode = "110" then
					op_next <= SW;
				elsif opcode <= "111" then
					op_next <= LW;
				else
					op_next <= INVALID;
				end if;
				NS <= Execute;

			when Execute =>
				case op is
					when NOP =>
						NS <= RegUpdate;
					when ARITH =>
						ALUSrc <= '0';
						ALUOp  <= func;
						NS     <= RegUpdate;
					when LW =>
						ALUSrc <= '0';
						ALUOp  <= "0000";
						NS     <= RegUpdate;
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
				case op is
					when NOP =>
						Null;
					when ARITH =>
						ALUOp  <= func;
						ALUSrc <= '0';
						RegDst   <= '0';
						MemtoReg <= '0';	
					when LW =>
						ALUOp  <= "0000";
						ALUSrc <= '0';
						RegDst   <= '1';
						MemtoReg <= '1';	
					when ADDI =>
						ALUOp  <= "0000";
						ALUSrc <= '1';
						RegDst   <= '1';
						MemtoReg <= '0';						
					when others =>
						NULL;

				end case;
				RegWr    <= '1';
				NS       <= Fetch ;

			when WriteMem =>
				MemWr  <= '1';
				ALUSrc <= '1';
				ALUOp  <= "0000";
				NS     <= Fetch;

		end case;
	end process;

end Behavioral;
