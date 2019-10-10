----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:43:36 10/06/2019 
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
   anOut:out std_logic_vector(3 downto 0);	
	disp:out std_logic_vector(7 downto 0)
);
end accs_miRom;

architecture Behavioral of accs_miRom is
COMPONENT miRom
	PORT(
		addr : IN std_logic_vector(3 downto 0);          
		data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

COMPONENT transfer
	PORT(
		Lds_in : IN std_logic_vector(7 downto 0);
		divi_in : IN std_logic;          
		Lds_out : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;

COMPONENT Disp_mux
	PORT(
		clk : IN std_logic;
		ln0 : IN std_logic_vector(7 downto 0);
		ln1 : IN std_logic_vector(7 downto 0);
		ln2 : IN std_logic_vector(7 downto 0);
		ln3 : IN std_logic_vector(7 downto 0);          
		an : OUT std_logic_vector(3 downto 0);
		dspls : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;



signal data1:std_logic_vector(7 downto 0);
signal delay: integer range 0 to 64000000:=0; -- Reloj base 64 MHz
signal div: std_logic:='0';
signal sw:std_logic_vector(3 downto 0):="0000";
signal s2,s3,s4,s5: std_logic_vector(7 downto 0);
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


contador: process(div,sw)
begin
		if rising_edge(div) then
			if(sw="1111") then 
				sw<="0000";
			else 
			   sw<=sw+1;
			end if;
		end if;
end process;

process(div,sw)
begin
		if rising_edge(div) then
			if(sw="1111") then 
				sw<="0000";
			else 
			   sw<=sw+1;
			end if;
		end if;
end process;
--disp<=data1;

Inst_miRom: miRom PORT MAP(addr =>sw ,data =>data1 );

Inst_transfer: transfer PORT MAP(
		Lds_in =>data1 ,
		divi_in =>div ,
		Lds_out => s2
	);
Inst_transfer1: transfer PORT MAP(
		Lds_in =>s2 ,
		divi_in =>div ,
		Lds_out => s3
	);
Inst_transfer2: transfer PORT MAP(
		Lds_in =>s3 ,
		divi_in =>div ,
		Lds_out => s4
	);
Inst_transfer3: transfer PORT MAP(
		Lds_in => s4,
		divi_in =>div ,
		Lds_out =>s5
	);
	
Inst_Disp_mux: Disp_mux PORT MAP(
		clk =>mclk ,
		ln0 =>s2 ,
		ln1 =>s3 ,
		ln2 =>s4 ,
		ln3 =>s5 ,
		an =>anOut ,
		dspls =>disp
);

end Behavioral;


