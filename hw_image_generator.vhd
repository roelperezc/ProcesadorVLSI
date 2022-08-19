--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY hw_image_generator IS
  GENERIC(
   pixels_y :  INTEGER := 478;   --row that first color will persist until
   pixels_x :  INTEGER := 600);  --column that first color will persist until
  PORT(
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
	 d7s		: in 	std_logic_vector(6 downto 0);
	 pivR: in integer;
	 pivC: in integer);
    
	 END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS

 signal aSeg: integer:=10;
 signal lSeg:integer:=30;
 
 signal opcty: std_logic_vector(3 downto 0):="0001";

BEGIN
  PROCESS(disp_ena, row, column)
   
 BEGIN


 IF(disp_ena = '1') THEN        --display time
     

	              
      if ((row > pivR and row <pivR+aSeg) and (column>pivC+12 and column<pivC+12+lseg) and d7s(0)='1') THEN --segmento 0
			   red <= (OTHERS => '1');
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
		elsif ((row > pivR and row <pivR+aSeg) and (column>pivC+12 and column<pivC+12+lseg) and d7s(0)='0') THEN 
			   red <= opcty;
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
		elsif ((row > pivR+12 and row <pivR+12+lseg) and (column>pivC+44 and column<pivC+44+aseg) and d7s(1)='1') THEN --segmento 1
			   red <= (others => '1');
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
      elsif ((row > pivR+12 and row <pivR+12+lseg) and (column>pivC+44 and column<pivC+44+aseg) and d7s(1)='0') THEN 
			   red <= opcty;
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
		elsif ((row > pivR+56 and row <pivR+56+lseg) and (column>pivC+44 and column<pivC+44+aseg) and d7s(2)='1') THEN --segmento 2
			   red <= (others => '1');
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
      elsif ((row > pivR+56 and row <pivR+56+lseg) and (column>pivC+44 and column<pivC+44+aseg) and d7s(2)='0') THEN 
			   red <= opcty;
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
		elsif ((row > pivR+88 and row <pivR+88+aseg) and (column>pivC+12 and column<pivC+12+lseg) and d7s(3)='1') THEN --segmento 3
			   red <= (others => '1');
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
      elsif ((row > pivR+88 and row <pivR+88+aseg) and (column>pivC+12 and column<pivC+12+lseg) and d7s(3)='0') THEN 
			   red <= opcty;
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
		elsif ((row > pivR+56 and row <pivR+56+lseg) and (column>pivC and column<pivC+aseg) and d7s(4)='1') THEN --segmento 4
			   red <= (others => '1');
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
      elsif ((row > pivR+56 and row <pivR+56+lseg) and (column>pivC and column<pivC+aseg) and d7s(4)='0') THEN 
			   red <= opcty;
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
		elsif ((row > pivR+12 and row <pivR+12+lseg) and (column>pivC and column<pivC+aseg) and d7s(5)='1') THEN --segmento 5
			   red <= (others => '1');
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
      elsif ((row > pivR+12 and row <pivR+12+lseg) and (column>pivC and column<pivC+aseg) and d7s(5)='0') THEN 
			   red <= opcty;
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
		elsif ((row > pivR+44 and row <pivR+44+aseg) and (column>pivC+12 and column<pivC+12+lseg) and d7s(6)='1') THEN --segmento 5
			   red <= (others => '1');
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
      elsif ((row > pivR+44 and row <pivR+44+aseg) and (column>pivC+12 and column<pivC+12+lseg) and d7s(6)='0') THEN 
			   red <= opcty;
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');		
				
		else		
				red <= (OTHERS => '0');  --es el fondo
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
		end if;
	

	

END IF;  --del enable
  
  END PROCESS;
END behavior;