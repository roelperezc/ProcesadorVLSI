library ieee;
use ieee.std_logic_1164.all;

entity fetch is
port(clk,reset,cs: in std_logic;
	  bus_datos: out std_logic_vector(15 downto 0);
	  ledfetch:out std_logic_vector(6 downto 0);
	  saledo:out std_logic_vector(3 downto 0));
end entity;

architecture arqfetch of fetch is
signal cable_bus_dir: std_logic_vector(3 downto 0);
begin
	saledo<=cable_bus_dir;		  

	u2: entity work.conta(arqconta)
		 port map (clk, reset,cable_bus_dir);
	u3: entity work.miromNT(arqmiromNT)
		 port map (cable_bus_dir,cs,bus_datos, ledfetch);
end arqfetch;
