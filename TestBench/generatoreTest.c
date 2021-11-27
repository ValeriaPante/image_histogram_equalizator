#include <stdio.h>
#include <stdlib.h>
#define MAX_RIGHE 128
#define MAX_COLONNE 128
#define VAL_MAX 255
#define VAL_MIN 0
#define PATH_SALVATAGGIO "Testbench_chunk.vhd"

int main()
{
    FILE *pDaScrivere;
    int num_imm_succ, num_bit;
    int i, j, rnd_pixel_value, temp_pixel;
    int periodo_clock, ritardo_mem;
    int generazione_automatica;
    int n_max_righe, n_max_colonne;
    int add_wait, time_wait, rnd_wait, rnd_val;
    int rst, rst_middle_no_change = 0, rst_middle_change = 0, rst_after = 0, rst_middle_stop = 0;
    int b_pc, c_pc, d_pc, b_read, c_read, d_read; //prima compresa --> pc
    int a, b, c, d;

    //INSERIMENTO DIMENSIONI MASSIME
    printf ("numero massimo righe: \n");
    scanf ("%d", &n_max_righe);
    printf ("numero massimo di colonne: \n");
    scanf ("%d", &n_max_colonne);

    //INSERIMENTO VALORI PRE TEMPORARIZZAZIONE
    printf ("periodo del clock (in ns): \n");
    scanf ("%d", &periodo_clock);
    printf ("ritardo interazione con memoria (in ns): \n");
    scanf ("%d", &ritardo_mem);
    printf ("Aggiungere wait durante esecuzione? (0 no, 1 si) \n");
    scanf ("%d", &add_wait);
    if (1==add_wait)
    {
        printf ("tempo delle wait (in ns): \n");
        scanf ("%d", &time_wait);
        printf ("Scelta tempo wait casuale con valore massimo quello inserito prima? (0 no, 1 si)\n");
        scanf ("%d", &rnd_wait);
    }


    //INSERIEMENTO VALORI PER RESET
    printf ("Aggiungere reset? (0 no, 1 si) \n");
    scanf ("%d", &rst);
    if (1==rst)
    {
        //RESET AD ELABORAZIONE CONCLUSA
        printf ("Reset dopo elaborazione? (0 no, 1 si) \n");
        scanf ("%d", &rst_after);
        if (1==rst_after)
        {
            printf ("Ogni quante immagini? (numero intero) \n");
            scanf ("%d", &a);
        }

        //RESET DURANTE ESECUZIONE MA SENZA CAMBIARE IMMAGINE
        printf ("Reset durante elaborazione senza cambiare immagine? (0 no, 1 si) \n");
        scanf ("%d", &rst_middle_no_change);
        if (1==rst_middle_no_change)
        {
            printf ("Ogni quante immagini? (numero intero) \n");
            scanf ("%d", &b);
            printf ("A partire dalla prima? (0 no, 1 si) \n");
            scanf ("%d", &b_pc);
            printf ("Durante lettura o scrittura? (0 scrittura, 1 lettura) \n");
            scanf ("%d", &b_read);
        }

        //RESET DURANTE ESECUZIONE CON CAMBIO IMMAGINE
        printf ("Reset durante elaborazione con cambio immagine? (0 no, 1 si) \n");
        scanf ("%d", &rst_middle_change);
        if (1==rst_middle_change)
        {
            printf ("Ogni quante immagini? (numero intero) \n");
            scanf ("%d", &c);
            printf ("A partire dalla prima? (0 no, 1 si) \n");
            scanf ("%d", &c_pc);
            printf ("Durante lettura o scrittura? (0 scrittura, 1 lettura) \n");
            scanf ("%d", &c_read);
        }

        //RESET DURANTE ESECUZIONE CON TERMINAZIONE
        printf ("Reset durante elaborazione con annullamento? (0 no, 1 si) \n");
        scanf ("%d", &rst_middle_stop);
        if (1==rst_middle_stop)
        {
            printf ("Ogni quante immagini? (numero intero) \n");
            scanf ("%d", &d);
            printf ("A partire dalla prima? (0 no, 1 si) \n");
            scanf ("%d", &d_pc);
            printf ("Durante lettura o scrittura? (0 scrittura, 1 lettura) \n");
            scanf ("%d", &d_read);
        }
    }


    //INSERIMENTO VALORI PER GENERAZIONE
    printf ("numero immagini successive: \n");
    scanf ("%d", &num_imm_succ);
    printf ("Consigliato per tb con molte immagini: Generazione automatica? (0 no, 1 si) \n");
    scanf ("%d", &generazione_automatica );


    int num_righe[num_imm_succ], num_colonne[num_imm_succ];
    int val_max[num_imm_succ], val_min[num_imm_succ], pos_max[num_imm_succ], pos_min[num_imm_succ];
    int tot_pixel[num_imm_succ];
    int delta_value[num_imm_succ], shift_lvl[num_imm_succ];


    //RIEMPIMENTO CAMPI
    if (0==generazione_automatica)
    {
        for (i=0; i < num_imm_succ; i++)
        {


            printf ("numero colonne: \n");
            scanf ("%d", &num_colonne[i]);
            if (num_colonne[i]>n_max_colonne)
            {
                printf("inserito valore colonne eccessivo");
                return (-1);
            }
            printf ("numero righe: \n");
            scanf ("%d", &num_righe[i]);
            if (num_righe[i]>n_max_righe)
            {
                printf("inserito valore righe eccessivo");
                return (-1);
            }

            tot_pixel[i]= num_righe[i]*num_colonne[i];

            printf ("valore massimo: \n");
            scanf ("%d", &val_max[i]);
            if (val_max[i]>VAL_MAX)
            {
                printf("inserito valore massimo eccessivo");
                return (-1);
            }
            printf ("posizione valore massimo: \n");
            scanf ("%d", &pos_max[i]);
            if (pos_max[i]>tot_pixel[i])
            {
                printf("inserita posizione valore massimo eccessiva");
                return (-1);
            }
            printf ("valore minimo: \n");
            scanf ("%d", &val_min[i]);
            if (val_min[i]<VAL_MIN)
            {
                printf("inserito valore minimo eccessivo");
                return (-1);
            }
            printf ("posizione valore minimo: \n");
            scanf ("%d", &pos_min[i]);
            if (pos_min[i]>tot_pixel[i])
            {
                printf("inserita posizione valore minimo eccessiva");
                return (-1);
            }
        }
    }
    else
    {
        for (i=0; i < num_imm_succ; i++)
        {
            num_colonne[i] = (rand() % (n_max_colonne)) + 1;
            num_righe[i] = (rand() % (n_max_righe)) + 1;

            tot_pixel[i]= num_righe[i]*num_colonne[i];

            val_max[i] = (rand() % (VAL_MAX - VAL_MIN + 1)) + VAL_MIN;
            if (1==tot_pixel[i]) val_min[i]=val_max[i];
            else val_min[i] = (rand() % (val_max[i] - VAL_MIN + 1)) + VAL_MIN;

            pos_max[i] = (rand() % (tot_pixel[i])) + 1;
            if ((1==tot_pixel[i])||(val_max[i]==val_min[i]))
            {
                pos_min[i] = pos_max[i];
            }
            else if (1==pos_max[i])
            {
                pos_min[i]= (rand() % (tot_pixel[i] - 1)) + 2;
            }
            else if (tot_pixel[i]==pos_max[i])
            {
                pos_min[i]= (rand() % (tot_pixel[i] - 1)) + 1;
            }
            else
            {
                int prima_o_dopo;
                prima_o_dopo = rand() % 2;
                if (0== prima_o_dopo)
                {
                    pos_min[i]= (rand() % (pos_max[i] - 1)) + 1;
                }
                else
                {
                    pos_min[i]= (rand() % (tot_pixel[i] - pos_max[i])) + pos_max[i] + 1;
                }
            }
        }
    }


    //PER FARE ASSERZIONI SOLO DELLE IMMAGINI CHE SERVONO: INIZIALIZZAZIONE A 1
    int to_be_counted[num_imm_succ];
    for (i=0; i < num_imm_succ; i++)
    {
        to_be_counted[i] = 1;
    }


    int immagine[num_imm_succ][n_max_righe*n_max_colonne];

    pDaScrivere=fopen (PATH_SALVATAGGIO, "wb");
    if (NULL==pDaScrivere) printf ("Erorre durante l'apertura o la creazione del file");
    else
    {
        //PARTE INIZIALE CON DICHIARAZIONI
        fprintf(pDaScrivere, "library ieee;\n"
                             "use ieee.std_logic_1164.all;\n"
                             "use ieee.numeric_std.all;\n"
                             "use ieee.std_logic_unsigned.all;\n"
                             "\n"
                             "entity project_tb is\n"
                             "end project_tb;\n"
                             "\n"
                             "architecture projecttb of project_tb is\n"
                             "constant c_CLOCK_PERIOD         : time := %d ns;\n"
                             "signal   tb_done                : std_logic;\n"
                             "signal   mem_address            : std_logic_vector (15 downto 0) := (others => '0');\n"
                             "signal   tb_rst                 : std_logic := '0';\n"
                             "signal   tb_start               : std_logic := '0';\n"
                             "signal   tb_clk                 : std_logic := '0';\n"
                             "signal   mem_o_data,mem_i_data  : std_logic_vector (7 downto 0);\n"
                             "signal   enable_wire            : std_logic;\n"
                             "signal   mem_we                 : std_logic;\n"
                             "\n"
                             "type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);\n", periodo_clock);


        //PER SEGNALE RAM
        if (2>=num_imm_succ) num_bit=1;
        else if (num_imm_succ>=3 && num_imm_succ<=4) num_bit=2;
        else if (num_imm_succ>=5 && num_imm_succ<=8) num_bit=3;
        else if (num_imm_succ>=9 && num_imm_succ<=16) num_bit=4;
        else if (num_imm_succ>=17 && num_imm_succ<=32) num_bit=5;
        else if (num_imm_succ>=33 && num_imm_succ<=64) num_bit=6;
        else if (num_imm_succ>=65 && num_imm_succ<=128) num_bit=7;
        else if (num_imm_succ>=129 && num_imm_succ<=256) num_bit=8;
        else if (num_imm_succ>=257 && num_imm_succ<=512) num_bit=9;
        else if (num_imm_succ>=513 && num_imm_succ<=1024) num_bit=10;
        else if (num_imm_succ>=1025 && num_imm_succ<=2048) num_bit=11;
        else if (num_imm_succ>=2049 && num_imm_succ<=4096) num_bit=12;
        else if (num_imm_succ>=4097 && num_imm_succ<=8192) num_bit=13;
        else if (num_imm_succ>=8193 && num_imm_succ<=16384) num_bit=14;
        else if (num_imm_succ>=16385 && num_imm_succ<=32768) num_bit=15;
        else if (num_imm_succ>=32769 && num_imm_succ<=65536) num_bit=16;
        else if (num_imm_succ>=65537 && num_imm_succ<=131072) num_bit=17;
        else if (num_imm_succ>=131073 && num_imm_succ<=262144) num_bit=18;
        else if (num_imm_succ>=262145 && num_imm_succ<=524288) num_bit=19;
        fprintf(pDaScrivere, "signal i: std_logic_vector(%d downto 0) := std_logic_vector(to_unsigned( 0, %d)); \n\n\n", num_bit-1, num_bit);


        //PER INIZIALIZZAZIONE ELEMENTI IN RAM
        for (j=0; j<num_imm_succ; j++)
        {
            fprintf(pDaScrivere, "signal RAM%d: ram_type := (0 => std_logic_vector(to_unsigned( %d, 8)), \n", j, num_colonne[j]);
            fprintf(pDaScrivere, "\t\t\t\t\t\t 1 => std_logic_vector(to_unsigned( %d, 8)), \n", num_righe[j]);
            for(i=2; i<(tot_pixel[j]+2); i++)
            {
                if ((i-1)==pos_max[j]) rnd_pixel_value=val_max[j];
                else if ((i-1)==pos_min[j]) rnd_pixel_value=val_min[j];
                else rnd_pixel_value=(rand() % (val_max[j] - val_min[j] + 1)) + val_min[j];

                immagine[j][i-2]=rnd_pixel_value;
                fprintf(pDaScrivere, "\t\t\t\t\t\t %d => std_logic_vector(to_unsigned( %d, 8)),\n", i, rnd_pixel_value);
            }
            fprintf(pDaScrivere, "\t\t\t\t\t\t others => (others =>'0')); \n\n\n\n");
        }
        fprintf(pDaScrivere, "\n\n\n\n\n\n");


        //COMPONENT E PROCESSI STANDARD
        fprintf(pDaScrivere, "component project_reti_logiche is\n"
                             "port (\n"
                             "      i_clk         : in  std_logic;\n"
                             "      i_start       : in  std_logic;\n"
                             "      i_rst         : in  std_logic;\n"
                             "      i_data        : in  std_logic_vector(7 downto 0);\n"
                             "      o_address     : out std_logic_vector(15 downto 0);\n"
                             "      o_done        : out std_logic;\n"
                             "      o_en          : out std_logic;\n"
                             "      o_we          : out std_logic;\n"
                             "      o_data        : out std_logic_vector (7 downto 0)\n"
                             "      );\n"
                             "end component project_reti_logiche;\n"
                             "\n"
                             "\n"
                             "begin\n"
                             "UUT: project_reti_logiche\n"
                             "port map (\n"
                             "          i_clk      \t=> tb_clk,\n"
                             "          i_start       => tb_start,\n"
                             "          i_rst      \t=> tb_rst,\n"
                             "          i_data    \t=> mem_o_data,\n"
                             "          o_address  \t=> mem_address,\n"
                             "          o_done      \t=> tb_done,\n"
                             "          o_en   \t=> enable_wire,\n"
                             "          o_we \t\t=> mem_we,\n"
                             "          o_data    \t=> mem_i_data\n"
                             "          );\n"
                             "\n"
                             "p_CLK_GEN : process is\n"
                             "begin\n"
                             "    wait for c_CLOCK_PERIOD/2;\n"
                             "    tb_clk <= not tb_clk;\n"
                             "end process p_CLK_GEN;\n");


        //PROCESSO MEMORIA
        fprintf(pDaScrivere, "MEM : process(tb_clk)\n"
                             "begin\n"
                             "\t if tb_clk'event and tb_clk = '1' then\n"
                             "\t\t if enable_wire = '1' then\n");
        for(i=0; i<num_imm_succ; i++)
        {
            if(0==i)
            {
                fprintf(pDaScrivere, "\t\t\t if i = std_logic_vector(to_unsigned( %d, %d)) then\n"
                                     "\t\t\t\t if mem_we = '1' then\n"
                                     "\t\t\t\t\t RAM%d(conv_integer(mem_address)) <= mem_i_data;\n"
                                     "\t\t\t\t\t mem_o_data <= mem_i_data after %d ns;\n"
                                     "\t\t\t\t else\n"
                                     "\t\t\t\t\t mem_o_data <= RAM%d(conv_integer(mem_address)) after %d ns;\n"
                                     "\t\t\t\t end if;\n", i, num_bit, i, ritardo_mem, i, ritardo_mem);
            }
            else
            {
                fprintf(pDaScrivere, "\t\t\t elsif i = std_logic_vector(to_unsigned( %d, %d)) then\n"
                                     "\t\t\t\t if mem_we = '1' then\n"
                                     "\t\t\t\t\t RAM%d(conv_integer(mem_address)) <= mem_i_data;\n"
                                     "\t\t\t\t\t mem_o_data <= mem_i_data after %d ns;\n"
                                     "\t\t\t\t else\n"
                                     "\t\t\t\t\t mem_o_data <= RAM%d(conv_integer(mem_address)) after %d ns;\n"
                                     "\t\t\t\t end if;\n", i, num_bit, i, ritardo_mem, i, ritardo_mem);
            }
        }
        fprintf(pDaScrivere, "\t\t\t end if;\n"
                             "\t\t end if;\n"
                             "\t end if;\n"
                             "end process;\n");
        fprintf(pDaScrivere, "\n\n\n\n\n\n");

        //PROCESSO TEST
        fprintf(pDaScrivere, "test : process is\n"
                             "begin\n");
        for (i=0; i<num_imm_succ; i++)
        {
            if(0==i)
            {
                if (1==add_wait)
                {
                    if (1==rnd_wait)
                    {
                        rnd_val= (rand() % time_wait) + 1;
                        fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                    }
                    else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                }
                fprintf(pDaScrivere, "\t wait for c_CLOCK_PERIOD;\n"
                                     "\t tb_rst <= '1';\n"
                                     "\t wait for c_CLOCK_PERIOD;\n");
                if (1==add_wait)
                {
                    if (1==rnd_wait)
                    {
                        rnd_val= (rand() % time_wait) + 1;
                        fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                    }
                    else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                }
                fprintf(pDaScrivere, "\t tb_rst <= '0';\n"
                                     "\t wait for c_CLOCK_PERIOD;\n");
                if (1==add_wait)
                {
                    if (1==rnd_wait)
                    {
                        rnd_val= (rand() % time_wait) + 1;
                        fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                    }
                    else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                }
                fprintf(pDaScrivere, "\t tb_start <= '1';\n"
                                     "\t wait for c_CLOCK_PERIOD;\n");
                if (1==rst_middle_no_change)
                {
                    if (1==b_pc)
                    {
                        if (1==b_read) fprintf(pDaScrivere, "\t wait for %d ns;\n", 2*(tot_pixel[i] * (periodo_clock-2)));
                        else fprintf(pDaScrivere, "\t wait for %d ns;\n", ((3 * tot_pixel[i] * periodo_clock) +((tot_pixel[i] % 2) * periodo_clock)) + 2 * periodo_clock);

                        fprintf(pDaScrivere, "\t tb_rst <= '1';\n"
                                             "\t wait for c_CLOCK_PERIOD;\n");
                        if (1==add_wait)
                        {
                            if (1==rnd_wait)
                            {
                                rnd_val= (rand() % time_wait) + 1;
                                fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                            }
                            else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                        }
                        fprintf(pDaScrivere, "\t tb_rst <= '0';\n");
                    }
                }
                if (1==rst_middle_change)
                {
                    if ((1==c_pc) && ((i + 1) < num_imm_succ))
                    {
                        if (1==c_read) fprintf(pDaScrivere, "\t wait for %d ns;\n", 2*(tot_pixel[i] * (periodo_clock-2)));
                        else fprintf(pDaScrivere, "\t wait for %d ns;\n", ((3 * tot_pixel[i] * periodo_clock) +((tot_pixel[i] % 2) * periodo_clock)) + 2 * periodo_clock);
                        to_be_counted[i] = 0;
                        i++;
                        fprintf(pDaScrivere, "\t tb_rst <= '1';\n"
                                             "\t wait for c_CLOCK_PERIOD;\n"
                                             "\t i <= std_logic_vector(to_unsigned( %d, %d));\n"
                                             "\n "
                                             "\n ", i, num_bit);
                        if (1==add_wait)
                        {
                            if (1==rnd_wait)
                            {
                                rnd_val= (rand() % time_wait) + 1;
                                fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                            }
                            else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                        }
                        fprintf(pDaScrivere, "\t tb_rst <= '0';\n");
                    }
                }
                if (1==d_pc)
                {
                    to_be_counted[i] = 0;
                    if (1==d_read) fprintf(pDaScrivere, "\t wait for %d ns;\n", 2*(tot_pixel[i] * (periodo_clock-2)));
                    else fprintf(pDaScrivere, "\t wait for %d ns;\n", ((3 * tot_pixel[i] * periodo_clock) +((tot_pixel[i] % 2) * periodo_clock)) + 2 * periodo_clock);

                    fprintf(pDaScrivere, "\t tb_rst <= '1';\n"
                                         "\t wait for c_CLOCK_PERIOD;\n"
                                         "\t tb_start <= '0';\n"
                                         "\t wait for c_CLOCK_PERIOD;\n"
                                         "\t tb_rst <= '0';\n");
                }
                else
                {
                    fprintf(pDaScrivere, "\t wait until tb_done = '1';\n"
                                         "\t wait for c_CLOCK_PERIOD;\n"
                                         "\t tb_start <= '0';\n"
                                         "\t wait until tb_done = '0';\n");
                }

                if (1==add_wait)
                {
                    if (1==rnd_wait)
                    {
                        rnd_val= (rand() % time_wait) + 1;
                        fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                    }
                    else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                }
            }
            //IMMAGINI DIVERSE DALLA PRIMA
            else
            {
                if (1==rst_after)
                {
                    if (0==(i % a))
                    {
                        fprintf(pDaScrivere, "\t wait for c_CLOCK_PERIOD;\n"
                                             "\t tb_rst <= '1';\n"
                                             "\t wait for c_CLOCK_PERIOD;\n");
                        if (1==add_wait)
                        {
                            if (1==rnd_wait)
                            {
                                rnd_val= (rand() % time_wait) + 1;
                                fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                            }
                            else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                        }
                        fprintf(pDaScrivere, "\t tb_rst <= '0';\n"
                                             "\t wait for c_CLOCK_PERIOD;\n");
                    }
                }
                fprintf(pDaScrivere, "\t i <= std_logic_vector(to_unsigned( %d, %d));\n"
                                     "\n "
                                     "\n ", i, num_bit);
                if (1==add_wait)
                {
                    if (1==rnd_wait)
                    {
                        rnd_val= (rand() % time_wait) + 1;
                        fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                    }
                    else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                }
                fprintf(pDaScrivere, "\t tb_start <= '1';\n"
                                     "\t wait for c_CLOCK_PERIOD;\n");
                if (1==rst_middle_no_change)
                {
                    if (0==((i) % b))
                    {
                        if (1==b_read) fprintf(pDaScrivere, "\t wait for %d ns;\n", 2*(tot_pixel[i] * (periodo_clock-2)));
                        else fprintf(pDaScrivere, "\t wait for %d ns;\n", ((3 * tot_pixel[i] * periodo_clock) +((tot_pixel[i] % 2) * periodo_clock)) + 2 * periodo_clock);

                        fprintf(pDaScrivere, "\t tb_rst <= '1';\n"
                                             "\t wait for c_CLOCK_PERIOD;\n");
                        if (1==add_wait)
                        {
                            if (1==rnd_wait)
                            {
                                rnd_val= (rand() % time_wait) + 1;
                                fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                            }
                            else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                        }
                        fprintf(pDaScrivere, "\t tb_rst <= '0';\n");
                    }
                }
                if (1==rst_middle_change)
                {
                    if (((i + 1) < num_imm_succ) && (0 == (i % c)))
                    {
                        if (1==c_read) fprintf(pDaScrivere, "\t wait for %d ns;\n", 2*(tot_pixel[i] * (periodo_clock-2)));
                        else fprintf(pDaScrivere, "\t wait for %d ns;\n", ((3 * tot_pixel[i] * periodo_clock) +((tot_pixel[i] % 2) * periodo_clock)) + 2 * periodo_clock);
                        to_be_counted[i] = 0;
                        i++;
                        fprintf(pDaScrivere, "\t tb_rst <= '1';\n"
                                             "\t wait for c_CLOCK_PERIOD;\n"
                                             "\t i <= std_logic_vector(to_unsigned( %d, %d));\n"
                                             "\n "
                                             "\n ", i, num_bit);
                        if (1==add_wait)
                        {
                            if (1==rnd_wait)
                            {
                                rnd_val= (rand() % time_wait) + 1;
                                fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                            }
                            else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                        }
                        fprintf(pDaScrivere, "\t tb_rst <= '0';\n");
                    }
                }
                if ((1==rst_middle_stop) && (0 == (i % d)))
                {
                    to_be_counted[i] = 0;
                    if (1==d_read) fprintf(pDaScrivere, "\t wait for %d ns;\n", 2*(tot_pixel[i] * (periodo_clock-2)));
                    else fprintf(pDaScrivere, "\t wait for %d ns;\n", ((3 * tot_pixel[i] * periodo_clock) +((tot_pixel[i] % 2) * periodo_clock)) + 2 * periodo_clock);

                    fprintf(pDaScrivere, "\t tb_rst <= '1';\n"
                                         "\t wait for c_CLOCK_PERIOD;\n"
                                         "\t tb_start <= '0';\n"
                                         "\t wait for c_CLOCK_PERIOD;\n"
                                         "\t tb_rst <= '0';\n");
                }
                else
                {
                    fprintf(pDaScrivere, "\t wait until tb_done = '1';\n"
                                         "\t wait for c_CLOCK_PERIOD;\n"
                                         "\t tb_start <= '0';\n"
                                         "\t wait until tb_done = '0';\n");
                }

                if (1==add_wait)
                {
                    if (1==rnd_wait)
                    {
                        rnd_val= (rand() % time_wait) + 1;
                        fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                    }
                    else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                }
            }
        }


        if (1==rst_after)
        {
            if (0==(i % a))
            {
                fprintf(pDaScrivere, "\t wait for c_CLOCK_PERIOD;\n"
                                     "\t tb_rst <= '1';\n"
                                     "\t wait for c_CLOCK_PERIOD;\n");
                if (1==add_wait)
                {
                    if (1==rnd_wait)
                    {
                        rnd_val= (rand() % time_wait) + 1;
                        fprintf(pDaScrivere, "\t wait for %d ns;\n", rnd_val);
                    }
                    else fprintf(pDaScrivere, "\t wait for %d ns;\n", time_wait);
                }
                fprintf(pDaScrivere, "\t tb_rst <= '0';\n"
                                     "\t wait for c_CLOCK_PERIOD;\n");
            }
        }


        fprintf(pDaScrivere, "\n\n\n");


        //CALCOLO SHIFT LEVEL
        for(i=0; i<num_imm_succ; i++)
        {
            delta_value[i]=(val_max[i]-val_min[i])+1;
            if (1==delta_value[i]) shift_lvl[i]=8;
            else if (delta_value[i]>=2 && delta_value[i]<=3) shift_lvl[i]=7;
            else if (delta_value[i]>=4 && delta_value[i]<=7) shift_lvl[i]=6;
            else if (delta_value[i]>=8 && delta_value[i]<=15) shift_lvl[i]=5;
            else if (delta_value[i]>=16 && delta_value[i]<=31) shift_lvl[i]=4;
            else if (delta_value[i]>=32 && delta_value[i]<=63) shift_lvl[i]=3;
            else if (delta_value[i]>=64 && delta_value[i]<=127) shift_lvl[i]=2;
            else if (delta_value[i]>=128 && delta_value[i]<=255) shift_lvl[i]=1;
            else shift_lvl[i]=0;
        }


        //CALCOLO VALORE PIXEL FINALE
        for (j=0; j<num_imm_succ; j++)
        {
            for(i=0; i<tot_pixel[j]; i++)
            {
                temp_pixel=(immagine[j][i]-val_min[j])<<shift_lvl[j];
                if (temp_pixel>255) immagine[j][i]=255;
                else immagine[j][i]=temp_pixel;
            }
        }


        //ASSERZIONI PER CONTROLLO
        for (j=0; j<num_imm_succ; j++)
        {
            if (1==to_be_counted[j])
            {
                for(i=0; i<tot_pixel[j]; i++)
                {
                    fprintf(pDaScrivere, "\t assert RAM%d(%d) = std_logic_vector(to_unsigned( %d, 8)) report \" TEST FALLITO (WORKING ZONE). Expected  %d  found \" & integer'image(to_integer(unsigned(RAM%d(%d))))  severity failure; \n ", j, i+(tot_pixel[j])+2, immagine[j][i], immagine[j][i], j, i+(tot_pixel[j])+2);
                }
                fprintf(pDaScrivere, "\n\n");
            }
        }


        //CONCLUSIONE CODICE VHDL
        fprintf(pDaScrivere, "\t assert false report \"Simulation Ended! TEST PASSATO\" severity failure;\n"
                             "end process test;\n"
                             "\n"
                             "end projecttb; \n"
                             "\n");

    }
    return (0);
}
