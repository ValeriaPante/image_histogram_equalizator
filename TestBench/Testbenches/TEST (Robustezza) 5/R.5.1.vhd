library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb is
end project_tb;

architecture projecttb of project_tb is
constant c_CLOCK_PERIOD         : time := 100 ns;
signal   tb_done                : std_logic;
signal   mem_address            : std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst                 : std_logic := '0';
signal   tb_start               : std_logic := '0';
signal   tb_clk                 : std_logic := '0';
signal   mem_o_data,mem_i_data  : std_logic_vector (7 downto 0);
signal   enable_wire            : std_logic;
signal   mem_we                 : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);
signal i: std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned( 0, 2)); 


signal RAM0: ram_type := (0 => std_logic_vector(to_unsigned( 2, 8)), 
						 1 => std_logic_vector(to_unsigned( 3, 8)), 
						 2 => std_logic_vector(to_unsigned( 144, 8)),
						 3 => std_logic_vector(to_unsigned( 144, 8)),
						 4 => std_logic_vector(to_unsigned( 173, 8)),
						 5 => std_logic_vector(to_unsigned( 148, 8)),
						 6 => std_logic_vector(to_unsigned( 142, 8)),
						 7 => std_logic_vector(to_unsigned( 190, 8)),
						 others => (others =>'0')); 



signal RAM1: ram_type := (0 => std_logic_vector(to_unsigned( 4, 8)), 
						 1 => std_logic_vector(to_unsigned( 4, 8)), 
						 2 => std_logic_vector(to_unsigned( 81, 8)),
						 3 => std_logic_vector(to_unsigned( 75, 8)),
						 4 => std_logic_vector(to_unsigned( 74, 8)),
						 5 => std_logic_vector(to_unsigned( 67, 8)),
						 6 => std_logic_vector(to_unsigned( 82, 8)),
						 7 => std_logic_vector(to_unsigned( 70, 8)),
						 8 => std_logic_vector(to_unsigned( 70, 8)),
						 9 => std_logic_vector(to_unsigned( 74, 8)),
						 10 => std_logic_vector(to_unsigned( 70, 8)),
						 11 => std_logic_vector(to_unsigned( 82, 8)),
						 12 => std_logic_vector(to_unsigned( 71, 8)),
						 13 => std_logic_vector(to_unsigned( 62, 8)),
						 14 => std_logic_vector(to_unsigned( 62, 8)),
						 15 => std_logic_vector(to_unsigned( 66, 8)),
						 16 => std_logic_vector(to_unsigned( 67, 8)),
						 17 => std_logic_vector(to_unsigned( 69, 8)),
						 others => (others =>'0')); 



signal RAM2: ram_type := (0 => std_logic_vector(to_unsigned( 3, 8)), 
						 1 => std_logic_vector(to_unsigned( 2, 8)), 
						 2 => std_logic_vector(to_unsigned( 189, 8)),
						 3 => std_logic_vector(to_unsigned( 202, 8)),
						 4 => std_logic_vector(to_unsigned( 235, 8)),
						 5 => std_logic_vector(to_unsigned( 163, 8)),
						 6 => std_logic_vector(to_unsigned( 177, 8)),
						 7 => std_logic_vector(to_unsigned( 176, 8)),
						 others => (others =>'0')); 









component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;
MEM : process(tb_clk)
begin
	 if tb_clk'event and tb_clk = '1' then
		 if enable_wire = '1' then
			 if i = std_logic_vector(to_unsigned( 0, 2)) then
				 if mem_we = '1' then
					 RAM0(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM0(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 1, 2)) then
				 if mem_we = '1' then
					 RAM1(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM1(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 2, 2)) then
				 if mem_we = '1' then
					 RAM2(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM2(conv_integer(mem_address)) after 1 ns;
				 end if;
			 end if;
		 end if;
	 end if;
end process;






test : process is
begin
	 wait for 23 ns;
	 wait for c_CLOCK_PERIOD;
	 tb_rst <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait for 34 ns;
	 tb_rst <= '0';
	 wait for c_CLOCK_PERIOD;
	 wait for 74 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 65 ns;
	 i <= std_logic_vector(to_unsigned( 1, 2));

 
 	 wait for 42 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 12 ns;
	 i <= std_logic_vector(to_unsigned( 2, 2));

 
 	 wait for 54 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 69 ns;



	 assert RAM0(8) = std_logic_vector(to_unsigned( 16, 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM0(8))))  severity failure; 
 	 assert RAM0(9) = std_logic_vector(to_unsigned( 16, 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM0(9))))  severity failure; 
 	 assert RAM0(10) = std_logic_vector(to_unsigned( 248, 8)) report " TEST FALLITO (WORKING ZONE). Expected  248  found " & integer'image(to_integer(unsigned(RAM0(10))))  severity failure; 
 	 assert RAM0(11) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM0(11))))  severity failure; 
 	 assert RAM0(12) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM0(12))))  severity failure; 
 	 assert RAM0(13) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(13))))  severity failure; 
 

	 assert RAM1(18) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(18))))  severity failure; 
 	 assert RAM1(19) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM1(19))))  severity failure; 
 	 assert RAM1(20) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM1(20))))  severity failure; 
 	 assert RAM1(21) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM1(21))))  severity failure; 
 	 assert RAM1(22) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(22))))  severity failure; 
 	 assert RAM1(23) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM1(23))))  severity failure; 
 	 assert RAM1(24) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM1(24))))  severity failure; 
 	 assert RAM1(25) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM1(25))))  severity failure; 
 	 assert RAM1(26) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM1(26))))  severity failure; 
 	 assert RAM1(27) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(27))))  severity failure; 
 	 assert RAM1(28) = std_logic_vector(to_unsigned( 144, 8)) report " TEST FALLITO (WORKING ZONE). Expected  144  found " & integer'image(to_integer(unsigned(RAM1(28))))  severity failure; 
 	 assert RAM1(29) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(29))))  severity failure; 
 	 assert RAM1(30) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(30))))  severity failure; 
 	 assert RAM1(31) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM1(31))))  severity failure; 
 	 assert RAM1(32) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM1(32))))  severity failure; 
 	 assert RAM1(33) = std_logic_vector(to_unsigned( 112, 8)) report " TEST FALLITO (WORKING ZONE). Expected  112  found " & integer'image(to_integer(unsigned(RAM1(33))))  severity failure; 
 

	 assert RAM2(8) = std_logic_vector(to_unsigned( 104, 8)) report " TEST FALLITO (WORKING ZONE). Expected  104  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
 	 assert RAM2(9) = std_logic_vector(to_unsigned( 156, 8)) report " TEST FALLITO (WORKING ZONE). Expected  156  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure; 
 	 assert RAM2(10) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(10))))  severity failure; 
 	 assert RAM2(11) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(11))))  severity failure; 
 	 assert RAM2(12) = std_logic_vector(to_unsigned( 56, 8)) report " TEST FALLITO (WORKING ZONE). Expected  56  found " & integer'image(to_integer(unsigned(RAM2(12))))  severity failure; 
 	 assert RAM2(13) = std_logic_vector(to_unsigned( 52, 8)) report " TEST FALLITO (WORKING ZONE). Expected  52  found " & integer'image(to_integer(unsigned(RAM2(13))))  severity failure; 
 

	 assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end projecttb; 

