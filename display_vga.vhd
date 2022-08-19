library ieee;
use ieee.std_logic_1164.all;

entity display_vga is
port(input_clk:  in std_logic;  --for this example is 50MHz
	  d7s_A,ins7s : in  std_logic_vector(6 downto 0); -- A
	  auxB : in  std_logic_vector(6 downto 0); -- B
	  op: in std_logic_vector(3 downto 0); -- Type of Operation
	  d7s_R0,d7s_R1: in std_logic_vector(6 downto 0); -- Result A & B

	  R			: out std_logic_vector (3 downto 0);
	  G			: out std_logic_vector (3 downto 0);
	  B			: out std_logic_vector (3 downto 0);
	  HS			: out std_logic;
	  VS			: out std_logic);
end entity;

architecture arq of display_vga is
signal pix_clock: STD_LOGIC;
signal disp_ena  : STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
signal column    : INTEGER;    --horizontal pixel coordinate
signal row       : INTEGER;    --vertical pixel coordinate
--signal auxB: std_logic_vector(6 downto 0);
--signal op: std_logic_vector(3 downto 0):= "0000";
signal d7s_B,d7s_Uno: std_logic_vector(6 downto 0);
signal d_OpPrincipal, d_OpSec: std_logic_vector(5 downto 0);
signal rINS,gINS,bINS: std_logic_vector(3 downto 0);
signal rA,gA,bA: std_logic_vector(3 downto 0);
signal rB,gB,bB: std_logic_vector(3 downto 0);
signal rOP1,gOP1,bOP1: std_logic_vector(3 downto 0);
signal rOP2,gOP2,bOP2: std_logic_vector(3 downto 0);
signal rUno,gUno,bUno: std_logic_vector(3 downto 0);
signal rIgual,gIgual,bIgual: std_logic_vector(3 downto 0);
signal rR0,gR0,bR0: std_logic_vector(3 downto 0);
signal rR1,gR1,bR1: std_logic_vector(3 downto 0);

begin

VGAclk: entity work.Gen25MHz(behavior)  port map(input_clk,pix_clock);
												
controllerVGA: entity work.vga_controller (behavior) port map 
( pix_clock, '1', HS, VS, disp_ena, column,row);


	
-------------ATENCIÓN: INICIA MUX DE PRUEBA ---------------

--muxB_d7s: entity work.bcd7seg(arcbcd7seg) port map("0010",auxB);  -- numero b

--muxA_d7s: entity work.bcd7seg(arcbcd7seg) port map("0001",d7s_A); -- numeroA

--muxR0_d7s: entity work.bcd7seg(arcbcd7seg) port map("0011",d7s_R0); -- unidades -- answers

--muxR1_d7s: entity work.bcd7seg(arcbcd7seg) port map("0011",d7s_R1); -- decenas -- answers

-------------ATENCIÓN: TERMINA MUX DE PRUEBA------------------



operador: entity work.interpreterOperador(behavior) port map(op,auxB,d7s_Uno,d7s_B, -- operador alu
	d_OpPrincipal,d_OpSec);

displayINS: entity work.hw_image_generator (behavior) port map 
(disp_ena, row, column, rINS, gINS, bINS,not ins7s,100,0); --row,column
	
displayA: entity work.hw_image_generator (behavior) port map 
(disp_ena, row, column, rA, gA, bA,not d7s_A,100,60); --row,column

displayB: entity work.hw_image_generator (behavior) port map 
(disp_ena, row, column, rB, gB, bB,not d7s_B,100,200); --row,column

displayOp1: entity work.hw_image_generator_OP (behavior) port map 
(disp_ena, row, column, rOP1, gOP1, bOP1,d_OpPrincipal,100,130); --row,column

displayOp2: entity work.hw_image_generator_OP (behavior) port map 
(disp_ena, row, column, rOP2, gOP2, bOP2,d_OpSec,100,270); --row,column

displayUnoExtra: entity work.hw_image_generator (behavior) port map 
(disp_ena, row, column, rUno, gUno, bUno,d7s_Uno,100,340); --row,column

displayR1: entity work.hw_image_generator (behavior) port map 
(disp_ena, row, column, rR1, gR1, bR1,not d7s_R1,100,480); --row,column

displayR0: entity work.hw_image_generator (behavior) port map 
(disp_ena, row, column, rR0, gR0, bR0,not d7s_R0,100,550); --row,column

displayIgual: entity work.hw_image_generator_OP (behavior) port map 
(disp_ena, row, column, rIgual, gIgual, bIgual,"010000",100,410); --row,column



R<= rINS or rA or rB or rOP1 or rOP2 or rUno or rR0 or rR1 or rIgual;
G<= gINS or gA or gB or gOP1 or gOP2 or gUno or gR0 or gR1 or gIgual;
B<= bINS or bA or bB or bOP1 or bOP2 or bUno or bR0 or bR1 or bIgual;

																			
end arq;