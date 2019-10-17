----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:20:05 10/11/2019 
-- Design Name: 
-- Module Name:    miROM - Behavioral 
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
USE ieee.numeric_std.ALL;
 
entity miROM is
generic( 
	addr_width:integer:= 8;
	addr_bits:integer:=3;
	data_width:integer:=14	
);

port (
	addr:in std_logic_vector(addr_bits-1 downto 0);
	data:out std_logic_vector(data_width-1 downto 0)
);

end miROM;

architecture Behavioral of miROM is

type rom_type is array(0 to addr_width-1) of
std_logic_vector(data_width-1 downto 0);

signal seg7:rom_type:=(
           "10101110011000", -- 0
           "00010010001001", -- 1
           "11111100000110", -- 2
           "01010100000100", -- 3
           "00000000001010", -- 4
           "00001001011010", -- 5
           "00011011011100", -- 6
           "00001001100110" -- 7
			  );

begin
data<=seg7(to_integer(unsigned(addr)));
end Behavioral;
