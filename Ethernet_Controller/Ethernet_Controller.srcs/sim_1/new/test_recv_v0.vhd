----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2023 16:03:58
-- Design Name: 
-- Module Name: test_recv_v0 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_recv_v0 is
--  Port ( );
end test_recv_v0;

architecture Behavioral of test_recv_v0 is

    component ethernet_controller is 
        Port ( RBYTEP : out STD_LOGIC;
                   RCLEANP : out STD_LOGIC;
                   RCVNGP : out STD_LOGIC;
                   RDONEP : out STD_LOGIC;
                   RENABP : in STD_LOGIC;
                   RSMATIP : out STD_LOGIC;
                   RSTARTP : out STD_LOGIC;
                   RDATAO : out STD_LOGIC_VECTOR (7 downto 0);
                   RDATAI : in STD_LOGIC_VECTOR (7 downto 0);
                   TABORTP : in STD_LOGIC;
                   TAVAILP : in STD_LOGIC;
                   TDONEP : out STD_LOGIC;
                   TFINISHP : in STD_LOGIC;
                   TREADDP : out STD_LOGIC;
                   TRNSMTP : out STD_LOGIC;
                   TSTARTP : out STD_LOGIC;
                   TSOCOLP : out STD_LOGIC;
                   TDATAO : out STD_LOGIC_VECTOR (7 downto 0);
                   TDATAI : in STD_LOGIC_VECTOR (7 downto 0);
                   RESETN : in STD_LOGIC;
                   CLK10I : in STD_LOGIC);
    end component; 
    
    For all : ethernet_controller use entity work.ethernet_controller(behavioral);
    
    signal t_rbytep, t_rcleanp, t_rcvngp, t_rdonep, t_renabp, t_rsmatip, t_rstartp : std_logic; 
    signal t_clk : std_logic := '1';
    signal t_rdatao, t_rdatai, t_tdatao, t_tdatai : std_logic_vector(7 downto 0); 
    signal t_tabortp, t_tavailp,t_tdonep,t_tfinishp,t_readdp,t_trnsmtp,t_tstartp,t_tsocolp,t_resetn : std_logic;
    constant period : time := 10ns;
   --
   --
   --
   --
begin
    controller : ethernet_controller port map(
    t_rbytep, t_rcleanp, t_rcvngp, t_rdonep, t_renabp, t_rsmatip, t_rstartp, t_rdatao, t_rdatai,
    t_tabortp, t_tavailp,t_tdonep,t_tfinishp,t_readdp,t_trnsmtp,t_tstartp,t_tsocolp,t_tdatao, t_tdatai, 
    t_resetn, t_clk); 
    t_clk<=not t_clk after 5 ns; -- horloge à f=100Mhz sinon simu trop courte
    
    t_resetn<='0', '1' after period, '0' after 2*period; 
    
    -----------------------Décommenter le test souhaité ----------------------------------------
    
    -------------------- COLLISION : tester transmission et réception en même temps -------------
--    t_renabp <= '0', '1' after 8*period; 
--    t_RDATAI <= X"00", X"AB" after 2*8*period, X"FF" after  3*8*period, X"AB" after 4*8*period, X"00" after 5*8*period;
--    -- X"EE" after 4*8*period, X"DD" after 5*8*period, 
--    --    X"CC" after 6*8*period, X"BB" after 7*8*period, X"AA" after 8*8*period, 
--    --    X"12" after 9*8*period,
--    --    X"AB" after 10*8*period, X"12" after 11*8*period; 
        
        
--     t_tavailp <= '0', '1' after 7*period,
--     '0' after 8*period;
           
--     t_tdatai <= X"00", X"EF" after 8*2*period, X"CD" after 8*3*period, X"AA" after 8*4*period, X"EF" after 8*5*period; 
           
--     t_tfinishp <= '0'; 
       
    
    -------------------- RECEPTION -----------------------------------
    
    ------------------ pour tester la réception, décommenter uniquement l'un des tests ------------
    
    -------------------- frame valide ----------------------------------
--    t_renabp <= '0', '1' after 8*period; 
--    t_RDATAI <= X"00", X"AB" after 2*8*period, X"FF" after  3*8*period, X"EE" after 4*8*period, X"DD" after 5*8*period, 
--        X"CC" after 6*8*period, X"BB" after 7*8*period, X"AA" after 8*8*period, 
--        X"12" after 9*8*period,
--        X"AB" after 10*8*period, X"12" after 11*8*period; 
    --------------------------------------------------------------------
    
    -------------------- frame invalide ----------------------------------
--    t_renabp <= '0', '1' after 8*period; 
--    t_RDATAI <= X"00", X"AB" after 2*8*period, X"FF" after  3*8*period, X"E0" after 4*8*period, X"DD" after 5*8*period, 
--         X"CC" after 6*8*period, X"BB" after 7*8*period, X"AA" after 8*8*period, 
--        X"12" after 9*8*period,
--        X"AB" after 10*8*period, X"12" after 11*8*period; 
    --------------------------------------------------------------------
        
     -------------------- renabp bloqué ----------------------------------
--    t_renabp <= '0', '1' after 8*period, '0' after 8*11*period; 
--    t_RDATAI <= X"00", X"AB" after 2*8*period, X"FF" after  3*8*period, X"EE" after 4*8*period, X"DD" after 5*8*period, 
--        X"CC" after 6*8*period, X"BB" after 7*8*period, X"AA" after 8*8*period, 
--        X"12" after 9*8*period,X"34" after 10*8*period, X"56" after 11*8*period,
--        X"AB" after 12*8*period; 
    --------------------------------------------------------------------
           
       
    
    
    
    --------------------- TRANSMISSION ---------------------------------

    ------------------ pour tester la transmission, décommenter uniquement l'un des tests ------------
    
        --------------------- 1ere transmission : réussie ---------------------------
    
--    t_tavailp <= '0', '1' after 7*period,'0' after 8*period;
--    -- adresse destination AACDEFAACDEF
--    t_tdatai <= X"00", X"EF" after 2*8*period, X"CD" after 3*8*period, X"AA" after 4*8*period, X"EF" after 5*8*period,
--        X"CD" after 6*8*period, X"AA" after 7*8*period; 
        
    -- on ne peut pas tester la fin de la transmission car la simulation est trop courte     
    
    ---------------------- 2eme transmission : avortée  ----------------------------
  
    t_tavailp <= '0', '1' after 7*period,'0' after 8*period;
      -- adresse destination AACDEFAACDEF
    t_tdatai <= X"00", X"AA" after 2*8*period, X"CD" after 3*8*period, X"EF" after 4*8*period, X"AA" after 5*8*period,
          X"CD" after 6*8*period, X"EF" after 7*8*period; 
   
    t_tabortp <= '1' after ((8*7)+2)*period, '0' after ((8*7)+3)*period; 
    
    
    
    -----------------------------------------------------------------------


end Behavioral;
