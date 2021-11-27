
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb is
end project_tb;

architecture projecttb of project_tb is
constant c_CLOCK_PERIOD         : time := 15 ns;
signal   tb_done                : std_logic;
signal   mem_address            : std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst                 : std_logic := '0';
signal   tb_start               : std_logic := '0';
signal   tb_clk                 : std_logic := '0';
signal   mem_o_data,mem_i_data  : std_logic_vector (7 downto 0);
signal   enable_wire            : std_logic;
signal   mem_we                 : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal i: std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned( 0, 3)); 

signal RAM0: ram_type := (0 => std_logic_vector(to_unsigned( 5, 8)), 
						 1 => std_logic_vector(to_unsigned( 5, 8)), 
						 2 => std_logic_vector(to_unsigned( 45, 8)),
						 3 => std_logic_vector(to_unsigned( 86, 8)),
						 4 => std_logic_vector(to_unsigned( 88, 8)),
						 5 => std_logic_vector(to_unsigned( 107, 8)),
						 6 => std_logic_vector(to_unsigned( 85, 8)),
						 7 => std_logic_vector(to_unsigned( 202, 8)),
						 8 => std_logic_vector(to_unsigned( 89, 8)),
						 9 => std_logic_vector(to_unsigned( 155, 8)),
						 10 => std_logic_vector(to_unsigned( 199, 8)),
						 11 => std_logic_vector(to_unsigned( 155, 8)),
						 12 => std_logic_vector(to_unsigned( 205, 8)),
						 13 => std_logic_vector(to_unsigned( 66, 8)),
						 14 => std_logic_vector(to_unsigned( 162, 8)),
						 15 => std_logic_vector(to_unsigned( 198, 8)),
						 16 => std_logic_vector(to_unsigned( 212, 8)),
						 17 => std_logic_vector(to_unsigned( 206, 8)),
						 18 => std_logic_vector(to_unsigned( 144, 8)),
						 19 => std_logic_vector(to_unsigned( 240, 8)),
						 20 => std_logic_vector(to_unsigned( 100, 8)),
						 21 => std_logic_vector(to_unsigned( 227, 8)),
						 22 => std_logic_vector(to_unsigned( 168, 8)),
						 23 => std_logic_vector(to_unsigned( 189, 8)),
						 24 => std_logic_vector(to_unsigned( 96, 8)),
						 25 => std_logic_vector(to_unsigned( 145, 8)),
						 26 => std_logic_vector(to_unsigned( 223, 8)),
						 others => (others =>'0')); 

signal RAM1: ram_type := (0 => std_logic_vector(to_unsigned( 13, 8)), 
						 1 => std_logic_vector(to_unsigned( 4, 8)), 
						 2 => std_logic_vector(to_unsigned( 192, 8)),
						 3 => std_logic_vector(to_unsigned( 169, 8)),
						 4 => std_logic_vector(to_unsigned( 190, 8)),
						 5 => std_logic_vector(to_unsigned( 126, 8)),
						 6 => std_logic_vector(to_unsigned( 200, 8)),
						 7 => std_logic_vector(to_unsigned( 125, 8)),
						 8 => std_logic_vector(to_unsigned( 155, 8)),
						 9 => std_logic_vector(to_unsigned( 170, 8)),
						 10 => std_logic_vector(to_unsigned( 140, 8)),
						 11 => std_logic_vector(to_unsigned( 138, 8)),
						 12 => std_logic_vector(to_unsigned( 149, 8)),
						 13 => std_logic_vector(to_unsigned( 156, 8)),
						 14 => std_logic_vector(to_unsigned( 126, 8)),
						 15 => std_logic_vector(to_unsigned( 187, 8)),
						 16 => std_logic_vector(to_unsigned( 191, 8)),
						 17 => std_logic_vector(to_unsigned( 120, 8)),
						 18 => std_logic_vector(to_unsigned( 175, 8)),
						 19 => std_logic_vector(to_unsigned( 145, 8)),
						 20 => std_logic_vector(to_unsigned( 132, 8)),
						 21 => std_logic_vector(to_unsigned( 149, 8)),
						 22 => std_logic_vector(to_unsigned( 198, 8)),
						 23 => std_logic_vector(to_unsigned( 176, 8)),
						 24 => std_logic_vector(to_unsigned( 159, 8)),
						 25 => std_logic_vector(to_unsigned( 135, 8)),
						 26 => std_logic_vector(to_unsigned( 167, 8)),
						 27 => std_logic_vector(to_unsigned( 195, 8)),
						 28 => std_logic_vector(to_unsigned( 136, 8)),
						 29 => std_logic_vector(to_unsigned( 185, 8)),
						 30 => std_logic_vector(to_unsigned( 184, 8)),
						 31 => std_logic_vector(to_unsigned( 152, 8)),
						 32 => std_logic_vector(to_unsigned( 143, 8)),
						 33 => std_logic_vector(to_unsigned( 139, 8)),
						 34 => std_logic_vector(to_unsigned( 153, 8)),
						 35 => std_logic_vector(to_unsigned( 150, 8)),
						 36 => std_logic_vector(to_unsigned( 181, 8)),
						 37 => std_logic_vector(to_unsigned( 176, 8)),
						 38 => std_logic_vector(to_unsigned( 141, 8)),
						 39 => std_logic_vector(to_unsigned( 190, 8)),
						 40 => std_logic_vector(to_unsigned( 169, 8)),
						 41 => std_logic_vector(to_unsigned( 124, 8)),
						 42 => std_logic_vector(to_unsigned( 158, 8)),
						 43 => std_logic_vector(to_unsigned( 197, 8)),
						 44 => std_logic_vector(to_unsigned( 180, 8)),
						 45 => std_logic_vector(to_unsigned( 165, 8)),
						 46 => std_logic_vector(to_unsigned( 175, 8)),
						 47 => std_logic_vector(to_unsigned( 169, 8)),
						 48 => std_logic_vector(to_unsigned( 152, 8)),
						 49 => std_logic_vector(to_unsigned( 187, 8)),
						 50 => std_logic_vector(to_unsigned( 169, 8)),
						 51 => std_logic_vector(to_unsigned( 188, 8)),
						 52 => std_logic_vector(to_unsigned( 192, 8)),
						 53 => std_logic_vector(to_unsigned( 134, 8)),
						 others => (others =>'0')); 

signal RAM2: ram_type := (0 => std_logic_vector(to_unsigned( 3, 8)), 
						 1 => std_logic_vector(to_unsigned( 8, 8)), 
						 2 => std_logic_vector(to_unsigned( 60, 8)),
						 3 => std_logic_vector(to_unsigned( 0, 8)),
						 4 => std_logic_vector(to_unsigned( 19, 8)),
						 5 => std_logic_vector(to_unsigned( 31, 8)),
						 6 => std_logic_vector(to_unsigned( 39, 8)),
						 7 => std_logic_vector(to_unsigned( 0, 8)),
						 8 => std_logic_vector(to_unsigned( 52, 8)),
						 9 => std_logic_vector(to_unsigned( 54, 8)),
						 10 => std_logic_vector(to_unsigned( 10, 8)),
						 11 => std_logic_vector(to_unsigned( 48, 8)),
						 12 => std_logic_vector(to_unsigned( 57, 8)),
						 13 => std_logic_vector(to_unsigned( 50, 8)),
						 14 => std_logic_vector(to_unsigned( 7, 8)),
						 15 => std_logic_vector(to_unsigned( 29, 8)),
						 16 => std_logic_vector(to_unsigned( 6, 8)),
						 17 => std_logic_vector(to_unsigned( 25, 8)),
						 18 => std_logic_vector(to_unsigned( 56, 8)),
						 19 => std_logic_vector(to_unsigned( 23, 8)),
						 20 => std_logic_vector(to_unsigned( 17, 8)),
						 21 => std_logic_vector(to_unsigned( 47, 8)),
						 22 => std_logic_vector(to_unsigned( 48, 8)),
						 23 => std_logic_vector(to_unsigned( 43, 8)),
						 24 => std_logic_vector(to_unsigned( 38, 8)),
						 25 => std_logic_vector(to_unsigned( 47, 8)),
						 others => (others =>'0')); 

signal RAM3: ram_type := (0 => std_logic_vector(to_unsigned( 1, 8)), 
						 1 => std_logic_vector(to_unsigned( 23, 8)), 
						 2 => std_logic_vector(to_unsigned( 143, 8)),
						 3 => std_logic_vector(to_unsigned( 141, 8)),
						 4 => std_logic_vector(to_unsigned( 133, 8)),
						 5 => std_logic_vector(to_unsigned( 148, 8)),
						 6 => std_logic_vector(to_unsigned( 144, 8)),
						 7 => std_logic_vector(to_unsigned( 133, 8)),
						 8 => std_logic_vector(to_unsigned( 144, 8)),
						 9 => std_logic_vector(to_unsigned( 149, 8)),
						 10 => std_logic_vector(to_unsigned( 136, 8)),
						 11 => std_logic_vector(to_unsigned( 133, 8)),
						 12 => std_logic_vector(to_unsigned( 148, 8)),
						 13 => std_logic_vector(to_unsigned( 142, 8)),
						 14 => std_logic_vector(to_unsigned( 147, 8)),
						 15 => std_logic_vector(to_unsigned( 135, 8)),
						 16 => std_logic_vector(to_unsigned( 130, 8)),
						 17 => std_logic_vector(to_unsigned( 132, 8)),
						 18 => std_logic_vector(to_unsigned( 147, 8)),
						 19 => std_logic_vector(to_unsigned( 132, 8)),
						 20 => std_logic_vector(to_unsigned( 134, 8)),
						 21 => std_logic_vector(to_unsigned( 142, 8)),
						 22 => std_logic_vector(to_unsigned( 142, 8)),
						 23 => std_logic_vector(to_unsigned( 150, 8)),
						 24 => std_logic_vector(to_unsigned( 130, 8)),
						 others => (others =>'0')); 

signal RAM4: ram_type := (0 => std_logic_vector(to_unsigned( 14, 8)), 
						 1 => std_logic_vector(to_unsigned( 1, 8)), 
						 2 => std_logic_vector(to_unsigned( 33, 8)),
						 3 => std_logic_vector(to_unsigned( 38, 8)),
						 4 => std_logic_vector(to_unsigned( 34, 8)),
						 5 => std_logic_vector(to_unsigned( 31, 8)),
						 6 => std_logic_vector(to_unsigned( 36, 8)),
						 7 => std_logic_vector(to_unsigned( 32, 8)),
						 8 => std_logic_vector(to_unsigned( 39, 8)),
						 9 => std_logic_vector(to_unsigned( 32, 8)),
						 10 => std_logic_vector(to_unsigned( 33, 8)),
						 11 => std_logic_vector(to_unsigned( 36, 8)),
						 12 => std_logic_vector(to_unsigned( 35, 8)),
						 13 => std_logic_vector(to_unsigned( 39, 8)),
						 14 => std_logic_vector(to_unsigned( 30, 8)),
						 15 => std_logic_vector(to_unsigned( 40, 8)),
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
			 if i = std_logic_vector(to_unsigned( 0, 3)) then
				 if mem_we = '1' then
					 RAM0(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM0(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 1, 3)) then
				 if mem_we = '1' then
					 RAM1(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM1(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 2, 3)) then
				 if mem_we = '1' then
					 RAM2(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM2(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 3, 3)) then
				 if mem_we = '1' then
					 RAM3(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM3(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 4, 3)) then
				 if mem_we = '1' then
					 RAM4(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM4(conv_integer(mem_address)) after 1 ns;
				 end if;			 end if;
		 end if;
	 end if;
end process;

test : process is
begin
	 wait for 100 ns;
	 wait for c_CLOCK_PERIOD;
	 tb_rst <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait for 100 ns;
	 tb_rst <= '0';
	 wait for c_CLOCK_PERIOD;
	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns; 
	 i <= std_logic_vector(to_unsigned( 1, 3));
 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 2, 3));
 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 3, 3));
 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 4, 3));

 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;

	 assert RAM0(27) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM0(27))))  severity failure; 
 	 assert RAM0(28) = std_logic_vector(to_unsigned( 82, 8)) report " TEST FALLITO (WORKING ZONE). Expected  82  found " & integer'image(to_integer(unsigned(RAM0(28))))  severity failure; 
 	 assert RAM0(29) = std_logic_vector(to_unsigned( 86, 8)) report " TEST FALLITO (WORKING ZONE). Expected  86  found " & integer'image(to_integer(unsigned(RAM0(29))))  severity failure; 
 	 assert RAM0(30) = std_logic_vector(to_unsigned( 124, 8)) report " TEST FALLITO (WORKING ZONE). Expected  124  found " & integer'image(to_integer(unsigned(RAM0(30))))  severity failure; 
 	 assert RAM0(31) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM0(31))))  severity failure; 
 	 assert RAM0(32) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(32))))  severity failure; 
 	 assert RAM0(33) = std_logic_vector(to_unsigned( 88, 8)) report " TEST FALLITO (WORKING ZONE). Expected  88  found " & integer'image(to_integer(unsigned(RAM0(33))))  severity failure; 
 	 assert RAM0(34) = std_logic_vector(to_unsigned( 220, 8)) report " TEST FALLITO (WORKING ZONE). Expected  220  found " & integer'image(to_integer(unsigned(RAM0(34))))  severity failure; 
 	 assert RAM0(35) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(35))))  severity failure; 
 	 assert RAM0(36) = std_logic_vector(to_unsigned( 220, 8)) report " TEST FALLITO (WORKING ZONE). Expected  220  found " & integer'image(to_integer(unsigned(RAM0(36))))  severity failure; 
 	 assert RAM0(37) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(37))))  severity failure; 
 	 assert RAM0(38) = std_logic_vector(to_unsigned( 42, 8)) report " TEST FALLITO (WORKING ZONE). Expected  42  found " & integer'image(to_integer(unsigned(RAM0(38))))  severity failure; 
 	 assert RAM0(39) = std_logic_vector(to_unsigned( 234, 8)) report " TEST FALLITO (WORKING ZONE). Expected  234  found " & integer'image(to_integer(unsigned(RAM0(39))))  severity failure; 
 	 assert RAM0(40) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(40))))  severity failure; 
 	 assert RAM0(41) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(41))))  severity failure; 
 	 assert RAM0(42) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(42))))  severity failure; 
 	 assert RAM0(43) = std_logic_vector(to_unsigned( 198, 8)) report " TEST FALLITO (WORKING ZONE). Expected  198  found " & integer'image(to_integer(unsigned(RAM0(43))))  severity failure; 
 	 assert RAM0(44) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(44))))  severity failure; 
 	 assert RAM0(45) = std_logic_vector(to_unsigned( 110, 8)) report " TEST FALLITO (WORKING ZONE). Expected  110  found " & integer'image(to_integer(unsigned(RAM0(45))))  severity failure; 
 	 assert RAM0(46) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(46))))  severity failure; 
 	 assert RAM0(47) = std_logic_vector(to_unsigned( 246, 8)) report " TEST FALLITO (WORKING ZONE). Expected  246  found " & integer'image(to_integer(unsigned(RAM0(47))))  severity failure; 
 	 assert RAM0(48) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(48))))  severity failure; 
 	 assert RAM0(49) = std_logic_vector(to_unsigned( 102, 8)) report " TEST FALLITO (WORKING ZONE). Expected  102  found " & integer'image(to_integer(unsigned(RAM0(49))))  severity failure; 
 	 assert RAM0(50) = std_logic_vector(to_unsigned( 200, 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM0(50))))  severity failure; 
 	 assert RAM0(51) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(51))))  severity failure; 
 

	 assert RAM1(54) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(54))))  severity failure; 
 	 assert RAM1(55) = std_logic_vector(to_unsigned( 196, 8)) report " TEST FALLITO (WORKING ZONE). Expected  196  found " & integer'image(to_integer(unsigned(RAM1(55))))  severity failure; 
 	 assert RAM1(56) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(56))))  severity failure; 
 	 assert RAM1(57) = std_logic_vector(to_unsigned( 24, 8)) report " TEST FALLITO (WORKING ZONE). Expected  24  found " & integer'image(to_integer(unsigned(RAM1(57))))  severity failure; 
 	 assert RAM1(58) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(58))))  severity failure; 
 	 assert RAM1(59) = std_logic_vector(to_unsigned( 20, 8)) report " TEST FALLITO (WORKING ZONE). Expected  20  found " & integer'image(to_integer(unsigned(RAM1(59))))  severity failure; 
 	 assert RAM1(60) = std_logic_vector(to_unsigned( 140, 8)) report " TEST FALLITO (WORKING ZONE). Expected  140  found " & integer'image(to_integer(unsigned(RAM1(60))))  severity failure; 
 	 assert RAM1(61) = std_logic_vector(to_unsigned( 200, 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM1(61))))  severity failure; 
 	 assert RAM1(62) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM1(62))))  severity failure; 
 	 assert RAM1(63) = std_logic_vector(to_unsigned( 72, 8)) report " TEST FALLITO (WORKING ZONE). Expected  72  found " & integer'image(to_integer(unsigned(RAM1(63))))  severity failure; 
 	 assert RAM1(64) = std_logic_vector(to_unsigned( 116, 8)) report " TEST FALLITO (WORKING ZONE). Expected  116  found " & integer'image(to_integer(unsigned(RAM1(64))))  severity failure; 
 	 assert RAM1(65) = std_logic_vector(to_unsigned( 144, 8)) report " TEST FALLITO (WORKING ZONE). Expected  144  found " & integer'image(to_integer(unsigned(RAM1(65))))  severity failure; 
 	 assert RAM1(66) = std_logic_vector(to_unsigned( 24, 8)) report " TEST FALLITO (WORKING ZONE). Expected  24  found " & integer'image(to_integer(unsigned(RAM1(66))))  severity failure; 
 	 assert RAM1(67) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(67))))  severity failure; 
 	 assert RAM1(68) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(68))))  severity failure; 
 	 assert RAM1(69) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(69))))  severity failure; 
 	 assert RAM1(70) = std_logic_vector(to_unsigned( 220, 8)) report " TEST FALLITO (WORKING ZONE). Expected  220  found " & integer'image(to_integer(unsigned(RAM1(70))))  severity failure; 
 	 assert RAM1(71) = std_logic_vector(to_unsigned( 100, 8)) report " TEST FALLITO (WORKING ZONE). Expected  100  found " & integer'image(to_integer(unsigned(RAM1(71))))  severity failure; 
 	 assert RAM1(72) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM1(72))))  severity failure; 
 	 assert RAM1(73) = std_logic_vector(to_unsigned( 116, 8)) report " TEST FALLITO (WORKING ZONE). Expected  116  found " & integer'image(to_integer(unsigned(RAM1(73))))  severity failure; 
 	 assert RAM1(74) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(74))))  severity failure; 
 	 assert RAM1(75) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM1(75))))  severity failure; 
 	 assert RAM1(76) = std_logic_vector(to_unsigned( 156, 8)) report " TEST FALLITO (WORKING ZONE). Expected  156  found " & integer'image(to_integer(unsigned(RAM1(76))))  severity failure; 
 	 assert RAM1(77) = std_logic_vector(to_unsigned( 60, 8)) report " TEST FALLITO (WORKING ZONE). Expected  60  found " & integer'image(to_integer(unsigned(RAM1(77))))  severity failure; 
 	 assert RAM1(78) = std_logic_vector(to_unsigned( 188, 8)) report " TEST FALLITO (WORKING ZONE). Expected  188  found " & integer'image(to_integer(unsigned(RAM1(78))))  severity failure; 
 	 assert RAM1(79) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(79))))  severity failure; 
 	 assert RAM1(80) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM1(80))))  severity failure; 
 	 assert RAM1(81) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(81))))  severity failure; 
 	 assert RAM1(82) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(82))))  severity failure; 
 	 assert RAM1(83) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM1(83))))  severity failure; 
 	 assert RAM1(84) = std_logic_vector(to_unsigned( 92, 8)) report " TEST FALLITO (WORKING ZONE). Expected  92  found " & integer'image(to_integer(unsigned(RAM1(84))))  severity failure; 
 	 assert RAM1(85) = std_logic_vector(to_unsigned( 76, 8)) report " TEST FALLITO (WORKING ZONE). Expected  76  found " & integer'image(to_integer(unsigned(RAM1(85))))  severity failure; 
 	 assert RAM1(86) = std_logic_vector(to_unsigned( 132, 8)) report " TEST FALLITO (WORKING ZONE). Expected  132  found " & integer'image(to_integer(unsigned(RAM1(86))))  severity failure; 
 	 assert RAM1(87) = std_logic_vector(to_unsigned( 120, 8)) report " TEST FALLITO (WORKING ZONE). Expected  120  found " & integer'image(to_integer(unsigned(RAM1(87))))  severity failure; 
 	 assert RAM1(88) = std_logic_vector(to_unsigned( 244, 8)) report " TEST FALLITO (WORKING ZONE). Expected  244  found " & integer'image(to_integer(unsigned(RAM1(88))))  severity failure; 
 	 assert RAM1(89) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM1(89))))  severity failure; 
 	 assert RAM1(90) = std_logic_vector(to_unsigned( 84, 8)) report " TEST FALLITO (WORKING ZONE). Expected  84  found " & integer'image(to_integer(unsigned(RAM1(90))))  severity failure; 
 	 assert RAM1(91) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(91))))  severity failure; 
 	 assert RAM1(92) = std_logic_vector(to_unsigned( 196, 8)) report " TEST FALLITO (WORKING ZONE). Expected  196  found " & integer'image(to_integer(unsigned(RAM1(92))))  severity failure; 
 	 assert RAM1(93) = std_logic_vector(to_unsigned( 16, 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM1(93))))  severity failure; 
 	 assert RAM1(94) = std_logic_vector(to_unsigned( 152, 8)) report " TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM1(94))))  severity failure; 
 	 assert RAM1(95) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(95))))  severity failure; 
 	 assert RAM1(96) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM1(96))))  severity failure; 
 	 assert RAM1(97) = std_logic_vector(to_unsigned( 180, 8)) report " TEST FALLITO (WORKING ZONE). Expected  180  found " & integer'image(to_integer(unsigned(RAM1(97))))  severity failure; 
 	 assert RAM1(98) = std_logic_vector(to_unsigned( 220, 8)) report " TEST FALLITO (WORKING ZONE). Expected  220  found " & integer'image(to_integer(unsigned(RAM1(98))))  severity failure; 
 	 assert RAM1(99) = std_logic_vector(to_unsigned( 196, 8)) report " TEST FALLITO (WORKING ZONE). Expected  196  found " & integer'image(to_integer(unsigned(RAM1(99))))  severity failure; 
 	 assert RAM1(100) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM1(100))))  severity failure; 
 	 assert RAM1(101) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(101))))  severity failure; 
 	 assert RAM1(102) = std_logic_vector(to_unsigned( 196, 8)) report " TEST FALLITO (WORKING ZONE). Expected  196  found " & integer'image(to_integer(unsigned(RAM1(102))))  severity failure; 
 	 assert RAM1(103) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(103))))  severity failure; 
 	 assert RAM1(104) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(104))))  severity failure; 
 	 assert RAM1(105) = std_logic_vector(to_unsigned( 56, 8)) report " TEST FALLITO (WORKING ZONE). Expected  56  found " & integer'image(to_integer(unsigned(RAM1(105))))  severity failure; 
 

	 assert RAM2(26) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(26))))  severity failure; 
 	 assert RAM2(27) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(27))))  severity failure; 
 	 assert RAM2(28) = std_logic_vector(to_unsigned( 152, 8)) report " TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM2(28))))  severity failure; 
 	 assert RAM2(29) = std_logic_vector(to_unsigned( 248, 8)) report " TEST FALLITO (WORKING ZONE). Expected  248  found " & integer'image(to_integer(unsigned(RAM2(29))))  severity failure; 
 	 assert RAM2(30) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(30))))  severity failure; 
 	 assert RAM2(31) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(31))))  severity failure; 
 	 assert RAM2(32) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(32))))  severity failure; 
 	 assert RAM2(33) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(33))))  severity failure; 
 	 assert RAM2(34) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM2(34))))  severity failure; 
 	 assert RAM2(35) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(35))))  severity failure; 
 	 assert RAM2(36) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(36))))  severity failure; 
 	 assert RAM2(37) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(37))))  severity failure; 
 	 assert RAM2(38) = std_logic_vector(to_unsigned( 56, 8)) report " TEST FALLITO (WORKING ZONE). Expected  56  found " & integer'image(to_integer(unsigned(RAM2(38))))  severity failure; 
 	 assert RAM2(39) = std_logic_vector(to_unsigned( 232, 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM2(39))))  severity failure; 
 	 assert RAM2(40) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM2(40))))  severity failure; 
 	 assert RAM2(41) = std_logic_vector(to_unsigned( 200, 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM2(41))))  severity failure; 
 	 assert RAM2(42) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(42))))  severity failure; 
 	 assert RAM2(43) = std_logic_vector(to_unsigned( 184, 8)) report " TEST FALLITO (WORKING ZONE). Expected  184  found " & integer'image(to_integer(unsigned(RAM2(43))))  severity failure; 
 	 assert RAM2(44) = std_logic_vector(to_unsigned( 136, 8)) report " TEST FALLITO (WORKING ZONE). Expected  136  found " & integer'image(to_integer(unsigned(RAM2(44))))  severity failure; 
 	 assert RAM2(45) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(45))))  severity failure; 
 	 assert RAM2(46) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(46))))  severity failure; 
 	 assert RAM2(47) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(47))))  severity failure; 
 	 assert RAM2(48) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(48))))  severity failure; 
 	 assert RAM2(49) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(49))))  severity failure; 
 

	 assert RAM3(25) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM3(25))))  severity failure; 
 	 assert RAM3(26) = std_logic_vector(to_unsigned( 176, 8)) report " TEST FALLITO (WORKING ZONE). Expected  176  found " & integer'image(to_integer(unsigned(RAM3(26))))  severity failure; 
 	 assert RAM3(27) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM3(27))))  severity failure; 
 	 assert RAM3(28) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(28))))  severity failure; 
 	 assert RAM3(29) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM3(29))))  severity failure; 
 	 assert RAM3(30) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM3(30))))  severity failure; 
 	 assert RAM3(31) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM3(31))))  severity failure; 
 	 assert RAM3(32) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(32))))  severity failure; 
 	 assert RAM3(33) = std_logic_vector(to_unsigned( 96, 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM3(33))))  severity failure; 
 	 assert RAM3(34) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM3(34))))  severity failure; 
 	 assert RAM3(35) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(35))))  severity failure; 
 	 assert RAM3(36) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM3(36))))  severity failure; 
 	 assert RAM3(37) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(37))))  severity failure; 
 	 assert RAM3(38) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM3(38))))  severity failure; 
 	 assert RAM3(39) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(39))))  severity failure; 
 	 assert RAM3(40) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM3(40))))  severity failure; 
 	 assert RAM3(41) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(41))))  severity failure; 
 	 assert RAM3(42) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM3(42))))  severity failure; 
 	 assert RAM3(43) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM3(43))))  severity failure; 
 	 assert RAM3(44) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM3(44))))  severity failure; 
 	 assert RAM3(45) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM3(45))))  severity failure; 
 	 assert RAM3(46) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(46))))  severity failure; 
 	 assert RAM3(47) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(47))))  severity failure; 
 

	 assert RAM4(16) = std_logic_vector(to_unsigned( 96, 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM4(16))))  severity failure; 
 	 assert RAM4(17) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM4(17))))  severity failure; 
 	 assert RAM4(18) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM4(18))))  severity failure; 
 	 assert RAM4(19) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM4(19))))  severity failure; 
 	 assert RAM4(20) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM4(20))))  severity failure; 
 	 assert RAM4(21) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM4(21))))  severity failure; 
 	 assert RAM4(22) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM4(22))))  severity failure; 
 	 assert RAM4(23) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM4(23))))  severity failure; 
 	 assert RAM4(24) = std_logic_vector(to_unsigned( 96, 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM4(24))))  severity failure; 
 	 assert RAM4(25) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM4(25))))  severity failure; 
 	 assert RAM4(26) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM4(26))))  severity failure; 
 	 assert RAM4(27) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM4(27))))  severity failure; 
 	 assert RAM4(28) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(28))))  severity failure; 
 	 assert RAM4(29) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM4(29))))  severity failure;

    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end projecttb; 