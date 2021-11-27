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
signal i: std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned( 0, 3)); 


signal RAM0: ram_type := (0 => std_logic_vector(to_unsigned( 4, 8)), 
						 1 => std_logic_vector(to_unsigned( 4, 8)), 
						 2 => std_logic_vector(to_unsigned( 255, 8)),
						 3 => std_logic_vector(to_unsigned( 51, 8)),
						 4 => std_logic_vector(to_unsigned( 27, 8)),
						 5 => std_logic_vector(to_unsigned( 194, 8)),
						 6 => std_logic_vector(to_unsigned( 188, 8)),
						 7 => std_logic_vector(to_unsigned( 237, 8)),
						 8 => std_logic_vector(to_unsigned( 236, 8)),
						 9 => std_logic_vector(to_unsigned( 172, 8)),
						 10 => std_logic_vector(to_unsigned( 94, 8)),
						 11 => std_logic_vector(to_unsigned( 158, 8)),
						 12 => std_logic_vector(to_unsigned( 120, 8)),
						 13 => std_logic_vector(to_unsigned( 57, 8)),
						 14 => std_logic_vector(to_unsigned( 111, 8)),
						 15 => std_logic_vector(to_unsigned( 167, 8)),
						 16 => std_logic_vector(to_unsigned( 109, 8)),
						 17 => std_logic_vector(to_unsigned( 10, 8)),
						 others => (others =>'0')); 



signal RAM1: ram_type := (0 => std_logic_vector(to_unsigned( 5, 8)), 
						 1 => std_logic_vector(to_unsigned( 2, 8)), 
						 2 => std_logic_vector(to_unsigned( 0, 8)),
						 3 => std_logic_vector(to_unsigned( 79, 8)),
						 4 => std_logic_vector(to_unsigned( 5, 8)),
						 5 => std_logic_vector(to_unsigned( 79, 8)),
						 6 => std_logic_vector(to_unsigned( 35, 8)),
						 7 => std_logic_vector(to_unsigned( 48, 8)),
						 8 => std_logic_vector(to_unsigned( 9, 8)),
						 9 => std_logic_vector(to_unsigned( 72, 8)),
						 10 => std_logic_vector(to_unsigned( 24, 8)),
						 11 => std_logic_vector(to_unsigned( 80, 8)),
						 others => (others =>'0')); 



signal RAM2: ram_type := (0 => std_logic_vector(to_unsigned( 3, 8)), 
						 1 => std_logic_vector(to_unsigned( 6, 8)), 
						 2 => std_logic_vector(to_unsigned( 100, 8)),
						 3 => std_logic_vector(to_unsigned( 100, 8)),
						 4 => std_logic_vector(to_unsigned( 100, 8)),
						 5 => std_logic_vector(to_unsigned( 100, 8)),
						 6 => std_logic_vector(to_unsigned( 100, 8)),
						 7 => std_logic_vector(to_unsigned( 100, 8)),
						 8 => std_logic_vector(to_unsigned( 100, 8)),
						 9 => std_logic_vector(to_unsigned( 100, 8)),
						 10 => std_logic_vector(to_unsigned( 100, 8)),
						 11 => std_logic_vector(to_unsigned( 100, 8)),
						 12 => std_logic_vector(to_unsigned( 100, 8)),
						 13 => std_logic_vector(to_unsigned( 100, 8)),
						 14 => std_logic_vector(to_unsigned( 100, 8)),
						 15 => std_logic_vector(to_unsigned( 100, 8)),
						 16 => std_logic_vector(to_unsigned( 100, 8)),
						 17 => std_logic_vector(to_unsigned( 100, 8)),
						 18 => std_logic_vector(to_unsigned( 100, 8)),
						 19 => std_logic_vector(to_unsigned( 100, 8)),
						 others => (others =>'0')); 



signal RAM3: ram_type := (0 => std_logic_vector(to_unsigned( 8, 8)), 
						 1 => std_logic_vector(to_unsigned( 1, 8)), 
						 2 => std_logic_vector(to_unsigned( 238, 8)),
						 3 => std_logic_vector(to_unsigned( 173, 8)),
						 4 => std_logic_vector(to_unsigned( 180, 8)),
						 5 => std_logic_vector(to_unsigned( 233, 8)),
						 6 => std_logic_vector(to_unsigned( 232, 8)),
						 7 => std_logic_vector(to_unsigned( 224, 8)),
						 8 => std_logic_vector(to_unsigned( 211, 8)),
						 9 => std_logic_vector(to_unsigned( 212, 8)),
						 others => (others =>'0')); 



signal RAM4: ram_type := (0 => std_logic_vector(to_unsigned( 1, 8)), 
						 1 => std_logic_vector(to_unsigned( 12, 8)), 
						 2 => std_logic_vector(to_unsigned( 69, 8)),
						 3 => std_logic_vector(to_unsigned( 163, 8)),
						 4 => std_logic_vector(to_unsigned( 72, 8)),
						 5 => std_logic_vector(to_unsigned( 78, 8)),
						 6 => std_logic_vector(to_unsigned( 105, 8)),
						 7 => std_logic_vector(to_unsigned( 85, 8)),
						 8 => std_logic_vector(to_unsigned( 107, 8)),
						 9 => std_logic_vector(to_unsigned( 97, 8)),
						 10 => std_logic_vector(to_unsigned( 156, 8)),
						 11 => std_logic_vector(to_unsigned( 163, 8)),
						 12 => std_logic_vector(to_unsigned( 146, 8)),
						 13 => std_logic_vector(to_unsigned( 146, 8)),
						 others => (others =>'0')); 



signal RAM5: ram_type := (0 => std_logic_vector(to_unsigned( 1, 8)), 
						 1 => std_logic_vector(to_unsigned( 1, 8)), 
						 2 => std_logic_vector(to_unsigned( 10, 8)),
						 others => (others =>'0')); 



signal RAM6: ram_type := (0 => std_logic_vector(to_unsigned( 3, 8)), 
						 1 => std_logic_vector(to_unsigned( 3, 8)), 
						 2 => std_logic_vector(to_unsigned( 100, 8)),
						 3 => std_logic_vector(to_unsigned( 100, 8)),
						 4 => std_logic_vector(to_unsigned( 100, 8)),
						 5 => std_logic_vector(to_unsigned( 100, 8)),
						 6 => std_logic_vector(to_unsigned( 100, 8)),
						 7 => std_logic_vector(to_unsigned( 99, 8)),
						 8 => std_logic_vector(to_unsigned( 99, 8)),
						 9 => std_logic_vector(to_unsigned( 100, 8)),
						 10 => std_logic_vector(to_unsigned( 99, 8)),
						 others => (others =>'0')); 



signal RAM7: ram_type := (0 => std_logic_vector(to_unsigned( 8, 8)), 
						 1 => std_logic_vector(to_unsigned( 2, 8)), 
						 2 => std_logic_vector(to_unsigned( 135, 8)),
						 3 => std_logic_vector(to_unsigned( 70, 8)),
						 4 => std_logic_vector(to_unsigned( 182, 8)),
						 5 => std_logic_vector(to_unsigned( 178, 8)),
						 6 => std_logic_vector(to_unsigned( 81, 8)),
						 7 => std_logic_vector(to_unsigned( 95, 8)),
						 8 => std_logic_vector(to_unsigned( 152, 8)),
						 9 => std_logic_vector(to_unsigned( 89, 8)),
						 10 => std_logic_vector(to_unsigned( 63, 8)),
						 11 => std_logic_vector(to_unsigned( 56, 8)),
						 12 => std_logic_vector(to_unsigned( 135, 8)),
						 13 => std_logic_vector(to_unsigned( 125, 8)),
						 14 => std_logic_vector(to_unsigned( 109, 8)),
						 15 => std_logic_vector(to_unsigned( 80, 8)),
						 16 => std_logic_vector(to_unsigned( 45, 8)),
						 17 => std_logic_vector(to_unsigned( 199, 8)),
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
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 2, 3)) then
				 if mem_we = '1' then
					 RAM2(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM2(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 3, 3)) then
				 if mem_we = '1' then
					 RAM3(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM3(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 4, 3)) then
				 if mem_we = '1' then
					 RAM4(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM4(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 5, 3)) then
				 if mem_we = '1' then
					 RAM5(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM5(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 6, 3)) then
				 if mem_we = '1' then
					 RAM6(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM6(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 7, 3)) then
				 if mem_we = '1' then
					 RAM7(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM7(conv_integer(mem_address)) after 1 ns;
				 end if;
			 end if;
		 end if;
	 end if;
end process;






test : process is
begin
	 wait for 151 ns;
	 wait for c_CLOCK_PERIOD;
	 tb_rst <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait for 7 ns;
	 tb_rst <= '0';
	 wait for c_CLOCK_PERIOD;
	 wait for 102 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 194 ns;
	 i <= std_logic_vector(to_unsigned( 1, 3));

 
 	 wait for 149 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 30 ns;
	 i <= std_logic_vector(to_unsigned( 2, 3));

 
 	 wait for 24 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 85 ns;
	 i <= std_logic_vector(to_unsigned( 3, 3));

 
 	 wait for 155 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 157 ns;
	 i <= std_logic_vector(to_unsigned( 4, 3));

 
 	 wait for 41 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 167 ns;
	 i <= std_logic_vector(to_unsigned( 5, 3));

 
 	 wait for 177 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 132 ns;
	 i <= std_logic_vector(to_unsigned( 6, 3));

 
 	 wait for 109 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 145 ns;
	 i <= std_logic_vector(to_unsigned( 7, 3));

 
 	 wait for 40 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 27 ns;



	 assert RAM0(18) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(18))))  severity failure; 
 	 assert RAM0(19) = std_logic_vector(to_unsigned( 82, 8)) report " TEST FALLITO (WORKING ZONE). Expected  82  found " & integer'image(to_integer(unsigned(RAM0(19))))  severity failure; 
 	 assert RAM0(20) = std_logic_vector(to_unsigned( 34, 8)) report " TEST FALLITO (WORKING ZONE). Expected  34  found " & integer'image(to_integer(unsigned(RAM0(20))))  severity failure; 
 	 assert RAM0(21) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(21))))  severity failure; 
 	 assert RAM0(22) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(22))))  severity failure; 
 	 assert RAM0(23) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(23))))  severity failure; 
 	 assert RAM0(24) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(24))))  severity failure; 
 	 assert RAM0(25) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(25))))  severity failure; 
 	 assert RAM0(26) = std_logic_vector(to_unsigned( 168, 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM0(26))))  severity failure; 
 	 assert RAM0(27) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(27))))  severity failure; 
 	 assert RAM0(28) = std_logic_vector(to_unsigned( 220, 8)) report " TEST FALLITO (WORKING ZONE). Expected  220  found " & integer'image(to_integer(unsigned(RAM0(28))))  severity failure; 
 	 assert RAM0(29) = std_logic_vector(to_unsigned( 94, 8)) report " TEST FALLITO (WORKING ZONE). Expected  94  found " & integer'image(to_integer(unsigned(RAM0(29))))  severity failure; 
 	 assert RAM0(30) = std_logic_vector(to_unsigned( 202, 8)) report " TEST FALLITO (WORKING ZONE). Expected  202  found " & integer'image(to_integer(unsigned(RAM0(30))))  severity failure; 
 	 assert RAM0(31) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(31))))  severity failure; 
 	 assert RAM0(32) = std_logic_vector(to_unsigned( 198, 8)) report " TEST FALLITO (WORKING ZONE). Expected  198  found " & integer'image(to_integer(unsigned(RAM0(32))))  severity failure; 
 	 assert RAM0(33) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM0(33))))  severity failure; 
 

	 assert RAM1(12) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(12))))  severity failure; 
 	 assert RAM1(13) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(13))))  severity failure; 
 	 assert RAM1(14) = std_logic_vector(to_unsigned( 20, 8)) report " TEST FALLITO (WORKING ZONE). Expected  20  found " & integer'image(to_integer(unsigned(RAM1(14))))  severity failure; 
 	 assert RAM1(15) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(15))))  severity failure; 
 	 assert RAM1(16) = std_logic_vector(to_unsigned( 140, 8)) report " TEST FALLITO (WORKING ZONE). Expected  140  found " & integer'image(to_integer(unsigned(RAM1(16))))  severity failure; 
 	 assert RAM1(17) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM1(17))))  severity failure; 
 	 assert RAM1(18) = std_logic_vector(to_unsigned( 36, 8)) report " TEST FALLITO (WORKING ZONE). Expected  36  found " & integer'image(to_integer(unsigned(RAM1(18))))  severity failure; 
 	 assert RAM1(19) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(19))))  severity failure; 
 	 assert RAM1(20) = std_logic_vector(to_unsigned( 96, 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM1(20))))  severity failure; 
 	 assert RAM1(21) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(21))))  severity failure; 
 

	 assert RAM2(20) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(20))))  severity failure; 
 	 assert RAM2(21) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(21))))  severity failure; 
 	 assert RAM2(22) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(22))))  severity failure; 
 	 assert RAM2(23) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(23))))  severity failure; 
 	 assert RAM2(24) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(24))))  severity failure; 
 	 assert RAM2(25) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(25))))  severity failure; 
 	 assert RAM2(26) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(26))))  severity failure; 
 	 assert RAM2(27) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(27))))  severity failure; 
 	 assert RAM2(28) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(28))))  severity failure; 
 	 assert RAM2(29) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(29))))  severity failure; 
 	 assert RAM2(30) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(30))))  severity failure; 
 	 assert RAM2(31) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(31))))  severity failure; 
 	 assert RAM2(32) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(32))))  severity failure; 
 	 assert RAM2(33) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(33))))  severity failure; 
 	 assert RAM2(34) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(34))))  severity failure; 
 	 assert RAM2(35) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(35))))  severity failure; 
 	 assert RAM2(36) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(36))))  severity failure; 
 	 assert RAM2(37) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(37))))  severity failure; 
 

	 assert RAM3(10) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(10))))  severity failure; 
 	 assert RAM3(11) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(11))))  severity failure; 
 	 assert RAM3(12) = std_logic_vector(to_unsigned( 28, 8)) report " TEST FALLITO (WORKING ZONE). Expected  28  found " & integer'image(to_integer(unsigned(RAM3(12))))  severity failure; 
 	 assert RAM3(13) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM3(13))))  severity failure; 
 	 assert RAM3(14) = std_logic_vector(to_unsigned( 236, 8)) report " TEST FALLITO (WORKING ZONE). Expected  236  found " & integer'image(to_integer(unsigned(RAM3(14))))  severity failure; 
 	 assert RAM3(15) = std_logic_vector(to_unsigned( 204, 8)) report " TEST FALLITO (WORKING ZONE). Expected  204  found " & integer'image(to_integer(unsigned(RAM3(15))))  severity failure; 
 	 assert RAM3(16) = std_logic_vector(to_unsigned( 152, 8)) report " TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM3(16))))  severity failure; 
 	 assert RAM3(17) = std_logic_vector(to_unsigned( 156, 8)) report " TEST FALLITO (WORKING ZONE). Expected  156  found " & integer'image(to_integer(unsigned(RAM3(17))))  severity failure; 
 

	 assert RAM4(14) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(14))))  severity failure; 
 	 assert RAM4(15) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM4(15))))  severity failure; 
 	 assert RAM4(16) = std_logic_vector(to_unsigned( 12, 8)) report " TEST FALLITO (WORKING ZONE). Expected  12  found " & integer'image(to_integer(unsigned(RAM4(16))))  severity failure; 
 	 assert RAM4(17) = std_logic_vector(to_unsigned( 36, 8)) report " TEST FALLITO (WORKING ZONE). Expected  36  found " & integer'image(to_integer(unsigned(RAM4(17))))  severity failure; 
 	 assert RAM4(18) = std_logic_vector(to_unsigned( 144, 8)) report " TEST FALLITO (WORKING ZONE). Expected  144  found " & integer'image(to_integer(unsigned(RAM4(18))))  severity failure; 
 	 assert RAM4(19) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM4(19))))  severity failure; 
 	 assert RAM4(20) = std_logic_vector(to_unsigned( 152, 8)) report " TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM4(20))))  severity failure; 
 	 assert RAM4(21) = std_logic_vector(to_unsigned( 112, 8)) report " TEST FALLITO (WORKING ZONE). Expected  112  found " & integer'image(to_integer(unsigned(RAM4(21))))  severity failure; 
 	 assert RAM4(22) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM4(22))))  severity failure; 
 	 assert RAM4(23) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM4(23))))  severity failure; 
 	 assert RAM4(24) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM4(24))))  severity failure; 
 	 assert RAM4(25) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM4(25))))  severity failure; 
 

	 assert RAM5(3) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM5(3))))  severity failure; 
 

	 assert RAM6(11) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM6(11))))  severity failure; 
 	 assert RAM6(12) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM6(12))))  severity failure; 
 	 assert RAM6(13) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM6(13))))  severity failure; 
 	 assert RAM6(14) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM6(14))))  severity failure; 
 	 assert RAM6(15) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM6(15))))  severity failure; 
 	 assert RAM6(16) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM6(16))))  severity failure; 
 	 assert RAM6(17) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM6(17))))  severity failure; 
 	 assert RAM6(18) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM6(18))))  severity failure; 
 	 assert RAM6(19) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM6(19))))  severity failure; 
 

	 assert RAM7(18) = std_logic_vector(to_unsigned( 180, 8)) report " TEST FALLITO (WORKING ZONE). Expected  180  found " & integer'image(to_integer(unsigned(RAM7(18))))  severity failure; 
 	 assert RAM7(19) = std_logic_vector(to_unsigned( 50, 8)) report " TEST FALLITO (WORKING ZONE). Expected  50  found " & integer'image(to_integer(unsigned(RAM7(19))))  severity failure; 
 	 assert RAM7(20) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM7(20))))  severity failure; 
 	 assert RAM7(21) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM7(21))))  severity failure; 
 	 assert RAM7(22) = std_logic_vector(to_unsigned( 72, 8)) report " TEST FALLITO (WORKING ZONE). Expected  72  found " & integer'image(to_integer(unsigned(RAM7(22))))  severity failure; 
 	 assert RAM7(23) = std_logic_vector(to_unsigned( 100, 8)) report " TEST FALLITO (WORKING ZONE). Expected  100  found " & integer'image(to_integer(unsigned(RAM7(23))))  severity failure; 
 	 assert RAM7(24) = std_logic_vector(to_unsigned( 214, 8)) report " TEST FALLITO (WORKING ZONE). Expected  214  found " & integer'image(to_integer(unsigned(RAM7(24))))  severity failure; 
 	 assert RAM7(25) = std_logic_vector(to_unsigned( 88, 8)) report " TEST FALLITO (WORKING ZONE). Expected  88  found " & integer'image(to_integer(unsigned(RAM7(25))))  severity failure; 
 	 assert RAM7(26) = std_logic_vector(to_unsigned( 36, 8)) report " TEST FALLITO (WORKING ZONE). Expected  36  found " & integer'image(to_integer(unsigned(RAM7(26))))  severity failure; 
 	 assert RAM7(27) = std_logic_vector(to_unsigned( 22, 8)) report " TEST FALLITO (WORKING ZONE). Expected  22  found " & integer'image(to_integer(unsigned(RAM7(27))))  severity failure; 
 	 assert RAM7(28) = std_logic_vector(to_unsigned( 180, 8)) report " TEST FALLITO (WORKING ZONE). Expected  180  found " & integer'image(to_integer(unsigned(RAM7(28))))  severity failure; 
 	 assert RAM7(29) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM7(29))))  severity failure; 
 	 assert RAM7(30) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM7(30))))  severity failure; 
 	 assert RAM7(31) = std_logic_vector(to_unsigned( 70, 8)) report " TEST FALLITO (WORKING ZONE). Expected  70  found " & integer'image(to_integer(unsigned(RAM7(31))))  severity failure; 
 	 assert RAM7(32) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM7(32))))  severity failure; 
 	 assert RAM7(33) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM7(33))))  severity failure; 
 

	 assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end projecttb; 

