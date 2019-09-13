LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Tanque IS
	PORT (mclk: IN STD_LOGIC;
			H: IN STD_LOGIC;
			estados: OUT STD_LOGIC_VECTOR(5 downto 0));
END Tanque;

ARCHITECTURE Behavioral  OF Tanque IS
	TYPE estado IS(E0,E1,E2,E3);
	SIGNAL qt:estado;
	signal cont:STD_LOGIC_VECTOR(5 downto 0):="000000";
	
	
	BEGIN
	PROCESS (mclk)
		BEGIN
		IF RISING_EDGE(mclk)THEN
			CASE qt IS
				WHEN E0 =>
					cont<="000001";
					IF (H='0') THEN
						qt<=E1;
					ELSE
						qt<=E0;
					END IF;
				WHEN E1 =>
					cont<="010010";
					IF (H='0') THEN
						qt<=E1;
					ELSE
						qt<=E2;
					END IF;
				WHEN E2 =>
					cont<="000100";
					IF (H='0') THEN
						qt<=E3;
					ELSE
						qt<=E2;
					END IF;
				WHEN E3 =>
					cont<="101000";
					IF (H='0') THEN
						qt<=E3;
					ELSE
						qt<=E0;
					END IF;
			END CASE;
		END IF;
	END PROCESS;

	estados<=not cont;
END Behavioral;

