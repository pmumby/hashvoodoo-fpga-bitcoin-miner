LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

USE IEEE.STD_LOGIC_UNSIGNED.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

-- ------------------------------
    ENTITY LOOPBACK_TEST IS
-- ------------------------------
   PORT( 
	CLOCK_50MHZ            	:	IN   STD_LOGIC ;         -- SYSTEM CLOCK
	RESET_N               	:  IN   STD_LOGIC ;    
  --	PB1                    	:  IN   STD_LOGIC ;
   IO_TEST_BUS_IN 	      :  IN   STD_LOGIC_VECTOR(3 DOWNTO 0);          
   IO_TEST_BUS_OUT         :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
 --	LOOPBACK_SINGLE_LED		:  OUT  STD_LOGIC;
	LOOPBACK_PASS		      :  OUT  STD_LOGIC
	
      );                           
                                  
END LOOPBACK_TEST;

--------------------------------
 ARCHITECTURE RTL OF LOOPBACK_TEST IS
--------------------------------
 SIGNAL INPUT_DELAY1         : STD_LOGIC_VECTOR(13 DOWNTO 0);
 SIGNAL INPUT_DELAY2         : STD_LOGIC_VECTOR(13 DOWNTO 0);
 SIGNAL INPUT_DELAY3         : STD_LOGIC_VECTOR(13 DOWNTO 0);
 SIGNAL INPUT_DELAY4         : STD_LOGIC_VECTOR(13 DOWNTO 0);
 
 SIGNAL PATTERN_REG1         : STD_LOGIC_VECTOR(15 DOWNTO 0) :=X"1234"; 
 SIGNAL PATTERN_REG2         : STD_LOGIC_VECTOR(15 DOWNTO 0) :=X"5678";
 SIGNAL PATTERN_REG3         : STD_LOGIC_VECTOR(15 DOWNTO 0) :=X"9012";
 SIGNAL PATTERN_REG4         : STD_LOGIC_VECTOR(15 DOWNTO 0) :=X"3456"; 
 
 SIGNAL REG_IO_TEST_BUS_IN           : STD_LOGIC_VECTOR(3 DOWNTO 0);
-- SIGNAL SINGLE_LED                   : STD_LOGIC; 
 SIGNAL STATUS               : STD_LOGIC_VECTOR(3 DOWNTO 0);
 --SIGNAL CHIPSCOPE_DATA       : STD_LOGIC_VECTOR(127  DOWNTO 0);
 SIGNAL LOOPBACK_RESULT      : STD_LOGIC;   --BUFFER FOR SIGNAL LOOPBACK_PASS
 SIGNAL CLOCK_DIV2           : STD_LOGIC;
--   -------------------------------------------------------------------
--   --
--   --  ICON core component declaration
--   --
--   -------------------------------------------------------------------
--   component chipscope_icon
--     port
--     (
--       control0    :   inout std_logic_vector(35 downto 0)
--     );
--   end component;
-- 
-- 
--   -------------------------------------------------------------------
--   --
--   --  ICON core signal declarations
--   --
--   -------------------------------------------------------------------
--   signal control0       : std_logic_vector(35 downto 0);
--  
--  
--   -------------------------------------------------------------------
--   --
--   --  ILA core component declaration
--   --
--   -------------------------------------------------------------------
--   component chipscope_ila_128
--      port
--      (
--        control     : inout    std_logic_vector(35 downto 0);
--        clk         : in    std_logic;
--        trig0       : in    std_logic_vector(127 downto 0)
--      );
--    end component;
--   
--     -------------------------------------------------------------------
--   --
--   --  ILA core signal declarations
--   --
--   -------------------------------------------------------------------
--   signal control    : std_logic_vector(35 downto 0);
--   signal CLK        : STD_LOGIC;
--   signal TRIG0      : STD_LOGIC_VECTOR(127 DOWNTO 0);
--    -------------------------------------------------------------------------------
-- 

begin


-- CHIP : PROCESS(CLOCK_50MHZ)
-- BEGIN
-- IF (CLOCK_50MHZ'event  AND CLOCK_50MHZ='1') THEN
--    CHIPSCOPE_DATA <=    X"00000000000000000000000000"                --127
--                      &  "00000000000"
--                      &  REG_IO_TEST_BUS_IN    --9-12
--                      &  CLOCK_DIV2            --8
--                      &  RESET_N               --7
--                      &  LOOPBACK_RESULT       --6
--                      &  PATTERN_REG3(15)      --5
--                      &  PATTERN_REG4(15)      --4
--                      &  STATUS(4 DOWNTO 1);   --3 TO 0                     
-- 
-- END IF;
-- END PROCESS CHIP;
-- 
-- -------------------------------------------------------------------
-- --
-- --  ICON core instance
-- --
-- -------------------------------------------------------------------
-- i_icon : chipscope_icon
--   port map
--   (
--     control0    => control0
--   );
-- 
-- -------------------------------------------------------------------
-- --
-- --  ILA core instance
-- --
-- -------------------------------------------------------------------
--   i_ila : chipscope_ila_128
--      port map
--      (
--        control   => control0,
--        clk       => CLOCK_50MHZ,
--        trig0     => CHIPSCOPE_DATA(127 downto 0)
--      );


--------------------------------------------------------------------

------------------------------------------------------------------------------------------
-------LOOPBACK TEST STARTS HERE --------------------------------------------------------
-----------------------------------------------------------------------------------------

CLOCK_DIVIDE : PROCESS(CLOCK_50MHZ)
BEGIN
IF (CLOCK_50MHZ'event  AND CLOCK_50MHZ='1') THEN
   CLOCK_DIV2   <= NOT CLOCK_DIV2;
END IF;

END PROCESS CLOCK_DIVIDE;


DATAFEED : PROCESS(RESET_N, CLOCK_50MHZ)
BEGIN
IF (RESET_N = '0') THEN                         --RESET=0 SETS UP STARTING VALUES
   PATTERN_REG1            <= X"1234";         
   PATTERN_REG2            <= X"5678";         
   PATTERN_REG3            <= X"9012";         
   PATTERN_REG4            <= X"3456";         

ELSIF (CLOCK_50MHZ'event  AND CLOCK_50MHZ='1') THEN                              -- RESET = 1 BEGINS COMPARISON PROGRAM
   PATTERN_REG1            <= PATTERN_REG1 (14 DOWNTO 0) & PATTERN_REG1(15) ;    --THIS CHUNK ROTATES THE SHIFT REGISTERS ROUND CONTINUALLY     
   PATTERN_REG2            <= PATTERN_REG2 (14 DOWNTO 0) & PATTERN_REG2(15) ;         
   PATTERN_REG3            <= PATTERN_REG3 (14 DOWNTO 0) & PATTERN_REG3(15) ;         
   PATTERN_REG4            <= PATTERN_REG4 (14 DOWNTO 0) & PATTERN_REG4(15) ;         

   IO_TEST_BUS_OUT(0)     <= PATTERN_REG1(15);        --THIS BIT PUTS THE 15TH BIT OF EACH PATTERN OUT ON ITS IO
   IO_TEST_BUS_OUT(1)     <= PATTERN_REG2(15);
   IO_TEST_BUS_OUT(2)     <= PATTERN_REG3(15);
   IO_TEST_BUS_OUT(3)     <= PATTERN_REG4(15);
 
   REG_IO_TEST_BUS_IN     <= IO_TEST_BUS_IN;              --INPUTS ARE EXAMINED

   STATUS(0)  <= (INPUT_DELAY1(13)  XOR PATTERN_REG1(15)); --compares 13th bit of input delay (which is actually the input bit) 
   STATUS(1)  <= (INPUT_DELAY2(13)  XOR PATTERN_REG2(15)); --with pattern reg 15 (which was the output bit)
   STATUS(2)  <= (INPUT_DELAY3(13)  XOR PATTERN_REG3(15));
   STATUS(3)  <= (INPUT_DELAY4(13)  XOR PATTERN_REG4(15));
   
END IF;
END PROCESS DATAFEED;

 DELAYER : PROCESS(CLOCK_50MHZ)      --NEED TO DELAY ONE CLOCK CYCLE BETWEEN SENDING OUT DATA AND READING IT IN
 BEGIN
 IF (CLOCK_50MHZ'event  AND CLOCK_50MHZ='1') THEN
    INPUT_DELAY1     <= INPUT_DELAY1(12 DOWNTO 0) & REG_IO_TEST_BUS_IN(0);     --CONCATENATES INPUT DELAY WITH IO INPUT SIGNAL BIT  (TOTAL 14 BITS)  
    INPUT_DELAY2     <= INPUT_DELAY2(12 DOWNTO 0) & REG_IO_TEST_BUS_IN(1);      --input signal bit becomes bit 13   
    INPUT_DELAY3     <= INPUT_DELAY3(12 DOWNTO 0) & REG_IO_TEST_BUS_IN(2);         
    INPUT_DELAY4     <= INPUT_DELAY4(12 DOWNTO 0) & REG_IO_TEST_BUS_IN(3);         
                                                                                      
 END IF;
 END PROCESS DELAYER;
--
TESTRESULT : PROCESS(CLOCK_50MHZ)
BEGIN
IF (CLOCK_50MHZ'event  AND CLOCK_50MHZ='1') THEN
   IF (STATUS = "0000") THEN
      LOOPBACK_RESULT <= '1';      --PASS CONDITION
   ELSE
      LOOPBACK_RESULT <= '0';      --FAIL CONDITION
   END IF;
END IF;
END PROCESS TESTRESULT;
--
LOOPBACK_PASS   <= LOOPBACK_RESULT;   -- LOOPBACK_RESULT IS VERSION USED BY CHIPSCOPE
--
END RTL;




