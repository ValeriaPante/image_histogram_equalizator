-----------------------------------------------------------------------------
-- Prova Finale di Reti Logiche A.A. 2020/21
-- Autori: Valeria Pantè (Codice Persona: 10712755), Alberto Panzanini (Codice Persona: 10629004)
-----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

---------------------------------- ENTITY ----------------------------------
entity project_reti_logiche is
    port(
        i_clk       : in std_logic;
        i_rst       : in std_logic;
        i_start     : in std_logic;
        i_data      : in std_logic_vector (7 downto 0);
        o_address   : out std_logic_vector (15 downto 0);
        o_done      : out std_logic;
        o_en        : out std_logic;
        o_we        : out std_logic;
        o_data      : out std_logic_vector (7 downto 0)
    );    
end project_reti_logiche;
--------------------------------- END ENTITY ---------------------------------

-------------------------------- ARCHITECTURE --------------------------------
architecture Behavioral of project_reti_logiche is
    type state_type is (OFF, READ, CALCOLO, SHIFT, WRITE, DONE);
    signal curr_state, next_state: state_type := OFF;
    
    signal next_addr, curr_addr: std_logic_vector (15 downto 0) := "0000000000000000";
    signal next_en, next_we, next_done: std_logic := '0';
    
    signal curr_righe, curr_colonne, next_righe, next_colonne: std_logic_vector (7 downto 0) := (others => '0');
    
    signal curr_max, next_max: unsigned (7 downto 0) := (others => '0');
    signal curr_min, next_min: unsigned (7 downto 0) := (others => '1');
    
    signal letto0, next_letto0: std_logic := '0';
    signal letto255, next_letto255: std_logic := '0';
    signal shiftlevel, next_shiftlevel: NATURAL := 0;
    
    signal new_pixel_value: std_logic_vector (7 downto 0) := "00000000";
     
begin
------------------------------ PROCESS STANDARD ------------------------------
    standard: process(i_clk, i_rst)
        begin
            if (i_clk'event and i_clk = '0') then       --sensibile sul fronte di discesa del clock
                if (i_rst = '1') then                   --RESET
                    curr_state <= OFF;
                    o_done <= '0';
                    o_en <= '0';
                    o_we <= '0';
                    o_address <= "0000000000000000";
                    o_data <= "00000000";
                else                                    --AGGIORNAMENTO
                    curr_state <= next_state;                    
                    curr_addr <= next_addr;
                    
                    o_address <= next_addr;
                    o_en <= next_en;
                    o_we <= next_we;
                    o_done <= next_done;
                    o_data <= new_pixel_value;
                    
                    curr_righe <= next_righe;
                    curr_colonne <= next_colonne;
                    curr_max <= next_max;
                    curr_min <= next_min;
                    letto0 <= next_letto0;
                    letto255 <= next_letto255;
                    shiftlevel <= next_shiftlevel;
    
                end if;
            end if;
        end process;
----------------------------- END PROCESS STANDARD -----------------------------

------------------------------- PROCESS ACTIVITY -------------------------------         
    activity: process(i_start, curr_state, curr_addr, i_rst, i_data)
           variable delta_value: UNSIGNED (7 downto 0) := to_unsigned(0, 8);
           variable temp_pixel: integer := 0;
        begin
            -- Assegnamenti di default se non ce ne sono altri successivi
            next_state <= curr_state;
            next_addr <= curr_addr;
            next_done <= '0';
            next_en <= '0';
            next_we <= '0';
            next_righe <= curr_righe;
            next_colonne <= curr_colonne;
            next_max <= curr_max;
            next_min <= curr_min;
            next_letto0 <= letto0;
            next_letto255 <= letto255;
            next_shiftlevel <= shiftlevel;
            new_pixel_value <= "00000000";
                
            if (i_rst = '1') then                   --RESET
                    next_state <= OFF;
                    next_done <= '0';
                    next_en <= '0';
                    next_we <= '0';
                    next_addr <= "0000000000000000";
                    new_pixel_value <= "00000000";
            else
                case curr_state is
                    ------------------- Stato corrente OFF
                    when OFF =>
                        next_addr <= "0000000000000000";
                        next_max <= to_unsigned(0, 8);
                        next_min <= to_unsigned(255, 8);
                        next_letto0 <= '0';
                        next_letto255 <= '0';
                     
                        if i_start = '1' then
                            next_state <= READ;
                            next_en <= '1';
                        else 
                            next_state <= OFF;
                        end if;
                        
                    ------------------- Stato corrente READ
                    when READ =>
                        next_en <= '1';
                        
                        if curr_addr = "0000000000000000" then
                            next_colonne <= i_data;
                            next_addr <= "0000000000000001";
                            next_state <= READ;
                        elsif curr_addr = "0000000000000001" then
                            next_righe <= i_data;
                            next_addr <= "0000000000000010";
                            next_state <= READ;
                        else
                            -- Controllo SE LETTI volori estremi
                            if(UNSIGNED(i_data) = to_unsigned(0, 8)) then
                                next_letto0 <= '1';
                            elsif(UNSIGNED(i_data) = to_unsigned(255, 8)) then
                                next_letto255 <= '1';
                            end if;
                            
                            --Individuazione MASSIMO e MINIMO
                            if(to_integer(UNSIGNED(i_data)) < to_integer(curr_min)) then
                                next_min <= UNSIGNED(i_data);
                            end if;
                            if(to_integer(UNSIGNED(i_data)) > to_integer(curr_max)) then
                                next_max <= UNSIGNED(i_data);
                            end if;
                            
                            if ((letto0 AND letto255) = '1') then
                                next_state <= SHIFT;
                                next_addr <= "0000000000000010";
                            elsif (to_integer(UNSIGNED(curr_addr)) - 1 = UNSIGNED(curr_righe)*UNSIGNED(curr_colonne)) then
                                next_state <= CALCOLO;
                                next_addr <= "0000000000000010";
                            elsif (curr_righe = "00000000" OR curr_colonne = "00000000") then
                                next_state <= DONE;
                                next_done <= '1';
                            else 
                                next_state <= READ;
                                next_addr <= STD_LOGIC_VECTOR(UNSIGNED(curr_addr) + 1);
                            end if;
                        end if;
                              
                    ------------------- Stato corrente CALCOLO      
                    when CALCOLO =>
                        next_en <= '1';
                        
                        delta_value := curr_max - curr_min;
                        if (delta_value < 1) then next_shiftlevel <= 8;
                        elsif (delta_value >= 1 AND delta_value < 3) then next_shiftlevel <= 7;
                        elsif (delta_value >= 3 AND delta_value < 7) then next_shiftlevel <= 6;
                        elsif (delta_value >= 7 AND delta_value < 15) then next_shiftlevel <= 5;
                        elsif (delta_value >= 15 AND delta_value < 31) then next_shiftlevel <= 4;
                        elsif (delta_value >= 31 AND delta_value < 63) then next_shiftlevel <= 3;
                        elsif (delta_value >= 63 AND delta_value < 127) then next_shiftlevel <= 2;
                        elsif (delta_value >= 127 AND delta_value < 255) then next_shiftlevel <= 1;
                        else next_shiftlevel <= 0;
                        end if;
                        
                        next_state <= SHIFT;
                        
                    ------------------- Stato corrente SHIFT     
                    when SHIFT =>
                        next_en <= '1';
                    
                        if((letto0 AND letto255) = '1') then
                            new_pixel_value <= i_data;
                        else
                            -- Calcolo NUOVO VALORE                      
                            temp_pixel := to_integer(shift_left(to_unsigned(to_integer(UNSIGNED(i_data) - curr_min), 16), shiftlevel));
                            if(temp_pixel < 255) then new_pixel_value <= STD_LOGIC_VECTOR(to_unsigned(temp_pixel, 8));
                            else new_pixel_value <= "11111111";
                            end if;
                        end if;
                        
                        next_addr <= STD_LOGIC_VECTOR(UNSIGNED(curr_addr) + UNSIGNED(curr_righe)*UNSIGNED(curr_colonne));
                        next_we <= '1';
                        next_state <= WRITE;
                        
                    ------------------- Stato corrente WRITE    
                    when WRITE =>
                        if (curr_addr = STD_LOGIC_VECTOR(to_unsigned((1 + to_integer(UNSIGNED(curr_righe)*UNSIGNED(curr_colonne))*2), 16))) then
                            next_state <= DONE;
                            next_done <= '1';
                        else
                            next_en <= '1';
                            next_addr <= STD_LOGIC_VECTOR(UNSIGNED(curr_addr) - UNSIGNED(curr_righe)*UNSIGNED(curr_colonne) + 1);
                            next_state <= SHIFT;
                        end if;
 
                    ------------------- Stato corrente DONE
                    when DONE =>
                        if (i_start = '0') then
                            next_done <= '0';
                            next_state <= OFF;
                        else
                            next_done <= '1';
                            next_state <= DONE;                    
                        end if;
                end case;
            end if;
        end process;
----------------------------- END PROCESS ACTIVITY -----------------------------
end Behavioral;