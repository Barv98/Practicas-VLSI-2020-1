
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY cont8b IS
	PORT (mclk: IN STD_LOGIC;
			reset: IN STD_LOGIC;
			ip: IN STD_LOGIC;
			LEDS: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END cont8b;

ARCHITECTURE Behavioral of cont8b IS
SIGNAL delay: INTEGER RANGE 0 TO 64000000:=0; --Esto debido al reloj base de 64 MHz
SIGNAL div: STD_LOGIC:='0';
SIGNAL cont: STD_LOGIC_VECTOR (7 DOWNTO 0):= "00000000";

BEGIN
--divisor @1 HZ
divisor: PROCESS(mclk) --frec divisor = Reloj Base (mclk) / N => N =(64MHz / 1 Hz) / 2 -1 = 3199999
BEGIN
	IF RISING_EDGE(mclk) THEN
		IF (delay = 31999999) THEN --el limite de cuenta para el Divisor 
			delay<=0;
			div<=not div;
		ELSE
			delay<=delay+1;
		END IF;
	END IF;
END PROCESS;
contador: PROCESS(div,cont)
BEGIN
	IF RISING_EDGE(div) THEN
		IF (reset='1') THEN
			cont<="00000000";
		ELSIF (cont<="11111111") THEN
			cont<="00000000";
		ELSIF (ip='0') THEN
			cont<=cont+0;
		ELSE
			cont<=cont+1;
		END IF;
	END IF;
END PROCESS;

LEDS <= not(cont); -- not debido a la conexion de logica negada de los leds
END Behavioral;
	
