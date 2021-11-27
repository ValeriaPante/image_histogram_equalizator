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
signal i: std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned( 0, 4)); 


signal RAM0: ram_type := (0 => std_logic_vector(to_unsigned( 2, 8)), 
						 1 => std_logic_vector(to_unsigned( 3, 8)), 
						 2 => std_logic_vector(to_unsigned( 152, 8)),
						 3 => std_logic_vector(to_unsigned( 148, 8)),
						 4 => std_logic_vector(to_unsigned( 182, 8)),
						 5 => std_logic_vector(to_unsigned( 156, 8)),
						 6 => std_logic_vector(to_unsigned( 142, 8)),
						 7 => std_logic_vector(to_unsigned( 190, 8)),
						 others => (others =>'0')); 



signal RAM1: ram_type := (0 => std_logic_vector(to_unsigned( 4, 8)), 
						 1 => std_logic_vector(to_unsigned( 4, 8)), 
						 2 => std_logic_vector(to_unsigned( 71, 8)),
						 3 => std_logic_vector(to_unsigned( 72, 8)),
						 4 => std_logic_vector(to_unsigned( 82, 8)),
						 5 => std_logic_vector(to_unsigned( 74, 8)),
						 6 => std_logic_vector(to_unsigned( 62, 8)),
						 7 => std_logic_vector(to_unsigned( 74, 8)),
						 8 => std_logic_vector(to_unsigned( 82, 8)),
						 9 => std_logic_vector(to_unsigned( 77, 8)),
						 10 => std_logic_vector(to_unsigned( 64, 8)),
						 11 => std_logic_vector(to_unsigned( 82, 8)),
						 12 => std_logic_vector(to_unsigned( 80, 8)),
						 13 => std_logic_vector(to_unsigned( 62, 8)),
						 14 => std_logic_vector(to_unsigned( 66, 8)),
						 15 => std_logic_vector(to_unsigned( 65, 8)),
						 16 => std_logic_vector(to_unsigned( 79, 8)),
						 17 => std_logic_vector(to_unsigned( 72, 8)),
						 others => (others =>'0')); 



signal RAM2: ram_type := (0 => std_logic_vector(to_unsigned( 3, 8)), 
						 1 => std_logic_vector(to_unsigned( 2, 8)), 
						 2 => std_logic_vector(to_unsigned( 166, 8)),
						 3 => std_logic_vector(to_unsigned( 224, 8)),
						 4 => std_logic_vector(to_unsigned( 235, 8)),
						 5 => std_logic_vector(to_unsigned( 163, 8)),
						 6 => std_logic_vector(to_unsigned( 191, 8)),
						 7 => std_logic_vector(to_unsigned( 171, 8)),
						 others => (others =>'0')); 



signal RAM3: ram_type := (0 => std_logic_vector(to_unsigned( 2, 8)), 
						 1 => std_logic_vector(to_unsigned( 5, 8)), 
						 2 => std_logic_vector(to_unsigned( 30, 8)),
						 3 => std_logic_vector(to_unsigned( 27, 8)),
						 4 => std_logic_vector(to_unsigned( 62, 8)),
						 5 => std_logic_vector(to_unsigned( 29, 8)),
						 6 => std_logic_vector(to_unsigned( 46, 8)),
						 7 => std_logic_vector(to_unsigned( 56, 8)),
						 8 => std_logic_vector(to_unsigned( 37, 8)),
						 9 => std_logic_vector(to_unsigned( 53, 8)),
						 10 => std_logic_vector(to_unsigned( 57, 8)),
						 11 => std_logic_vector(to_unsigned( 60, 8)),
						 others => (others =>'0')); 



signal RAM4: ram_type := (0 => std_logic_vector(to_unsigned( 2, 8)), 
						 1 => std_logic_vector(to_unsigned( 4, 8)), 
						 2 => std_logic_vector(to_unsigned( 154, 8)),
						 3 => std_logic_vector(to_unsigned( 126, 8)),
						 4 => std_logic_vector(to_unsigned( 128, 8)),
						 5 => std_logic_vector(to_unsigned( 151, 8)),
						 6 => std_logic_vector(to_unsigned( 131, 8)),
						 7 => std_logic_vector(to_unsigned( 112, 8)),
						 8 => std_logic_vector(to_unsigned( 183, 8)),
						 9 => std_logic_vector(to_unsigned( 111, 8)),
						 others => (others =>'0')); 



signal RAM5: ram_type := (0 => std_logic_vector(to_unsigned( 5, 8)), 
						 1 => std_logic_vector(to_unsigned( 3, 8)), 
						 2 => std_logic_vector(to_unsigned( 53, 8)),
						 3 => std_logic_vector(to_unsigned( 54, 8)),
						 4 => std_logic_vector(to_unsigned( 62, 8)),
						 5 => std_logic_vector(to_unsigned( 51, 8)),
						 6 => std_logic_vector(to_unsigned( 53, 8)),
						 7 => std_logic_vector(to_unsigned( 65, 8)),
						 8 => std_logic_vector(to_unsigned( 57, 8)),
						 9 => std_logic_vector(to_unsigned( 66, 8)),
						 10 => std_logic_vector(to_unsigned( 64, 8)),
						 11 => std_logic_vector(to_unsigned( 66, 8)),
						 12 => std_logic_vector(to_unsigned( 67, 8)),
						 13 => std_logic_vector(to_unsigned( 65, 8)),
						 14 => std_logic_vector(to_unsigned( 66, 8)),
						 15 => std_logic_vector(to_unsigned( 53, 8)),
						 16 => std_logic_vector(to_unsigned( 52, 8)),
						 others => (others =>'0')); 



signal RAM6: ram_type := (0 => std_logic_vector(to_unsigned( 2, 8)), 
						 1 => std_logic_vector(to_unsigned( 3, 8)), 
						 2 => std_logic_vector(to_unsigned( 108, 8)),
						 3 => std_logic_vector(to_unsigned( 84, 8)),
						 4 => std_logic_vector(to_unsigned( 125, 8)),
						 5 => std_logic_vector(to_unsigned( 118, 8)),
						 6 => std_logic_vector(to_unsigned( 33, 8)),
						 7 => std_logic_vector(to_unsigned( 117, 8)),
						 others => (others =>'0')); 



signal RAM7: ram_type := (0 => std_logic_vector(to_unsigned( 4, 8)), 
						 1 => std_logic_vector(to_unsigned( 4, 8)), 
						 2 => std_logic_vector(to_unsigned( 165, 8)),
						 3 => std_logic_vector(to_unsigned( 140, 8)),
						 4 => std_logic_vector(to_unsigned( 159, 8)),
						 5 => std_logic_vector(to_unsigned( 171, 8)),
						 6 => std_logic_vector(to_unsigned( 159, 8)),
						 7 => std_logic_vector(to_unsigned( 178, 8)),
						 8 => std_logic_vector(to_unsigned( 203, 8)),
						 9 => std_logic_vector(to_unsigned( 135, 8)),
						 10 => std_logic_vector(to_unsigned( 156, 8)),
						 11 => std_logic_vector(to_unsigned( 154, 8)),
						 12 => std_logic_vector(to_unsigned( 104, 8)),
						 13 => std_logic_vector(to_unsigned( 154, 8)),
						 14 => std_logic_vector(to_unsigned( 145, 8)),
						 15 => std_logic_vector(to_unsigned( 128, 8)),
						 16 => std_logic_vector(to_unsigned( 170, 8)),
						 17 => std_logic_vector(to_unsigned( 134, 8)),
						 others => (others =>'0')); 



signal RAM8: ram_type := (0 => std_logic_vector(to_unsigned( 5, 8)), 
						 1 => std_logic_vector(to_unsigned( 4, 8)), 
						 2 => std_logic_vector(to_unsigned( 8, 8)),
						 3 => std_logic_vector(to_unsigned( 10, 8)),
						 4 => std_logic_vector(to_unsigned( 12, 8)),
						 5 => std_logic_vector(to_unsigned( 11, 8)),
						 6 => std_logic_vector(to_unsigned( 9, 8)),
						 7 => std_logic_vector(to_unsigned( 7, 8)),
						 8 => std_logic_vector(to_unsigned( 11, 8)),
						 9 => std_logic_vector(to_unsigned( 11, 8)),
						 10 => std_logic_vector(to_unsigned( 10, 8)),
						 11 => std_logic_vector(to_unsigned( 13, 8)),
						 12 => std_logic_vector(to_unsigned( 12, 8)),
						 13 => std_logic_vector(to_unsigned( 5, 8)),
						 14 => std_logic_vector(to_unsigned( 7, 8)),
						 15 => std_logic_vector(to_unsigned( 7, 8)),
						 16 => std_logic_vector(to_unsigned( 8, 8)),
						 17 => std_logic_vector(to_unsigned( 10, 8)),
						 18 => std_logic_vector(to_unsigned( 12, 8)),
						 19 => std_logic_vector(to_unsigned( 7, 8)),
						 20 => std_logic_vector(to_unsigned( 13, 8)),
						 21 => std_logic_vector(to_unsigned( 12, 8)),
						 others => (others =>'0')); 



signal RAM9: ram_type := (0 => std_logic_vector(to_unsigned( 1, 8)), 
						 1 => std_logic_vector(to_unsigned( 3, 8)), 
						 2 => std_logic_vector(to_unsigned( 10, 8)),
						 3 => std_logic_vector(to_unsigned( 32, 8)),
						 4 => std_logic_vector(to_unsigned( 24, 8)),
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
			 if i = std_logic_vector(to_unsigned( 0, 4)) then
				 if mem_we = '1' then
					 RAM0(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM0(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 1, 4)) then
				 if mem_we = '1' then
					 RAM1(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM1(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 2, 4)) then
				 if mem_we = '1' then
					 RAM2(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM2(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 3, 4)) then
				 if mem_we = '1' then
					 RAM3(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM3(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 4, 4)) then
				 if mem_we = '1' then
					 RAM4(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM4(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 5, 4)) then
				 if mem_we = '1' then
					 RAM5(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM5(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 6, 4)) then
				 if mem_we = '1' then
					 RAM6(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM6(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 7, 4)) then
				 if mem_we = '1' then
					 RAM7(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM7(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 8, 4)) then
				 if mem_we = '1' then
					 RAM8(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM8(conv_integer(mem_address)) after 1 ns;
				 end if;
			 elsif i = std_logic_vector(to_unsigned( 9, 4)) then
				 if mem_we = '1' then
					 RAM9(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM9(conv_integer(mem_address)) after 1 ns;
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
	 wait for 0 ns;
	 tb_rst <= '1';
	 wait for c_CLOCK_PERIOD;
	 tb_rst <= '0';
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 i <= std_logic_vector(to_unsigned( 1, 4));

 
 	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 i <= std_logic_vector(to_unsigned( 2, 4));

 
 	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 i <= std_logic_vector(to_unsigned( 3, 4));

 
 	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait for 0 ns;
	 tb_rst <= '1';
	 wait for c_CLOCK_PERIOD;
	 tb_rst <= '0';
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 i <= std_logic_vector(to_unsigned( 4, 4));

 
 	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 i <= std_logic_vector(to_unsigned( 5, 4));

 
 	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 i <= std_logic_vector(to_unsigned( 6, 4));

 
 	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait for 0 ns;
	 tb_rst <= '1';
	 wait for c_CLOCK_PERIOD;
	 tb_rst <= '0';
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 i <= std_logic_vector(to_unsigned( 7, 4));

 
 	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 i <= std_logic_vector(to_unsigned( 8, 4));

 
 	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 i <= std_logic_vector(to_unsigned( 9, 4));

 
 	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait for 100 ns;
	 tb_rst <= '1';
	 wait for c_CLOCK_PERIOD;
	 tb_rst <= '0';
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';



	 assert RAM0(8) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM0(8))))  severity failure; 
 	 assert RAM0(9) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM0(9))))  severity failure; 
 	 assert RAM0(10) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(10))))  severity failure; 
 	 assert RAM0(11) = std_logic_vector(to_unsigned( 112, 8)) report " TEST FALLITO (WORKING ZONE). Expected  112  found " & integer'image(to_integer(unsigned(RAM0(11))))  severity failure; 
 	 assert RAM0(12) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM0(12))))  severity failure; 
 	 assert RAM0(13) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(13))))  severity failure; 
 

	 assert RAM1(18) = std_logic_vector(to_unsigned( 144, 8)) report " TEST FALLITO (WORKING ZONE). Expected  144  found " & integer'image(to_integer(unsigned(RAM1(18))))  severity failure; 
 	 assert RAM1(19) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM1(19))))  severity failure; 
 	 assert RAM1(20) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(20))))  severity failure; 
 	 assert RAM1(21) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM1(21))))  severity failure; 
 	 assert RAM1(22) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(22))))  severity failure; 
 	 assert RAM1(23) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM1(23))))  severity failure; 
 	 assert RAM1(24) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(24))))  severity failure; 
 	 assert RAM1(25) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM1(25))))  severity failure; 
 	 assert RAM1(26) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM1(26))))  severity failure; 
 	 assert RAM1(27) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(27))))  severity failure; 
 	 assert RAM1(28) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(28))))  severity failure; 
 	 assert RAM1(29) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(29))))  severity failure; 
 	 assert RAM1(30) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM1(30))))  severity failure; 
 	 assert RAM1(31) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM1(31))))  severity failure; 
 	 assert RAM1(32) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(32))))  severity failure; 
 	 assert RAM1(33) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM1(33))))  severity failure; 
 

	 assert RAM2(8) = std_logic_vector(to_unsigned( 12, 8)) report " TEST FALLITO (WORKING ZONE). Expected  12  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
 	 assert RAM2(9) = std_logic_vector(to_unsigned( 244, 8)) report " TEST FALLITO (WORKING ZONE). Expected  244  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure; 
 	 assert RAM2(10) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(10))))  severity failure; 
 	 assert RAM2(11) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(11))))  severity failure; 
 	 assert RAM2(12) = std_logic_vector(to_unsigned( 112, 8)) report " TEST FALLITO (WORKING ZONE). Expected  112  found " & integer'image(to_integer(unsigned(RAM2(12))))  severity failure; 
 	 assert RAM2(13) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM2(13))))  severity failure; 
 

	 assert RAM3(12) = std_logic_vector(to_unsigned( 24, 8)) report " TEST FALLITO (WORKING ZONE). Expected  24  found " & integer'image(to_integer(unsigned(RAM3(12))))  severity failure; 
 	 assert RAM3(13) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(13))))  severity failure; 
 	 assert RAM3(14) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(14))))  severity failure; 
 	 assert RAM3(15) = std_logic_vector(to_unsigned( 16, 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM3(15))))  severity failure; 
 	 assert RAM3(16) = std_logic_vector(to_unsigned( 152, 8)) report " TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM3(16))))  severity failure; 
 	 assert RAM3(17) = std_logic_vector(to_unsigned( 232, 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM3(17))))  severity failure; 
 	 assert RAM3(18) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM3(18))))  severity failure; 
 	 assert RAM3(19) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM3(19))))  severity failure; 
 	 assert RAM3(20) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM3(20))))  severity failure; 
 	 assert RAM3(21) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(21))))  severity failure; 
 

	 assert RAM4(10) = std_logic_vector(to_unsigned( 172, 8)) report " TEST FALLITO (WORKING ZONE). Expected  172  found " & integer'image(to_integer(unsigned(RAM4(10))))  severity failure; 
 	 assert RAM4(11) = std_logic_vector(to_unsigned( 60, 8)) report " TEST FALLITO (WORKING ZONE). Expected  60  found " & integer'image(to_integer(unsigned(RAM4(11))))  severity failure; 
 	 assert RAM4(12) = std_logic_vector(to_unsigned( 68, 8)) report " TEST FALLITO (WORKING ZONE). Expected  68  found " & integer'image(to_integer(unsigned(RAM4(12))))  severity failure; 
 	 assert RAM4(13) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM4(13))))  severity failure; 
 	 assert RAM4(14) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM4(14))))  severity failure; 
 	 assert RAM4(15) = std_logic_vector(to_unsigned( 4, 8)) report " TEST FALLITO (WORKING ZONE). Expected  4  found " & integer'image(to_integer(unsigned(RAM4(15))))  severity failure; 
 	 assert RAM4(16) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM4(16))))  severity failure; 
 	 assert RAM4(17) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(17))))  severity failure; 
 

	 assert RAM5(17) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM5(17))))  severity failure; 
 	 assert RAM5(18) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM5(18))))  severity failure; 
 	 assert RAM5(19) = std_logic_vector(to_unsigned( 176, 8)) report " TEST FALLITO (WORKING ZONE). Expected  176  found " & integer'image(to_integer(unsigned(RAM5(19))))  severity failure; 
 	 assert RAM5(20) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM5(20))))  severity failure; 
 	 assert RAM5(21) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM5(21))))  severity failure; 
 	 assert RAM5(22) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM5(22))))  severity failure; 
 	 assert RAM5(23) = std_logic_vector(to_unsigned( 96, 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM5(23))))  severity failure; 
 	 assert RAM5(24) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM5(24))))  severity failure; 
 	 assert RAM5(25) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM5(25))))  severity failure; 
 	 assert RAM5(26) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM5(26))))  severity failure; 
 	 assert RAM5(27) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(27))))  severity failure; 
 	 assert RAM5(28) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM5(28))))  severity failure; 
 	 assert RAM5(29) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM5(29))))  severity failure; 
 	 assert RAM5(30) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM5(30))))  severity failure; 
 	 assert RAM5(31) = std_logic_vector(to_unsigned( 16, 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM5(31))))  severity failure; 
 

	 assert RAM6(8) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM6(8))))  severity failure; 
 	 assert RAM6(9) = std_logic_vector(to_unsigned( 204, 8)) report " TEST FALLITO (WORKING ZONE). Expected  204  found " & integer'image(to_integer(unsigned(RAM6(9))))  severity failure; 
 	 assert RAM6(10) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM6(10))))  severity failure; 
 	 assert RAM6(11) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM6(11))))  severity failure; 
 	 assert RAM6(12) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM6(12))))  severity failure; 
 	 assert RAM6(13) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM6(13))))  severity failure; 
 

	 assert RAM7(18) = std_logic_vector(to_unsigned( 244, 8)) report " TEST FALLITO (WORKING ZONE). Expected  244  found " & integer'image(to_integer(unsigned(RAM7(18))))  severity failure; 
 	 assert RAM7(19) = std_logic_vector(to_unsigned( 144, 8)) report " TEST FALLITO (WORKING ZONE). Expected  144  found " & integer'image(to_integer(unsigned(RAM7(19))))  severity failure; 
 	 assert RAM7(20) = std_logic_vector(to_unsigned( 220, 8)) report " TEST FALLITO (WORKING ZONE). Expected  220  found " & integer'image(to_integer(unsigned(RAM7(20))))  severity failure; 
 	 assert RAM7(21) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM7(21))))  severity failure; 
 	 assert RAM7(22) = std_logic_vector(to_unsigned( 220, 8)) report " TEST FALLITO (WORKING ZONE). Expected  220  found " & integer'image(to_integer(unsigned(RAM7(22))))  severity failure; 
 	 assert RAM7(23) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM7(23))))  severity failure; 
 	 assert RAM7(24) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM7(24))))  severity failure; 
 	 assert RAM7(25) = std_logic_vector(to_unsigned( 124, 8)) report " TEST FALLITO (WORKING ZONE). Expected  124  found " & integer'image(to_integer(unsigned(RAM7(25))))  severity failure; 
 	 assert RAM7(26) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM7(26))))  severity failure; 
 	 assert RAM7(27) = std_logic_vector(to_unsigned( 200, 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM7(27))))  severity failure; 
 	 assert RAM7(28) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM7(28))))  severity failure; 
 	 assert RAM7(29) = std_logic_vector(to_unsigned( 200, 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM7(29))))  severity failure; 
 	 assert RAM7(30) = std_logic_vector(to_unsigned( 164, 8)) report " TEST FALLITO (WORKING ZONE). Expected  164  found " & integer'image(to_integer(unsigned(RAM7(30))))  severity failure; 
 	 assert RAM7(31) = std_logic_vector(to_unsigned( 96, 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM7(31))))  severity failure; 
 	 assert RAM7(32) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM7(32))))  severity failure; 
 	 assert RAM7(33) = std_logic_vector(to_unsigned( 120, 8)) report " TEST FALLITO (WORKING ZONE). Expected  120  found " & integer'image(to_integer(unsigned(RAM7(33))))  severity failure; 
 

	 assert RAM8(22) = std_logic_vector(to_unsigned( 96, 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM8(22))))  severity failure; 
 	 assert RAM8(23) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM8(23))))  severity failure; 
 	 assert RAM8(24) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM8(24))))  severity failure; 
 	 assert RAM8(25) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM8(25))))  severity failure; 
 	 assert RAM8(26) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM8(26))))  severity failure; 
 	 assert RAM8(27) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM8(27))))  severity failure; 
 	 assert RAM8(28) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM8(28))))  severity failure; 
 	 assert RAM8(29) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM8(29))))  severity failure; 
 	 assert RAM8(30) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM8(30))))  severity failure; 
 	 assert RAM8(31) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM8(31))))  severity failure; 
 	 assert RAM8(32) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM8(32))))  severity failure; 
 	 assert RAM8(33) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM8(33))))  severity failure; 
 	 assert RAM8(34) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM8(34))))  severity failure; 
 	 assert RAM8(35) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM8(35))))  severity failure; 
 	 assert RAM8(36) = std_logic_vector(to_unsigned( 96, 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM8(36))))  severity failure; 
 	 assert RAM8(37) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM8(37))))  severity failure; 
 	 assert RAM8(38) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM8(38))))  severity failure; 
 	 assert RAM8(39) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM8(39))))  severity failure; 
 	 assert RAM8(40) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM8(40))))  severity failure; 
 	 assert RAM8(41) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM8(41))))  severity failure; 
 

	 assert RAM9(5) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM9(5))))  severity failure; 
 	 assert RAM9(6) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(6))))  severity failure; 
 	 assert RAM9(7) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM9(7))))  severity failure; 
 

	 assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end projecttb; 

