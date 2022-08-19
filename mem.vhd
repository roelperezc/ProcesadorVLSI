library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is 
port (
	 AddrWr  :  in std_logic_vector (3 downto 0);	--Dirección de escritura
	 AddrRd  :  in std_logic_vector (3 downto 0);	--Dirección de lectura
	 clkWr	:  in std_logic;
	 clkRd	:  in std_logic;
	 WrEN    :  in std_logic;
	 dataIn  :  in std_logic_vector(3 downto 0);	--Registro de entrada
	 dataOut :  out std_logic_vector(3 downto 0));	--Registro de salida
	 --ledmem:  buffer std_logic:='0');
end entity mem;

architecture arqmem of mem is
	type matrix is array (0 to 15) of std_logic_vector(3 downto 0); 
	signal       memory : matrix;
	signal    dataInBuf : std_logic_vector(3 downto 0); 
	signal AddressWrite : std_logic_vector (3 downto 0);
	signal  AddressRead : std_logic_vector (3 downto 0);
begin
--ledmem<=not ledmem;
	--Acceso de escritura
	process (clkWr)
	begin
		if (clkWr'event and clkWr='1' and wrEn='1') then
				   dataInBuf <= dataIn;
			AddressWrite <= AddrWr;
			memory(to_integer(unsigned(AddressWrite)))<=dataInBuf;
			--ledcarga<='1';--led de aviso de cargado
		end if;		
		
	end process;	

	
	--Acceso de lectura
	process (clkRd)
	begin
	
		if (clkRd'event and clkRd='1') then
		
			AddressRead <= AddrRd;
			dataOut<=memory(to_integer(unsigned(AddressRead))); 
			
		end if;	
	
	end process;

end architecture arqmem;
