----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:44:59 09/27/2019 
-- Design Name: 
-- Module Name:    PWM - Behavioral 
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

 

ENTITY PWM is

    generic( Max: natural := 500000);

    Port ( clk :  in  STD_LOGIC;--reloj de 50MHz

             selector :  in  STD_LOGIC_VECTOR (3 downto 0);--selecciona las 4 posiciones

             PWM :  out  STD_LOGIC);--terminal donde sale la señal de PWM

end PWM;
--  50000;  --representa a 1.00ms = 0°
--cuando el periodo es de 1ms el servo motor  esta en angulo 0°
-- 62500;  --representa a 1.25ms = 45°
-- 75000;  --representa a 1.50ms = 90°
-- 100000; --representa a 2.00ms = 180°
--cuando el periodo es de 2ms el servo motor  esta en angulo 180°

 

ARCHITECTURE PWM of PWM is

   signal PWM_Count: integer range 1 to Max;--500000;

begin

   process( clk, selector,PWM_Count)

          variable pos1: integer;  
          begin

         if rising_edge(clk)then
			 PWM_Count <= PWM_Count + 1;
          end if;
			 --si dividimos 50000 que es el rango de valores que puede tomar el contrador entre 15
			 --que es el maximo valor de nuestra entrada nos da 3332 apromimadamente  lo que quiere decir que nuestro servomotor
			 -- se podra situar en 15 diferentes posiciones,estas posiciones seran en angulos multiplos de 12
          pos1:=(CONV_INTEGER(selector)*3332)+ 50000;                       
		    if PWM_Count <= pos1 then 
			PWM <= '1';
			else                                      
			PWM <= '0';
			end if;
         end process;

end PWM;

