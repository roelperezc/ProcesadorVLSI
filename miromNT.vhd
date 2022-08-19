library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_UNSIGNED.all;

entity miromNT is
port(
	bus_dir: in std_logic_vector(3 downto 0);
	cs: in std_logic;
	bus_datos: out std_logic_vector (15 downto 0);
	ledfetch:out std_logic_vector (6 downto 0));
end miromNT;

architecture arqmiromNT of miromNT is

type memoria is array (15 downto 0) of std_logic_vector(15 downto 0);
signal mem_rom : memoria;
attribute ram_init_file : string;
attribute ram_init_file of mem_rom : signal is "instruc.mif";

signal dato: std_logic_vector(15 downto 0);

begin

  prom: process(bus_dir)
  begin
    dato <= mem_rom(conv_integer(bus_dir));
	end process prom;
	
	pbuf: process (dato,cs)
	begin
		if(cs='1') then
			bus_datos<=dato;
		else
			bus_datos <= (others=>'Z');
		end if;
	end process pbuf;
 
 --monitorear el numero de instruccion
	with  bus_dir select
		ledfetch<= "1000000" when "0000",
					  "1111001" when "0001",
					  "0100100" when "0010",
					  "0110000" when "0011",
					  "0011001" when "0100",
					  "0010010" when "0101",
					  "0000010" when "0110",
					  "1111000" when "0111",
					  "0000000" when "1000",
					  "0010000" when "1001",----
					  "0001000" when "1010",
					  "0000011" when "1011",
					  "1000110" when "1100",
					  "0100001" when "1101",
					  "0000110" when "1110",
					  "0001110" when "1111",
					  "1111111" when others;
end arqmiromNT;
