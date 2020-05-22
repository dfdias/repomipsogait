library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.std_logic_arith.all;
use IEEE.NUMERIC_STD.ALL;


entity datapath is

	port(EnPC : in std_logic;
		RegWr    : in  std_logic;
		RegDst   : in  std_logic;
		AluSrc   : in  std_logic;
		MemtoReg : in  std_logic;
		MemWr    : in  std_logic;
		RI       : in  std_logic;
		clk      : in  std_logic;
		AluOp    : in  std_logic_vector(3 downto 0);
		inst     : out std_logic_vector(15 downto 0));

end ;

architecture struct of datapath is

	-- signals for intercpnectios
	signal s_inst         : std_logic_vector(15 downto 0);
	signal s_inst_addr    : std_logic_vector(7 downto 0);
	signal s_sig_extended : std_logic_vector(7 downto 0);
	signal s_WA           : std_logic_vector(2 downto 0);
	signal s_MemtoRegData : std_logic_vector(7 downto 0);
	signal s_OP2          : std_logic_vector(7 downto 0);
	signal s_res          : std_logic_vector(7 downto 0);
	signal s_RD1,s_RD2    : std_logic_vector(7 downto 0);
	signal s_RD           : std_logic_vector(7 downto 0);


	--contro unit control bits
	signal s_ENPC     : std_logic;
	signal s_RegWr    : std_logic;
	signal s_ALUSrc   : std_logic;
	signal s_RegDst   : std_logic;
	signal s_MemWr    : std_logic;
	signal s_MemtoReg : std_logic;
	signal s_RI       : std_logic;
	signal s_clk      : std_logic;
	signal s_aluOp    : std_logic_vector(3 downto 0);

begin

	s_ENPC     <= ENPC;
	s_RegWr    <= RegWr;
	s_ALUSrc   <= ALUSrc;
	s_RegDst   <= RegDst;
	s_MemWr    <= MemWr ;
	s_MemtoReg <= MemtoReg;
	s_RI       <= RI ;
	s_clk	   <= clk;
	s_aluOp <= aluOP;
	--instruction  fetch area
	pc : entity work.pc(Behavioral) --program counter
		port map (
			EN  => s_ENPC,
			cnt => s_inst_addr
		);


	IMemory : entity work.IMemory(Behavioral) --Instruction memory
		port map(
			EN  => s_RI,
			RA  => s_inst_addr,
			RD  => s_inst,
			clk => s_clk
		);
	--signal extension
	SIG_EXTENDER : entity work.signal_extender(Behavioral)
		port map(
			unext    => s_inst(6 downto 0),
			extended => s_sig_extended
		);

	--reg_mux
	wa_mux : entity work.mux(Behavioral)
		generic map(size => 3)
		port map(
			sel    => s_RegDst,
			input0 => s_inst(6 downto 4),
			input1 => s_inst(9 downto 7),
			muxOut => s_WA
		);

	--registers
	registers : entity work.registers(Behavioral)
		port map(
			clk => s_clk,
			RA1 => s_inst(12 downto 10),
			RA2 => s_inst(9 downto 7),

			WA => s_WA,
			WD => s_MemtoRegData,

			WE => s_RegWr,

			RD1 => s_RD1,
			RD2 => s_RD2
		);

	--alu
	alu_mux : entity work.mux(Behavioral)
		generic map(size => 8)
		port map(
			sel    => s_AluSrc,
			input0 => s_RD2,
			input1 => s_sig_extended,
			muxOut => s_OP2
		);
	alu : entity work.alu(Behavioral)
		generic map(size => 8)
		port map(
			aluOp => s_aluOp,
			op1   => s_RD1,
			op2   => s_OP2,

			result => s_res
		);



	--memory access
	mem2reg : entity work.mux(Behavioral)
		generic map (size => 8)
		port map(
			input0 => s_res,
			input1 => s_RD,
			sel    => s_MemtoReg,

			muxOut => s_MemtoRegData
		);

	--memory block(RTL)

	data_memory : entity work.DMemory(Behavioral)
		port map(
			clk  => s_clk,
			addr => s_res,
			WE   => s_MemWr,
			WD   => s_RD2,
			RD   => s_RD
		);

	inst <= s_inst;
end architecture ; -- struct