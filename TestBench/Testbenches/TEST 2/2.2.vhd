library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb is
end project_tb;

architecture projecttb of project_tb is
constant c_CLOCK_PERIOD         : time := 10 ns;
signal   tb_done                : std_logic;
signal   mem_address            : std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst                 : std_logic := '0';
signal   tb_start               : std_logic := '0';
signal   tb_clk                 : std_logic := '0';
signal   mem_o_data,mem_i_data  : std_logic_vector (7 downto 0);
signal   enable_wire            : std_logic;
signal   mem_we                 : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);
signal i: std_logic_vector(0 downto 0) := std_logic_vector(to_unsigned( 0, 1)); 


signal RAM0: ram_type := (0 => std_logic_vector(to_unsigned( 10, 8)), 
						 1 => std_logic_vector(to_unsigned( 10, 8)), 
						 2 => std_logic_vector(to_unsigned( 255, 8)),
						 3 => std_logic_vector(to_unsigned( 0, 8)),
						 4 => std_logic_vector(to_unsigned( 41, 8)),
						 5 => std_logic_vector(to_unsigned( 35, 8)),
						 6 => std_logic_vector(to_unsigned( 190, 8)),
						 7 => std_logic_vector(to_unsigned( 132, 8)),
						 8 => std_logic_vector(to_unsigned( 225, 8)),
						 9 => std_logic_vector(to_unsigned( 108, 8)),
						 10 => std_logic_vector(to_unsigned( 214, 8)),
						 11 => std_logic_vector(to_unsigned( 174, 8)),
						 12 => std_logic_vector(to_unsigned( 82, 8)),
						 13 => std_logic_vector(to_unsigned( 144, 8)),
						 14 => std_logic_vector(to_unsigned( 73, 8)),
						 15 => std_logic_vector(to_unsigned( 241, 8)),
						 16 => std_logic_vector(to_unsigned( 241, 8)),
						 17 => std_logic_vector(to_unsigned( 187, 8)),
						 18 => std_logic_vector(to_unsigned( 233, 8)),
						 19 => std_logic_vector(to_unsigned( 235, 8)),
						 20 => std_logic_vector(to_unsigned( 179, 8)),
						 21 => std_logic_vector(to_unsigned( 166, 8)),
						 22 => std_logic_vector(to_unsigned( 219, 8)),
						 23 => std_logic_vector(to_unsigned( 60, 8)),
						 24 => std_logic_vector(to_unsigned( 135, 8)),
						 25 => std_logic_vector(to_unsigned( 12, 8)),
						 26 => std_logic_vector(to_unsigned( 62, 8)),
						 27 => std_logic_vector(to_unsigned( 153, 8)),
						 28 => std_logic_vector(to_unsigned( 36, 8)),
						 29 => std_logic_vector(to_unsigned( 94, 8)),
						 30 => std_logic_vector(to_unsigned( 13, 8)),
						 31 => std_logic_vector(to_unsigned( 28, 8)),
						 32 => std_logic_vector(to_unsigned( 6, 8)),
						 33 => std_logic_vector(to_unsigned( 183, 8)),
						 34 => std_logic_vector(to_unsigned( 71, 8)),
						 35 => std_logic_vector(to_unsigned( 222, 8)),
						 36 => std_logic_vector(to_unsigned( 179, 8)),
						 37 => std_logic_vector(to_unsigned( 18, 8)),
						 38 => std_logic_vector(to_unsigned( 77, 8)),
						 39 => std_logic_vector(to_unsigned( 200, 8)),
						 40 => std_logic_vector(to_unsigned( 67, 8)),
						 41 => std_logic_vector(to_unsigned( 187, 8)),
						 42 => std_logic_vector(to_unsigned( 139, 8)),
						 43 => std_logic_vector(to_unsigned( 166, 8)),
						 44 => std_logic_vector(to_unsigned( 31, 8)),
						 45 => std_logic_vector(to_unsigned( 3, 8)),
						 46 => std_logic_vector(to_unsigned( 90, 8)),
						 47 => std_logic_vector(to_unsigned( 125, 8)),
						 48 => std_logic_vector(to_unsigned( 9, 8)),
						 49 => std_logic_vector(to_unsigned( 56, 8)),
						 50 => std_logic_vector(to_unsigned( 37, 8)),
						 51 => std_logic_vector(to_unsigned( 31, 8)),
						 52 => std_logic_vector(to_unsigned( 93, 8)),
						 53 => std_logic_vector(to_unsigned( 212, 8)),
						 54 => std_logic_vector(to_unsigned( 203, 8)),
						 55 => std_logic_vector(to_unsigned( 252, 8)),
						 56 => std_logic_vector(to_unsigned( 150, 8)),
						 57 => std_logic_vector(to_unsigned( 245, 8)),
						 58 => std_logic_vector(to_unsigned( 69, 8)),
						 59 => std_logic_vector(to_unsigned( 59, 8)),
						 60 => std_logic_vector(to_unsigned( 19, 8)),
						 61 => std_logic_vector(to_unsigned( 13, 8)),
						 62 => std_logic_vector(to_unsigned( 137, 8)),
						 63 => std_logic_vector(to_unsigned( 10, 8)),
						 64 => std_logic_vector(to_unsigned( 28, 8)),
						 65 => std_logic_vector(to_unsigned( 219, 8)),
						 66 => std_logic_vector(to_unsigned( 174, 8)),
						 67 => std_logic_vector(to_unsigned( 50, 8)),
						 68 => std_logic_vector(to_unsigned( 32, 8)),
						 69 => std_logic_vector(to_unsigned( 154, 8)),
						 70 => std_logic_vector(to_unsigned( 80, 8)),
						 71 => std_logic_vector(to_unsigned( 238, 8)),
						 72 => std_logic_vector(to_unsigned( 64, 8)),
						 73 => std_logic_vector(to_unsigned( 120, 8)),
						 74 => std_logic_vector(to_unsigned( 54, 8)),
						 75 => std_logic_vector(to_unsigned( 253, 8)),
						 76 => std_logic_vector(to_unsigned( 18, 8)),
						 77 => std_logic_vector(to_unsigned( 73, 8)),
						 78 => std_logic_vector(to_unsigned( 50, 8)),
						 79 => std_logic_vector(to_unsigned( 246, 8)),
						 80 => std_logic_vector(to_unsigned( 158, 8)),
						 81 => std_logic_vector(to_unsigned( 125, 8)),
						 82 => std_logic_vector(to_unsigned( 73, 8)),
						 83 => std_logic_vector(to_unsigned( 220, 8)),
						 84 => std_logic_vector(to_unsigned( 173, 8)),
						 85 => std_logic_vector(to_unsigned( 79, 8)),
						 86 => std_logic_vector(to_unsigned( 20, 8)),
						 87 => std_logic_vector(to_unsigned( 242, 8)),
						 88 => std_logic_vector(to_unsigned( 68, 8)),
						 89 => std_logic_vector(to_unsigned( 64, 8)),
						 90 => std_logic_vector(to_unsigned( 102, 8)),
						 91 => std_logic_vector(to_unsigned( 208, 8)),
						 92 => std_logic_vector(to_unsigned( 107, 8)),
						 93 => std_logic_vector(to_unsigned( 196, 8)),
						 94 => std_logic_vector(to_unsigned( 48, 8)),
						 95 => std_logic_vector(to_unsigned( 183, 8)),
						 96 => std_logic_vector(to_unsigned( 50, 8)),
						 97 => std_logic_vector(to_unsigned( 59, 8)),
						 98 => std_logic_vector(to_unsigned( 161, 8)),
						 99 => std_logic_vector(to_unsigned( 34, 8)),
						 100 => std_logic_vector(to_unsigned( 246, 8)),
						 101 => std_logic_vector(to_unsigned( 34, 8)),
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
			 if i = std_logic_vector(to_unsigned( 0, 1)) then
				 if mem_we = '1' then
					 RAM0(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM0(conv_integer(mem_address)) after 1 ns;
				 end if;
			 end if;
		 end if;
	 end if;
end process;






test : process is
begin
	 wait for c_CLOCK_PERIOD;
	 tb_rst <= '1';
	 wait for c_CLOCK_PERIOD;
	 tb_rst <= '0';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';



	 assert RAM0(102) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(102))))  severity failure; 
 	 assert RAM0(103) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM0(103))))  severity failure; 
 	 assert RAM0(104) = std_logic_vector(to_unsigned( 41, 8)) report " TEST FALLITO (WORKING ZONE). Expected  41  found " & integer'image(to_integer(unsigned(RAM0(104))))  severity failure; 
 	 assert RAM0(105) = std_logic_vector(to_unsigned( 35, 8)) report " TEST FALLITO (WORKING ZONE). Expected  35  found " & integer'image(to_integer(unsigned(RAM0(105))))  severity failure; 
 	 assert RAM0(106) = std_logic_vector(to_unsigned( 190, 8)) report " TEST FALLITO (WORKING ZONE). Expected  190  found " & integer'image(to_integer(unsigned(RAM0(106))))  severity failure; 
 	 assert RAM0(107) = std_logic_vector(to_unsigned( 132, 8)) report " TEST FALLITO (WORKING ZONE). Expected  132  found " & integer'image(to_integer(unsigned(RAM0(107))))  severity failure; 
 	 assert RAM0(108) = std_logic_vector(to_unsigned( 225, 8)) report " TEST FALLITO (WORKING ZONE). Expected  225  found " & integer'image(to_integer(unsigned(RAM0(108))))  severity failure; 
 	 assert RAM0(109) = std_logic_vector(to_unsigned( 108, 8)) report " TEST FALLITO (WORKING ZONE). Expected  108  found " & integer'image(to_integer(unsigned(RAM0(109))))  severity failure; 
 	 assert RAM0(110) = std_logic_vector(to_unsigned( 214, 8)) report " TEST FALLITO (WORKING ZONE). Expected  214  found " & integer'image(to_integer(unsigned(RAM0(110))))  severity failure; 
 	 assert RAM0(111) = std_logic_vector(to_unsigned( 174, 8)) report " TEST FALLITO (WORKING ZONE). Expected  174  found " & integer'image(to_integer(unsigned(RAM0(111))))  severity failure; 
 	 assert RAM0(112) = std_logic_vector(to_unsigned( 82, 8)) report " TEST FALLITO (WORKING ZONE). Expected  82  found " & integer'image(to_integer(unsigned(RAM0(112))))  severity failure; 
 	 assert RAM0(113) = std_logic_vector(to_unsigned( 144, 8)) report " TEST FALLITO (WORKING ZONE). Expected  144  found " & integer'image(to_integer(unsigned(RAM0(113))))  severity failure; 
 	 assert RAM0(114) = std_logic_vector(to_unsigned( 73, 8)) report " TEST FALLITO (WORKING ZONE). Expected  73  found " & integer'image(to_integer(unsigned(RAM0(114))))  severity failure; 
 	 assert RAM0(115) = std_logic_vector(to_unsigned( 241, 8)) report " TEST FALLITO (WORKING ZONE). Expected  241  found " & integer'image(to_integer(unsigned(RAM0(115))))  severity failure; 
 	 assert RAM0(116) = std_logic_vector(to_unsigned( 241, 8)) report " TEST FALLITO (WORKING ZONE). Expected  241  found " & integer'image(to_integer(unsigned(RAM0(116))))  severity failure; 
 	 assert RAM0(117) = std_logic_vector(to_unsigned( 187, 8)) report " TEST FALLITO (WORKING ZONE). Expected  187  found " & integer'image(to_integer(unsigned(RAM0(117))))  severity failure; 
 	 assert RAM0(118) = std_logic_vector(to_unsigned( 233, 8)) report " TEST FALLITO (WORKING ZONE). Expected  233  found " & integer'image(to_integer(unsigned(RAM0(118))))  severity failure; 
 	 assert RAM0(119) = std_logic_vector(to_unsigned( 235, 8)) report " TEST FALLITO (WORKING ZONE). Expected  235  found " & integer'image(to_integer(unsigned(RAM0(119))))  severity failure; 
 	 assert RAM0(120) = std_logic_vector(to_unsigned( 179, 8)) report " TEST FALLITO (WORKING ZONE). Expected  179  found " & integer'image(to_integer(unsigned(RAM0(120))))  severity failure; 
 	 assert RAM0(121) = std_logic_vector(to_unsigned( 166, 8)) report " TEST FALLITO (WORKING ZONE). Expected  166  found " & integer'image(to_integer(unsigned(RAM0(121))))  severity failure; 
 	 assert RAM0(122) = std_logic_vector(to_unsigned( 219, 8)) report " TEST FALLITO (WORKING ZONE). Expected  219  found " & integer'image(to_integer(unsigned(RAM0(122))))  severity failure; 
 	 assert RAM0(123) = std_logic_vector(to_unsigned( 60, 8)) report " TEST FALLITO (WORKING ZONE). Expected  60  found " & integer'image(to_integer(unsigned(RAM0(123))))  severity failure; 
 	 assert RAM0(124) = std_logic_vector(to_unsigned( 135, 8)) report " TEST FALLITO (WORKING ZONE). Expected  135  found " & integer'image(to_integer(unsigned(RAM0(124))))  severity failure; 
 	 assert RAM0(125) = std_logic_vector(to_unsigned( 12, 8)) report " TEST FALLITO (WORKING ZONE). Expected  12  found " & integer'image(to_integer(unsigned(RAM0(125))))  severity failure; 
 	 assert RAM0(126) = std_logic_vector(to_unsigned( 62, 8)) report " TEST FALLITO (WORKING ZONE). Expected  62  found " & integer'image(to_integer(unsigned(RAM0(126))))  severity failure; 
 	 assert RAM0(127) = std_logic_vector(to_unsigned( 153, 8)) report " TEST FALLITO (WORKING ZONE). Expected  153  found " & integer'image(to_integer(unsigned(RAM0(127))))  severity failure; 
 	 assert RAM0(128) = std_logic_vector(to_unsigned( 36, 8)) report " TEST FALLITO (WORKING ZONE). Expected  36  found " & integer'image(to_integer(unsigned(RAM0(128))))  severity failure; 
 	 assert RAM0(129) = std_logic_vector(to_unsigned( 94, 8)) report " TEST FALLITO (WORKING ZONE). Expected  94  found " & integer'image(to_integer(unsigned(RAM0(129))))  severity failure; 
 	 assert RAM0(130) = std_logic_vector(to_unsigned( 13, 8)) report " TEST FALLITO (WORKING ZONE). Expected  13  found " & integer'image(to_integer(unsigned(RAM0(130))))  severity failure; 
 	 assert RAM0(131) = std_logic_vector(to_unsigned( 28, 8)) report " TEST FALLITO (WORKING ZONE). Expected  28  found " & integer'image(to_integer(unsigned(RAM0(131))))  severity failure; 
 	 assert RAM0(132) = std_logic_vector(to_unsigned( 6, 8)) report " TEST FALLITO (WORKING ZONE). Expected  6  found " & integer'image(to_integer(unsigned(RAM0(132))))  severity failure; 
 	 assert RAM0(133) = std_logic_vector(to_unsigned( 183, 8)) report " TEST FALLITO (WORKING ZONE). Expected  183  found " & integer'image(to_integer(unsigned(RAM0(133))))  severity failure; 
 	 assert RAM0(134) = std_logic_vector(to_unsigned( 71, 8)) report " TEST FALLITO (WORKING ZONE). Expected  71  found " & integer'image(to_integer(unsigned(RAM0(134))))  severity failure; 
 	 assert RAM0(135) = std_logic_vector(to_unsigned( 222, 8)) report " TEST FALLITO (WORKING ZONE). Expected  222  found " & integer'image(to_integer(unsigned(RAM0(135))))  severity failure; 
 	 assert RAM0(136) = std_logic_vector(to_unsigned( 179, 8)) report " TEST FALLITO (WORKING ZONE). Expected  179  found " & integer'image(to_integer(unsigned(RAM0(136))))  severity failure; 
 	 assert RAM0(137) = std_logic_vector(to_unsigned( 18, 8)) report " TEST FALLITO (WORKING ZONE). Expected  18  found " & integer'image(to_integer(unsigned(RAM0(137))))  severity failure; 
 	 assert RAM0(138) = std_logic_vector(to_unsigned( 77, 8)) report " TEST FALLITO (WORKING ZONE). Expected  77  found " & integer'image(to_integer(unsigned(RAM0(138))))  severity failure; 
 	 assert RAM0(139) = std_logic_vector(to_unsigned( 200, 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM0(139))))  severity failure; 
 	 assert RAM0(140) = std_logic_vector(to_unsigned( 67, 8)) report " TEST FALLITO (WORKING ZONE). Expected  67  found " & integer'image(to_integer(unsigned(RAM0(140))))  severity failure; 
 	 assert RAM0(141) = std_logic_vector(to_unsigned( 187, 8)) report " TEST FALLITO (WORKING ZONE). Expected  187  found " & integer'image(to_integer(unsigned(RAM0(141))))  severity failure; 
 	 assert RAM0(142) = std_logic_vector(to_unsigned( 139, 8)) report " TEST FALLITO (WORKING ZONE). Expected  139  found " & integer'image(to_integer(unsigned(RAM0(142))))  severity failure; 
 	 assert RAM0(143) = std_logic_vector(to_unsigned( 166, 8)) report " TEST FALLITO (WORKING ZONE). Expected  166  found " & integer'image(to_integer(unsigned(RAM0(143))))  severity failure; 
 	 assert RAM0(144) = std_logic_vector(to_unsigned( 31, 8)) report " TEST FALLITO (WORKING ZONE). Expected  31  found " & integer'image(to_integer(unsigned(RAM0(144))))  severity failure; 
 	 assert RAM0(145) = std_logic_vector(to_unsigned( 3, 8)) report " TEST FALLITO (WORKING ZONE). Expected  3  found " & integer'image(to_integer(unsigned(RAM0(145))))  severity failure; 
 	 assert RAM0(146) = std_logic_vector(to_unsigned( 90, 8)) report " TEST FALLITO (WORKING ZONE). Expected  90  found " & integer'image(to_integer(unsigned(RAM0(146))))  severity failure; 
 	 assert RAM0(147) = std_logic_vector(to_unsigned( 125, 8)) report " TEST FALLITO (WORKING ZONE). Expected  125  found " & integer'image(to_integer(unsigned(RAM0(147))))  severity failure; 
 	 assert RAM0(148) = std_logic_vector(to_unsigned( 9, 8)) report " TEST FALLITO (WORKING ZONE). Expected  9  found " & integer'image(to_integer(unsigned(RAM0(148))))  severity failure; 
 	 assert RAM0(149) = std_logic_vector(to_unsigned( 56, 8)) report " TEST FALLITO (WORKING ZONE). Expected  56  found " & integer'image(to_integer(unsigned(RAM0(149))))  severity failure; 
 	 assert RAM0(150) = std_logic_vector(to_unsigned( 37, 8)) report " TEST FALLITO (WORKING ZONE). Expected  37  found " & integer'image(to_integer(unsigned(RAM0(150))))  severity failure; 
 	 assert RAM0(151) = std_logic_vector(to_unsigned( 31, 8)) report " TEST FALLITO (WORKING ZONE). Expected  31  found " & integer'image(to_integer(unsigned(RAM0(151))))  severity failure; 
 	 assert RAM0(152) = std_logic_vector(to_unsigned( 93, 8)) report " TEST FALLITO (WORKING ZONE). Expected  93  found " & integer'image(to_integer(unsigned(RAM0(152))))  severity failure; 
 	 assert RAM0(153) = std_logic_vector(to_unsigned( 212, 8)) report " TEST FALLITO (WORKING ZONE). Expected  212  found " & integer'image(to_integer(unsigned(RAM0(153))))  severity failure; 
 	 assert RAM0(154) = std_logic_vector(to_unsigned( 203, 8)) report " TEST FALLITO (WORKING ZONE). Expected  203  found " & integer'image(to_integer(unsigned(RAM0(154))))  severity failure; 
 	 assert RAM0(155) = std_logic_vector(to_unsigned( 252, 8)) report " TEST FALLITO (WORKING ZONE). Expected  252  found " & integer'image(to_integer(unsigned(RAM0(155))))  severity failure; 
 	 assert RAM0(156) = std_logic_vector(to_unsigned( 150, 8)) report " TEST FALLITO (WORKING ZONE). Expected  150  found " & integer'image(to_integer(unsigned(RAM0(156))))  severity failure; 
 	 assert RAM0(157) = std_logic_vector(to_unsigned( 245, 8)) report " TEST FALLITO (WORKING ZONE). Expected  245  found " & integer'image(to_integer(unsigned(RAM0(157))))  severity failure; 
 	 assert RAM0(158) = std_logic_vector(to_unsigned( 69, 8)) report " TEST FALLITO (WORKING ZONE). Expected  69  found " & integer'image(to_integer(unsigned(RAM0(158))))  severity failure; 
 	 assert RAM0(159) = std_logic_vector(to_unsigned( 59, 8)) report " TEST FALLITO (WORKING ZONE). Expected  59  found " & integer'image(to_integer(unsigned(RAM0(159))))  severity failure; 
 	 assert RAM0(160) = std_logic_vector(to_unsigned( 19, 8)) report " TEST FALLITO (WORKING ZONE). Expected  19  found " & integer'image(to_integer(unsigned(RAM0(160))))  severity failure; 
 	 assert RAM0(161) = std_logic_vector(to_unsigned( 13, 8)) report " TEST FALLITO (WORKING ZONE). Expected  13  found " & integer'image(to_integer(unsigned(RAM0(161))))  severity failure; 
 	 assert RAM0(162) = std_logic_vector(to_unsigned( 137, 8)) report " TEST FALLITO (WORKING ZONE). Expected  137  found " & integer'image(to_integer(unsigned(RAM0(162))))  severity failure; 
 	 assert RAM0(163) = std_logic_vector(to_unsigned( 10, 8)) report " TEST FALLITO (WORKING ZONE). Expected  10  found " & integer'image(to_integer(unsigned(RAM0(163))))  severity failure; 
 	 assert RAM0(164) = std_logic_vector(to_unsigned( 28, 8)) report " TEST FALLITO (WORKING ZONE). Expected  28  found " & integer'image(to_integer(unsigned(RAM0(164))))  severity failure; 
 	 assert RAM0(165) = std_logic_vector(to_unsigned( 219, 8)) report " TEST FALLITO (WORKING ZONE). Expected  219  found " & integer'image(to_integer(unsigned(RAM0(165))))  severity failure; 
 	 assert RAM0(166) = std_logic_vector(to_unsigned( 174, 8)) report " TEST FALLITO (WORKING ZONE). Expected  174  found " & integer'image(to_integer(unsigned(RAM0(166))))  severity failure; 
 	 assert RAM0(167) = std_logic_vector(to_unsigned( 50, 8)) report " TEST FALLITO (WORKING ZONE). Expected  50  found " & integer'image(to_integer(unsigned(RAM0(167))))  severity failure; 
 	 assert RAM0(168) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM0(168))))  severity failure; 
 	 assert RAM0(169) = std_logic_vector(to_unsigned( 154, 8)) report " TEST FALLITO (WORKING ZONE). Expected  154  found " & integer'image(to_integer(unsigned(RAM0(169))))  severity failure; 
 	 assert RAM0(170) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM0(170))))  severity failure; 
 	 assert RAM0(171) = std_logic_vector(to_unsigned( 238, 8)) report " TEST FALLITO (WORKING ZONE). Expected  238  found " & integer'image(to_integer(unsigned(RAM0(171))))  severity failure; 
 	 assert RAM0(172) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM0(172))))  severity failure; 
 	 assert RAM0(173) = std_logic_vector(to_unsigned( 120, 8)) report " TEST FALLITO (WORKING ZONE). Expected  120  found " & integer'image(to_integer(unsigned(RAM0(173))))  severity failure; 
 	 assert RAM0(174) = std_logic_vector(to_unsigned( 54, 8)) report " TEST FALLITO (WORKING ZONE). Expected  54  found " & integer'image(to_integer(unsigned(RAM0(174))))  severity failure; 
 	 assert RAM0(175) = std_logic_vector(to_unsigned( 253, 8)) report " TEST FALLITO (WORKING ZONE). Expected  253  found " & integer'image(to_integer(unsigned(RAM0(175))))  severity failure; 
 	 assert RAM0(176) = std_logic_vector(to_unsigned( 18, 8)) report " TEST FALLITO (WORKING ZONE). Expected  18  found " & integer'image(to_integer(unsigned(RAM0(176))))  severity failure; 
 	 assert RAM0(177) = std_logic_vector(to_unsigned( 73, 8)) report " TEST FALLITO (WORKING ZONE). Expected  73  found " & integer'image(to_integer(unsigned(RAM0(177))))  severity failure; 
 	 assert RAM0(178) = std_logic_vector(to_unsigned( 50, 8)) report " TEST FALLITO (WORKING ZONE). Expected  50  found " & integer'image(to_integer(unsigned(RAM0(178))))  severity failure; 
 	 assert RAM0(179) = std_logic_vector(to_unsigned( 246, 8)) report " TEST FALLITO (WORKING ZONE). Expected  246  found " & integer'image(to_integer(unsigned(RAM0(179))))  severity failure; 
 	 assert RAM0(180) = std_logic_vector(to_unsigned( 158, 8)) report " TEST FALLITO (WORKING ZONE). Expected  158  found " & integer'image(to_integer(unsigned(RAM0(180))))  severity failure; 
 	 assert RAM0(181) = std_logic_vector(to_unsigned( 125, 8)) report " TEST FALLITO (WORKING ZONE). Expected  125  found " & integer'image(to_integer(unsigned(RAM0(181))))  severity failure; 
 	 assert RAM0(182) = std_logic_vector(to_unsigned( 73, 8)) report " TEST FALLITO (WORKING ZONE). Expected  73  found " & integer'image(to_integer(unsigned(RAM0(182))))  severity failure; 
 	 assert RAM0(183) = std_logic_vector(to_unsigned( 220, 8)) report " TEST FALLITO (WORKING ZONE). Expected  220  found " & integer'image(to_integer(unsigned(RAM0(183))))  severity failure; 
 	 assert RAM0(184) = std_logic_vector(to_unsigned( 173, 8)) report " TEST FALLITO (WORKING ZONE). Expected  173  found " & integer'image(to_integer(unsigned(RAM0(184))))  severity failure; 
 	 assert RAM0(185) = std_logic_vector(to_unsigned( 79, 8)) report " TEST FALLITO (WORKING ZONE). Expected  79  found " & integer'image(to_integer(unsigned(RAM0(185))))  severity failure; 
 	 assert RAM0(186) = std_logic_vector(to_unsigned( 20, 8)) report " TEST FALLITO (WORKING ZONE). Expected  20  found " & integer'image(to_integer(unsigned(RAM0(186))))  severity failure; 
 	 assert RAM0(187) = std_logic_vector(to_unsigned( 242, 8)) report " TEST FALLITO (WORKING ZONE). Expected  242  found " & integer'image(to_integer(unsigned(RAM0(187))))  severity failure; 
 	 assert RAM0(188) = std_logic_vector(to_unsigned( 68, 8)) report " TEST FALLITO (WORKING ZONE). Expected  68  found " & integer'image(to_integer(unsigned(RAM0(188))))  severity failure; 
 	 assert RAM0(189) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM0(189))))  severity failure; 
 	 assert RAM0(190) = std_logic_vector(to_unsigned( 102, 8)) report " TEST FALLITO (WORKING ZONE). Expected  102  found " & integer'image(to_integer(unsigned(RAM0(190))))  severity failure; 
 	 assert RAM0(191) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM0(191))))  severity failure; 
 	 assert RAM0(192) = std_logic_vector(to_unsigned( 107, 8)) report " TEST FALLITO (WORKING ZONE). Expected  107  found " & integer'image(to_integer(unsigned(RAM0(192))))  severity failure; 
 	 assert RAM0(193) = std_logic_vector(to_unsigned( 196, 8)) report " TEST FALLITO (WORKING ZONE). Expected  196  found " & integer'image(to_integer(unsigned(RAM0(193))))  severity failure; 
 	 assert RAM0(194) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM0(194))))  severity failure; 
 	 assert RAM0(195) = std_logic_vector(to_unsigned( 183, 8)) report " TEST FALLITO (WORKING ZONE). Expected  183  found " & integer'image(to_integer(unsigned(RAM0(195))))  severity failure; 
 	 assert RAM0(196) = std_logic_vector(to_unsigned( 50, 8)) report " TEST FALLITO (WORKING ZONE). Expected  50  found " & integer'image(to_integer(unsigned(RAM0(196))))  severity failure; 
 	 assert RAM0(197) = std_logic_vector(to_unsigned( 59, 8)) report " TEST FALLITO (WORKING ZONE). Expected  59  found " & integer'image(to_integer(unsigned(RAM0(197))))  severity failure; 
 	 assert RAM0(198) = std_logic_vector(to_unsigned( 161, 8)) report " TEST FALLITO (WORKING ZONE). Expected  161  found " & integer'image(to_integer(unsigned(RAM0(198))))  severity failure; 
 	 assert RAM0(199) = std_logic_vector(to_unsigned( 34, 8)) report " TEST FALLITO (WORKING ZONE). Expected  34  found " & integer'image(to_integer(unsigned(RAM0(199))))  severity failure; 
 	 assert RAM0(200) = std_logic_vector(to_unsigned( 246, 8)) report " TEST FALLITO (WORKING ZONE). Expected  246  found " & integer'image(to_integer(unsigned(RAM0(200))))  severity failure; 
 	 assert RAM0(201) = std_logic_vector(to_unsigned( 34, 8)) report " TEST FALLITO (WORKING ZONE). Expected  34  found " & integer'image(to_integer(unsigned(RAM0(201))))  severity failure; 
 

	 assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end projecttb; 

