library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity relojlento is
port( clkl: in std_logic;
		clkout: buffer std_logic:= '0');
end entity relojlento;

architecture arq of relojlento is
signal conteo: integer range 0 to 25000000;
begin
	process(clkl)
	begin
		if(clkl' event and clkl='1') then
			if(conteo=25000000) then
				conteo<=0;
				clkout<=not(clkout);
			else
				conteo<=conteo+1;
			end if;
		end if;
	end process;
end arq;
