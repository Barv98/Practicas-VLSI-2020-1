----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:50:35 09/21/2019 
-- Design Name: 
-- Module Name:    AUV - Behavioral 
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

entity AUV is
    Port ( mclk : in  STD_LOGIC;
			  reset:in STD_LOGIC;
           sd : in  STD_LOGIC;
           si : in  STD_LOGIC;
           estadoIni : in  STD_LOGIC_VECTOR (3 downto 0);
           leds : out  STD_LOGIC_VECTOR (3 downto 0);
           display  : out  STD_LOGIC_VECTOR (7 downto 0));
end AUV;

architecture Behavioral of AUV is
signal delay: integer range 0 to 64000000:=0; -- Reloj base 64 MHz
signal div,aux: std_logic:='0';
TYPE estado IS(E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11);
SIGNAL qt,qi:estado;
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


PROCESS (div,qt,si,sd,reset,estadoIni,aux)
		BEGIN
		IF(reset='1')then
			 qt<=qi;
			 aux<='0';
		ELSIF RISING_EDGE(div)THEN
		if(aux='0')then
			aux<='1';
			case estadoIni is
         when "0000"=>qi<=E0; -- 0
			qt<=E0;
         when  "0001"=>qi<=E1; -- 1
			qt<=E1;
          when  "0010"=>qi<=E2; -- 2
			 qt<=E2;
          when  "0011"=>qi<=E3; -- 3
			 qt<=E3;
          when  "0100"=>qi<=E4; -- 4
			 qt<=E4;
          when  "0101"=>qi<=E5; -- 5
			 qt<=E5;
          when  "0110"=>qi<=E6; -- 6
			 qt<=E6;
          when  "0111"=>qi<=E7; -- 7
			 qt<=E7;
          when  "1000"=>qi<=E8; -- 8
			 qt<=E8;
          when  "1001"=>qi<=E9; -- 9
			 qt<=E9;
           when "1010"=>qi<=E10; -- A
			  qt<=E10;
           when "1011"=>qi<=E11; -- B    
				qt<=E11;
            when others =>qi<=E0; -- Nada
				qt<=E0;
        end case;
		else
			CASE qt IS
				WHEN E0 =>
					leds<="1000";
					display <= x"C0";--0
					IF (si='0') THEN
						 IF(sd='1')THEN
							qt<=E1;
						 ELSE
							leds<="1000";
							qt<=E0;
						 end if;
					ELSE
						IF(sd='1')THEN
							qt<=E5;
						 ELSE
							qt<=E3;
						 end if;
					END IF;
				WHEN E1 =>
					leds<="0100";
					display <= x"F9";--1
					qt<=E2;
				WHEN E2 =>
					leds<="0001";
					display <= x"A4";--2
					qt<=E0;
				WHEN E3 =>
					leds<="0100";
					display <= x"B0";--3
					qt<=E4;
				WHEN E4 =>
					leds<="0010";
					display <= x"99";--4
					qt<=E0;
				WHEN E5 =>
					leds<="0100";
					display <= x"92";--5
					qt<=E6;
				WHEN E6 =>
					leds<="0001";
					display <= x"82";--6
					qt<=E7;
				WHEN E7 =>
					leds<="0001";
					display <= x"F8"; -- 7
					qt<=E8;
				WHEN E8 =>
					leds<="1000";
					display <= x"80"; -- 8
					qt<=E9;
				WHEN E9 =>
					leds<="1000";
					display <= x"98"; -- 9
					qt<=E10;
				WHEN E10 =>
					leds<="0010";
					display <= x"88"; -- A
					qt<=E11;
				WHEN E11 =>
					leds<="0010";
					display <= x"83"; -- B
					qt<=E0;
			END CASE;
			end if;
		END IF;
	END PROCESS;

end Behavioral;

