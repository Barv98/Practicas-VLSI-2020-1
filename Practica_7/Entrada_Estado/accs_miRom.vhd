----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:43:02 10/11/2019 
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
   mclk:in std_logic;
	reset:in std_logic;
	A:in std_logic;
	B:in std_logic;
	C:in std_logic;
	disp:out std_logic_vector(7 downto 0);
	leds:out std_logic_vector(5 downto 0)
);
end accs_miRom;

architecture Behavioral of accs_miRom is
COMPONENT miROM
	PORT(
		addr : IN std_logic_vector(2 downto 0);          
		data : OUT std_logic_vector(13 downto 0)
		);
	END COMPONENT;

signal data1:std_logic_vector(13 downto 0);
signal delay: integer range 0 to 64000000:=0; -- Reloj base 64 MHz
signal div: std_logic:='0';
signal edP:std_logic_vector(2 downto 0):="000";

begin

divisor: process(mclk) --frec divisor = Reloj base(mclk) / N => N= (64MHz / 1 Hz)/2 -1 = 31999999
begin
		if rising_edge(mclk) then
			if(delay=31999999) then -- el limite de cuenta para el DIVISOR es N
				delay<=0;
				div<=not div;
			else 
			   delay<=delay+1;
			end if;
		end if;
end process;
mR:miRom port map(addr=>edP,data=>data1);

PROCESS (div,edP,data1,reset)
		BEGIN
		IF(reset='1')then
			 edP<="000";
		ELSIF RISING_EDGE(div)THEN
		case edP is
         when "000"=>
			disp<= x"C0";
			if(B='0') then
				edP<=data1(11 downto 9);
				leds<=data1(5 downto 0);
			elsif(B='1')then 
			     edP<=data1(8 downto 6);
				  leds<=data1(5 downto 0);
			end if;
         when "001"=>
			     disp<=x"F9";
				  edP<=data1(8 downto 6);
				  leds<=data1(5 downto 0);
			
          when "010"=>
			     disp<= x"A4"; -- 2
				 if(C='0') then
					edP<=data1(11 downto 9);
				   leds<=data1(5 downto 0);
				elsif(C='1')then 
					  edP<=data1(8 downto 6);
				     leds<=data1(5 downto 0);
				end if;
          when "011"=>
			  disp<=  x"B0"; -- 3
				 if(A='0') then
					edP<=data1(11 downto 9);
				   leds<=data1(5 downto 0);
				elsif(A='1')then 
					  edP<=data1(8 downto 6);
				     leds<=data1(5 downto 0);
				end if;
          when  "100"=>
			  disp<=  x"99";-- 4
			        edP<=data1(8 downto 6);
				     leds<=data1(5 downto 0);
          when  "101"=>
			   disp<=x"92"; -- 5
			  edP<=data1(8 downto 6);
			  leds<=data1(5 downto 0);
          when  "110"=>
			  disp<=x"82"; -- 6
			 edP<=data1(8 downto 6);
			 leds<=data1(5 downto 0);
          when  "111"=>
			  disp<= x"F8"; -- 7
			  edP<=data1(8 downto 6);
			  leds<=data1(5 downto 0);
			when others =>
			edP<="000";
          end case;
         end if;			  
	END PROCESS;
end Behavioral;


