----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:00:47 10/05/2019 
-- Design Name: 
-- Module Name:    accs_miRom - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity accs_miRom is
port (
	sw:in std_logic_vector(3 downto 0);
	disp:out std_logic_vector(7 downto 0)
);
end accs_miRom;

architecture Behavioral of accs_miRom is
COMPONENT miROM
	PORT(
		addr : IN std_logic_vector(3 downto 0);          
		data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

signal data1:std_logic_vector(7 downto 0);

begin
mR:miRom port map(addr=>sw,data=>data1);
disp<=data1;
end Behavioral;

