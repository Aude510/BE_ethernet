----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.03.2023 18:15:16
-- Design Name: 
-- Module Name: ethernet_controller - Behavioral
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
use IEEE.std_logic_1164.ALL; 
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ethernet_controller is
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

end ethernet_controller;

architecture Behavioral of ethernet_controller is

constant NOADDR : std_logic_vector (47 downto 0) := X"AABBCCDDEEFF"; 
signal randomNumberGenerator : std_logic_vector (1 downto 0) := "11"; 


--------------- signaux auxiliaires réception ---------------------
signal AuxRCVNGP : std_logic := '0'; 
signal AuxRSMATIP : std_logic := '0'; 
signal CheckingAddress : std_logic := '0'; -- 0 false 
signal InvalidFrame : std_logic := '0'; -- 0 : false => frame valide 


--------------- signaux auxiliaires transmission  ---------------------
signal isTransmitting : std_logic := '0';
constant abortMission : std_logic_vector (7 downto 0) := X"AA";

--------------- signaux auxiliaires collision ----------------------
signal collisionDetected : std_logic := '0';
signal auxCollision : std_logic := '0';
signal BackOffTime : std_logic := '0';


begin
    receiver: process 
    variable NbBytesAddress : integer := 0;
    variable NbBitsReceived : integer := 0;
    begin
        wait until rising_edge(CLK10I);
        RSTARTP <= '0';
        RCLEANP <= '0';
        RBYTEP <= '0';
        RDONEP <= '0';
        if RESETN='1' then
        
            AuxRCVNGP<='0'; 
            AuxRSMATIP<='0';
            CheckingAddress<='0'; 
            InvalidFrame<='0'; 
            
            NbBytesAddress:=0;
            NbBitsReceived:=0; 
            
            RDATAO<=X"00";
            RCVNGP<='0'; 
            RSMATIP<='0'; 
               
        end if; 
        if RENABP='1' then -- on reçoit 
            if NbBitsReceived<7 then -- on attend un octet 
                NbBitsReceived := NbBitsReceived + 1;   
            else -- octet entier reçu 
                NbBitsReceived := 0;
                if RDATAI=X"AB" and AuxRCVNGP = '0' then --- début frame 
                    RSTARTP <= '1';
                    RCVNGP <= '1';
                    AuxRCVNGP <= '1';
                    CheckingAddress <= '1'; 
                elsif RDATAI=X"AB" and AuxRCVNGP = '1' then -- fin de frame 
                    if InvalidFrame='1' then 
                        RCLEANP<='1'; 
                    else 
                        RDONEP<='1'; 
                    end if; 
                    RSMATIP <= '0'; 
                    RCVNGP <= '0'; 
                    RDATAO<= X"00";
                    AuxRCVNGP <= '0'; 
                elsif (CheckingAddress = '1') then  
                -- on reçoit ET on est encore en train de checker l'adresse 
                    if RDATAI/=NOADDR(NbBytesAddress*8 +7 downto NbBytesAddress*8) then 
                        InvalidFrame <= '1'; 
                    end if; 
                    NbBytesAddress := NbBytesAddress +1;  
                    if NbBytesAddress=6 then 
                        NbBytesAddress := 0;
                        CheckingAddress <= '0'; 
                        if InvalidFrame='0' then 
                            RSMATIP <= '1'; 
                            AuxRSMATIP <= '1';
                        else 
                            RSMATIP <= '0'; 
                            AuxRSMATIP <= '0';
                        end if;  
                    end if; 
                elsif AuxRCVNGP='1' and (InvalidFrame='0') then -- octet disponible pour l'host
                    RBYTEP <= '1'; 
                    RDATAO <= RDATAI;  
                end if;            
            end if;
        end if;
    end process receiver;
    
    transmitter: process
    variable NbBitsReceived : integer := 0;
    variable AbortNbBits : integer := 0;
    variable NbByteSent : integer := 0;
    variable NbClkBackOff : integer := 0;
    begin
        wait until rising_edge(CLK10I);
        TDONEP <= '0';
        TREADDP <= '0';
        TSTARTP <= '0';
        TSOCOLP<='0'; 
        if RESETN='1' then -- reset ou collision : on arrête de transmettre 
            
            isTransmitting<='0'; 
                
            NbBitsReceived:=0;
            AbortNbBits:=0; 
                
            TDATAO<=X"00";
            TRNSMTP<='0';                    
        end if; 
        
        if CollisionDetected ='1' then
            isTransmitting <= '0';
            TRNSMTP<='0';
        end if;
        
        
        
        if NbClkBackOff >0 then
            NbClkBackOff := NbClkBackOff -1;
            if NbClkBackOff = 0 then
                isTransmitting <= '1';
                TRNSMTP<='1';
                BackOffTime<='0';
            end if;
        end if;
        
        if BackOffTime = '1' then
            NbClkBackOff := to_integer(unsigned(randomNumberGenerator));
            BackOffTime<='0';
            TDATAO<=X"00";
        end if;
        
        if TAVAILP = '1' and isTransmitting = '0' then -- début transmission 
            isTransmitting <= '1';
            TSTARTP <= '1';
            TRNSMTP <= '1';
            
        end if;
        
        if isTransmitting='1' then
            if TFINISHP = '1' then -- transmission terminée 
                TDONEP <='1';
                NbByteSent := 0;
                isTransmitting <= '0'; 
                TRNSMTP <= '0'; 
            elsif TABORTP = '1' then -- abort transmission 
                TDONEP<='1';
                TSOCOLP<='1'; 
                NbByteSent := 0;
                AbortNbBits := AbortNbBits + 1;
            elsif AbortNbBits>0 then -- abort transmission en cours 
                AbortNbBits := AbortNbBits + 1;
                if AbortNbBits mod 7 = 0 then -- on a un octet complet de la séquence d'abort à envoyer 
                    TDATAO<= AbortMission;
                end if;
                
                if AbortNbBits = 39 then -- on a déjà envoyé 4 octets de la séquence d'abort, on arrête 
                    AbortNbBits := 0;
                    isTransmitting <= '0'; 
                    TRNSMTP <= '0'; 
                    TDATAO <= X"00"; 
                end if;
            elsif NbBitsReceived<7 then -- on attend 8 ticks d'horloge 
                NbBitsReceived := NbBitsReceived + 1;   
            else -- un octet entier à transmettre
                if NbByteSent=0 then
                     TDATAO<=X"AB";
                     TREADDP <= '1';
                elsif NbByteSent>6 and NbByteSent<13 then
                    TDATAO<=NOADDR((NbByteSent-7)*8 +7 downto (NbByteSent-7)*8);
                else
                    TDATAO<=TDATAI;
                    TREADDP <= '1';
                end if;
                NbBitsReceived := 0;   
                NbByteSent:=NbByteSent+1;
            end if;
  
        end if;
    end process transmitter;
    

    collision: process 
    variable NbShift : integer := 0; 
    begin
        wait until rising_edge(CLK10I);
        if AuxRCVNGP='1' and isTransmitting='1' then -- collision : on arrête de transmettre 
            collisionDetected<='1';
        elsif collisionDetected = '1' then
            auxCollision <= randomNumberGenerator(0) xor randomNumberGenerator(1);
            randomNumberGenerator(1 downto 0)<= auxCollision & randomNumberGenerator(1 downto 1);
            NbShift := NbShift + 1; 
       
        elsif NbShift = 2 then
            BackOffTime <= '1';
            collisionDetected<='0';
        end if;
        

    
    end process collision; 
    
    
        
    
    
    
end Behavioral;
