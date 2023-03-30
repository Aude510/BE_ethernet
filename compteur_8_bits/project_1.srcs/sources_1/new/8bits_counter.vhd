----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2023 15:58:30
-- Design Name: 
-- Module Name: 8bits_counter - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bits8_counter is
    Port ( Din : in STD_LOGIC_VECTOR (7 downto 0);
           CK : in STD_LOGIC;
           RST : in STD_LOGIC;
           SENS : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           EN : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
end bits8_counter;

architecture Behavioral of bits8_counter is
    signal aux : std_logic_vector(7 downto 0) ; 

begin
    process
    begin
        wait until rising_edge(CK);
        if RST='0' then
            aux <= (others => '0');
        elsif LOAD='1' then
            aux<=Din;
        elsif EN='0' then
            if SENS='0' then
                aux<=aux-1;
            else
                aux<=aux+1;
            end if; 
        end if;
    end process;
    Dout<=aux; 
end Behavioral;
