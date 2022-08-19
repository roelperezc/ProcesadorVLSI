library ieee;
use ieee.std_logic_1164.all;

entity write_mem is
port(dato:	in std_logic_vector(3 downto 0);
	  clk,clk1Hz: 			in std_logic;
	  addr: 	in std_logic_vector(3 downto 0));
end entity;

architecture arq of write_mem is

begin

	mem:entity work.mem(arqmem)
		 port map(addr,addr,clk,clk,clk1Hz,dato);

end architecture;