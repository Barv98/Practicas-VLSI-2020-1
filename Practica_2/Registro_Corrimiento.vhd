LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Registro_Corrimiento IS
	PORT (mclk: IN STD_LOGIC;
			DIR: IN STD_LOGIC;
			RST: IN STD_LOGIC;
			LEDS: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END Registro_Corrimiento;

ARCHITECTURE Behavioral OF Registro_Corrimiento IS
	
		SIGNAL delay: INTEGER RANGE 0 TO 64000000:=0;                     --Esto debido al reloj base de 64 MHz
		SIGNAL div: STD_LOGIC:='0';
		SIGNAL corrimiento: STD_LOGIC_VECTOR (7 DOWNTO 0):= "10011000";
	
	BEGIN
	--divisor @1 HZ
	divisor: PROCESS(mclk)                                                --frec divisor = Reloj Base (mclk) / N => N =(64MHz / 1 Hz) / 2 -1 = 3199999
	BEGIN
		IF RISING_EDGE(mclk) THEN
			IF (delay = 31999999) THEN                                      --el limite de cuenta para el Divisor 
				delay<=0;
				div<=not div;
			ELSE
				delay<=delay+1;
			END IF;
		END IF;
	END PROCESS;
	
	registro: PROCESS (div,corrimiento)
	BEGIN 
			IF (RISING_EDGE(mclk)) THEN 
				IF (RST = '1') THEN
					corrimiento <= "10011001";
				ELSE
					IF (DIR = '1') THEN
						corrimiento <= corrimiento(0) & corrimiento (7 DOWNTO 1);
					ELSIF (DIR = '0') THEN	
						corrimiento <= corrimiento (6 DOWNTO 0) & corrimiento(7);
					END IF;
				END IF;
			END IF;
	END PROCESS;
	
	LEDS <= not (corrimiento);
	
	END Behavioral;

