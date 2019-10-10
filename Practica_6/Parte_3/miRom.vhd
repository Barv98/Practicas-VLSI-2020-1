----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:39:18 10/06/2019 
-- Design Name: 
-- Module Name:    miRom - Behavioral 
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
 
entity miRom is
generic( 
	addr_width:integer:= 16;
	addr_bits:integer:=4;
	data_width:integer:=8	
);

port (
	addr:in std_logic_vector(addr_bits-1 downto 0);
	data:out std_logic_vector(data_width-1 downto 0)
);

end miRom;

architecture Behavioral of miRom is

type rom_type is array(0 to addr_width-1) of
std_logic_vector(data_width-1 downto 0);

signal seg7:rom_type:=(
           x"C1", -- v
			  x"C7", -- L
           x"92", -- s
           x"E6", -- I
           x"BF", -- "-"
           x"A4", -- 2
           x"C0", -- 0
           x"A4", -- 2
           x"C0", -- 0
           x"BF", -- "-"
           x"F9", -- 1
           x"BF", -- "-"
           x"92", -- s
           x"E1", -- J
           x"83", -- B
           x"AF" -- R
			  );

begin
data<=seg7(to_integer(unsigned(addr)));
end Behavioral;

