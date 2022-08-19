library ieee;
use ieee.std_logic_1164.all;

entity exec is
port(A,B:		in std_logic_vector(2 downto 0);
	  A7s,B7s:	out std_logic_vector(6 downto 0);
	  cin:		in std_logic;
	  sel:		in std_logic_vector(2 downto 0);
	  R:			out std_logic_vector(3 downto 0);
	  R17s,R07s:out std_logic_vector(6 downto 0));
end entity;

architecture arq of exec is
signal cout: std_logic;
signal sal: std_logic_vector(2 downto 0);
begin

	alu:entity work.alu(arq)
		 port map(A,B,cin,sel,cout,sal,R17s,R07s);	 
	R <= cout&sal;
	
	with  A select
		A7s <=  "1000000" when "000",
				  "1111001" when "001",
				  "0100100" when "010",
				  "0110000" when "011",
				  "0011001" when "100",
				  "0010010" when "101",
				  "0000010" when "110",
				  "1111000" when "111",
				  "1111111" when others;			  
	with  B select
		B7s <=  "1000000" when "000",
				  "1111001" when "001",
				  "0100100" when "010",
				  "0110000" when "011",
				  "0011001" when "100",
				  "0010010" when "101",
				  "0000010" when "110",
				  "1111000" when "111",
				  "1111111" when others;

end architecture;