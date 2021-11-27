
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

signal i: std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned( 0, 4)); 

signal RAM0: ram_type := (0 => std_logic_vector(to_unsigned( 2, 8)), 
						 1 => std_logic_vector(to_unsigned( 3, 8)), 
						 2 => std_logic_vector(to_unsigned( 255, 8)),
						 3 => std_logic_vector(to_unsigned( 0, 8)),
						 4 => std_logic_vector(to_unsigned( 41, 8)),
						 5 => std_logic_vector(to_unsigned( 35, 8)),
						 6 => std_logic_vector(to_unsigned( 190, 8)),
						 7 => std_logic_vector(to_unsigned( 132, 8)),
						 others => (others =>'0')); 

signal RAM1: ram_type := (0 => std_logic_vector(to_unsigned( 5, 8)), 
						 1 => std_logic_vector(to_unsigned( 2, 8)), 
						 2 => std_logic_vector(to_unsigned( 51, 8)),
						 3 => std_logic_vector(to_unsigned( 48, 8)),
						 4 => std_logic_vector(to_unsigned( 50, 8)),
						 5 => std_logic_vector(to_unsigned( 53, 8)),
						 6 => std_logic_vector(to_unsigned( 54, 8)),
						 7 => std_logic_vector(to_unsigned( 48, 8)),
						 8 => std_logic_vector(to_unsigned( 53, 8)),
						 9 => std_logic_vector(to_unsigned( 54, 8)),
						 10 => std_logic_vector(to_unsigned( 48, 8)),
						 11 => std_logic_vector(to_unsigned( 53, 8)),
						 others => (others =>'0')); 

signal RAM2: ram_type := (0 => std_logic_vector(to_unsigned( 4, 8)), 
						 1 => std_logic_vector(to_unsigned( 4, 8)), 
						 2 => std_logic_vector(to_unsigned( 1, 8)),
						 3 => std_logic_vector(to_unsigned( 0, 8)),
						 4 => std_logic_vector(to_unsigned( 3, 8)),
						 5 => std_logic_vector(to_unsigned( 3, 8)),
						 6 => std_logic_vector(to_unsigned( 1, 8)),
						 7 => std_logic_vector(to_unsigned( 3, 8)),
						 8 => std_logic_vector(to_unsigned( 3, 8)),
						 9 => std_logic_vector(to_unsigned( 2, 8)),
						 10 => std_logic_vector(to_unsigned( 3, 8)),
						 11 => std_logic_vector(to_unsigned( 0, 8)),
						 12 => std_logic_vector(to_unsigned( 3, 8)),
						 13 => std_logic_vector(to_unsigned( 0, 8)),
						 14 => std_logic_vector(to_unsigned( 2, 8)),
						 15 => std_logic_vector(to_unsigned( 1, 8)),
						 16 => std_logic_vector(to_unsigned( 0, 8)),
						 17 => std_logic_vector(to_unsigned( 2, 8)),
						 others => (others =>'0')); 

signal RAM3: ram_type := (0 => std_logic_vector(to_unsigned( 5, 8)), 
						 1 => std_logic_vector(to_unsigned( 6, 8)), 
						 2 => std_logic_vector(to_unsigned( 200, 8)),
						 3 => std_logic_vector(to_unsigned( 200, 8)),
						 4 => std_logic_vector(to_unsigned( 200, 8)),
						 5 => std_logic_vector(to_unsigned( 200, 8)),
						 6 => std_logic_vector(to_unsigned( 200, 8)),
						 7 => std_logic_vector(to_unsigned( 200, 8)),
						 8 => std_logic_vector(to_unsigned( 200, 8)),
						 9 => std_logic_vector(to_unsigned( 200, 8)),
						 10 => std_logic_vector(to_unsigned( 200, 8)),
						 11 => std_logic_vector(to_unsigned( 200, 8)),
						 12 => std_logic_vector(to_unsigned( 200, 8)),
						 13 => std_logic_vector(to_unsigned( 200, 8)),
						 14 => std_logic_vector(to_unsigned( 200, 8)),
						 15 => std_logic_vector(to_unsigned( 200, 8)),
						 16 => std_logic_vector(to_unsigned( 200, 8)),
						 17 => std_logic_vector(to_unsigned( 200, 8)),
						 18 => std_logic_vector(to_unsigned( 200, 8)),
						 19 => std_logic_vector(to_unsigned( 200, 8)),
						 20 => std_logic_vector(to_unsigned( 200, 8)),
						 21 => std_logic_vector(to_unsigned( 200, 8)),
						 22 => std_logic_vector(to_unsigned( 200, 8)),
						 23 => std_logic_vector(to_unsigned( 200, 8)),
						 24 => std_logic_vector(to_unsigned( 200, 8)),
						 25 => std_logic_vector(to_unsigned( 200, 8)),
						 26 => std_logic_vector(to_unsigned( 200, 8)),
						 27 => std_logic_vector(to_unsigned( 200, 8)),
						 28 => std_logic_vector(to_unsigned( 200, 8)),
						 29 => std_logic_vector(to_unsigned( 200, 8)),
						 30 => std_logic_vector(to_unsigned( 200, 8)),
						 31 => std_logic_vector(to_unsigned( 200, 8)),
						 others => (others =>'0')); 

signal RAM4: ram_type := (0 => std_logic_vector(to_unsigned( 2, 8)), 
						 1 => std_logic_vector(to_unsigned( 5, 8)), 
						 2 => std_logic_vector(to_unsigned( 0, 8)),
						 3 => std_logic_vector(to_unsigned( 0, 8)),
						 4 => std_logic_vector(to_unsigned( 0, 8)),
						 5 => std_logic_vector(to_unsigned( 0, 8)),
						 6 => std_logic_vector(to_unsigned( 0, 8)),
						 7 => std_logic_vector(to_unsigned( 0, 8)),
						 8 => std_logic_vector(to_unsigned( 0, 8)),
						 9 => std_logic_vector(to_unsigned( 0, 8)),
						 10 => std_logic_vector(to_unsigned( 0, 8)),
						 11 => std_logic_vector(to_unsigned( 0, 8)),
						 others => (others =>'0')); 

signal RAM5: ram_type := (0 => std_logic_vector(to_unsigned( 6, 8)), 
						 1 => std_logic_vector(to_unsigned( 7, 8)), 
						 2 => std_logic_vector(to_unsigned( 146, 8)),
						 3 => std_logic_vector(to_unsigned( 112, 8)),
						 4 => std_logic_vector(to_unsigned( 84, 8)),
						 5 => std_logic_vector(to_unsigned( 54, 8)),
						 6 => std_logic_vector(to_unsigned( 27, 8)),
						 7 => std_logic_vector(to_unsigned( 43, 8)),
						 8 => std_logic_vector(to_unsigned( 72, 8)),
						 9 => std_logic_vector(to_unsigned( 107, 8)),
						 10 => std_logic_vector(to_unsigned( 62, 8)),
						 11 => std_logic_vector(to_unsigned( 34, 8)),
						 12 => std_logic_vector(to_unsigned( 76, 8)),
						 13 => std_logic_vector(to_unsigned( 35, 8)),
						 14 => std_logic_vector(to_unsigned( 145, 8)),
						 15 => std_logic_vector(to_unsigned( 133, 8)),
						 16 => std_logic_vector(to_unsigned( 130, 8)),
						 17 => std_logic_vector(to_unsigned( 40, 8)),
						 18 => std_logic_vector(to_unsigned( 133, 8)),
						 19 => std_logic_vector(to_unsigned( 29, 8)),
						 20 => std_logic_vector(to_unsigned( 139, 8)),
						 21 => std_logic_vector(to_unsigned( 91, 8)),
						 22 => std_logic_vector(to_unsigned( 70, 8)),
						 23 => std_logic_vector(to_unsigned( 101, 8)),
						 24 => std_logic_vector(to_unsigned( 35, 8)),
						 25 => std_logic_vector(to_unsigned( 107, 8)),
						 26 => std_logic_vector(to_unsigned( 49, 8)),
						 27 => std_logic_vector(to_unsigned( 33, 8)),
						 28 => std_logic_vector(to_unsigned( 30, 8)),
						 29 => std_logic_vector(to_unsigned( 108, 8)),
						 30 => std_logic_vector(to_unsigned( 39, 8)),
						 31 => std_logic_vector(to_unsigned( 73, 8)),
						 32 => std_logic_vector(to_unsigned( 74, 8)),
						 33 => std_logic_vector(to_unsigned( 135, 8)),
						 34 => std_logic_vector(to_unsigned( 40, 8)),
						 35 => std_logic_vector(to_unsigned( 96, 8)),
						 36 => std_logic_vector(to_unsigned( 95, 8)),
						 37 => std_logic_vector(to_unsigned( 136, 8)),
						 38 => std_logic_vector(to_unsigned( 70, 8)),
						 39 => std_logic_vector(to_unsigned( 89, 8)),
						 40 => std_logic_vector(to_unsigned( 51, 8)),
						 41 => std_logic_vector(to_unsigned( 27, 8)),
						 42 => std_logic_vector(to_unsigned( 20, 8)),
						 43 => std_logic_vector(to_unsigned( 20, 8)),
						 others => (others =>'0')); 

signal RAM6: ram_type := (0 => std_logic_vector(to_unsigned( 2, 8)), 
						 1 => std_logic_vector(to_unsigned( 2, 8)), 
						 2 => std_logic_vector(to_unsigned( 85, 8)),
						 3 => std_logic_vector(to_unsigned( 148, 8)),
						 4 => std_logic_vector(to_unsigned( 116, 8)),
						 5 => std_logic_vector(to_unsigned( 111, 8)),
						 others => (others =>'0')); 

signal RAM7: ram_type := (0 => std_logic_vector(to_unsigned( 23, 8)), 
						 1 => std_logic_vector(to_unsigned( 10, 8)), 
						 2 => std_logic_vector(to_unsigned( 98, 8)),
						 3 => std_logic_vector(to_unsigned( 124, 8)),
						 4 => std_logic_vector(to_unsigned( 75, 8)),
						 5 => std_logic_vector(to_unsigned( 52, 8)),
						 6 => std_logic_vector(to_unsigned( 107, 8)),
						 7 => std_logic_vector(to_unsigned( 164, 8)),
						 8 => std_logic_vector(to_unsigned( 79, 8)),
						 9 => std_logic_vector(to_unsigned( 123, 8)),
						 10 => std_logic_vector(to_unsigned( 94, 8)),
						 11 => std_logic_vector(to_unsigned( 50, 8)),
						 12 => std_logic_vector(to_unsigned( 176, 8)),
						 13 => std_logic_vector(to_unsigned( 119, 8)),
						 14 => std_logic_vector(to_unsigned( 75, 8)),
						 15 => std_logic_vector(to_unsigned( 135, 8)),
						 16 => std_logic_vector(to_unsigned( 155, 8)),
						 17 => std_logic_vector(to_unsigned( 50, 8)),
						 18 => std_logic_vector(to_unsigned( 100, 8)),
						 19 => std_logic_vector(to_unsigned( 156, 8)),
						 20 => std_logic_vector(to_unsigned( 123, 8)),
						 21 => std_logic_vector(to_unsigned( 126, 8)),
						 22 => std_logic_vector(to_unsigned( 133, 8)),
						 23 => std_logic_vector(to_unsigned( 113, 8)),
						 24 => std_logic_vector(to_unsigned( 153, 8)),
						 25 => std_logic_vector(to_unsigned( 136, 8)),
						 26 => std_logic_vector(to_unsigned( 113, 8)),
						 27 => std_logic_vector(to_unsigned( 70, 8)),
						 28 => std_logic_vector(to_unsigned( 136, 8)),
						 29 => std_logic_vector(to_unsigned( 176, 8)),
						 30 => std_logic_vector(to_unsigned( 95, 8)),
						 31 => std_logic_vector(to_unsigned( 142, 8)),
						 32 => std_logic_vector(to_unsigned( 64, 8)),
						 33 => std_logic_vector(to_unsigned( 152, 8)),
						 34 => std_logic_vector(to_unsigned( 53, 8)),
						 35 => std_logic_vector(to_unsigned( 161, 8)),
						 36 => std_logic_vector(to_unsigned( 137, 8)),
						 37 => std_logic_vector(to_unsigned( 123, 8)),
						 38 => std_logic_vector(to_unsigned( 147, 8)),
						 39 => std_logic_vector(to_unsigned( 177, 8)),
						 40 => std_logic_vector(to_unsigned( 155, 8)),
						 41 => std_logic_vector(to_unsigned( 65, 8)),
						 42 => std_logic_vector(to_unsigned( 147, 8)),
						 43 => std_logic_vector(to_unsigned( 127, 8)),
						 44 => std_logic_vector(to_unsigned( 131, 8)),
						 45 => std_logic_vector(to_unsigned( 80, 8)),
						 46 => std_logic_vector(to_unsigned( 79, 8)),
						 47 => std_logic_vector(to_unsigned( 78, 8)),
						 48 => std_logic_vector(to_unsigned( 72, 8)),
						 49 => std_logic_vector(to_unsigned( 164, 8)),
						 50 => std_logic_vector(to_unsigned( 164, 8)),
						 51 => std_logic_vector(to_unsigned( 152, 8)),
						 52 => std_logic_vector(to_unsigned( 79, 8)),
						 53 => std_logic_vector(to_unsigned( 162, 8)),
						 54 => std_logic_vector(to_unsigned( 54, 8)),
						 55 => std_logic_vector(to_unsigned( 129, 8)),
						 56 => std_logic_vector(to_unsigned( 124, 8)),
						 57 => std_logic_vector(to_unsigned( 169, 8)),
						 58 => std_logic_vector(to_unsigned( 52, 8)),
						 59 => std_logic_vector(to_unsigned( 137, 8)),
						 60 => std_logic_vector(to_unsigned( 154, 8)),
						 61 => std_logic_vector(to_unsigned( 107, 8)),
						 62 => std_logic_vector(to_unsigned( 94, 8)),
						 63 => std_logic_vector(to_unsigned( 133, 8)),
						 64 => std_logic_vector(to_unsigned( 125, 8)),
						 65 => std_logic_vector(to_unsigned( 123, 8)),
						 66 => std_logic_vector(to_unsigned( 68, 8)),
						 67 => std_logic_vector(to_unsigned( 80, 8)),
						 68 => std_logic_vector(to_unsigned( 101, 8)),
						 69 => std_logic_vector(to_unsigned( 166, 8)),
						 70 => std_logic_vector(to_unsigned( 80, 8)),
						 71 => std_logic_vector(to_unsigned( 62, 8)),
						 72 => std_logic_vector(to_unsigned( 166, 8)),
						 73 => std_logic_vector(to_unsigned( 135, 8)),
						 74 => std_logic_vector(to_unsigned( 134, 8)),
						 75 => std_logic_vector(to_unsigned( 81, 8)),
						 76 => std_logic_vector(to_unsigned( 134, 8)),
						 77 => std_logic_vector(to_unsigned( 86, 8)),
						 78 => std_logic_vector(to_unsigned( 139, 8)),
						 79 => std_logic_vector(to_unsigned( 176, 8)),
						 80 => std_logic_vector(to_unsigned( 103, 8)),
						 81 => std_logic_vector(to_unsigned( 129, 8)),
						 82 => std_logic_vector(to_unsigned( 100, 8)),
						 83 => std_logic_vector(to_unsigned( 84, 8)),
						 84 => std_logic_vector(to_unsigned( 166, 8)),
						 85 => std_logic_vector(to_unsigned( 126, 8)),
						 86 => std_logic_vector(to_unsigned( 129, 8)),
						 87 => std_logic_vector(to_unsigned( 133, 8)),
						 88 => std_logic_vector(to_unsigned( 66, 8)),
						 89 => std_logic_vector(to_unsigned( 95, 8)),
						 90 => std_logic_vector(to_unsigned( 122, 8)),
						 91 => std_logic_vector(to_unsigned( 133, 8)),
						 92 => std_logic_vector(to_unsigned( 65, 8)),
						 93 => std_logic_vector(to_unsigned( 167, 8)),
						 94 => std_logic_vector(to_unsigned( 152, 8)),
						 95 => std_logic_vector(to_unsigned( 139, 8)),
						 96 => std_logic_vector(to_unsigned( 79, 8)),
						 97 => std_logic_vector(to_unsigned( 92, 8)),
						 98 => std_logic_vector(to_unsigned( 151, 8)),
						 99 => std_logic_vector(to_unsigned( 114, 8)),
						 100 => std_logic_vector(to_unsigned( 169, 8)),
						 101 => std_logic_vector(to_unsigned( 93, 8)),
						 102 => std_logic_vector(to_unsigned( 170, 8)),
						 103 => std_logic_vector(to_unsigned( 51, 8)),
						 104 => std_logic_vector(to_unsigned( 57, 8)),
						 105 => std_logic_vector(to_unsigned( 118, 8)),
						 106 => std_logic_vector(to_unsigned( 64, 8)),
						 107 => std_logic_vector(to_unsigned( 145, 8)),
						 108 => std_logic_vector(to_unsigned( 130, 8)),
						 109 => std_logic_vector(to_unsigned( 50, 8)),
						 110 => std_logic_vector(to_unsigned( 134, 8)),
						 111 => std_logic_vector(to_unsigned( 147, 8)),
						 112 => std_logic_vector(to_unsigned( 63, 8)),
						 113 => std_logic_vector(to_unsigned( 112, 8)),
						 114 => std_logic_vector(to_unsigned( 173, 8)),
						 115 => std_logic_vector(to_unsigned( 55, 8)),
						 116 => std_logic_vector(to_unsigned( 71, 8)),
						 117 => std_logic_vector(to_unsigned( 57, 8)),
						 118 => std_logic_vector(to_unsigned( 109, 8)),
						 119 => std_logic_vector(to_unsigned( 101, 8)),
						 120 => std_logic_vector(to_unsigned( 52, 8)),
						 121 => std_logic_vector(to_unsigned( 81, 8)),
						 122 => std_logic_vector(to_unsigned( 74, 8)),
						 123 => std_logic_vector(to_unsigned( 162, 8)),
						 124 => std_logic_vector(to_unsigned( 68, 8)),
						 125 => std_logic_vector(to_unsigned( 140, 8)),
						 126 => std_logic_vector(to_unsigned( 150, 8)),
						 127 => std_logic_vector(to_unsigned( 134, 8)),
						 128 => std_logic_vector(to_unsigned( 128, 8)),
						 129 => std_logic_vector(to_unsigned( 99, 8)),
						 130 => std_logic_vector(to_unsigned( 55, 8)),
						 131 => std_logic_vector(to_unsigned( 112, 8)),
						 132 => std_logic_vector(to_unsigned( 155, 8)),
						 133 => std_logic_vector(to_unsigned( 71, 8)),
						 134 => std_logic_vector(to_unsigned( 170, 8)),
						 135 => std_logic_vector(to_unsigned( 120, 8)),
						 136 => std_logic_vector(to_unsigned( 156, 8)),
						 137 => std_logic_vector(to_unsigned( 54, 8)),
						 138 => std_logic_vector(to_unsigned( 72, 8)),
						 139 => std_logic_vector(to_unsigned( 165, 8)),
						 140 => std_logic_vector(to_unsigned( 64, 8)),
						 141 => std_logic_vector(to_unsigned( 139, 8)),
						 142 => std_logic_vector(to_unsigned( 72, 8)),
						 143 => std_logic_vector(to_unsigned( 97, 8)),
						 144 => std_logic_vector(to_unsigned( 153, 8)),
						 145 => std_logic_vector(to_unsigned( 154, 8)),
						 146 => std_logic_vector(to_unsigned( 134, 8)),
						 147 => std_logic_vector(to_unsigned( 169, 8)),
						 148 => std_logic_vector(to_unsigned( 124, 8)),
						 149 => std_logic_vector(to_unsigned( 124, 8)),
						 150 => std_logic_vector(to_unsigned( 130, 8)),
						 151 => std_logic_vector(to_unsigned( 137, 8)),
						 152 => std_logic_vector(to_unsigned( 154, 8)),
						 153 => std_logic_vector(to_unsigned( 168, 8)),
						 154 => std_logic_vector(to_unsigned( 172, 8)),
						 155 => std_logic_vector(to_unsigned( 72, 8)),
						 156 => std_logic_vector(to_unsigned( 109, 8)),
						 157 => std_logic_vector(to_unsigned( 67, 8)),
						 158 => std_logic_vector(to_unsigned( 95, 8)),
						 159 => std_logic_vector(to_unsigned( 96, 8)),
						 160 => std_logic_vector(to_unsigned( 86, 8)),
						 161 => std_logic_vector(to_unsigned( 58, 8)),
						 162 => std_logic_vector(to_unsigned( 171, 8)),
						 163 => std_logic_vector(to_unsigned( 176, 8)),
						 164 => std_logic_vector(to_unsigned( 132, 8)),
						 165 => std_logic_vector(to_unsigned( 141, 8)),
						 166 => std_logic_vector(to_unsigned( 87, 8)),
						 167 => std_logic_vector(to_unsigned( 117, 8)),
						 168 => std_logic_vector(to_unsigned( 151, 8)),
						 169 => std_logic_vector(to_unsigned( 110, 8)),
						 170 => std_logic_vector(to_unsigned( 166, 8)),
						 171 => std_logic_vector(to_unsigned( 119, 8)),
						 172 => std_logic_vector(to_unsigned( 133, 8)),
						 173 => std_logic_vector(to_unsigned( 138, 8)),
						 174 => std_logic_vector(to_unsigned( 90, 8)),
						 175 => std_logic_vector(to_unsigned( 128, 8)),
						 176 => std_logic_vector(to_unsigned( 61, 8)),
						 177 => std_logic_vector(to_unsigned( 167, 8)),
						 178 => std_logic_vector(to_unsigned( 119, 8)),
						 179 => std_logic_vector(to_unsigned( 146, 8)),
						 180 => std_logic_vector(to_unsigned( 139, 8)),
						 181 => std_logic_vector(to_unsigned( 111, 8)),
						 182 => std_logic_vector(to_unsigned( 73, 8)),
						 183 => std_logic_vector(to_unsigned( 89, 8)),
						 184 => std_logic_vector(to_unsigned( 60, 8)),
						 185 => std_logic_vector(to_unsigned( 139, 8)),
						 186 => std_logic_vector(to_unsigned( 168, 8)),
						 187 => std_logic_vector(to_unsigned( 95, 8)),
						 188 => std_logic_vector(to_unsigned( 130, 8)),
						 189 => std_logic_vector(to_unsigned( 116, 8)),
						 190 => std_logic_vector(to_unsigned( 123, 8)),
						 191 => std_logic_vector(to_unsigned( 127, 8)),
						 192 => std_logic_vector(to_unsigned( 154, 8)),
						 193 => std_logic_vector(to_unsigned( 134, 8)),
						 194 => std_logic_vector(to_unsigned( 123, 8)),
						 195 => std_logic_vector(to_unsigned( 156, 8)),
						 196 => std_logic_vector(to_unsigned( 171, 8)),
						 197 => std_logic_vector(to_unsigned( 87, 8)),
						 198 => std_logic_vector(to_unsigned( 58, 8)),
						 199 => std_logic_vector(to_unsigned( 147, 8)),
						 200 => std_logic_vector(to_unsigned( 114, 8)),
						 201 => std_logic_vector(to_unsigned( 70, 8)),
						 202 => std_logic_vector(to_unsigned( 99, 8)),
						 203 => std_logic_vector(to_unsigned( 109, 8)),
						 204 => std_logic_vector(to_unsigned( 156, 8)),
						 205 => std_logic_vector(to_unsigned( 87, 8)),
						 206 => std_logic_vector(to_unsigned( 67, 8)),
						 207 => std_logic_vector(to_unsigned( 90, 8)),
						 208 => std_logic_vector(to_unsigned( 115, 8)),
						 209 => std_logic_vector(to_unsigned( 62, 8)),
						 210 => std_logic_vector(to_unsigned( 136, 8)),
						 211 => std_logic_vector(to_unsigned( 91, 8)),
						 212 => std_logic_vector(to_unsigned( 61, 8)),
						 213 => std_logic_vector(to_unsigned( 57, 8)),
						 214 => std_logic_vector(to_unsigned( 73, 8)),
						 215 => std_logic_vector(to_unsigned( 62, 8)),
						 216 => std_logic_vector(to_unsigned( 97, 8)),
						 217 => std_logic_vector(to_unsigned( 163, 8)),
						 218 => std_logic_vector(to_unsigned( 71, 8)),
						 219 => std_logic_vector(to_unsigned( 79, 8)),
						 220 => std_logic_vector(to_unsigned( 76, 8)),
						 221 => std_logic_vector(to_unsigned( 71, 8)),
						 222 => std_logic_vector(to_unsigned( 115, 8)),
						 223 => std_logic_vector(to_unsigned( 77, 8)),
						 224 => std_logic_vector(to_unsigned( 147, 8)),
						 225 => std_logic_vector(to_unsigned( 114, 8)),
						 226 => std_logic_vector(to_unsigned( 176, 8)),
						 227 => std_logic_vector(to_unsigned( 155, 8)),
						 228 => std_logic_vector(to_unsigned( 90, 8)),
						 229 => std_logic_vector(to_unsigned( 76, 8)),
						 230 => std_logic_vector(to_unsigned( 50, 8)),
						 231 => std_logic_vector(to_unsigned( 177, 8)),
						 others => (others =>'0')); 

signal RAM8: ram_type := (0 => std_logic_vector(to_unsigned( 3, 8)), 
						 1 => std_logic_vector(to_unsigned( 3, 8)), 
						 2 => std_logic_vector(to_unsigned( 216, 8)),
						 3 => std_logic_vector(to_unsigned( 255, 8)),
						 4 => std_logic_vector(to_unsigned( 235, 8)),
						 5 => std_logic_vector(to_unsigned( 10, 8)),
						 6 => std_logic_vector(to_unsigned( 227, 8)),
						 7 => std_logic_vector(to_unsigned( 1, 8)),
						 8 => std_logic_vector(to_unsigned( 207, 8)),
						 9 => std_logic_vector(to_unsigned( 17, 8)),
						 10 => std_logic_vector(to_unsigned( 177, 8)),
						 others => (others =>'0')); 

signal RAM9: ram_type := (0 => std_logic_vector(to_unsigned( 4, 8)), 
						 1 => std_logic_vector(to_unsigned( 10, 8)), 
						 2 => std_logic_vector(to_unsigned( 51, 8)),
						 3 => std_logic_vector(to_unsigned( 39, 8)),
						 4 => std_logic_vector(to_unsigned( 47, 8)),
						 5 => std_logic_vector(to_unsigned( 10, 8)),
						 6 => std_logic_vector(to_unsigned( 29, 8)),
						 7 => std_logic_vector(to_unsigned( 40, 8)),
						 8 => std_logic_vector(to_unsigned( 45, 8)),
						 9 => std_logic_vector(to_unsigned( 15, 8)),
						 10 => std_logic_vector(to_unsigned( 39, 8)),
						 11 => std_logic_vector(to_unsigned( 72, 8)),
						 12 => std_logic_vector(to_unsigned( 39, 8)),
						 13 => std_logic_vector(to_unsigned( 46, 8)),
						 14 => std_logic_vector(to_unsigned( 44, 8)),
						 15 => std_logic_vector(to_unsigned( 38, 8)),
						 16 => std_logic_vector(to_unsigned( 31, 8)),
						 17 => std_logic_vector(to_unsigned( 20, 8)),
						 18 => std_logic_vector(to_unsigned( 50, 8)),
						 19 => std_logic_vector(to_unsigned( 59, 8)),
						 20 => std_logic_vector(to_unsigned( 22, 8)),
						 21 => std_logic_vector(to_unsigned( 10, 8)),
						 22 => std_logic_vector(to_unsigned( 72, 8)),
						 23 => std_logic_vector(to_unsigned( 20, 8)),
						 24 => std_logic_vector(to_unsigned( 29, 8)),
						 25 => std_logic_vector(to_unsigned( 64, 8)),
						 26 => std_logic_vector(to_unsigned( 48, 8)),
						 27 => std_logic_vector(to_unsigned( 32, 8)),
						 28 => std_logic_vector(to_unsigned( 18, 8)),
						 29 => std_logic_vector(to_unsigned( 21, 8)),
						 30 => std_logic_vector(to_unsigned( 60, 8)),
						 31 => std_logic_vector(to_unsigned( 31, 8)),
						 32 => std_logic_vector(to_unsigned( 52, 8)),
						 33 => std_logic_vector(to_unsigned( 64, 8)),
						 34 => std_logic_vector(to_unsigned( 63, 8)),
						 35 => std_logic_vector(to_unsigned( 19, 8)),
						 36 => std_logic_vector(to_unsigned( 36, 8)),
						 37 => std_logic_vector(to_unsigned( 30, 8)),
						 38 => std_logic_vector(to_unsigned( 58, 8)),
						 39 => std_logic_vector(to_unsigned( 29, 8)),
						 40 => std_logic_vector(to_unsigned( 70, 8)),
						 41 => std_logic_vector(to_unsigned( 11, 8)),
						 others => (others =>'0')); 

signal RAM10: ram_type := (0 => std_logic_vector(to_unsigned( 5, 8)), 
						 1 => std_logic_vector(to_unsigned( 5, 8)), 
						 2 => std_logic_vector(to_unsigned( 222, 8)),
						 3 => std_logic_vector(to_unsigned( 200, 8)),
						 4 => std_logic_vector(to_unsigned( 224, 8)),
						 5 => std_logic_vector(to_unsigned( 202, 8)),
						 6 => std_logic_vector(to_unsigned( 203, 8)),
						 7 => std_logic_vector(to_unsigned( 217, 8)),
						 8 => std_logic_vector(to_unsigned( 206, 8)),
						 9 => std_logic_vector(to_unsigned( 231, 8)),
						 10 => std_logic_vector(to_unsigned( 226, 8)),
						 11 => std_logic_vector(to_unsigned( 209, 8)),
						 12 => std_logic_vector(to_unsigned( 213, 8)),
						 13 => std_logic_vector(to_unsigned( 230, 8)),
						 14 => std_logic_vector(to_unsigned( 202, 8)),
						 15 => std_logic_vector(to_unsigned( 200, 8)),
						 16 => std_logic_vector(to_unsigned( 222, 8)),
						 17 => std_logic_vector(to_unsigned( 218, 8)),
						 18 => std_logic_vector(to_unsigned( 220, 8)),
						 19 => std_logic_vector(to_unsigned( 231, 8)),
						 20 => std_logic_vector(to_unsigned( 225, 8)),
						 21 => std_logic_vector(to_unsigned( 231, 8)),
						 22 => std_logic_vector(to_unsigned( 206, 8)),
						 23 => std_logic_vector(to_unsigned( 231, 8)),
						 24 => std_logic_vector(to_unsigned( 209, 8)),
						 25 => std_logic_vector(to_unsigned( 230, 8)),
						 26 => std_logic_vector(to_unsigned( 217, 8)),
						 others => (others =>'0')); 

signal RAM11: ram_type := (0 => std_logic_vector(to_unsigned( 4, 8)), 
						 1 => std_logic_vector(to_unsigned( 2, 8)), 
						 2 => std_logic_vector(to_unsigned( 99, 8)),
						 3 => std_logic_vector(to_unsigned( 91, 8)),
						 4 => std_logic_vector(to_unsigned( 100, 8)),
						 5 => std_logic_vector(to_unsigned( 94, 8)),
						 6 => std_logic_vector(to_unsigned( 99, 8)),
						 7 => std_logic_vector(to_unsigned( 88, 8)),
						 8 => std_logic_vector(to_unsigned( 91, 8)),
						 9 => std_logic_vector(to_unsigned( 86, 8)),
						 others => (others =>'0')); 

signal RAM12: ram_type := (0 => std_logic_vector(to_unsigned( 2, 8)), 
						 1 => std_logic_vector(to_unsigned( 1, 8)), 
						 2 => std_logic_vector(to_unsigned( 15, 8)),
						 3 => std_logic_vector(to_unsigned( 0, 8)),
						 others => (others =>'0')); 


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
				 end if;			 elsif i = std_logic_vector(to_unsigned( 2, 4)) then
				 if mem_we = '1' then
					 RAM2(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM2(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 3, 4)) then
				 if mem_we = '1' then
					 RAM3(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM3(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 4, 4)) then
				 if mem_we = '1' then
					 RAM4(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM4(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 5, 4)) then
				 if mem_we = '1' then
					 RAM5(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM5(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 6, 4)) then
				 if mem_we = '1' then
					 RAM6(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM6(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 7, 4)) then
				 if mem_we = '1' then
					 RAM7(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM7(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 8, 4)) then
				 if mem_we = '1' then
					 RAM8(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM8(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 9, 4)) then
				 if mem_we = '1' then
					 RAM9(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM9(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 10, 4)) then
				 if mem_we = '1' then
					 RAM10(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM10(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 11, 4)) then
				 if mem_we = '1' then
					 RAM11(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM11(conv_integer(mem_address)) after 1 ns;
				 end if;			 elsif i = std_logic_vector(to_unsigned( 12, 4)) then
				 if mem_we = '1' then
					 RAM12(conv_integer(mem_address)) <= mem_i_data;
					 mem_o_data <= mem_i_data after 1 ns;
				 else
					 mem_o_data <= RAM12(conv_integer(mem_address)) after 1 ns;
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
	 i <= std_logic_vector(to_unsigned( 1, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 2, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 3, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 4, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 5, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 6, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 7, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 8, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 9, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 10, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 11, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;
	 i <= std_logic_vector(to_unsigned( 12, 4));

 
 	 wait for 100 ns;
	 tb_start <= '1';
	 wait for c_CLOCK_PERIOD;
	 wait until tb_done = '1';
	 wait for c_CLOCK_PERIOD;
	 tb_start <= '0';
	 wait until tb_done = '0';
	 wait for 100 ns;



	 assert RAM0(8) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM0(8))))  severity failure; 
 	 assert RAM0(9) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM0(9))))  severity failure; 
 	 assert RAM0(10) = std_logic_vector(to_unsigned( 41, 8)) report " TEST FALLITO (WORKING ZONE). Expected  41  found " & integer'image(to_integer(unsigned(RAM0(10))))  severity failure; 
 	 assert RAM0(11) = std_logic_vector(to_unsigned( 35, 8)) report " TEST FALLITO (WORKING ZONE). Expected  35  found " & integer'image(to_integer(unsigned(RAM0(11))))  severity failure; 
 	 assert RAM0(12) = std_logic_vector(to_unsigned( 190, 8)) report " TEST FALLITO (WORKING ZONE). Expected  190  found " & integer'image(to_integer(unsigned(RAM0(12))))  severity failure; 
 	 assert RAM0(13) = std_logic_vector(to_unsigned( 132, 8)) report " TEST FALLITO (WORKING ZONE). Expected  132  found " & integer'image(to_integer(unsigned(RAM0(13))))  severity failure; 
 

	 assert RAM1(12) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM1(12))))  severity failure; 
 	 assert RAM1(13) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(13))))  severity failure; 
 	 assert RAM1(14) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM1(14))))  severity failure; 
 	 assert RAM1(15) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(15))))  severity failure; 
 	 assert RAM1(16) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(16))))  severity failure; 
 	 assert RAM1(17) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(17))))  severity failure; 
 	 assert RAM1(18) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(18))))  severity failure; 
 	 assert RAM1(19) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(19))))  severity failure; 
 	 assert RAM1(20) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(20))))  severity failure; 
 	 assert RAM1(21) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(21))))  severity failure; 
 

	 assert RAM2(18) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM2(18))))  severity failure; 
 	 assert RAM2(19) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(19))))  severity failure; 
 	 assert RAM2(20) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(20))))  severity failure; 
 	 assert RAM2(21) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(21))))  severity failure; 
 	 assert RAM2(22) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM2(22))))  severity failure; 
 	 assert RAM2(23) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(23))))  severity failure; 
 	 assert RAM2(24) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(24))))  severity failure; 
 	 assert RAM2(25) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM2(25))))  severity failure; 
 	 assert RAM2(26) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(26))))  severity failure; 
 	 assert RAM2(27) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(27))))  severity failure; 
 	 assert RAM2(28) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(28))))  severity failure; 
 	 assert RAM2(29) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(29))))  severity failure; 
 	 assert RAM2(30) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM2(30))))  severity failure; 
 	 assert RAM2(31) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM2(31))))  severity failure; 
 	 assert RAM2(32) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(32))))  severity failure; 
 	 assert RAM2(33) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM2(33))))  severity failure; 
 

	 assert RAM3(32) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(32))))  severity failure; 
 	 assert RAM3(33) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(33))))  severity failure; 
 	 assert RAM3(34) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(34))))  severity failure; 
 	 assert RAM3(35) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(35))))  severity failure; 
 	 assert RAM3(36) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(36))))  severity failure; 
 	 assert RAM3(37) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(37))))  severity failure; 
 	 assert RAM3(38) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(38))))  severity failure; 
 	 assert RAM3(39) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(39))))  severity failure; 
 	 assert RAM3(40) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(40))))  severity failure; 
 	 assert RAM3(41) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(41))))  severity failure; 
 	 assert RAM3(42) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(42))))  severity failure; 
 	 assert RAM3(43) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(43))))  severity failure; 
 	 assert RAM3(44) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(44))))  severity failure; 
 	 assert RAM3(45) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(45))))  severity failure; 
 	 assert RAM3(46) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(46))))  severity failure; 
 	 assert RAM3(47) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(47))))  severity failure; 
 	 assert RAM3(48) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(48))))  severity failure; 
 	 assert RAM3(49) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(49))))  severity failure; 
 	 assert RAM3(50) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(50))))  severity failure; 
 	 assert RAM3(51) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(51))))  severity failure; 
 	 assert RAM3(52) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(52))))  severity failure; 
 	 assert RAM3(53) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(53))))  severity failure; 
 	 assert RAM3(54) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(54))))  severity failure; 
 	 assert RAM3(55) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(55))))  severity failure; 
 	 assert RAM3(56) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(56))))  severity failure; 
 	 assert RAM3(57) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(57))))  severity failure; 
 	 assert RAM3(58) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(58))))  severity failure; 
 	 assert RAM3(59) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(59))))  severity failure; 
 	 assert RAM3(60) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(60))))  severity failure; 
 	 assert RAM3(61) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(61))))  severity failure; 
 

	 assert RAM4(12) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(12))))  severity failure; 
 	 assert RAM4(13) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(13))))  severity failure; 
 	 assert RAM4(14) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(14))))  severity failure; 
 	 assert RAM4(15) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(15))))  severity failure; 
 	 assert RAM4(16) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(16))))  severity failure; 
 	 assert RAM4(17) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(17))))  severity failure; 
 	 assert RAM4(18) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(18))))  severity failure; 
 	 assert RAM4(19) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(19))))  severity failure; 
 	 assert RAM4(20) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(20))))  severity failure; 
 	 assert RAM4(21) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM4(21))))  severity failure; 
 

	 assert RAM5(44) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(44))))  severity failure; 
 	 assert RAM5(45) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(45))))  severity failure; 
 	 assert RAM5(46) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(46))))  severity failure; 
 	 assert RAM5(47) = std_logic_vector(to_unsigned( 136, 8)) report " TEST FALLITO (WORKING ZONE). Expected  136  found " & integer'image(to_integer(unsigned(RAM5(47))))  severity failure; 
 	 assert RAM5(48) = std_logic_vector(to_unsigned( 28, 8)) report " TEST FALLITO (WORKING ZONE). Expected  28  found " & integer'image(to_integer(unsigned(RAM5(48))))  severity failure; 
 	 assert RAM5(49) = std_logic_vector(to_unsigned( 92, 8)) report " TEST FALLITO (WORKING ZONE). Expected  92  found " & integer'image(to_integer(unsigned(RAM5(49))))  severity failure; 
 	 assert RAM5(50) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM5(50))))  severity failure; 
 	 assert RAM5(51) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(51))))  severity failure; 
 	 assert RAM5(52) = std_logic_vector(to_unsigned( 168, 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM5(52))))  severity failure; 
 	 assert RAM5(53) = std_logic_vector(to_unsigned( 56, 8)) report " TEST FALLITO (WORKING ZONE). Expected  56  found " & integer'image(to_integer(unsigned(RAM5(53))))  severity failure; 
 	 assert RAM5(54) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM5(54))))  severity failure; 
 	 assert RAM5(55) = std_logic_vector(to_unsigned( 60, 8)) report " TEST FALLITO (WORKING ZONE). Expected  60  found " & integer'image(to_integer(unsigned(RAM5(55))))  severity failure; 
 	 assert RAM5(56) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(56))))  severity failure; 
 	 assert RAM5(57) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(57))))  severity failure; 
 	 assert RAM5(58) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(58))))  severity failure; 
 	 assert RAM5(59) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM5(59))))  severity failure; 
 	 assert RAM5(60) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(60))))  severity failure; 
 	 assert RAM5(61) = std_logic_vector(to_unsigned( 36, 8)) report " TEST FALLITO (WORKING ZONE). Expected  36  found " & integer'image(to_integer(unsigned(RAM5(61))))  severity failure; 
 	 assert RAM5(62) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(62))))  severity failure; 
 	 assert RAM5(63) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(63))))  severity failure; 
 	 assert RAM5(64) = std_logic_vector(to_unsigned( 200, 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM5(64))))  severity failure; 
 	 assert RAM5(65) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(65))))  severity failure; 
 	 assert RAM5(66) = std_logic_vector(to_unsigned( 60, 8)) report " TEST FALLITO (WORKING ZONE). Expected  60  found " & integer'image(to_integer(unsigned(RAM5(66))))  severity failure; 
 	 assert RAM5(67) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(67))))  severity failure; 
 	 assert RAM5(68) = std_logic_vector(to_unsigned( 116, 8)) report " TEST FALLITO (WORKING ZONE). Expected  116  found " & integer'image(to_integer(unsigned(RAM5(68))))  severity failure; 
 	 assert RAM5(69) = std_logic_vector(to_unsigned( 52, 8)) report " TEST FALLITO (WORKING ZONE). Expected  52  found " & integer'image(to_integer(unsigned(RAM5(69))))  severity failure; 
 	 assert RAM5(70) = std_logic_vector(to_unsigned( 40, 8)) report " TEST FALLITO (WORKING ZONE). Expected  40  found " & integer'image(to_integer(unsigned(RAM5(70))))  severity failure; 
 	 assert RAM5(71) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(71))))  severity failure; 
 	 assert RAM5(72) = std_logic_vector(to_unsigned( 76, 8)) report " TEST FALLITO (WORKING ZONE). Expected  76  found " & integer'image(to_integer(unsigned(RAM5(72))))  severity failure; 
 	 assert RAM5(73) = std_logic_vector(to_unsigned( 212, 8)) report " TEST FALLITO (WORKING ZONE). Expected  212  found " & integer'image(to_integer(unsigned(RAM5(73))))  severity failure; 
 	 assert RAM5(74) = std_logic_vector(to_unsigned( 216, 8)) report " TEST FALLITO (WORKING ZONE). Expected  216  found " & integer'image(to_integer(unsigned(RAM5(74))))  severity failure; 
 	 assert RAM5(75) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(75))))  severity failure; 
 	 assert RAM5(76) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM5(76))))  severity failure; 
 	 assert RAM5(77) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(77))))  severity failure; 
 	 assert RAM5(78) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(78))))  severity failure; 
 	 assert RAM5(79) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(79))))  severity failure; 
 	 assert RAM5(80) = std_logic_vector(to_unsigned( 200, 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM5(80))))  severity failure; 
 	 assert RAM5(81) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM5(81))))  severity failure; 
 	 assert RAM5(82) = std_logic_vector(to_unsigned( 124, 8)) report " TEST FALLITO (WORKING ZONE). Expected  124  found " & integer'image(to_integer(unsigned(RAM5(82))))  severity failure; 
 	 assert RAM5(83) = std_logic_vector(to_unsigned( 28, 8)) report " TEST FALLITO (WORKING ZONE). Expected  28  found " & integer'image(to_integer(unsigned(RAM5(83))))  severity failure; 
 	 assert RAM5(84) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM5(84))))  severity failure; 
 	 assert RAM5(85) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM5(85))))  severity failure; 
 

	 assert RAM6(6) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM6(6))))  severity failure; 
 	 assert RAM6(7) = std_logic_vector(to_unsigned( 252, 8)) report " TEST FALLITO (WORKING ZONE). Expected  252  found " & integer'image(to_integer(unsigned(RAM6(7))))  severity failure; 
 	 assert RAM6(8) = std_logic_vector(to_unsigned( 124, 8)) report " TEST FALLITO (WORKING ZONE). Expected  124  found " & integer'image(to_integer(unsigned(RAM6(8))))  severity failure; 
 	 assert RAM6(9) = std_logic_vector(to_unsigned( 104, 8)) report " TEST FALLITO (WORKING ZONE). Expected  104  found " & integer'image(to_integer(unsigned(RAM6(9))))  severity failure; 
 

	 assert RAM7(232) = std_logic_vector(to_unsigned( 96, 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM7(232))))  severity failure; 
 	 assert RAM7(233) = std_logic_vector(to_unsigned( 148, 8)) report " TEST FALLITO (WORKING ZONE). Expected  148  found " & integer'image(to_integer(unsigned(RAM7(233))))  severity failure; 
 	 assert RAM7(234) = std_logic_vector(to_unsigned( 50, 8)) report " TEST FALLITO (WORKING ZONE). Expected  50  found " & integer'image(to_integer(unsigned(RAM7(234))))  severity failure; 
 	 assert RAM7(235) = std_logic_vector(to_unsigned( 4, 8)) report " TEST FALLITO (WORKING ZONE). Expected  4  found " & integer'image(to_integer(unsigned(RAM7(235))))  severity failure; 
 	 assert RAM7(236) = std_logic_vector(to_unsigned( 114, 8)) report " TEST FALLITO (WORKING ZONE). Expected  114  found " & integer'image(to_integer(unsigned(RAM7(236))))  severity failure; 
 	 assert RAM7(237) = std_logic_vector(to_unsigned( 228, 8)) report " TEST FALLITO (WORKING ZONE). Expected  228  found " & integer'image(to_integer(unsigned(RAM7(237))))  severity failure; 
 	 assert RAM7(238) = std_logic_vector(to_unsigned( 58, 8)) report " TEST FALLITO (WORKING ZONE). Expected  58  found " & integer'image(to_integer(unsigned(RAM7(238))))  severity failure; 
 	 assert RAM7(239) = std_logic_vector(to_unsigned( 146, 8)) report " TEST FALLITO (WORKING ZONE). Expected  146  found " & integer'image(to_integer(unsigned(RAM7(239))))  severity failure; 
 	 assert RAM7(240) = std_logic_vector(to_unsigned( 88, 8)) report " TEST FALLITO (WORKING ZONE). Expected  88  found " & integer'image(to_integer(unsigned(RAM7(240))))  severity failure; 
 	 assert RAM7(241) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM7(241))))  severity failure; 
 	 assert RAM7(242) = std_logic_vector(to_unsigned( 252, 8)) report " TEST FALLITO (WORKING ZONE). Expected  252  found " & integer'image(to_integer(unsigned(RAM7(242))))  severity failure; 
 	 assert RAM7(243) = std_logic_vector(to_unsigned( 138, 8)) report " TEST FALLITO (WORKING ZONE). Expected  138  found " & integer'image(to_integer(unsigned(RAM7(243))))  severity failure; 
 	 assert RAM7(244) = std_logic_vector(to_unsigned( 50, 8)) report " TEST FALLITO (WORKING ZONE). Expected  50  found " & integer'image(to_integer(unsigned(RAM7(244))))  severity failure; 
 	 assert RAM7(245) = std_logic_vector(to_unsigned( 170, 8)) report " TEST FALLITO (WORKING ZONE). Expected  170  found " & integer'image(to_integer(unsigned(RAM7(245))))  severity failure; 
 	 assert RAM7(246) = std_logic_vector(to_unsigned( 210, 8)) report " TEST FALLITO (WORKING ZONE). Expected  210  found " & integer'image(to_integer(unsigned(RAM7(246))))  severity failure; 
 	 assert RAM7(247) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM7(247))))  severity failure; 
 	 assert RAM7(248) = std_logic_vector(to_unsigned( 100, 8)) report " TEST FALLITO (WORKING ZONE). Expected  100  found " & integer'image(to_integer(unsigned(RAM7(248))))  severity failure; 
 	 assert RAM7(249) = std_logic_vector(to_unsigned( 212, 8)) report " TEST FALLITO (WORKING ZONE). Expected  212  found " & integer'image(to_integer(unsigned(RAM7(249))))  severity failure; 
 	 assert RAM7(250) = std_logic_vector(to_unsigned( 146, 8)) report " TEST FALLITO (WORKING ZONE). Expected  146  found " & integer'image(to_integer(unsigned(RAM7(250))))  severity failure; 
 	 assert RAM7(251) = std_logic_vector(to_unsigned( 152, 8)) report " TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM7(251))))  severity failure; 
 	 assert RAM7(252) = std_logic_vector(to_unsigned( 166, 8)) report " TEST FALLITO (WORKING ZONE). Expected  166  found " & integer'image(to_integer(unsigned(RAM7(252))))  severity failure; 
 	 assert RAM7(253) = std_logic_vector(to_unsigned( 126, 8)) report " TEST FALLITO (WORKING ZONE). Expected  126  found " & integer'image(to_integer(unsigned(RAM7(253))))  severity failure; 
 	 assert RAM7(254) = std_logic_vector(to_unsigned( 206, 8)) report " TEST FALLITO (WORKING ZONE). Expected  206  found " & integer'image(to_integer(unsigned(RAM7(254))))  severity failure; 
 	 assert RAM7(255) = std_logic_vector(to_unsigned( 172, 8)) report " TEST FALLITO (WORKING ZONE). Expected  172  found " & integer'image(to_integer(unsigned(RAM7(255))))  severity failure; 
 	 assert RAM7(256) = std_logic_vector(to_unsigned( 126, 8)) report " TEST FALLITO (WORKING ZONE). Expected  126  found " & integer'image(to_integer(unsigned(RAM7(256))))  severity failure; 
 	 assert RAM7(257) = std_logic_vector(to_unsigned( 40, 8)) report " TEST FALLITO (WORKING ZONE). Expected  40  found " & integer'image(to_integer(unsigned(RAM7(257))))  severity failure; 
 	 assert RAM7(258) = std_logic_vector(to_unsigned( 172, 8)) report " TEST FALLITO (WORKING ZONE). Expected  172  found " & integer'image(to_integer(unsigned(RAM7(258))))  severity failure; 
 	 assert RAM7(259) = std_logic_vector(to_unsigned( 252, 8)) report " TEST FALLITO (WORKING ZONE). Expected  252  found " & integer'image(to_integer(unsigned(RAM7(259))))  severity failure; 
 	 assert RAM7(260) = std_logic_vector(to_unsigned( 90, 8)) report " TEST FALLITO (WORKING ZONE). Expected  90  found " & integer'image(to_integer(unsigned(RAM7(260))))  severity failure; 
 	 assert RAM7(261) = std_logic_vector(to_unsigned( 184, 8)) report " TEST FALLITO (WORKING ZONE). Expected  184  found " & integer'image(to_integer(unsigned(RAM7(261))))  severity failure; 
 	 assert RAM7(262) = std_logic_vector(to_unsigned( 28, 8)) report " TEST FALLITO (WORKING ZONE). Expected  28  found " & integer'image(to_integer(unsigned(RAM7(262))))  severity failure; 
 	 assert RAM7(263) = std_logic_vector(to_unsigned( 204, 8)) report " TEST FALLITO (WORKING ZONE). Expected  204  found " & integer'image(to_integer(unsigned(RAM7(263))))  severity failure; 
 	 assert RAM7(264) = std_logic_vector(to_unsigned( 6, 8)) report " TEST FALLITO (WORKING ZONE). Expected  6  found " & integer'image(to_integer(unsigned(RAM7(264))))  severity failure; 
 	 assert RAM7(265) = std_logic_vector(to_unsigned( 222, 8)) report " TEST FALLITO (WORKING ZONE). Expected  222  found " & integer'image(to_integer(unsigned(RAM7(265))))  severity failure; 
 	 assert RAM7(266) = std_logic_vector(to_unsigned( 174, 8)) report " TEST FALLITO (WORKING ZONE). Expected  174  found " & integer'image(to_integer(unsigned(RAM7(266))))  severity failure; 
 	 assert RAM7(267) = std_logic_vector(to_unsigned( 146, 8)) report " TEST FALLITO (WORKING ZONE). Expected  146  found " & integer'image(to_integer(unsigned(RAM7(267))))  severity failure; 
 	 assert RAM7(268) = std_logic_vector(to_unsigned( 194, 8)) report " TEST FALLITO (WORKING ZONE). Expected  194  found " & integer'image(to_integer(unsigned(RAM7(268))))  severity failure; 
 	 assert RAM7(269) = std_logic_vector(to_unsigned( 254, 8)) report " TEST FALLITO (WORKING ZONE). Expected  254  found " & integer'image(to_integer(unsigned(RAM7(269))))  severity failure; 
 	 assert RAM7(270) = std_logic_vector(to_unsigned( 210, 8)) report " TEST FALLITO (WORKING ZONE). Expected  210  found " & integer'image(to_integer(unsigned(RAM7(270))))  severity failure; 
 	 assert RAM7(271) = std_logic_vector(to_unsigned( 30, 8)) report " TEST FALLITO (WORKING ZONE). Expected  30  found " & integer'image(to_integer(unsigned(RAM7(271))))  severity failure; 
 	 assert RAM7(272) = std_logic_vector(to_unsigned( 194, 8)) report " TEST FALLITO (WORKING ZONE). Expected  194  found " & integer'image(to_integer(unsigned(RAM7(272))))  severity failure; 
 	 assert RAM7(273) = std_logic_vector(to_unsigned( 154, 8)) report " TEST FALLITO (WORKING ZONE). Expected  154  found " & integer'image(to_integer(unsigned(RAM7(273))))  severity failure; 
 	 assert RAM7(274) = std_logic_vector(to_unsigned( 162, 8)) report " TEST FALLITO (WORKING ZONE). Expected  162  found " & integer'image(to_integer(unsigned(RAM7(274))))  severity failure; 
 	 assert RAM7(275) = std_logic_vector(to_unsigned( 60, 8)) report " TEST FALLITO (WORKING ZONE). Expected  60  found " & integer'image(to_integer(unsigned(RAM7(275))))  severity failure; 
 	 assert RAM7(276) = std_logic_vector(to_unsigned( 58, 8)) report " TEST FALLITO (WORKING ZONE). Expected  58  found " & integer'image(to_integer(unsigned(RAM7(276))))  severity failure; 
 	 assert RAM7(277) = std_logic_vector(to_unsigned( 56, 8)) report " TEST FALLITO (WORKING ZONE). Expected  56  found " & integer'image(to_integer(unsigned(RAM7(277))))  severity failure; 
 	 assert RAM7(278) = std_logic_vector(to_unsigned( 44, 8)) report " TEST FALLITO (WORKING ZONE). Expected  44  found " & integer'image(to_integer(unsigned(RAM7(278))))  severity failure; 
 	 assert RAM7(279) = std_logic_vector(to_unsigned( 228, 8)) report " TEST FALLITO (WORKING ZONE). Expected  228  found " & integer'image(to_integer(unsigned(RAM7(279))))  severity failure; 
 	 assert RAM7(280) = std_logic_vector(to_unsigned( 228, 8)) report " TEST FALLITO (WORKING ZONE). Expected  228  found " & integer'image(to_integer(unsigned(RAM7(280))))  severity failure; 
 	 assert RAM7(281) = std_logic_vector(to_unsigned( 204, 8)) report " TEST FALLITO (WORKING ZONE). Expected  204  found " & integer'image(to_integer(unsigned(RAM7(281))))  severity failure; 
 	 assert RAM7(282) = std_logic_vector(to_unsigned( 58, 8)) report " TEST FALLITO (WORKING ZONE). Expected  58  found " & integer'image(to_integer(unsigned(RAM7(282))))  severity failure; 
 	 assert RAM7(283) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM7(283))))  severity failure; 
 	 assert RAM7(284) = std_logic_vector(to_unsigned( 8, 8)) report " TEST FALLITO (WORKING ZONE). Expected  8  found " & integer'image(to_integer(unsigned(RAM7(284))))  severity failure; 
 	 assert RAM7(285) = std_logic_vector(to_unsigned( 158, 8)) report " TEST FALLITO (WORKING ZONE). Expected  158  found " & integer'image(to_integer(unsigned(RAM7(285))))  severity failure; 
 	 assert RAM7(286) = std_logic_vector(to_unsigned( 148, 8)) report " TEST FALLITO (WORKING ZONE). Expected  148  found " & integer'image(to_integer(unsigned(RAM7(286))))  severity failure; 
 	 assert RAM7(287) = std_logic_vector(to_unsigned( 238, 8)) report " TEST FALLITO (WORKING ZONE). Expected  238  found " & integer'image(to_integer(unsigned(RAM7(287))))  severity failure; 
 	 assert RAM7(288) = std_logic_vector(to_unsigned( 4, 8)) report " TEST FALLITO (WORKING ZONE). Expected  4  found " & integer'image(to_integer(unsigned(RAM7(288))))  severity failure; 
 	 assert RAM7(289) = std_logic_vector(to_unsigned( 174, 8)) report " TEST FALLITO (WORKING ZONE). Expected  174  found " & integer'image(to_integer(unsigned(RAM7(289))))  severity failure; 
 	 assert RAM7(290) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM7(290))))  severity failure; 
 	 assert RAM7(291) = std_logic_vector(to_unsigned( 114, 8)) report " TEST FALLITO (WORKING ZONE). Expected  114  found " & integer'image(to_integer(unsigned(RAM7(291))))  severity failure; 
 	 assert RAM7(292) = std_logic_vector(to_unsigned( 88, 8)) report " TEST FALLITO (WORKING ZONE). Expected  88  found " & integer'image(to_integer(unsigned(RAM7(292))))  severity failure; 
 	 assert RAM7(293) = std_logic_vector(to_unsigned( 166, 8)) report " TEST FALLITO (WORKING ZONE). Expected  166  found " & integer'image(to_integer(unsigned(RAM7(293))))  severity failure; 
 	 assert RAM7(294) = std_logic_vector(to_unsigned( 150, 8)) report " TEST FALLITO (WORKING ZONE). Expected  150  found " & integer'image(to_integer(unsigned(RAM7(294))))  severity failure; 
 	 assert RAM7(295) = std_logic_vector(to_unsigned( 146, 8)) report " TEST FALLITO (WORKING ZONE). Expected  146  found " & integer'image(to_integer(unsigned(RAM7(295))))  severity failure; 
 	 assert RAM7(296) = std_logic_vector(to_unsigned( 36, 8)) report " TEST FALLITO (WORKING ZONE). Expected  36  found " & integer'image(to_integer(unsigned(RAM7(296))))  severity failure; 
 	 assert RAM7(297) = std_logic_vector(to_unsigned( 60, 8)) report " TEST FALLITO (WORKING ZONE). Expected  60  found " & integer'image(to_integer(unsigned(RAM7(297))))  severity failure; 
 	 assert RAM7(298) = std_logic_vector(to_unsigned( 102, 8)) report " TEST FALLITO (WORKING ZONE). Expected  102  found " & integer'image(to_integer(unsigned(RAM7(298))))  severity failure; 
 	 assert RAM7(299) = std_logic_vector(to_unsigned( 232, 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM7(299))))  severity failure; 
 	 assert RAM7(300) = std_logic_vector(to_unsigned( 60, 8)) report " TEST FALLITO (WORKING ZONE). Expected  60  found " & integer'image(to_integer(unsigned(RAM7(300))))  severity failure; 
 	 assert RAM7(301) = std_logic_vector(to_unsigned( 24, 8)) report " TEST FALLITO (WORKING ZONE). Expected  24  found " & integer'image(to_integer(unsigned(RAM7(301))))  severity failure; 
 	 assert RAM7(302) = std_logic_vector(to_unsigned( 232, 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM7(302))))  severity failure; 
 	 assert RAM7(303) = std_logic_vector(to_unsigned( 170, 8)) report " TEST FALLITO (WORKING ZONE). Expected  170  found " & integer'image(to_integer(unsigned(RAM7(303))))  severity failure; 
 	 assert RAM7(304) = std_logic_vector(to_unsigned( 168, 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM7(304))))  severity failure; 
 	 assert RAM7(305) = std_logic_vector(to_unsigned( 62, 8)) report " TEST FALLITO (WORKING ZONE). Expected  62  found " & integer'image(to_integer(unsigned(RAM7(305))))  severity failure; 
 	 assert RAM7(306) = std_logic_vector(to_unsigned( 168, 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM7(306))))  severity failure; 
 	 assert RAM7(307) = std_logic_vector(to_unsigned( 72, 8)) report " TEST FALLITO (WORKING ZONE). Expected  72  found " & integer'image(to_integer(unsigned(RAM7(307))))  severity failure; 
 	 assert RAM7(308) = std_logic_vector(to_unsigned( 178, 8)) report " TEST FALLITO (WORKING ZONE). Expected  178  found " & integer'image(to_integer(unsigned(RAM7(308))))  severity failure; 
 	 assert RAM7(309) = std_logic_vector(to_unsigned( 252, 8)) report " TEST FALLITO (WORKING ZONE). Expected  252  found " & integer'image(to_integer(unsigned(RAM7(309))))  severity failure; 
 	 assert RAM7(310) = std_logic_vector(to_unsigned( 106, 8)) report " TEST FALLITO (WORKING ZONE). Expected  106  found " & integer'image(to_integer(unsigned(RAM7(310))))  severity failure; 
 	 assert RAM7(311) = std_logic_vector(to_unsigned( 158, 8)) report " TEST FALLITO (WORKING ZONE). Expected  158  found " & integer'image(to_integer(unsigned(RAM7(311))))  severity failure; 
 	 assert RAM7(312) = std_logic_vector(to_unsigned( 100, 8)) report " TEST FALLITO (WORKING ZONE). Expected  100  found " & integer'image(to_integer(unsigned(RAM7(312))))  severity failure; 
 	 assert RAM7(313) = std_logic_vector(to_unsigned( 68, 8)) report " TEST FALLITO (WORKING ZONE). Expected  68  found " & integer'image(to_integer(unsigned(RAM7(313))))  severity failure; 
 	 assert RAM7(314) = std_logic_vector(to_unsigned( 232, 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM7(314))))  severity failure; 
 	 assert RAM7(315) = std_logic_vector(to_unsigned( 152, 8)) report " TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM7(315))))  severity failure; 
 	 assert RAM7(316) = std_logic_vector(to_unsigned( 158, 8)) report " TEST FALLITO (WORKING ZONE). Expected  158  found " & integer'image(to_integer(unsigned(RAM7(316))))  severity failure; 
 	 assert RAM7(317) = std_logic_vector(to_unsigned( 166, 8)) report " TEST FALLITO (WORKING ZONE). Expected  166  found " & integer'image(to_integer(unsigned(RAM7(317))))  severity failure; 
 	 assert RAM7(318) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM7(318))))  severity failure; 
 	 assert RAM7(319) = std_logic_vector(to_unsigned( 90, 8)) report " TEST FALLITO (WORKING ZONE). Expected  90  found " & integer'image(to_integer(unsigned(RAM7(319))))  severity failure; 
 	 assert RAM7(320) = std_logic_vector(to_unsigned( 144, 8)) report " TEST FALLITO (WORKING ZONE). Expected  144  found " & integer'image(to_integer(unsigned(RAM7(320))))  severity failure; 
 	 assert RAM7(321) = std_logic_vector(to_unsigned( 166, 8)) report " TEST FALLITO (WORKING ZONE). Expected  166  found " & integer'image(to_integer(unsigned(RAM7(321))))  severity failure; 
 	 assert RAM7(322) = std_logic_vector(to_unsigned( 30, 8)) report " TEST FALLITO (WORKING ZONE). Expected  30  found " & integer'image(to_integer(unsigned(RAM7(322))))  severity failure; 
 	 assert RAM7(323) = std_logic_vector(to_unsigned( 234, 8)) report " TEST FALLITO (WORKING ZONE). Expected  234  found " & integer'image(to_integer(unsigned(RAM7(323))))  severity failure; 
 	 assert RAM7(324) = std_logic_vector(to_unsigned( 204, 8)) report " TEST FALLITO (WORKING ZONE). Expected  204  found " & integer'image(to_integer(unsigned(RAM7(324))))  severity failure; 
 	 assert RAM7(325) = std_logic_vector(to_unsigned( 178, 8)) report " TEST FALLITO (WORKING ZONE). Expected  178  found " & integer'image(to_integer(unsigned(RAM7(325))))  severity failure; 
 	 assert RAM7(326) = std_logic_vector(to_unsigned( 58, 8)) report " TEST FALLITO (WORKING ZONE). Expected  58  found " & integer'image(to_integer(unsigned(RAM7(326))))  severity failure; 
 	 assert RAM7(327) = std_logic_vector(to_unsigned( 84, 8)) report " TEST FALLITO (WORKING ZONE). Expected  84  found " & integer'image(to_integer(unsigned(RAM7(327))))  severity failure; 
 	 assert RAM7(328) = std_logic_vector(to_unsigned( 202, 8)) report " TEST FALLITO (WORKING ZONE). Expected  202  found " & integer'image(to_integer(unsigned(RAM7(328))))  severity failure; 
 	 assert RAM7(329) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM7(329))))  severity failure; 
 	 assert RAM7(330) = std_logic_vector(to_unsigned( 238, 8)) report " TEST FALLITO (WORKING ZONE). Expected  238  found " & integer'image(to_integer(unsigned(RAM7(330))))  severity failure; 
 	 assert RAM7(331) = std_logic_vector(to_unsigned( 86, 8)) report " TEST FALLITO (WORKING ZONE). Expected  86  found " & integer'image(to_integer(unsigned(RAM7(331))))  severity failure; 
 	 assert RAM7(332) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM7(332))))  severity failure; 
 	 assert RAM7(333) = std_logic_vector(to_unsigned( 2, 8)) report " TEST FALLITO (WORKING ZONE). Expected  2  found " & integer'image(to_integer(unsigned(RAM7(333))))  severity failure; 
 	 assert RAM7(334) = std_logic_vector(to_unsigned( 14, 8)) report " TEST FALLITO (WORKING ZONE). Expected  14  found " & integer'image(to_integer(unsigned(RAM7(334))))  severity failure; 
 	 assert RAM7(335) = std_logic_vector(to_unsigned( 136, 8)) report " TEST FALLITO (WORKING ZONE). Expected  136  found " & integer'image(to_integer(unsigned(RAM7(335))))  severity failure; 
 	 assert RAM7(336) = std_logic_vector(to_unsigned( 28, 8)) report " TEST FALLITO (WORKING ZONE). Expected  28  found " & integer'image(to_integer(unsigned(RAM7(336))))  severity failure; 
 	 assert RAM7(337) = std_logic_vector(to_unsigned( 190, 8)) report " TEST FALLITO (WORKING ZONE). Expected  190  found " & integer'image(to_integer(unsigned(RAM7(337))))  severity failure; 
 	 assert RAM7(338) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM7(338))))  severity failure; 
 	 assert RAM7(339) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM7(339))))  severity failure; 
 	 assert RAM7(340) = std_logic_vector(to_unsigned( 168, 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM7(340))))  severity failure; 
 	 assert RAM7(341) = std_logic_vector(to_unsigned( 194, 8)) report " TEST FALLITO (WORKING ZONE). Expected  194  found " & integer'image(to_integer(unsigned(RAM7(341))))  severity failure; 
 	 assert RAM7(342) = std_logic_vector(to_unsigned( 26, 8)) report " TEST FALLITO (WORKING ZONE). Expected  26  found " & integer'image(to_integer(unsigned(RAM7(342))))  severity failure; 
 	 assert RAM7(343) = std_logic_vector(to_unsigned( 124, 8)) report " TEST FALLITO (WORKING ZONE). Expected  124  found " & integer'image(to_integer(unsigned(RAM7(343))))  severity failure; 
 	 assert RAM7(344) = std_logic_vector(to_unsigned( 246, 8)) report " TEST FALLITO (WORKING ZONE). Expected  246  found " & integer'image(to_integer(unsigned(RAM7(344))))  severity failure; 
 	 assert RAM7(345) = std_logic_vector(to_unsigned( 10, 8)) report " TEST FALLITO (WORKING ZONE). Expected  10  found " & integer'image(to_integer(unsigned(RAM7(345))))  severity failure; 
 	 assert RAM7(346) = std_logic_vector(to_unsigned( 42, 8)) report " TEST FALLITO (WORKING ZONE). Expected  42  found " & integer'image(to_integer(unsigned(RAM7(346))))  severity failure; 
 	 assert RAM7(347) = std_logic_vector(to_unsigned( 14, 8)) report " TEST FALLITO (WORKING ZONE). Expected  14  found " & integer'image(to_integer(unsigned(RAM7(347))))  severity failure; 
 	 assert RAM7(348) = std_logic_vector(to_unsigned( 118, 8)) report " TEST FALLITO (WORKING ZONE). Expected  118  found " & integer'image(to_integer(unsigned(RAM7(348))))  severity failure; 
 	 assert RAM7(349) = std_logic_vector(to_unsigned( 102, 8)) report " TEST FALLITO (WORKING ZONE). Expected  102  found " & integer'image(to_integer(unsigned(RAM7(349))))  severity failure; 
 	 assert RAM7(350) = std_logic_vector(to_unsigned( 4, 8)) report " TEST FALLITO (WORKING ZONE). Expected  4  found " & integer'image(to_integer(unsigned(RAM7(350))))  severity failure; 
 	 assert RAM7(351) = std_logic_vector(to_unsigned( 62, 8)) report " TEST FALLITO (WORKING ZONE). Expected  62  found " & integer'image(to_integer(unsigned(RAM7(351))))  severity failure; 
 	 assert RAM7(352) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM7(352))))  severity failure; 
 	 assert RAM7(353) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM7(353))))  severity failure; 
 	 assert RAM7(354) = std_logic_vector(to_unsigned( 36, 8)) report " TEST FALLITO (WORKING ZONE). Expected  36  found " & integer'image(to_integer(unsigned(RAM7(354))))  severity failure; 
 	 assert RAM7(355) = std_logic_vector(to_unsigned( 180, 8)) report " TEST FALLITO (WORKING ZONE). Expected  180  found " & integer'image(to_integer(unsigned(RAM7(355))))  severity failure; 
 	 assert RAM7(356) = std_logic_vector(to_unsigned( 200, 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM7(356))))  severity failure; 
 	 assert RAM7(357) = std_logic_vector(to_unsigned( 168, 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM7(357))))  severity failure; 
 	 assert RAM7(358) = std_logic_vector(to_unsigned( 156, 8)) report " TEST FALLITO (WORKING ZONE). Expected  156  found " & integer'image(to_integer(unsigned(RAM7(358))))  severity failure; 
 	 assert RAM7(359) = std_logic_vector(to_unsigned( 98, 8)) report " TEST FALLITO (WORKING ZONE). Expected  98  found " & integer'image(to_integer(unsigned(RAM7(359))))  severity failure; 
 	 assert RAM7(360) = std_logic_vector(to_unsigned( 10, 8)) report " TEST FALLITO (WORKING ZONE). Expected  10  found " & integer'image(to_integer(unsigned(RAM7(360))))  severity failure; 
 	 assert RAM7(361) = std_logic_vector(to_unsigned( 124, 8)) report " TEST FALLITO (WORKING ZONE). Expected  124  found " & integer'image(to_integer(unsigned(RAM7(361))))  severity failure; 
 	 assert RAM7(362) = std_logic_vector(to_unsigned( 210, 8)) report " TEST FALLITO (WORKING ZONE). Expected  210  found " & integer'image(to_integer(unsigned(RAM7(362))))  severity failure; 
 	 assert RAM7(363) = std_logic_vector(to_unsigned( 42, 8)) report " TEST FALLITO (WORKING ZONE). Expected  42  found " & integer'image(to_integer(unsigned(RAM7(363))))  severity failure; 
 	 assert RAM7(364) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM7(364))))  severity failure; 
 	 assert RAM7(365) = std_logic_vector(to_unsigned( 140, 8)) report " TEST FALLITO (WORKING ZONE). Expected  140  found " & integer'image(to_integer(unsigned(RAM7(365))))  severity failure; 
 	 assert RAM7(366) = std_logic_vector(to_unsigned( 212, 8)) report " TEST FALLITO (WORKING ZONE). Expected  212  found " & integer'image(to_integer(unsigned(RAM7(366))))  severity failure; 
 	 assert RAM7(367) = std_logic_vector(to_unsigned( 8, 8)) report " TEST FALLITO (WORKING ZONE). Expected  8  found " & integer'image(to_integer(unsigned(RAM7(367))))  severity failure; 
 	 assert RAM7(368) = std_logic_vector(to_unsigned( 44, 8)) report " TEST FALLITO (WORKING ZONE). Expected  44  found " & integer'image(to_integer(unsigned(RAM7(368))))  severity failure; 
 	 assert RAM7(369) = std_logic_vector(to_unsigned( 230, 8)) report " TEST FALLITO (WORKING ZONE). Expected  230  found " & integer'image(to_integer(unsigned(RAM7(369))))  severity failure; 
 	 assert RAM7(370) = std_logic_vector(to_unsigned( 28, 8)) report " TEST FALLITO (WORKING ZONE). Expected  28  found " & integer'image(to_integer(unsigned(RAM7(370))))  severity failure; 
 	 assert RAM7(371) = std_logic_vector(to_unsigned( 178, 8)) report " TEST FALLITO (WORKING ZONE). Expected  178  found " & integer'image(to_integer(unsigned(RAM7(371))))  severity failure; 
 	 assert RAM7(372) = std_logic_vector(to_unsigned( 44, 8)) report " TEST FALLITO (WORKING ZONE). Expected  44  found " & integer'image(to_integer(unsigned(RAM7(372))))  severity failure; 
 	 assert RAM7(373) = std_logic_vector(to_unsigned( 94, 8)) report " TEST FALLITO (WORKING ZONE). Expected  94  found " & integer'image(to_integer(unsigned(RAM7(373))))  severity failure; 
 	 assert RAM7(374) = std_logic_vector(to_unsigned( 206, 8)) report " TEST FALLITO (WORKING ZONE). Expected  206  found " & integer'image(to_integer(unsigned(RAM7(374))))  severity failure; 
 	 assert RAM7(375) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM7(375))))  severity failure; 
 	 assert RAM7(376) = std_logic_vector(to_unsigned( 168, 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM7(376))))  severity failure; 
 	 assert RAM7(377) = std_logic_vector(to_unsigned( 238, 8)) report " TEST FALLITO (WORKING ZONE). Expected  238  found " & integer'image(to_integer(unsigned(RAM7(377))))  severity failure; 
 	 assert RAM7(378) = std_logic_vector(to_unsigned( 148, 8)) report " TEST FALLITO (WORKING ZONE). Expected  148  found " & integer'image(to_integer(unsigned(RAM7(378))))  severity failure; 
 	 assert RAM7(379) = std_logic_vector(to_unsigned( 148, 8)) report " TEST FALLITO (WORKING ZONE). Expected  148  found " & integer'image(to_integer(unsigned(RAM7(379))))  severity failure; 
 	 assert RAM7(380) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM7(380))))  severity failure; 
 	 assert RAM7(381) = std_logic_vector(to_unsigned( 174, 8)) report " TEST FALLITO (WORKING ZONE). Expected  174  found " & integer'image(to_integer(unsigned(RAM7(381))))  severity failure; 
 	 assert RAM7(382) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM7(382))))  severity failure; 
 	 assert RAM7(383) = std_logic_vector(to_unsigned( 236, 8)) report " TEST FALLITO (WORKING ZONE). Expected  236  found " & integer'image(to_integer(unsigned(RAM7(383))))  severity failure; 
 	 assert RAM7(384) = std_logic_vector(to_unsigned( 244, 8)) report " TEST FALLITO (WORKING ZONE). Expected  244  found " & integer'image(to_integer(unsigned(RAM7(384))))  severity failure; 
 	 assert RAM7(385) = std_logic_vector(to_unsigned( 44, 8)) report " TEST FALLITO (WORKING ZONE). Expected  44  found " & integer'image(to_integer(unsigned(RAM7(385))))  severity failure; 
 	 assert RAM7(386) = std_logic_vector(to_unsigned( 118, 8)) report " TEST FALLITO (WORKING ZONE). Expected  118  found " & integer'image(to_integer(unsigned(RAM7(386))))  severity failure; 
 	 assert RAM7(387) = std_logic_vector(to_unsigned( 34, 8)) report " TEST FALLITO (WORKING ZONE). Expected  34  found " & integer'image(to_integer(unsigned(RAM7(387))))  severity failure; 
 	 assert RAM7(388) = std_logic_vector(to_unsigned( 90, 8)) report " TEST FALLITO (WORKING ZONE). Expected  90  found " & integer'image(to_integer(unsigned(RAM7(388))))  severity failure; 
 	 assert RAM7(389) = std_logic_vector(to_unsigned( 92, 8)) report " TEST FALLITO (WORKING ZONE). Expected  92  found " & integer'image(to_integer(unsigned(RAM7(389))))  severity failure; 
 	 assert RAM7(390) = std_logic_vector(to_unsigned( 72, 8)) report " TEST FALLITO (WORKING ZONE). Expected  72  found " & integer'image(to_integer(unsigned(RAM7(390))))  severity failure; 
 	 assert RAM7(391) = std_logic_vector(to_unsigned( 16, 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM7(391))))  severity failure; 
 	 assert RAM7(392) = std_logic_vector(to_unsigned( 242, 8)) report " TEST FALLITO (WORKING ZONE). Expected  242  found " & integer'image(to_integer(unsigned(RAM7(392))))  severity failure; 
 	 assert RAM7(393) = std_logic_vector(to_unsigned( 252, 8)) report " TEST FALLITO (WORKING ZONE). Expected  252  found " & integer'image(to_integer(unsigned(RAM7(393))))  severity failure; 
 	 assert RAM7(394) = std_logic_vector(to_unsigned( 164, 8)) report " TEST FALLITO (WORKING ZONE). Expected  164  found " & integer'image(to_integer(unsigned(RAM7(394))))  severity failure; 
 	 assert RAM7(395) = std_logic_vector(to_unsigned( 182, 8)) report " TEST FALLITO (WORKING ZONE). Expected  182  found " & integer'image(to_integer(unsigned(RAM7(395))))  severity failure; 
 	 assert RAM7(396) = std_logic_vector(to_unsigned( 74, 8)) report " TEST FALLITO (WORKING ZONE). Expected  74  found " & integer'image(to_integer(unsigned(RAM7(396))))  severity failure; 
 	 assert RAM7(397) = std_logic_vector(to_unsigned( 134, 8)) report " TEST FALLITO (WORKING ZONE). Expected  134  found " & integer'image(to_integer(unsigned(RAM7(397))))  severity failure; 
 	 assert RAM7(398) = std_logic_vector(to_unsigned( 202, 8)) report " TEST FALLITO (WORKING ZONE). Expected  202  found " & integer'image(to_integer(unsigned(RAM7(398))))  severity failure; 
 	 assert RAM7(399) = std_logic_vector(to_unsigned( 120, 8)) report " TEST FALLITO (WORKING ZONE). Expected  120  found " & integer'image(to_integer(unsigned(RAM7(399))))  severity failure; 
 	 assert RAM7(400) = std_logic_vector(to_unsigned( 232, 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM7(400))))  severity failure; 
 	 assert RAM7(401) = std_logic_vector(to_unsigned( 138, 8)) report " TEST FALLITO (WORKING ZONE). Expected  138  found " & integer'image(to_integer(unsigned(RAM7(401))))  severity failure; 
 	 assert RAM7(402) = std_logic_vector(to_unsigned( 166, 8)) report " TEST FALLITO (WORKING ZONE). Expected  166  found " & integer'image(to_integer(unsigned(RAM7(402))))  severity failure; 
 	 assert RAM7(403) = std_logic_vector(to_unsigned( 176, 8)) report " TEST FALLITO (WORKING ZONE). Expected  176  found " & integer'image(to_integer(unsigned(RAM7(403))))  severity failure; 
 	 assert RAM7(404) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM7(404))))  severity failure; 
 	 assert RAM7(405) = std_logic_vector(to_unsigned( 156, 8)) report " TEST FALLITO (WORKING ZONE). Expected  156  found " & integer'image(to_integer(unsigned(RAM7(405))))  severity failure; 
 	 assert RAM7(406) = std_logic_vector(to_unsigned( 22, 8)) report " TEST FALLITO (WORKING ZONE). Expected  22  found " & integer'image(to_integer(unsigned(RAM7(406))))  severity failure; 
 	 assert RAM7(407) = std_logic_vector(to_unsigned( 234, 8)) report " TEST FALLITO (WORKING ZONE). Expected  234  found " & integer'image(to_integer(unsigned(RAM7(407))))  severity failure; 
 	 assert RAM7(408) = std_logic_vector(to_unsigned( 138, 8)) report " TEST FALLITO (WORKING ZONE). Expected  138  found " & integer'image(to_integer(unsigned(RAM7(408))))  severity failure; 
 	 assert RAM7(409) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM7(409))))  severity failure; 
 	 assert RAM7(410) = std_logic_vector(to_unsigned( 178, 8)) report " TEST FALLITO (WORKING ZONE). Expected  178  found " & integer'image(to_integer(unsigned(RAM7(410))))  severity failure; 
 	 assert RAM7(411) = std_logic_vector(to_unsigned( 122, 8)) report " TEST FALLITO (WORKING ZONE). Expected  122  found " & integer'image(to_integer(unsigned(RAM7(411))))  severity failure; 
 	 assert RAM7(412) = std_logic_vector(to_unsigned( 46, 8)) report " TEST FALLITO (WORKING ZONE). Expected  46  found " & integer'image(to_integer(unsigned(RAM7(412))))  severity failure; 
 	 assert RAM7(413) = std_logic_vector(to_unsigned( 78, 8)) report " TEST FALLITO (WORKING ZONE). Expected  78  found " & integer'image(to_integer(unsigned(RAM7(413))))  severity failure; 
 	 assert RAM7(414) = std_logic_vector(to_unsigned( 20, 8)) report " TEST FALLITO (WORKING ZONE). Expected  20  found " & integer'image(to_integer(unsigned(RAM7(414))))  severity failure; 
 	 assert RAM7(415) = std_logic_vector(to_unsigned( 178, 8)) report " TEST FALLITO (WORKING ZONE). Expected  178  found " & integer'image(to_integer(unsigned(RAM7(415))))  severity failure; 
 	 assert RAM7(416) = std_logic_vector(to_unsigned( 236, 8)) report " TEST FALLITO (WORKING ZONE). Expected  236  found " & integer'image(to_integer(unsigned(RAM7(416))))  severity failure; 
 	 assert RAM7(417) = std_logic_vector(to_unsigned( 90, 8)) report " TEST FALLITO (WORKING ZONE). Expected  90  found " & integer'image(to_integer(unsigned(RAM7(417))))  severity failure; 
 	 assert RAM7(418) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM7(418))))  severity failure; 
 	 assert RAM7(419) = std_logic_vector(to_unsigned( 132, 8)) report " TEST FALLITO (WORKING ZONE). Expected  132  found " & integer'image(to_integer(unsigned(RAM7(419))))  severity failure; 
 	 assert RAM7(420) = std_logic_vector(to_unsigned( 146, 8)) report " TEST FALLITO (WORKING ZONE). Expected  146  found " & integer'image(to_integer(unsigned(RAM7(420))))  severity failure; 
 	 assert RAM7(421) = std_logic_vector(to_unsigned( 154, 8)) report " TEST FALLITO (WORKING ZONE). Expected  154  found " & integer'image(to_integer(unsigned(RAM7(421))))  severity failure; 
 	 assert RAM7(422) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM7(422))))  severity failure; 
 	 assert RAM7(423) = std_logic_vector(to_unsigned( 168, 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM7(423))))  severity failure; 
 	 assert RAM7(424) = std_logic_vector(to_unsigned( 146, 8)) report " TEST FALLITO (WORKING ZONE). Expected  146  found " & integer'image(to_integer(unsigned(RAM7(424))))  severity failure; 
 	 assert RAM7(425) = std_logic_vector(to_unsigned( 212, 8)) report " TEST FALLITO (WORKING ZONE). Expected  212  found " & integer'image(to_integer(unsigned(RAM7(425))))  severity failure; 
 	 assert RAM7(426) = std_logic_vector(to_unsigned( 242, 8)) report " TEST FALLITO (WORKING ZONE). Expected  242  found " & integer'image(to_integer(unsigned(RAM7(426))))  severity failure; 
 	 assert RAM7(427) = std_logic_vector(to_unsigned( 74, 8)) report " TEST FALLITO (WORKING ZONE). Expected  74  found " & integer'image(to_integer(unsigned(RAM7(427))))  severity failure; 
 	 assert RAM7(428) = std_logic_vector(to_unsigned( 16, 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM7(428))))  severity failure; 
 	 assert RAM7(429) = std_logic_vector(to_unsigned( 194, 8)) report " TEST FALLITO (WORKING ZONE). Expected  194  found " & integer'image(to_integer(unsigned(RAM7(429))))  severity failure; 
 	 assert RAM7(430) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM7(430))))  severity failure; 
 	 assert RAM7(431) = std_logic_vector(to_unsigned( 40, 8)) report " TEST FALLITO (WORKING ZONE). Expected  40  found " & integer'image(to_integer(unsigned(RAM7(431))))  severity failure; 
 	 assert RAM7(432) = std_logic_vector(to_unsigned( 98, 8)) report " TEST FALLITO (WORKING ZONE). Expected  98  found " & integer'image(to_integer(unsigned(RAM7(432))))  severity failure; 
 	 assert RAM7(433) = std_logic_vector(to_unsigned( 118, 8)) report " TEST FALLITO (WORKING ZONE). Expected  118  found " & integer'image(to_integer(unsigned(RAM7(433))))  severity failure; 
 	 assert RAM7(434) = std_logic_vector(to_unsigned( 212, 8)) report " TEST FALLITO (WORKING ZONE). Expected  212  found " & integer'image(to_integer(unsigned(RAM7(434))))  severity failure; 
 	 assert RAM7(435) = std_logic_vector(to_unsigned( 74, 8)) report " TEST FALLITO (WORKING ZONE). Expected  74  found " & integer'image(to_integer(unsigned(RAM7(435))))  severity failure; 
 	 assert RAM7(436) = std_logic_vector(to_unsigned( 34, 8)) report " TEST FALLITO (WORKING ZONE). Expected  34  found " & integer'image(to_integer(unsigned(RAM7(436))))  severity failure; 
 	 assert RAM7(437) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM7(437))))  severity failure; 
 	 assert RAM7(438) = std_logic_vector(to_unsigned( 130, 8)) report " TEST FALLITO (WORKING ZONE). Expected  130  found " & integer'image(to_integer(unsigned(RAM7(438))))  severity failure; 
 	 assert RAM7(439) = std_logic_vector(to_unsigned( 24, 8)) report " TEST FALLITO (WORKING ZONE). Expected  24  found " & integer'image(to_integer(unsigned(RAM7(439))))  severity failure; 
 	 assert RAM7(440) = std_logic_vector(to_unsigned( 172, 8)) report " TEST FALLITO (WORKING ZONE). Expected  172  found " & integer'image(to_integer(unsigned(RAM7(440))))  severity failure; 
 	 assert RAM7(441) = std_logic_vector(to_unsigned( 82, 8)) report " TEST FALLITO (WORKING ZONE). Expected  82  found " & integer'image(to_integer(unsigned(RAM7(441))))  severity failure; 
 	 assert RAM7(442) = std_logic_vector(to_unsigned( 22, 8)) report " TEST FALLITO (WORKING ZONE). Expected  22  found " & integer'image(to_integer(unsigned(RAM7(442))))  severity failure; 
 	 assert RAM7(443) = std_logic_vector(to_unsigned( 14, 8)) report " TEST FALLITO (WORKING ZONE). Expected  14  found " & integer'image(to_integer(unsigned(RAM7(443))))  severity failure; 
 	 assert RAM7(444) = std_logic_vector(to_unsigned( 46, 8)) report " TEST FALLITO (WORKING ZONE). Expected  46  found " & integer'image(to_integer(unsigned(RAM7(444))))  severity failure; 
 	 assert RAM7(445) = std_logic_vector(to_unsigned( 24, 8)) report " TEST FALLITO (WORKING ZONE). Expected  24  found " & integer'image(to_integer(unsigned(RAM7(445))))  severity failure; 
 	 assert RAM7(446) = std_logic_vector(to_unsigned( 94, 8)) report " TEST FALLITO (WORKING ZONE). Expected  94  found " & integer'image(to_integer(unsigned(RAM7(446))))  severity failure; 
 	 assert RAM7(447) = std_logic_vector(to_unsigned( 226, 8)) report " TEST FALLITO (WORKING ZONE). Expected  226  found " & integer'image(to_integer(unsigned(RAM7(447))))  severity failure; 
 	 assert RAM7(448) = std_logic_vector(to_unsigned( 42, 8)) report " TEST FALLITO (WORKING ZONE). Expected  42  found " & integer'image(to_integer(unsigned(RAM7(448))))  severity failure; 
 	 assert RAM7(449) = std_logic_vector(to_unsigned( 58, 8)) report " TEST FALLITO (WORKING ZONE). Expected  58  found " & integer'image(to_integer(unsigned(RAM7(449))))  severity failure; 
 	 assert RAM7(450) = std_logic_vector(to_unsigned( 52, 8)) report " TEST FALLITO (WORKING ZONE). Expected  52  found " & integer'image(to_integer(unsigned(RAM7(450))))  severity failure; 
 	 assert RAM7(451) = std_logic_vector(to_unsigned( 42, 8)) report " TEST FALLITO (WORKING ZONE). Expected  42  found " & integer'image(to_integer(unsigned(RAM7(451))))  severity failure; 
 	 assert RAM7(452) = std_logic_vector(to_unsigned( 130, 8)) report " TEST FALLITO (WORKING ZONE). Expected  130  found " & integer'image(to_integer(unsigned(RAM7(452))))  severity failure; 
 	 assert RAM7(453) = std_logic_vector(to_unsigned( 54, 8)) report " TEST FALLITO (WORKING ZONE). Expected  54  found " & integer'image(to_integer(unsigned(RAM7(453))))  severity failure; 
 	 assert RAM7(454) = std_logic_vector(to_unsigned( 194, 8)) report " TEST FALLITO (WORKING ZONE). Expected  194  found " & integer'image(to_integer(unsigned(RAM7(454))))  severity failure; 
 	 assert RAM7(455) = std_logic_vector(to_unsigned( 128, 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM7(455))))  severity failure; 
 	 assert RAM7(456) = std_logic_vector(to_unsigned( 252, 8)) report " TEST FALLITO (WORKING ZONE). Expected  252  found " & integer'image(to_integer(unsigned(RAM7(456))))  severity failure; 
 	 assert RAM7(457) = std_logic_vector(to_unsigned( 210, 8)) report " TEST FALLITO (WORKING ZONE). Expected  210  found " & integer'image(to_integer(unsigned(RAM7(457))))  severity failure; 
 	 assert RAM7(458) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM7(458))))  severity failure; 
 	 assert RAM7(459) = std_logic_vector(to_unsigned( 52, 8)) report " TEST FALLITO (WORKING ZONE). Expected  52  found " & integer'image(to_integer(unsigned(RAM7(459))))  severity failure; 
 	 assert RAM7(460) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM7(460))))  severity failure; 
 	 assert RAM7(461) = std_logic_vector(to_unsigned( 254, 8)) report " TEST FALLITO (WORKING ZONE). Expected  254  found " & integer'image(to_integer(unsigned(RAM7(461))))  severity failure; 
 

	 assert RAM8(11) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM8(11))))  severity failure; 
 	 assert RAM8(12) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM8(12))))  severity failure; 
 	 assert RAM8(13) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM8(13))))  severity failure; 
 	 assert RAM8(14) = std_logic_vector(to_unsigned( 18, 8)) report " TEST FALLITO (WORKING ZONE). Expected  18  found " & integer'image(to_integer(unsigned(RAM8(14))))  severity failure; 
 	 assert RAM8(15) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM8(15))))  severity failure; 
 	 assert RAM8(16) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM8(16))))  severity failure; 
 	 assert RAM8(17) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM8(17))))  severity failure; 
 	 assert RAM8(18) = std_logic_vector(to_unsigned( 32, 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM8(18))))  severity failure; 
 	 assert RAM8(19) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM8(19))))  severity failure; 
 

	 assert RAM9(42) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(42))))  severity failure; 
 	 assert RAM9(43) = std_logic_vector(to_unsigned( 232, 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM9(43))))  severity failure; 
 	 assert RAM9(44) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(44))))  severity failure; 
 	 assert RAM9(45) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM9(45))))  severity failure; 
 	 assert RAM9(46) = std_logic_vector(to_unsigned( 152, 8)) report " TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM9(46))))  severity failure; 
 	 assert RAM9(47) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM9(47))))  severity failure; 
 	 assert RAM9(48) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(48))))  severity failure; 
 	 assert RAM9(49) = std_logic_vector(to_unsigned( 40, 8)) report " TEST FALLITO (WORKING ZONE). Expected  40  found " & integer'image(to_integer(unsigned(RAM9(49))))  severity failure; 
 	 assert RAM9(50) = std_logic_vector(to_unsigned( 232, 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM9(50))))  severity failure; 
 	 assert RAM9(51) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(51))))  severity failure; 
 	 assert RAM9(52) = std_logic_vector(to_unsigned( 232, 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM9(52))))  severity failure; 
 	 assert RAM9(53) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(53))))  severity failure; 
 	 assert RAM9(54) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(54))))  severity failure; 
 	 assert RAM9(55) = std_logic_vector(to_unsigned( 224, 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM9(55))))  severity failure; 
 	 assert RAM9(56) = std_logic_vector(to_unsigned( 168, 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM9(56))))  severity failure; 
 	 assert RAM9(57) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM9(57))))  severity failure; 
 	 assert RAM9(58) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(58))))  severity failure; 
 	 assert RAM9(59) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(59))))  severity failure; 
 	 assert RAM9(60) = std_logic_vector(to_unsigned( 96, 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM9(60))))  severity failure; 
 	 assert RAM9(61) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM9(61))))  severity failure; 
 	 assert RAM9(62) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(62))))  severity failure; 
 	 assert RAM9(63) = std_logic_vector(to_unsigned( 80, 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM9(63))))  severity failure; 
 	 assert RAM9(64) = std_logic_vector(to_unsigned( 152, 8)) report " TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM9(64))))  severity failure; 
 	 assert RAM9(65) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(65))))  severity failure; 
 	 assert RAM9(66) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(66))))  severity failure; 
 	 assert RAM9(67) = std_logic_vector(to_unsigned( 176, 8)) report " TEST FALLITO (WORKING ZONE). Expected  176  found " & integer'image(to_integer(unsigned(RAM9(67))))  severity failure; 
 	 assert RAM9(68) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM9(68))))  severity failure; 
 	 assert RAM9(69) = std_logic_vector(to_unsigned( 88, 8)) report " TEST FALLITO (WORKING ZONE). Expected  88  found " & integer'image(to_integer(unsigned(RAM9(69))))  severity failure; 
 	 assert RAM9(70) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(70))))  severity failure; 
 	 assert RAM9(71) = std_logic_vector(to_unsigned( 168, 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM9(71))))  severity failure; 
 	 assert RAM9(72) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(72))))  severity failure; 
 	 assert RAM9(73) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(73))))  severity failure; 
 	 assert RAM9(74) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(74))))  severity failure; 
 	 assert RAM9(75) = std_logic_vector(to_unsigned( 72, 8)) report " TEST FALLITO (WORKING ZONE). Expected  72  found " & integer'image(to_integer(unsigned(RAM9(75))))  severity failure; 
 	 assert RAM9(76) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM9(76))))  severity failure; 
 	 assert RAM9(77) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM9(77))))  severity failure; 
 	 assert RAM9(78) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(78))))  severity failure; 
 	 assert RAM9(79) = std_logic_vector(to_unsigned( 152, 8)) report " TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM9(79))))  severity failure; 
 	 assert RAM9(80) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM9(80))))  severity failure; 
 	 assert RAM9(81) = std_logic_vector(to_unsigned( 8, 8)) report " TEST FALLITO (WORKING ZONE). Expected  8  found " & integer'image(to_integer(unsigned(RAM9(81))))  severity failure; 
 

	 assert RAM10(27) = std_logic_vector(to_unsigned( 176, 8)) report " TEST FALLITO (WORKING ZONE). Expected  176  found " & integer'image(to_integer(unsigned(RAM10(27))))  severity failure; 
 	 assert RAM10(28) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM10(28))))  severity failure; 
 	 assert RAM10(29) = std_logic_vector(to_unsigned( 192, 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM10(29))))  severity failure; 
 	 assert RAM10(30) = std_logic_vector(to_unsigned( 16, 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM10(30))))  severity failure; 
 	 assert RAM10(31) = std_logic_vector(to_unsigned( 24, 8)) report " TEST FALLITO (WORKING ZONE). Expected  24  found " & integer'image(to_integer(unsigned(RAM10(31))))  severity failure; 
 	 assert RAM10(32) = std_logic_vector(to_unsigned( 136, 8)) report " TEST FALLITO (WORKING ZONE). Expected  136  found " & integer'image(to_integer(unsigned(RAM10(32))))  severity failure; 
 	 assert RAM10(33) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM10(33))))  severity failure; 
 	 assert RAM10(34) = std_logic_vector(to_unsigned( 248, 8)) report " TEST FALLITO (WORKING ZONE). Expected  248  found " & integer'image(to_integer(unsigned(RAM10(34))))  severity failure; 
 	 assert RAM10(35) = std_logic_vector(to_unsigned( 208, 8)) report " TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM10(35))))  severity failure; 
 	 assert RAM10(36) = std_logic_vector(to_unsigned( 72, 8)) report " TEST FALLITO (WORKING ZONE). Expected  72  found " & integer'image(to_integer(unsigned(RAM10(36))))  severity failure; 
 	 assert RAM10(37) = std_logic_vector(to_unsigned( 104, 8)) report " TEST FALLITO (WORKING ZONE). Expected  104  found " & integer'image(to_integer(unsigned(RAM10(37))))  severity failure; 
 	 assert RAM10(38) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM10(38))))  severity failure; 
 	 assert RAM10(39) = std_logic_vector(to_unsigned( 16, 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM10(39))))  severity failure; 
 	 assert RAM10(40) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM10(40))))  severity failure; 
 	 assert RAM10(41) = std_logic_vector(to_unsigned( 176, 8)) report " TEST FALLITO (WORKING ZONE). Expected  176  found " & integer'image(to_integer(unsigned(RAM10(41))))  severity failure; 
 	 assert RAM10(42) = std_logic_vector(to_unsigned( 144, 8)) report " TEST FALLITO (WORKING ZONE). Expected  144  found " & integer'image(to_integer(unsigned(RAM10(42))))  severity failure; 
 	 assert RAM10(43) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM10(43))))  severity failure; 
 	 assert RAM10(44) = std_logic_vector(to_unsigned( 248, 8)) report " TEST FALLITO (WORKING ZONE). Expected  248  found " & integer'image(to_integer(unsigned(RAM10(44))))  severity failure; 
 	 assert RAM10(45) = std_logic_vector(to_unsigned( 200, 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM10(45))))  severity failure; 
 	 assert RAM10(46) = std_logic_vector(to_unsigned( 248, 8)) report " TEST FALLITO (WORKING ZONE). Expected  248  found " & integer'image(to_integer(unsigned(RAM10(46))))  severity failure; 
 	 assert RAM10(47) = std_logic_vector(to_unsigned( 48, 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM10(47))))  severity failure; 
 	 assert RAM10(48) = std_logic_vector(to_unsigned( 248, 8)) report " TEST FALLITO (WORKING ZONE). Expected  248  found " & integer'image(to_integer(unsigned(RAM10(48))))  severity failure; 
 	 assert RAM10(49) = std_logic_vector(to_unsigned( 72, 8)) report " TEST FALLITO (WORKING ZONE). Expected  72  found " & integer'image(to_integer(unsigned(RAM10(49))))  severity failure; 
 	 assert RAM10(50) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM10(50))))  severity failure; 
 	 assert RAM10(51) = std_logic_vector(to_unsigned( 136, 8)) report " TEST FALLITO (WORKING ZONE). Expected  136  found " & integer'image(to_integer(unsigned(RAM10(51))))  severity failure; 
 

	 assert RAM11(10) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM11(10))))  severity failure; 
 	 assert RAM11(11) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM11(11))))  severity failure; 
 	 assert RAM11(12) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM11(12))))  severity failure; 
 	 assert RAM11(13) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM11(13))))  severity failure; 
 	 assert RAM11(14) = std_logic_vector(to_unsigned( 255, 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM11(14))))  severity failure; 
 	 assert RAM11(15) = std_logic_vector(to_unsigned( 64, 8)) report " TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM11(15))))  severity failure; 
 	 assert RAM11(16) = std_logic_vector(to_unsigned( 160, 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM11(16))))  severity failure; 
 	 assert RAM11(17) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM11(17))))  severity failure; 
 

	 assert RAM12(4) = std_logic_vector(to_unsigned( 240, 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM12(4))))  severity failure; 
 	 assert RAM12(5) = std_logic_vector(to_unsigned( 0, 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM12(5))))  severity failure; 
 


    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end projecttb; 