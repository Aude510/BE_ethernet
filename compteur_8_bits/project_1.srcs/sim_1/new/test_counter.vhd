----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2023 16:36:42
-- Design Name: 
-- Module Name: test_counter - Behavioral
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

entity test_counter is
--  Port ( );
end test_counter;

architecture test of test_counter is
    
    COMPONENT bits8_counter is
    Port ( Din : in STD_LOGIC_VECTOR (7 downto 0);
           CK : in STD_LOGIC;
           RST : in STD_LOGIC;
           SENS : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           EN : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
    end COMPONENT;
    
    For all : bits8_counter use entity work.bits8_counter(behavioral);
    
    SIGNAL t_Din, t_Dout : std_logic_vector(7 downto 0);
    SIGNAL t_RST,t_EN,t_SENS,t_LOAD : std_logic;
    SIGNAL t_CK : std_logic := '0';
    
begin
    counter : bits8_counter PORT MAP(t_Din,t_CK,t_RST,t_SENS,t_LOAD,t_EN,t_Dout);
    t_CK<=not t_CK after 5 ns; -- run the clock 
    t_Din <= X"05";
    t_EN <= '0', '1' after 100 ns, '0' after 200 ns; --Count for 100 ns, Stop for 100 ns and then count again
    t_RST <= '0', '1' after 10 ns, '0' after 60 ns, '1' after 70ns; --RESET after 50 ns
    t_SENS <= '1', '0' after 200 ns, '1' after 400 ns; -- Count upward for the first 100 ms then stop then count downward for 200 ms then count upward again
    t_LOAD <= '0', '1' after 150 ns, '0' after 160 ns; --LOAD the value during the break (150 ns)
end test;
