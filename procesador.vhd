library ieee;
use ieee.std_logic_1164.all;

entity procesador is 
port(clk,reset,cs: in std_logic;
	  op: out std_logic_vector(3 downto 0);
	  ins7s,a7s,b7s,op7s,r17s,r07s: out std_logic_vector(6 downto 0));
end entity;

architecture arq of procesador is

signal clk1Hz: std_logic;
signal inst_datos: std_logic_vector(15 downto 0);
signal saledo: std_logic_vector(3 downto 0);
signal A,B: std_logic_vector(2 downto 0);
signal R: std_logic_vector(3 downto 0);
signal op_s: std_logic_vector(1 downto 0);
signal ua_s,cin:std_logic;
signal dir_datos: std_logic_vector(3 downto 0);

begin
	
	cl1:entity work.relojlento(arq)
		 port map(clk,clk1Hz);

	fet:entity work.fetch(arqfetch)
		 port map(clk1Hz,reset,cs,inst_datos,ins7s,saledo);
	
	dec:entity work.dec(arqdec)
		 port map(inst_datos,A,B,op_s,ua_s,cin,op,dir_datos,cs,op7s);
		 
	exe:entity work.exec(arq)
		 port map(A,B,a7s,b7s,cin,ua_s&op_s,R,r17s,r07s);
		
	wrm:entity work.write_mem(arq)
		 port map(R,clk,clk1Hz,dir_datos);

end architecture;