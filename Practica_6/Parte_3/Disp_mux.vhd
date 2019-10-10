----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:55:12 10/09/2019 
-- Design Name: 
-- Module Name:    Disp_mux - Behavioral 
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
----------------------------------------------------------------------------------
entity Disp_mux is
    Port ( clk : in  STD_LOGIC;
           ln0 : in  STD_LOGIC_VECTOR (7 downto 0);
           ln1 : in  STD_LOGIC_VECTOR (7 downto 0);
           ln2 : in  STD_LOGIC_VECTOR (7 downto 0);
           ln3 : in  STD_LOGIC_VECTOR (7 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           dspls : out  STD_LOGIC_VECTOR (7 downto 0));
end Disp_mux;

architecture Behavioral of Disp_mux is

--reloj de 800Hz (50MHz/2)
constant N : integer := 18;
signal q_reg, q_next : unsigned (N-1 downto 0); ---add libr unsigned
signal sel : std_logic_vector (1 downto 0);

begin
--=============REGISTRO===============
	process (clk)
		begin
			if (clk'event and clk = '1')then
				q_reg <= q_next;
			end if;
		end process;
----------------------------------------
--==========CONTEO======================
	q_next <= q_reg +1;
----------------------------------------
--============MULTIPLEXOR=========================
	sel <= std_logic_vector(q_reg(N-1 downto N-2));
	process (sel)
		begin
			case sel is
				when "00" => an <= "1110" ; dspls <= ln0;
				when "01" => an <= "1101" ; dspls <= ln1;
				when "10" => an <= "1011" ; dspls <= ln2;
				when others => an <= "0111" ; dspls <= ln3;
			end case;
		end process;
-----------------------------------------------------
end Behavioral;

