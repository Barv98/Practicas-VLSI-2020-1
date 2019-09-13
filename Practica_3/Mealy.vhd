LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TanqueMealy IS
	PORT (mclk: IN STD_LOGIC;
			H: IN STD_LOGIC;
			reset: IN STD_LOGIC;
			estados: OUT STD_LOGIC_VECTOR(5 downto 0));
END TanqueMealy;

ARCHITECTURE Behavioral  OF TanqueMealy IS
	TYPE estado IS(E0,E1,E2,E3);
	SIGNAL edo_pres,edo_sig:estado;
	signal cont:STD_LOGIC_VECTOR(5 downto 0):="000000";
	
	BEGIN

	--Proceso asignacion de estados
	PROCESS (mclk,reset)
		BEGIN 
			IF (reset = '1') THEN
				edo_pres <= E0;
			ELSIF (RISING_EDGE(mclk)) THEN
				edo_pres <= edo_sig;
			END IF;
	END PROCESS;
	--Proceso de manejo de entradas/salidas
		PROCESS (edo_pres,H)
			BEGIN
			CASE edo_pres IS
				WHEN E0 =>
					IF (H='0') THEN
						
						cont<="000001";
						edo_sig<=E1;
					ELSE
						
						cont<="000001";
						edo_sig<=E0;
					END IF;
				WHEN E1 =>
					IF (H='0') THEN
						
						cont<="010010";
						edo_sig<=E1;
					ELSE
						
						cont<="010010";
						edo_sig<=E2;
					END IF;
				WHEN E2 =>
					IF (H='0') THEN
						
						cont<="000100";
						edo_sig<=E3;
					ELSE
						
						cont<="000100";
						edo_sig<=E2;
					END IF;
				WHEN E3 =>
					IF (H='0') THEN
					
						cont<="101000";
						edo_sig<=E3;
					ELSE
						cont<="101000";
						edo_sig<=E0;
					END IF;
		END CASE;
	END PROCESS;
	estados<= not cont;
END Behavioral;



