----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:12 10/12/2019 
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
	addr_width:integer:=40;
	addr_bits:integer:=6;
	data_width:integer:=9	
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
           "001011010", -- 0
           "001011010", -- 1
           "011011100", -- 2
           "011011100", -- 3
           "001011010", -- 4
           "001011010", -- 5
           "011011100", -- 6
           "011011100", -- 7
			  "010001001", -- 8
			  "010001001", -- 9
			  "010001001", -- 10
			  "010001001", -- 11
			  "010001001", -- 12
			  "010001001", -- 13
			  "010001001", -- 14
			  "010001001", -- 15
			  "001100110", -- 16
			  "100001010", -- 17
			  "001100110", -- 18
			  "100001010", -- 19
			  "001100110", -- 20
			  "100001010", -- 21
			  "001100110", -- 22
			  "100001010", -- 23
			  "010000100", -- 24
			  "010000100", -- 25
			  "010000100", -- 26
			  "010000100", -- 27
			  "100000100", -- 28
			  "100000100", -- 29
			  "100000100", -- 30
			  "100000100", -- 31
			  "000001010", -- 32
			  "000001010", -- 33
			  "000001010", -- 34
			  "000001010", -- 35
			  "000001010", -- 36
			  "000001010", -- 37
			  "000001010", -- 38
			  "000001010" -- 39 			  
			  );

begin
data<=seg7(to_integer(unsigned(addr)));
end Behavioral;

