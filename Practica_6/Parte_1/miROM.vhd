----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:42:28 10/05/2019 
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
	addr_width:integer:= 16;
	addr_bits:integer:=4;
	data_width:integer:=8	
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
           x"C0", -- 0
           x"F9", -- 1
           x"A4", -- 2
           x"B0", -- 3
           x"99", -- 4
           x"92", -- 5
           x"82", -- 6
           x"F8", -- 7
           x"80", -- 8
           x"98", -- 9
           x"88", -- A
           x"83", -- B
           x"C6", -- C
           x"A1", -- D
           x"86", -- E
           x"8E" -- F
			  );
begin
data<=seg7(to_integer(unsigned(addr)));
end Behavioral;

