library ieee;
use ieee.std_logic_1164.all;

entity procesador_vga is 
port(clk,reset,cs: in std_logic;
	  R			: out std_logic_vector (3 downto 0);
	  G			: out std_logic_vector (3 downto 0);
	  B			: out std_logic_vector (3 downto 0);
	  HS			: out std_logic;
	  VS			: out std_logic);
end entity;

architecture arq of procesador_vga is

signal op: std_logic_vector(3 downto 0);
signal ins7s,a7s,b7s,op7s,r17s,r07s: std_logic_vector(6 downto 0);

begin
	
	malu:entity work.procesador(arq)
		  port map(clk,reset,cs,op,ins7s,a7s,b7s,op7s,r17s,r07s);
		  
	dvga:entity work.display_vga(arq)
		  port map(clk,a7s,ins7s,b7s,op,r07s,r17s,R,G,B,HS,VS);

end architecture;  