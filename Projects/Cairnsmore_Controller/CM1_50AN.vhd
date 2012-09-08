--
--   E N T E R P O I N T   L T D
--
-----------------------------------------------------------------------------------------------
--
-- AUTHOR   : R FITZER
-- DATED    : 11/05/2012
--
-- COMMENTS : Cairnsmore 1 Test Program
--
--
-----------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY UNISIM;
USE UNISIM.VCOMPONENTS.ALL;
--
ENTITY TOPLEVEL IS
PORT (
	-- 25MHz CLOCK FROM OSCILLATOR
	CLOCK_25MHZ			      : IN STD_LOGIC;
	--  CLOCKS FROM CLOCK GENERATOR
-- 	CLK50					: IN STD_LOGIC;
-- 	CLK100				: IN STD_LOGIC;
-- 	CLK150				: IN STD_LOGIC;
-- 	CLK200				: IN STD_LOGIC;
   
--    CLK_180MHZ        :  IN    STD_LOGIC;
--    CLK_190MHZ        :  IN    STD_LOGIC;
--    CLK_200MHZ        :  IN    STD_LOGIC;
   CLK_180MHZ_210MHZ :  IN    STD_LOGIC;

	CLOCKS1_1			: OUT STD_LOGIC;
	CLOCKS1_2			: OUT STD_LOGIC;

	CLOCKS2_1			: OUT STD_LOGIC;
	CLOCKS2_2			: OUT STD_LOGIC;

	CLOCKS3_1			: OUT STD_LOGIC;
	CLOCKS3_2			: OUT STD_LOGIC;

	CLOCKS4_1			: OUT STD_LOGIC;
	CLOCKS4_2			: OUT STD_LOGIC;
	-- ARRAY CLOCKS
	-- DIP SWITCHES
	SWITCH1				: IN STD_LOGIC;
	SWITCH2				: IN STD_LOGIC;
	SWITCH3				: IN STD_LOGIC;
	SWITCH4				: IN STD_LOGIC;
	SWITCH5				: IN STD_LOGIC;
	SWITCH6				: IN STD_LOGIC;
--	SWITCH7				: IN STD_LOGIC;
	SWITCH8				: IN STD_LOGIC;
	-- POWER SUPPLY ENABLES
	EN_1V2_1				: OUT STD_LOGIC;
	EN_1V2_2				: OUT STD_LOGIC;
	EN_1V2_3				: OUT STD_LOGIC;
	EN_1V2_4				: OUT STD_LOGIC;
	ARRAY_3V3_EN		: OUT STD_LOGIC;
	-- SERIAL TO ARRAY FPGA 1
--	USB1_1				: OUT STD_LOGIC;		-- TXD TO 	ARRAY 1
--	USB1_2				: IN STD_LOGIC;		-- RXD FROM ARRAY 1
	-- SERIAL TO ARRAY FPGA 3
--	USB3_1				: OUT STD_LOGIC;		-- TXD TO 	ARRAY 3
--	USB3_2				: IN STD_LOGIC;		-- RXD FROM ARRAY 3
	-- JTAG DEDICATED - @ PORT 0
	USBC_0				: IN STD_LOGIC;		-- FTDI_TCK
	USBC_1				: INOUT STD_LOGIC;		-- FTDI_TDI
	USBC_2				: OUT STD_LOGIC;		-- FTDI_TDO
	USBC_3				: IN STD_LOGIC;		-- FTDI_TMS
	-- SPI DEDICATED - @ PORT 1
	USBC_8				: IN STD_LOGIC;		-- FTDI_SK
	USBC_9				: INOUT STD_LOGIC;		-- FTDI_DO
	USBC_10				: OUT STD_LOGIC;		-- FTDI_DI
	USBC_11				: IN STD_LOGIC;		-- FTDI_CS
	-- ICARUS STYLE PAIR @ PORT 1
	USBC_16				: IN STD_LOGIC;		-- FTDI_TXD
	USBC_17				: OUT STD_LOGIC;		-- FTDI_RXD
	-- ICARUS STYLE PAIR @ PORT 2
	USBC_24				: IN STD_LOGIC;		-- FTDI_TXD
	USBC_25				: OUT STD_LOGIC;		-- FTDI_RXD
	-- CLOCK GENERATOR
	CLK_SCLK          : OUT   STD_LOGIC;
	CLK_SDAT          : INOUT STD_LOGIC;
	-- JTAG DRIVE TO FPGA ARRAY ONLY WHEN SWITCH8 = 0
	JTAG_TCK				:  INOUT    STD_LOGIC;
	JTAG_TDI				:  INOUT    STD_LOGIC;
	JTAG_TDO				:  INOUT    STD_LOGIC;
	JTAG_TMS				:  INOUT    STD_LOGIC;
   
   
   --PRIMARY SERIAL COMS TO ARRAY
	USB1_4				: 	OUT		STD_LOGIC;		-- GUARD GND
	USB1_5		      :  OUT      STD_LOGIC;		--
	
	USB2_6				: 	OUT		STD_LOGIC;		-- GUARD GND
	USB2_5				:  OUT      STD_LOGIC;		--
	USB2_1				: 	OUT		STD_LOGIC;		-- GUARD GND
	
	USB3_4				: 	OUT		STD_LOGIC;		-- GUARD GND
	USB3_5				:  OUT      STD_LOGIC;		--
	USB4_1				: 	OUT		STD_LOGIC;		-- GUARD GND
	
	USB4_6				: 	OUT		STD_LOGIC;		-- GUARD GND
	USB4_5				:  OUT      STD_LOGIC;		--
	
   
   --DOWNSTREAM SERIAL COMS FROM ARRAY
	USB1_6		      :  OUT       STD_LOGIC;		--
--	USB2_6				:  IN       STD_LOGIC;		-- 
	USB3_6				:  OUT       STD_LOGIC;		-- 
--	USB4_6				:  IN       STD_LOGIC;		-- 
   
   --PRIMARY SERIAL COMS FROM ARRAY
	USB1_7		      :  IN      STD_LOGIC;		-- 
	USB2_7				:  IN      STD_LOGIC;		-- 
	USB3_7				:  IN      STD_LOGIC;		-- 
	USB4_7				:  IN      STD_LOGIC;		-- 

   --DOWNSTREAM SERIAL COMS TO ARRAY
	USB1_8				:  OUT      STD_LOGIC;		-- 
	USB2_8				:  OUT      STD_LOGIC;		-- 
	USB3_8				:  OUT      STD_LOGIC;		-- 
	USB4_8				:  OUT      STD_LOGIC;		-- 

   RESET_DEVICE_0    :  OUT      STD_LOGIC;
   RESET_DEVICE_1    :  OUT      STD_LOGIC;
   RESET_DEVICE_2    :  OUT      STD_LOGIC;
   RESET_DEVICE_3    :  OUT      STD_LOGIC;
  
	-- UPLINK 
	UP1	      		:  IN       STD_LOGIC;
	UP2			  		:  IN       STD_LOGIC;  
	UP3		   		:  IN       STD_LOGIC;
	UP4		   		:  IN       STD_LOGIC;
	-- DOWN LINK
	DOWN1	      		:  OUT      STD_LOGIC;
	DOWN2			  		:  OUT      STD_LOGIC;  
	DOWN3		   		:  OUT      STD_LOGIC;  
	DOWN4					:  OUT      STD_LOGIC;
   
   FAN_RPM1          :  IN       STD_LOGIC;
   FAN_RPM2          :  IN       STD_LOGIC;
   FAN_RPM3          :  IN       STD_LOGIC;
   FAN_RPM4          :  IN       STD_LOGIC;
   
	-- STATUS LED
	LED					:  OUT      STD_LOGIC
);
END TOPLEVEL;

-- # serial ports
-- #NET "RxD_PIN" LOC = C3;                #  INPUT     USB5
-- #NET "extminer_txd_PIN[0]" LOC = C1;    #  OUTPUT    USB6
-- #NET "TxD_PIN" LOC = F2;                #  OUTPUT    USB7
-- #NET "extminer_rxd_PIN[0]" LOC = F1;    #  INPUT     USB8



--
ARCHITECTURE RTL OF TOPLEVEL IS

CONSTANT STARTUP_TICK_VALUE   : INTEGER RANGE 0 TO 24999999:= 24999999;
--CONSTANT STARTUP_TICK_VALUE   :  INTEGER RANGE 0 TO 24999999:= 2499;     --FOR SIM
CONSTANT MINIMUM_FAN_COUNT    :  STD_LOGIC_VECTOR(15 DOWNTO 0):= X"0017";
--CONSTANT MINIMUM_FAN_COUNT    :  STD_LOGIC_VECTOR(15 DOWNTO 0):= X"0001";   --FOR SIM



--
 	COMPONENT TX
	PORT(
		CLOCK				: IN STD_LOGIC;
		RESET				: IN STD_LOGIC;
		TX_ENABLE		: IN STD_LOGIC;
		TX_CHAR			: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		SERIAL_OUT  	: OUT STD_LOGIC;
		TX_BUSY     	: OUT STD_LOGIC
		);
	END COMPONENT;                                                     
--
 	COMPONENT RX
	PORT(
		CLOCK       	: IN STD_LOGIC;
		RESET				: IN STD_LOGIC;
		SERIAL_IN   	: IN STD_LOGIC;
		RX_CHAR			: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		RX_VALID	   	: OUT STD_LOGIC
		);
	END COMPONENT;                                                     
--
 	COMPONENT PULSE
	PORT (
		CLOCK       	: IN STD_LOGIC;
		RESET				: IN STD_LOGIC;
		TRIGGER   		: IN STD_LOGIC;
		STRETCHED  		: OUT STD_LOGIC
	);
	END COMPONENT;   
--	
COMPONENT FLASHER
    PORT ( CLOCK 			: IN  STD_LOGIC;
           RESET_N 		: IN  STD_LOGIC;
           COUNT 			: IN  INTEGER RANGE 0 TO 250000000;
			  FLASHOUT		: OUT	STD_LOGIC
			  );
END COMPONENT;

COMPONENT CLOCKGEN_CONTROLLER
  PORT( 
		CLOCK          	:  IN 	STD_LOGIC;
      RST_N             :  IN 	STD_LOGIC;
      
      SWITCH_5_4              :  IN    STD_LOGIC_VECTOR( 1 DOWNTO 0);
      
      
      CLK_SCLK          :  OUT   STD_LOGIC;
      CLK_SDAT          :  INOUT STD_LOGIC;
		IDT_SCLK      				:  OUT   STD_LOGIC;
		IDT_SDAT_OUT  				:  OUT   STD_LOGIC;  
		IDT_SDAT_OE   				:  OUT   STD_LOGIC;  
		IDT_SDAT_IN					:  OUT 	STD_LOGIC;
		IDT_EN_200KHZ				: OUT STD_LOGIC
      );                           
END COMPONENT;
--
COMPONENT LOOPBACK_TEST
	PORT(CLOCK_50MHZ 	      : IN  STD_LOGIC ;        
			RESET_N           : IN  STD_LOGIC ;    
			IO_TEST_BUS_IN    : IN  STD_LOGIC_VECTOR(1 TO 4);          
			IO_TEST_BUS_OUT   : OUT STD_LOGIC_VECTOR(1 TO 4);
			LOOPBACK_PASS	   : OUT STD_LOGIC  -- '1' = PASS
			);
END COMPONENT;
--
CONSTANT	MESSAGE_LENGTH	: INTEGER := 24;	
CONSTANT LOWERCASE_R		: STD_LOGIC_VECTOR(7 DOWNTO 0) := X"72";
CONSTANT UPPERCASE_R		: STD_LOGIC_VECTOR(7 DOWNTO 0) := X"52";
CONSTANT LOWERCASE_A		: STD_LOGIC_VECTOR(7 DOWNTO 0) := X"61";
CONSTANT UPPERCASE_A		: STD_LOGIC_VECTOR(7 DOWNTO 0) := X"41";
CONSTANT LOWERCASE_G		: STD_LOGIC_VECTOR(7 DOWNTO 0) := X"67";
CONSTANT UPPERCASE_G		: STD_LOGIC_VECTOR(7 DOWNTO 0) := X"47";
--
TYPE MESSAGESTATES IS ( IDLE, 
                        GETCHAR,
                        WAIT_BUSY,
                        WAIT_NOT_BUSY,
                        REPEAT
                        );
--
TYPE RXSTATES IS ( IDLE,
						GETCHAR,
						CHECK_R,
						CHECK_A,
						CHECK_G
						);							
--
SIGNAL RESET                  :  STD_LOGIC;
SIGNAL FLASH				      :  STD_LOGIC;
SIGNAL RESET_N				      :  STD_LOGIC;
SIGNAL CLOCK_100MHZ		      :  STD_LOGIC;
--SIGNAL GCLOCKA				      :  STD_LOGIC;
--SIGNAL GCLOCKB				      :  STD_LOGIC;
--SIGNAL GCLOCKO				      :  STD_LOGIC;
SIGNAL GCLOCK				      :  STD_LOGIC;
SIGNAL SPI_DI				      :  STD_LOGIC;
SIGNAL SPI_SK				      :  STD_LOGIC;
SIGNAL SPI_CS				      :  STD_LOGIC;
SIGNAL SPI_DO				      :  STD_LOGIC;
SIGNAL SWITCH_STATE		      :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL IEN_1V2_1			      :  STD_LOGIC;
SIGNAL IEN_1V2_2			      :  STD_LOGIC;
SIGNAL IEN_1V2_3			      :  STD_LOGIC;
SIGNAL IEN_1V2_4			      :  STD_LOGIC;
SIGNAL IARRAY_3V3_EN		      :  STD_LOGIC;
SIGNAL LOOPIN1				      :  STD_LOGIC;
SIGNAL LOOPIN2				      :  STD_LOGIC;
SIGNAL LOOPIN3				      :  STD_LOGIC;
SIGNAL LOOPIN4				      :  STD_LOGIC;
SIGNAL LOOPOUT1			      :  STD_LOGIC;
SIGNAL LOOPOUT2			      :  STD_LOGIC;
SIGNAL LOOPOUT3			      :  STD_LOGIC;
SIGNAL LOOPOUT4			      :  STD_LOGIC;
SIGNAL LOOPBACK_PASS		      :  STD_LOGIC;
SIGNAL CLOCK_STOP			      :  STD_LOGIC;
SIGNAL TOGGLE_1KHZ            :  STD_LOGIC;
SIGNAL CLOCK_1KHZ             :  STD_LOGIC;
SIGNAL CLOCK_DIVIDE_COUNTER   :  INTEGER RANGE 0 TO 25000;
SIGNAL FREQUENCY_IS_100MHZ    :  STD_LOGIC;
SIGNAL COUNTER_1SEC           :  INTEGER RANGE 0 TO 24999999;
SIGNAL COUNTER_1SEC_TICK      :  STD_LOGIC;
SIGNAL POWER_STARTUP_N        :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL OP_CLK_PHASE           :  STD_LOGIC_VECTOR( 3 DOWNTO 0);
SIGNAL FREQUENCY_IS_50MHZ     :  STD_LOGIC;
SIGNAL RESET_COUNT            :  STD_LOGIC_VECTOR( 7 DOWNTO 0);
SIGNAL RESET_FROM_COUNT       :  STD_LOGIC;
SIGNAL FAN_COUNTER1           :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL FAN_COUNTER2           :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL FAN_COUNTER3           :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL FAN_COUNTER4           :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL FAN_COUNTER1_STORED    :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL FAN_COUNTER2_STORED    :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL FAN_COUNTER3_STORED    :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL FAN_COUNTER4_STORED    :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL TICK_1SEC              :  STD_LOGIC;
SIGNAL TICK_COUNTER           :  INTEGER RANGE 0 TO 24999999;
SIGNAL FAN_RPM1_SHIFT         :  STD_LOGIC_VECTOR( 3 DOWNTO 0);
SIGNAL FAN_RPM2_SHIFT         :  STD_LOGIC_VECTOR( 3 DOWNTO 0);
SIGNAL FAN_RPM3_SHIFT         :  STD_LOGIC_VECTOR( 3 DOWNTO 0);
SIGNAL FAN_RPM4_SHIFT         :  STD_LOGIC_VECTOR( 3 DOWNTO 0);
SIGNAL FAN1_IS_OK             :  STD_LOGIC;
SIGNAL FAN2_IS_OK             :  STD_LOGIC;
SIGNAL FAN3_IS_OK             :  STD_LOGIC;
SIGNAL FAN4_IS_OK             :  STD_LOGIC;
SIGNAL FAN_IS_RUNNING         :  STD_LOGIC;
--SIGNAL SWITCH4                :  STD_LOGIC;
--SIGNAL SWITCH5                :  STD_LOGIC;
SIGNAL INT_USBC_1             :  STD_LOGIC;
SIGNAL INT_USBC_9             :  STD_LOGIC;
SIGNAL INT_CLOCKS1_1          :  STD_LOGIC;
SIGNAL INT_CLOCKS2_1          :  STD_LOGIC;
SIGNAL INT_CLOCKS3_1          :  STD_LOGIC;
SIGNAL INT_CLOCKS4_1          :  STD_LOGIC;
SIGNAL INT_CLOCKS1_2          :  STD_LOGIC;
SIGNAL INT_CLOCKS2_2          :  STD_LOGIC;
SIGNAL INT_CLOCKS3_2          :  STD_LOGIC;
SIGNAL INT_CLOCKS4_2          :  STD_LOGIC;
SIGNAL FLASHER_COUNT          :  INTEGER RANGE 0 TO 250000000;
SIGNAL JTAG_TMS_EXTENDER      :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL INT_USB1_5             :  STD_LOGIC;
SIGNAL INT_USB2_5             :  STD_LOGIC;
SIGNAL INT_USB3_5             :  STD_LOGIC;
SIGNAL INT_USB4_5             :  STD_LOGIC;
SIGNAL CLOCK_ENABLE_PHASER    :  STD_LOGIC_VECTOR( 7 DOWNTO 0);
SIGNAL DATA_PHASE_000         :  STD_LOGIC;
SIGNAL DATA_PHASE_090         :  STD_LOGIC;
SIGNAL DATA_PHASE_180         :  STD_LOGIC;
SIGNAL DATA_PHASE_270         :  STD_LOGIC;
SIGNAL CLOCK_200MHZ_000_DEG   :  STD_LOGIC;
SIGNAL CLOCK_200MHZ_090_DEG   :  STD_LOGIC;
SIGNAL CLOCK_200MHZ_180_DEG   :  STD_LOGIC;
SIGNAL CLOCK_200MHZ_270_DEG   :  STD_LOGIC;
SIGNAL CLOCK_200MHZ_LOCKED    :  STD_LOGIC;
SIGNAL DATA_PHASE_180_ADV1    :  STD_LOGIC;
SIGNAL CLOCK_200MHZ           :  STD_LOGIC;
SIGNAL CLKIN_IBUFG_OUT        :  STD_LOGIC;   
SIGNAL REG_USB1_7             :  STD_LOGIC;   
SIGNAL REG_USB2_7             :  STD_LOGIC;   
SIGNAL REG_USB3_7             :  STD_LOGIC;   
SIGNAL REG_USB4_7             :  STD_LOGIC;   
SIGNAL SHIFT_REG_USB1_7       :  STD_LOGIC_VECTOR( 2 DOWNTO 0);   
SIGNAL SHIFT_REG_USB2_7       :  STD_LOGIC_VECTOR( 2 DOWNTO 0);   
SIGNAL SHIFT_REG_USB3_7       :  STD_LOGIC_VECTOR( 2 DOWNTO 0);   
SIGNAL SHIFT_REG_USB4_7       :  STD_LOGIC_VECTOR( 2 DOWNTO 0);   
SIGNAL DCM_NOT_LOCKED         :  STD_LOGIC;   
SIGNAL CLOCK_STOP_N           :  STD_LOGIC;
SIGNAL SWITCH_5_4          : STD_LOGIC_VECTOR( 1 DOWNTO 0);

--

component chipscope_icon
  PORT (
    CONTROL0 : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0));

end component;


component chipscope_ila
  PORT (
    CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    CLK : IN STD_LOGIC;
    TRIG0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0));

end component;

SIGNAL CHIPSCOPE_DATA          : STD_LOGIC_VECTOR(15 DOWNTO 0); 
SIGNAL CONTROL          : STD_LOGIC_VECTOR(35 DOWNTO 0);


COMPONENT CLOCKPHASE3 
   port ( CLKIN_IN         :  in    std_logic; 
          RST_IN           :  in    std_logic; 
          
          CLOCK_STOP       :  IN    STD_LOGIC;
          
          CLKIN_IBUFG_OUT  :  out   std_logic; 
          CLK0_OUT         :  out   std_logic; 
          CLK90_OUT        :  out   std_logic; 
          CLK180_OUT       :  out   std_logic; 
          CLK270_OUT       :  out   std_logic; 
          LOCKED_OUT       :  out   std_logic);
end COMPONENT;


BEGIN

--SWITCH4  <= '0';
--SWITCH5  <= '0';

CLOCK_STOP_N <= NOT CLOCK_STOP;

-- DCM1 : CLOCKPHASE3 
-- port MAP(CLKIN_IN          => CLK200               ,
--          RST_IN            => RESET                ,
--          CLOCK_STOP        => CLOCK_STOP           ,
--          CLKIN_IBUFG_OUT   => CLKIN_IBUFG_OUT      ,
--          CLK0_OUT          => CLOCK_200MHZ_000_DEG ,
--          CLK90_OUT         => CLOCK_200MHZ_090_DEG ,
--          CLK180_OUT        => CLOCK_200MHZ_180_DEG ,
--          CLK270_OUT        => CLOCK_200MHZ_270_DEG ,
--          LOCKED_OUT        => CLOCK_200MHZ_LOCKED  );
          
-- DCM_NOT_LOCKED <= NOT CLOCK_200MHZ_LOCKED;


-- --TEMP
-- CLKIN_IBUFG_OUT       <= CLK200;
-- CLOCK_200MHZ_000_DEG  <= CLK200;
-- CLOCK_200MHZ_090_DEG  <= CLK200;
-- CLOCK_200MHZ_180_DEG  <= CLK200;
-- CLOCK_200MHZ_270_DEG  <= CLK200;
-- DCM_NOT_LOCKED        <= '0';


-- OP_PHASER1 : PROCESS(RESET,CLOCK_200MHZ_000_DEG)
-- BEGIN
-- IF (RESET = '1') THEN
--    CLOCK_ENABLE_PHASER  <= "00001111";
--    DATA_PHASE_000       <= '0';
--    USB1_6	            <= '0';
-- --   USB1_5               <= '1';   --OUT
--    SHIFT_REG_USB1_7     <= "111";
--    REG_USB1_7           <= '1';
--    
-- --    USB2_6	         <= '0';
-- --    USB3_6	         <= '0';
-- --    USB4_6	         <= '0';
-- ELSIF (CLOCK_200MHZ_000_DEG'EVENT  AND CLOCK_200MHZ_000_DEG='1') THEN
--    CLOCK_ENABLE_PHASER  <= CLOCK_ENABLE_PHASER(6 DOWNTO 0) & CLOCK_ENABLE_PHASER(7);
--    DATA_PHASE_000       <= CLOCK_ENABLE_PHASER(7);
--    USB1_6	         <= DATA_PHASE_000;
-- 
-- --    --COM PORT ENABLED
-- --    IF (SWITCH5 = '0') THEN
-- --       USB1_5  <= USBC_0;   --OUT
-- --    --NOT ENABLED   
-- --    ELSE
-- --       USB1_5  <= '1';   --OUT
-- --    END IF;
--    
--    SHIFT_REG_USB1_7           <= SHIFT_REG_USB1_7(1 DOWNTO 0) & USB1_7;
--    
--    IF    (SHIFT_REG_USB1_7 = "111") THEN
--       REG_USB1_7 <= '1';   
--    ELSIF (SHIFT_REG_USB1_7 = "000") THEN   
--       REG_USB1_7 <= '0';
--    ELSE
--       REG_USB1_7 <= REG_USB1_7;
--    END IF;
--    
-- --    USB2_6	         <= DATA_PHASE_000;
-- --    USB3_6	         <= DATA_PHASE_000;
-- --    USB4_6	         <= DATA_PHASE_000;
--    
-- END IF;
-- END PROCESS OP_PHASER1;
-- 
-- 
-- OP_PHASER2 : PROCESS(RESET,CLOCK_200MHZ_090_DEG)
-- BEGIN
-- IF (RESET = '1') THEN
--    DATA_PHASE_090    <= '0';
--    USB2_6	         <= '0';
-- --    USB2_5            <= '1' ;   --OUT
--    SHIFT_REG_USB2_7  <= "111";
--    REG_USB2_7           <= '1';
-- --    REG_USB4_7        <= '1';   
-- 
-- ELSIF (CLOCK_200MHZ_090_DEG'EVENT  AND CLOCK_200MHZ_090_DEG='1') THEN
--    DATA_PHASE_090       <= DATA_PHASE_180_ADV1;
--    USB2_6	         <= DATA_PHASE_090;
-- 
-- --    --COM PORT ENABLED
-- --    IF (SWITCH5 = '0') THEN
-- --       USB2_5  <= USBC_8 ;   --OUT
-- --    --NOT ENABLED   
-- --    ELSE
-- --       USB2_5  <= '1' ;   --OUT
-- --    END IF;
--    
--    SHIFT_REG_USB2_7  <= SHIFT_REG_USB2_7(1 DOWNTO 0) & USB2_7;
--    
--    IF    (SHIFT_REG_USB2_7 = "111") THEN
--       REG_USB2_7 <= '1';   
--    ELSIF (SHIFT_REG_USB2_7 = "000") THEN   
--       REG_USB2_7 <= '0';
--    ELSE
--       REG_USB2_7 <= REG_USB2_7;
--    END IF;
--    
-- --    IF    (SHIFT_REG_USB4_7 = "111") THEN
-- --       REG_USB4_7 <= '1';   
-- --    ELSIF (SHIFT_REG_USB4_7 = "000") THEN   
-- --       REG_USB4_7 <= '0';
-- --    ELSE
-- --       REG_USB4_7 <= REG_USB4_7;
-- --    END IF;
-- --    
-- END IF;
-- END PROCESS OP_PHASER2;
-- 
-- 
-- OP_PHASER3 : PROCESS(RESET,CLOCK_200MHZ_180_DEG)
-- BEGIN
-- IF (RESET = '1') THEN
--    DATA_PHASE_180_ADV1  <= '0';
--    DATA_PHASE_180       <= '0';
--    USB3_6	            <= '0';
-- --    USB3_5               <= '1';   --OUT
--    SHIFT_REG_USB3_7     <= "111";
--    REG_USB3_7           <= '1';   
-- 
--    
-- ELSIF (CLOCK_200MHZ_180_DEG'EVENT  AND CLOCK_200MHZ_180_DEG='1') THEN
--    DATA_PHASE_180_ADV1  <= CLOCK_ENABLE_PHASER(7);
--    DATA_PHASE_180       <= DATA_PHASE_000;
--    USB3_6	         <= DATA_PHASE_180;
-- 
-- --    --COM PORT ENABLED
-- --    IF (SWITCH5 = '0') THEN
-- --       USB3_5  <= USBC_16;   --OUT
-- --    --NOT ENABLED   
-- --    ELSE
-- --       USB3_5  <= '1';   --OUT
-- --    END IF;  
--    
--    SHIFT_REG_USB3_7 <= SHIFT_REG_USB3_7(1 DOWNTO 0) & USB3_7;
--    
--    IF    (SHIFT_REG_USB3_7 = "111") THEN
--       REG_USB3_7 <= '1';   
--    ELSIF (SHIFT_REG_USB3_7 = "000") THEN   
--       REG_USB3_7 <= '0';
--    ELSE
--       REG_USB3_7 <= REG_USB3_7;
--    END IF;
--    
--    
-- 
-- END IF;
-- END PROCESS OP_PHASER3;
-- 
-- OP_PHASER4 : PROCESS(RESET,CLOCK_200MHZ_270_DEG)
-- BEGIN
-- IF (RESET = '1') THEN
--    DATA_PHASE_270    <= '0';
--    USB4_6	         <= '0';
-- --    USB4_5            <= '1' ;   --OUT
--    SHIFT_REG_USB4_7  <= "111";
--    REG_USB4_7        <= '1';   
-- 
-- ELSIF (CLOCK_200MHZ_270_DEG'EVENT  AND CLOCK_200MHZ_270_DEG='1') THEN
--    DATA_PHASE_270    <= DATA_PHASE_000;
--    USB4_6	         <= DATA_PHASE_270;
-- 
-- --    --COM PORT ENABLED
-- --    IF (SWITCH5 = '0') THEN
-- --       USB4_5  <= USBC_24 ;   --OUT
-- --    --NOT ENABLED   
-- --    ELSE
-- --       USB4_5  <= '1' ;   --OUT
-- --    END IF;
--    
--    SHIFT_REG_USB4_7 <= SHIFT_REG_USB4_7(1 DOWNTO 0) & USB4_7;
--    
--    IF    (SHIFT_REG_USB4_7 = "111") THEN
--       REG_USB4_7 <= '1';   
--    ELSIF (SHIFT_REG_USB4_7 = "000") THEN   
--       REG_USB4_7 <= '0';
--    ELSE
--       REG_USB4_7 <= REG_USB4_7;
--    END IF;
--    
-- 
-- END IF;
-- END PROCESS OP_PHASER4;

 
USB1_6 <= CLOCK_25MHZ;
USB2_6 <= CLOCK_25MHZ;
USB3_6 <= CLOCK_25MHZ;
USB4_6 <= CLOCK_25MHZ;
    
 

--CHIPSCOPE_DATA <=    USBC_0				
--                  &	USBC_1				
--                  &	USBC_3				
--                  &	USBC_8				
--                  &	USBC_9				
--                  &	USBC_11				
--                  &	USBC_16				
--                  &	USBC_24				
--                  &	USB1_6		      
--                  &	USB2_6				
--                  &	USB3_6				
--                  &	USB4_6				
--                  &	USB1_7		      
--                  &	USB2_7				
--                  &	USB3_7				
--                  &	USB4_7  ;				





--CHIP1 : chipscope_icon
--  port map (
--    CONTROL0 => CONTROL);
--
--CHIP2 : chipscope_ila
--  port map (
--    CONTROL => CONTROL,
--    CLK => GCLOCK,
--    TRIG0 => CHIPSCOPE_DATA);





MAKE_A_RESET : PROCESS(SWITCH1,CLOCK_25MHZ)
BEGIN
IF (SWITCH1 = '1')  THEN
   RESET_COUNT          <= X"00";
   RESET_FROM_COUNT     <= '1';
   
ELSIF (CLOCK_25MHZ'EVENT  AND CLOCK_25MHZ='1') THEN
   IF (RESET_COUNT = X"34") THEN
      RESET_COUNT          <= X"34";   
      RESET_FROM_COUNT     <= '0';
   ELSE
      RESET_COUNT          <= RESET_COUNT + 1;
      RESET_FROM_COUNT     <= '1';
   END IF;  
      
END IF;
END PROCESS MAKE_A_RESET;


RST : PROCESS(RESET_FROM_COUNT,CLOCK_25MHZ)
BEGIN
IF (RESET_FROM_COUNT = '1') THEN
   RESET_N <= '0';
ELSIF (CLOCK_25MHZ'EVENT  AND CLOCK_25MHZ='1') THEN
   RESET_N <= '1';
END IF;
END PROCESS RST;


RESET <= NOT RESET_N;

                 
FLASH_VAL : PROCESS(SWITCH_5_4)
BEGIN
   CASE SWITCH_5_4 IS
      WHEN "00"    => FLASHER_COUNT <=  6250000;
      WHEN "01"    => FLASHER_COUNT <= 12500000;
      WHEN "10"    => FLASHER_COUNT <= 25000000;
      WHEN  OTHERS => FLASHER_COUNT <= 50000000;
   END CASE;

END PROCESS FLASH_VAL;

--
-- CONFIDENCE TICKER
--
TCK : FLASHER
    PORT MAP ( 
		CLOCK 		=> CLOCK_25MHZ    ,
      RESET_N 		=> CLOCK_STOP_N   ,
      COUNT 		=> FLASHER_COUNT  ,
		FLASHOUT		=> FLASH
		);


SWITCH_5_4 <= SWITCH5 & SWITCH4;

--
CGEN : CLOCKGEN_CONTROLLER
  PORT MAP( 
		CLOCK				=> CLOCK_25MHZ    ,
      RST_N       	=> RESET_N        ,
      SWITCH_5_4     => SWITCH_5_4     ,
      CLK_SCLK    	=> CLK_SCLK,
      CLK_SDAT    	=> CLK_SDAT,
		IDT_SCLK     	=> OPEN,   
		IDT_SDAT_OUT 	=> OPEN,
		IDT_SDAT_OE  	=> OPEN, 
		IDT_SDAT_IN	 	=> OPEN,
		IDT_EN_200KHZ  => OPEN
      );   
--
-- FLASH SPARTAN3 LED
--
-- ROUTE 100MHZ CLOCK TO ARRAY FPGA'S

-- OPCLKS : PROCESS(POWER_STARTUP_N,GCLOCK)
-- BEGIN
-- IF (POWER_STARTUP_N(5) = '1') THEN
-- --    IF (SWITCH5 = '0') THEN
-- --       OP_CLK_PHASE   <= "0011";
-- --    ELSE
-- --       OP_CLK_PHASE   <= "0000";
-- --    END IF;
-- 
--    OP_CLK_PHASE     <= "0011";
--    
--    INT_CLOCKS1_1	   <= '0';
--    INT_CLOCKS2_1	   <= '0';
--    INT_CLOCKS3_1	   <= '0';
--    INT_CLOCKS4_1	   <= '0';
--    INT_CLOCKS1_2	   <= '1';
--    INT_CLOCKS2_2	   <= '1';
--    INT_CLOCKS3_2	   <= '1';
--    INT_CLOCKS4_2	   <= '1';
-- 
-- --    CLOCKS1_1	      <= '0';
-- --    CLOCKS3_1	      <= '0';
--    CLOCKS1_2	      <= '0';
--    CLOCKS3_2	      <= '0';
-- 
--    
-- ELSIF (GCLOCK'EVENT  AND GCLOCK='1') THEN
-- --    IF (SWITCH5 = '0') THEN
-- --       OP_CLK_PHASE   <= "0011";
-- --    ELSE
-- --       OP_CLK_PHASE   <= "0000";
-- --    END IF;
-- 
--    --25MHZ O/P
--    IF (SWITCH5 = '0') THEN
--       CASE OP_CLK_PHASE IS
--          WHEN "0011"  => OP_CLK_PHASE <= "0110";                      
--          WHEN "0110"  => OP_CLK_PHASE <= "1100";                      
--          WHEN "1001"  => OP_CLK_PHASE <= "0011";                      
--          WHEN "1100"  => OP_CLK_PHASE <= "1001";                      
--          WHEN  OTHERS => OP_CLK_PHASE <= "0011";
--       END CASE;
--    --50MHZ O/P   
--    ELSE
--       CASE OP_CLK_PHASE IS
--          WHEN "0101"  => OP_CLK_PHASE <= "1010";                      
--          WHEN "1010"  => OP_CLK_PHASE <= "0101";                      
--          WHEN  OTHERS => OP_CLK_PHASE <= "0101";
--       END CASE;
--    END IF;
-- 
-- 
-- --    OP_CLK_PHASE( 3 DOWNTO 0)  <= OP_CLK_PHASE(2 DOWNTO 0) & OP_CLK_PHASE(3);
-- 
--    --25MHZ O/P
--    IF (SWITCH5 = '0') THEN
--       INT_CLOCKS1_1	   <= OP_CLK_PHASE(0);
--       INT_CLOCKS2_1	   <= OP_CLK_PHASE(1);
--       INT_CLOCKS3_1	   <= OP_CLK_PHASE(2);
--       INT_CLOCKS4_1	   <= OP_CLK_PHASE(3);
--       
-- --	   INT_CLOCKS1_2		<= OP_CLK_PHASE(3);
-- --	   INT_CLOCKS2_2		<= OP_CLK_PHASE(0);
-- --	   INT_CLOCKS3_2		<= OP_CLK_PHASE(1);
-- --	   INT_CLOCKS4_2		<= OP_CLK_PHASE(2);
--    --50MHZ O/P
--    ELSE
--       INT_CLOCKS1_1	   <= OP_CLK_PHASE(0);
--       INT_CLOCKS2_1	   <= OP_CLK_PHASE(1);
--       INT_CLOCKS3_1	   <= OP_CLK_PHASE(2);
--       INT_CLOCKS4_1	   <= OP_CLK_PHASE(3);
--       
-- 	   INT_CLOCKS1_2		<= OP_CLK_PHASE(1);
-- 	   INT_CLOCKS2_2		<= OP_CLK_PHASE(2);
-- 	   INT_CLOCKS3_2		<= OP_CLK_PHASE(3);
-- 	   INT_CLOCKS4_2		<= OP_CLK_PHASE(0);
--    END IF;
--    
-- --    CLOCKS1_1	      <= INT_CLOCKS1_1;
-- --    CLOCKS3_1	      <= INT_CLOCKS3_1;
--    
-- --    CLOCKS1_2	      <= INT_CLOCKS1_2;
-- --    CLOCKS3_2	      <= INT_CLOCKS3_2;
--    
--    
--    
-- END IF;
-- END PROCESS OPCLKS;
-- 
-- 
-- OPCLKS2 : PROCESS(POWER_STARTUP_N,GCLOCK)
-- BEGIN
-- IF (POWER_STARTUP_N(5) = '1') THEN
-- --    CLOCKS2_1	      <= '0';
-- --    CLOCKS4_1	      <= '0';
--    CLOCKS2_2	      <= '0';
--    CLOCKS4_2	      <= '0';
--    
-- ELSIF (GCLOCK'EVENT  AND GCLOCK='0') THEN
-- --    CLOCKS2_1	      <= INT_CLOCKS2_1;
-- --    CLOCKS4_1	      <= INT_CLOCKS4_1;
-- 
-- --    CLOCKS2_2	      <= INT_CLOCKS2_2;
-- --    CLOCKS4_2	      <= INT_CLOCKS4_2;
-- 
-- END IF;
-- END PROCESS OPCLKS2;



--
-- Stop the clocks when we program!!
-- S = 1 = Stopped
--
-- 6 5
-- 0 0 - 50
-- 0 1 - 100
-- 1 0 - 150
-- 1 1 - 200
--
--    BGMUX_50_100 : BUFGMUX
--    port map (
--       O 	=>	GCLOCKA,    
--       I0 =>	CLK100,
--       I1 => CLK200,  
--       S 	=> SWITCH5
--    );
--
   BGMUX_ON_OFF : BUFGMUX
   port map (
      O 	=>	GCLOCK,    
      I0 =>	CLOCK_25MHZ,
      I1 => '0',  
      S 	=> CLOCK_STOP
   );






SPI_ACCESS_inst : SPI_ACCESS
   generic map (
      SIM_DELAY_TYPE => "SCALED",
      SIM_DEVICE => "3S50AN",
      SIM_FACTORY_ID => X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      SIM_MEM_FILE => "NONE",
      SIM_USER_ID => X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
   port map (
      MISO 	=> SPI_DI,
      CLK 	=> SPI_SK,
      CSB 	=> SPI_CS,
      MOSI 	=> SPI_DO
   );
--
-- JTAG Signals driven from USB Port 0 when SWITCH8 = 0, JTAG CONNECTOR WHEN SWITCH8 = 1
--
JTAG_TCK			<= USBC_0 WHEN ((SWITCH8 = '0') AND (SWITCH3 = '1')) ELSE 'Z';
JTAG_TDI			<= USBC_1 WHEN ((SWITCH8 = '0') AND (SWITCH3 = '1')) ELSE 'Z';
JTAG_TMS			<= USBC_3 WHEN ((SWITCH8 = '0') AND (SWITCH3 = '1')) ELSE 'Z';
-- SPI Signals driven from USB Port 1 when SWITCH6 = 1, DETACHED WHEN SWITCH6 = 0
SPI_SK			<= USBC_8  WHEN ((SWITCH6 = '0') AND (SWITCH3 = '1')) ELSE '1';
SPI_DO			<= USBC_9  WHEN ((SWITCH6 = '0') AND (SWITCH3 = '1')) ELSE '1';
USBC_10			<= SPI_DI  WHEN ((SWITCH6 = '0') AND (SWITCH3 = '1')) ELSE 'Z';
SPI_CS			<= USBC_11 WHEN ((SWITCH6 = '0') AND (SWITCH3 = '1')) ELSE '1';
--
-- Control Power Supplies for each Array FPGA
--
--
-- SWITCH3 NOW STOPS THE CLOCK ALSO TO THE ARRAY
--
CLKSTOP : PROCESS(JTAG_TMS_EXTENDER,JTAG_TMS, SWITCH3, POWER_STARTUP_N)
BEGIN
   IF ((SWITCH3 = '1') OR (JTAG_TMS = '0') OR (JTAG_TMS_EXTENDER(3) = '1') OR (POWER_STARTUP_N(11) = '1')) THEN
      CLOCK_STOP <= '1';   
   ELSE
      CLOCK_STOP <= '0';   
   END IF;
   
END PROCESS CLKSTOP;
--
-- SWITCH4 - SET LOOPBACK ON FOR UP-LINK AND DOWN-LINK 4 BITS EACH
--
LBACK: LOOPBACK_TEST		
	PORT MAP(
		CLOCK_50MHZ       => 	CLOCK_25MHZ,
      RESET_N 		      => 	RESET_N,
      IO_TEST_BUS_IN(1)	=>		LOOPIN1,
		IO_TEST_BUS_IN(2)	=>		LOOPIN2,
		IO_TEST_BUS_IN(3)	=>		LOOPIN3,
		IO_TEST_BUS_IN(4)	=>		LOOPIN4,
      IO_TEST_BUS_OUT(1)=>		LOOPOUT1,
      IO_TEST_BUS_OUT(2)=>		LOOPOUT2,
      IO_TEST_BUS_OUT(3)=>		LOOPOUT3,
      IO_TEST_BUS_OUT(4)=>		LOOPOUT4,
		LOOPBACK_PASS  	=> 	LOOPBACK_PASS
		);
--
-- ENABLE LOOPBACKS WHEN SWITCH4 = 1
--
      LOOPIN1		<= UP1;-- WHEN SWITCH4 = '1' ELSE '0';
		LOOPIN2		<= UP2;-- WHEN SWITCH4 = '1' ELSE '0';
		LOOPIN3		<= UP3;-- WHEN SWITCH4 = '1' ELSE '0';
		LOOPIN4		<= UP4;-- WHEN SWITCH4 = '1' ELSE '0';
--       DOWN1 	   <= LOOPOUT1 WHEN SWITCH4 = '1' ELSE 'Z';
--       DOWN2   	   <= LOOPOUT2 WHEN SWITCH4 = '1' ELSE 'Z';
--       DOWN3	      <= LOOPOUT3 WHEN SWITCH4 = '1' ELSE 'Z';
--       DOWN4	      <= LOOPOUT4 WHEN SWITCH4 = '1' ELSE 'Z';
		LED			<= FLASH;-- WHEN SWITCH4 = '0' ELSE LOOPBACK_PASS;
--
-- ENABLE THE 3V3 WHEN ANY OF THE 1V2'S ARE ENABLED
--
--ARRAY_3V3_EN 	<= '0' WHEN ((SWITCH1 = '0') OR (SWITCH2 = '0') OR (SWITCH3 = '0') OR (SWITCH4 = '0')) ELSE '1';
--
-- ROUTE TX,RX FROM FTDI PORT 2 & 3 (0 IS DEDICATED JTAG FOR ARRAY, 1 IS DEDICATED SPI FOR 3S50AN)
--
-- -- FPGA 1
-- USB1_1			<= USBC_16; -- TXD (OUT)
-- USBC_17			<= USB1_2;  -- RXD (IN)
-- -- FPGA 3
-- USB3_1			<= USBC_24;	-- TXD (OUT)
-- USBC_25			<= USB3_2;	-- RXD (IN)
-- --
-- --

-- # serial ports
-- # NET "RxD_PIN"              LOC = C3;   #INPUT   USB5
-- # NET "extminer_txd_PIN[0]"  LOC = C1;   #OUTPUT  USB6
-- # NET "TxD_PIN"              LOC = F2;   #OUTPUT  USB7
-- # NET "extminer_rxd_PIN[0]"  LOC = F1;   #INPUT   USB8
   
   
MUX1 : PROCESS(USBC_0,USBC_8,USBC_16,USBC_24,SWITCH3)
BEGIN
   --COM PORT ENABLED
   IF (SWITCH3 = '0') THEN
      --PRIMARY SERIAL COMS TO ARRAY
      USB1_5  <= USBC_0;   --OUT
      USB2_5  <= USBC_8 ;   --OUT
      USB3_5  <= USBC_16;   --OUT
      USB4_5  <= USBC_24 ;   --OUT
   --NOT ENABLED   
   ELSE
      USB1_5  <= '1';   --OUT
      USB2_5  <= '1' ;   --OUT
      USB3_5  <= '1';   --OUT
      USB4_5  <= '1' ;   --OUT
   END IF;
   
END PROCESS MUX1;   
   
   
-- MUX2 : PROCESS(USB1_7,USB2_7,USB3_7,USB4_7,SWITCH8)
-- BEGIN
--    --COM PORT ENABLED
--    IF (SWITCH5 = '0') THEN
--       INT_USBC_1		<= USB1_7;  -- RXD (IN)
--       INT_USBC_9	  	<= USB2_7;  -- RXD (IN)
--       USBC_17			<= USB3_7;	-- RXD (IN)
--       USBC_25			<= USB4_7;	-- RXD (IN)
--    --NOT ENABLED   
--    ELSE
--       INT_USBC_1	   <= '1';  -- RXD (IN)
--       INT_USBC_9	   <= '1';  -- RXD (IN)
--       USBC_17			<= '1';	-- RXD (IN)
--       USBC_25			<= '1';	-- RXD (IN)
--    END IF;
--    
-- END PROCESS MUX2;   

-- MUX1 : PROCESS(USBC_0,USBC_8,USBC_16,USBC_24,SWITCH8)
-- BEGIN
--    --COM PORT ENABLED
--    IF (SWITCH3 = '0') THEN
--       --PRIMARY SERIAL COMS TO ARRAY
--       USB1_5  <= USBC_0  ;   --OUT
--       USB2_5  <= USBC_8  ;   --OUT
--       USB3_5  <= USBC_16 ;   --OUT
--       USB4_5  <= USBC_24 ;   --OUT
--    --NOT ENABLED   
--    ELSE
--       USB1_5  <= '1';   --OUT
--       USB2_5  <= '1' ;   --OUT
--       USB3_5  <= '1';   --OUT
--       USB4_5  <= '1' ;   --OUT
--    END IF;
--    
-- END PROCESS MUX1;   


-- REG_COMS : PROCESS(RESET,GCLOCK)
-- BEGIN
-- IF (RESET = '1') THEN
--    INT_USB1_5  <= '1';   --OUT
--    INT_USB2_5  <= '1' ;   --OUT
--    INT_USB3_5  <= '1';   --OUT
--    INT_USB4_5  <= '1' ;   --OUT
-- 
-- ELSIF (GCLOCK'EVENT  AND GCLOCK='1') THEN
--    --COM PORT ENABLED
--    IF (SWITCH3 = '0') THEN
--       --PRIMARY SERIAL COMS TO ARRAY
--       IF (OP_CLK_PHASE(2 DOWNTO 1) = "10") THEN
--          INT_USB1_5  <= USBC_0  ;   --OUT
--       ELSE
--          INT_USB1_5 <= INT_USB1_5;
--       END IF;
--       
--       IF (OP_CLK_PHASE(3 DOWNTO 2) = "10") THEN
--          INT_USB2_5  <= USBC_8  ;   --OUT
--       ELSE
--          INT_USB2_5 <= INT_USB2_5;
--       END IF;
--       
--       IF (OP_CLK_PHASE(0) = '1') AND (OP_CLK_PHASE(3) = '0') THEN
--          INT_USB3_5  <= USBC_16 ;   --OUT
--       ELSE
--          INT_USB3_5  <= INT_USB3_5 ;   --OUT
--       END IF;
--       
--       IF (OP_CLK_PHASE(0) = '1') AND (OP_CLK_PHASE(3) = '0') THEN
--          INT_USB4_5  <= USBC_24 ;   --OUT
--       ELSE
--          INT_USB4_5 <= INT_USB4_5;
--       END IF;
--       
--       
--    --NOT ENABLED   
--    ELSE
--       INT_USB1_5  <= '1' ;   --OUT
--       INT_USB2_5  <= '1' ;   --OUT
--       INT_USB3_5  <= '1' ;   --OUT
--       INT_USB4_5  <= '1' ;   --OUT
--    END IF;
--    
-- END IF;
-- END PROCESS REG_COMS;
--    
--    
-- USB1_5  <= INT_USB1_5 ;   --OUT
-- USB2_5  <= INT_USB2_5 ;   --OUT
-- USB3_5  <= INT_USB3_5 ;   --OUT
-- USB4_5  <= INT_USB4_5 ;   --OUT
   
   
   
MUX2 : PROCESS(USB1_7,USB2_7,USB3_7,USB4_7,SWITCH3)
BEGIN
   --COM PORT ENABLED
   IF (SWITCH3 = '0') THEN
      INT_USBC_1		<= USB1_7 ;	-- RXD (IN)
      INT_USBC_9	  	<= USB2_7 ;	-- RXD (IN)
      USBC_17			<= USB3_7 ;  -- RXD (IN)
      USBC_25			<= USB4_7 ;  -- RXD (IN)

--       INT_USBC_1		<= REG_USB1_7 ;	-- RXD (IN)
--       INT_USBC_9	  	<= REG_USB2_7 ;	-- RXD (IN)
--       USBC_17			<= REG_USB3_7 ;  -- RXD (IN)
--       USBC_25			<= REG_USB4_7 ;  -- RXD (IN)
   --NOT ENABLED   
   ELSE
      INT_USBC_1	   <= '1';  -- RXD (IN)
      INT_USBC_9	   <= '1';  -- RXD (IN)
      USBC_17			<= '1';	-- RXD (IN)
      USBC_25			<= '1';	-- RXD (IN)
   END IF;
   
END PROCESS MUX2;   

USBC_1	   <= INT_USBC_1  WHEN (SWITCH3 = '0') ELSE 'Z';	
USBC_9	   <= INT_USBC_9  WHEN (SWITCH3 = '0') ELSE 'Z';		
USBC_2		<= JTAG_TDO    WHEN (SWITCH3 = '1') ELSE '1';		




-- --DOWNSTREAM SERIAL COMS FROM ARRAY
-- USB1_6  <= ;   --IN       
-- USB2_6  <= ;   --IN       
-- USB3_6  <= ;   --IN       
-- USB4_6  <= ;   --IN       
-- 
-- --PRIMARY SERIAL COMS FROM ARRAY
-- USB1_7  <= ;   --IN      
-- USB2_7  <= ;   --IN      
-- USB3_7  <= ;   --IN      
-- USB4_7  <= ;   --IN      

--DOWNSTREAM SERIAL COMS TO ARRAY
-- USB1_8  <= USB2_7 ;   --OUT
-- USB2_8  <= '1'    ;   --OUT
-- USB3_8  <= USB4_7 ;   --OUT
-- USB4_8  <= '1'    ;   --OUT

--reversed vaersion
--USB1_8  <= '1'  ;   --OUT
--USB2_8  <= '1'    ;   --OUT
--USB3_8  <= '1'  ;   --OUT
--USB4_8  <= '1'    ;   --OUT
--
-- USE TO GUARD CLOCKS
--
USB1_8	<= 'Z';
USB2_8	<= 'Z';
USB3_8	<= 'Z';
USB4_8	<= 'Z';
--
-- USE TO GUARD RX & TX LINES
--
USB1_4	<= 'Z';
USB2_1	<= 'Z';
USB3_4	<= 'Z';
USB4_1	<= 'Z';

-- USB1_6	<= '0';
-- USB2_6	<= '0';
-- USB3_6	<= '0';
-- USB4_6	<= '0';
--
divide1 : PROCESS(RESET,CLOCK_25MHZ)
BEGIN
IF (RESET = '1') THEN
   CLOCK_DIVIDE_COUNTER <= 24999; 
   TOGGLE_1KHZ          <= '0';  
   CLOCK_1KHZ           <= '0';   
   JTAG_TMS_EXTENDER    <= "0000"; 
   
ELSIF (CLOCK_25MHZ'event  AND CLOCK_25MHZ='1') THEN
   IF (CLOCK_DIVIDE_COUNTER = 0) THEN
      CLOCK_DIVIDE_COUNTER <= 12499; 
      TOGGLE_1KHZ          <= '1';  
   ELSE
      CLOCK_DIVIDE_COUNTER <= CLOCK_DIVIDE_COUNTER -1; 
      TOGGLE_1KHZ          <= '0';  
   END IF;
   
   IF (TOGGLE_1KHZ = '1') THEN
      IF (CLOCK_1KHZ = '1') THEN
         CLOCK_1KHZ <= '0';    
      ELSE
         CLOCK_1KHZ <= '1';    
      END IF;
   ELSE
      CLOCK_1KHZ <= CLOCK_1KHZ;   
   END IF;
   
   IF    (JTAG_TMS = '0') THEN
      JTAG_TMS_EXTENDER <= (OTHERS => '1');
   ELSIF (TOGGLE_1KHZ = '1') THEN
      JTAG_TMS_EXTENDER <= JTAG_TMS_EXTENDER(2 DOWNTO 0) & '0';
   ELSE
      JTAG_TMS_EXTENDER <= JTAG_TMS_EXTENDER;
   END IF;
   
END IF;
END PROCESS divide1;

-- CLKOP : PROCESS(CLK50)
-- BEGIN
-- IF (CLK50'event  AND CLK50='1') THEN
-- 	USB1_5   <= CLOCK_1KHZ;
-- 	USB2_5	<= CLOCK_1KHZ;
-- 	USB3_5	<= CLOCK_1KHZ;
-- 	USB4_5	<= CLOCK_1KHZ;
-- 
-- 
-- 	USB1_6   <= RESET_N;
-- 	USB2_6	<= RESET_N;
-- 	USB3_6	<= RESET_N;
-- 	USB4_6	<= RESET_N;
-- 
-- 
-- 	USB1_7   <= FREQUENCY_IS_100MHZ;
-- 	USB2_7	<= FREQUENCY_IS_100MHZ;
-- 	USB3_7	<= FREQUENCY_IS_100MHZ;
-- 	USB4_7	<= FREQUENCY_IS_100MHZ;
-- 
-- END IF;
-- END PROCESS CLKOP;

TURNON : PROCESS(FAN_IS_RUNNING,CLOCK_25MHZ)
BEGIN
IF (FAN_IS_RUNNING = '0') THEN
   COUNTER_1SEC        <= STARTUP_TICK_VALUE;
   COUNTER_1SEC_TICK   <= '0';
   POWER_STARTUP_N      <= (OTHERS => '1'); 
   
ELSIF (CLOCK_25MHZ'EVENT  AND CLOCK_25MHZ='1') THEN
   IF (COUNTER_1SEC = 0) THEN
      COUNTER_1SEC        <= STARTUP_TICK_VALUE;
      COUNTER_1SEC_TICK   <= '1';
   ELSE
      COUNTER_1SEC        <= COUNTER_1SEC - 1;
      COUNTER_1SEC_TICK   <= '0';
   END IF;

   --TURN THEM ON AT 1S INTERVALS   
   IF (COUNTER_1SEC_TICK = '1') THEN
      POWER_STARTUP_N(15 DOWNTO 0) <= POWER_STARTUP_N(14 DOWNTO 0) & '0'; 
   --WAIT     
   ELSE
      POWER_STARTUP_N(15 DOWNTO 0) <= POWER_STARTUP_N(15 DOWNTO 0);
   END IF;

END IF;
END PROCESS TURNON;


--WANT RESETS APPLIED AFTER FPGAS ARE CONFIGURED
RESET_DEVICE_0 <= RESET_FROM_COUNT  OR POWER_STARTUP_N(14) OR JTAG_TMS_EXTENDER(3);-- OR DCM_NOT_LOCKED;
RESET_DEVICE_1 <= RESET_FROM_COUNT  OR POWER_STARTUP_N(13) OR JTAG_TMS_EXTENDER(3);-- OR DCM_NOT_LOCKED;
RESET_DEVICE_2 <= RESET_FROM_COUNT  OR POWER_STARTUP_N(12) OR JTAG_TMS_EXTENDER(3);-- OR DCM_NOT_LOCKED;
RESET_DEVICE_3 <= RESET_FROM_COUNT  OR POWER_STARTUP_N(11) OR JTAG_TMS_EXTENDER(3);-- OR DCM_NOT_LOCKED;


ARRAY_3V3_EN	<= POWER_STARTUP_N(0);     -- ON = SUPPLY ON
EN_1V2_1			<= POWER_STARTUP_N(7);		-- ON = SUPPLY ON
EN_1V2_2			<= POWER_STARTUP_N(5);		-- ON = SUPPLY ON
EN_1V2_3			<= POWER_STARTUP_N(3);		-- ON = SUPPLY ON
EN_1V2_4			<= POWER_STARTUP_N(1);		-- ON = SUPPLY ON
-- EN_1V2_1			<= '1';		-- ON = SUPPLY ON
-- EN_1V2_2			<= '1';		-- ON = SUPPLY ON
-- EN_1V2_3			<= '1';		-- ON = SUPPLY ON
-- EN_1V2_4			<= '1';		-- ON = SUPPLY ON

FAN1 : PROCESS(RESET,CLOCK_25MHZ)
BEGIN
IF (RESET = '1') THEN
   TICK_COUNTER         <= STARTUP_TICK_VALUE ;
   TICK_1SEC            <= '0';
   FAN_RPM1_SHIFT       <= (OTHERS => '0');
   FAN_RPM2_SHIFT       <= (OTHERS => '0');
   FAN_RPM3_SHIFT       <= (OTHERS => '0');
   FAN_RPM4_SHIFT       <= (OTHERS => '0');
   FAN_COUNTER1         <= (OTHERS => '0');
   FAN_COUNTER2         <= (OTHERS => '0');
   FAN_COUNTER3         <= (OTHERS => '0');
   FAN_COUNTER4         <= (OTHERS => '0');
   FAN_COUNTER1_STORED  <= (OTHERS => '0');
   FAN_COUNTER2_STORED  <= (OTHERS => '0');
   FAN_COUNTER3_STORED  <= (OTHERS => '0');
   FAN_COUNTER4_STORED  <= (OTHERS => '0');
   FAN1_IS_OK           <= '0';
   FAN2_IS_OK           <= '0';
   FAN3_IS_OK           <= '0';
   FAN4_IS_OK           <= '0';
   FAN_IS_RUNNING       <= '0';
   
ELSIF (CLOCK_25MHZ'EVENT  AND CLOCK_25MHZ='1') THEN
   IF (TICK_COUNTER = 0) THEN
      TICK_COUNTER <= STARTUP_TICK_VALUE;   
      TICK_1SEC    <= '1';
   ELSE
      TICK_COUNTER <= TICK_COUNTER - 1;   
      TICK_1SEC    <= '0';
   END IF;

   FAN_RPM1_SHIFT <= FAN_RPM1_SHIFT(2 downto 0) & FAN_RPM1;
   FAN_RPM2_SHIFT <= FAN_RPM2_SHIFT(2 downto 0) & FAN_RPM2;
   FAN_RPM3_SHIFT <= FAN_RPM3_SHIFT(2 downto 0) & FAN_RPM3;
   FAN_RPM4_SHIFT <= FAN_RPM4_SHIFT(2 downto 0) & FAN_RPM4;

   IF    (TICK_1SEC = '1') THEN
      FAN_COUNTER1   <= (OTHERS => '0');
   ELSIF (FAN_RPM1_SHIFT(3 DOWNTO 2) = "01") THEN
      FAN_COUNTER1 <= FAN_COUNTER1 + 1;      
   ELSE
      FAN_COUNTER1 <= FAN_COUNTER1;      
   END IF;

   IF    (TICK_1SEC = '1') THEN
      FAN_COUNTER2   <= (OTHERS => '0');
   ELSIF (FAN_RPM2_SHIFT(3 DOWNTO 2) = "01") THEN
      FAN_COUNTER2 <= FAN_COUNTER2 + 1;      
   ELSE
      FAN_COUNTER2 <= FAN_COUNTER2;      
   END IF;

   IF    (TICK_1SEC = '1') THEN
      FAN_COUNTER3   <= (OTHERS => '0');
   ELSIF (FAN_RPM3_SHIFT(3 DOWNTO 2) = "01") THEN
      FAN_COUNTER3 <= FAN_COUNTER3 + 1;      
   ELSE
      FAN_COUNTER3 <= FAN_COUNTER3;      
   END IF;

   IF    (TICK_1SEC = '1') THEN
      FAN_COUNTER4   <= (OTHERS => '0');
   ELSIF (FAN_RPM4_SHIFT(3 DOWNTO 2) = "01") THEN
      FAN_COUNTER4 <= FAN_COUNTER4 + 1;      
   ELSE
      FAN_COUNTER4 <= FAN_COUNTER4;      
   END IF;

   IF    (TICK_1SEC = '1') THEN
      FAN_COUNTER1_STORED   <= FAN_COUNTER1;
      FAN_COUNTER2_STORED   <= FAN_COUNTER2;
      FAN_COUNTER3_STORED   <= FAN_COUNTER3;
      FAN_COUNTER4_STORED   <= FAN_COUNTER4;
   ELSE
      FAN_COUNTER1_STORED   <= FAN_COUNTER1_STORED;
      FAN_COUNTER2_STORED   <= FAN_COUNTER2_STORED;
      FAN_COUNTER3_STORED   <= FAN_COUNTER3_STORED;
      FAN_COUNTER4_STORED   <= FAN_COUNTER4_STORED;
   END IF;
   
   IF (FAN_COUNTER1_STORED(15 DOWNTO 0) > MINIMUM_FAN_COUNT) THEN
      FAN1_IS_OK <= '1';   
   ELSE
      FAN1_IS_OK <= '0';
   END IF;

   IF (FAN_COUNTER2_STORED(15 DOWNTO 0) > MINIMUM_FAN_COUNT) THEN
      FAN2_IS_OK <= '1';   
   ELSE
      FAN2_IS_OK <= '0';
   END IF;

   IF (FAN_COUNTER3_STORED(15 DOWNTO 0) > MINIMUM_FAN_COUNT) THEN
      FAN3_IS_OK <= '1';   
   ELSE
      FAN3_IS_OK <= '0';
   END IF;

   IF (FAN_COUNTER4_STORED(15 DOWNTO 0) > MINIMUM_FAN_COUNT) THEN
      FAN4_IS_OK <= '1';   
   ELSE
      FAN4_IS_OK <= '0';
   END IF;
   
   IF ((FAN1_IS_OK = '1') OR (FAN2_IS_OK = '1') OR (FAN3_IS_OK = '1') OR (FAN4_IS_OK = '1') OR (SWITCH2 = '1')) THEN
      FAN_IS_RUNNING <= '1';   
   ELSE
      FAN_IS_RUNNING <= '0';   
   END IF;

END IF;
END PROCESS FAN1;


          
          
          
          

-- CLKOP1 : OBUFDS
-- generic map(IOSTANDARD  => "DEFAULT"   )
-- port map(   O           => CLOCKS1_2   ,     -- Diff_p output (connect directly to top-level port)
--             OB          => CLOCKS1_1   ,     -- Diff_n output (connect directly to top-level port)
--             I           => CLOCK_200MHZ_000_DEG );    -- Buffer input 
-- 
-- 
-- CLKOP2 : OBUFDS
-- generic map(IOSTANDARD  => "DEFAULT"   )
-- port map(   O           => CLOCKS2_2   ,     -- Diff_p output (connect directly to top-level port)
--             OB          => CLOCKS2_1   ,     -- Diff_n output (connect directly to top-level port)
--             I           => CLOCK_200MHZ_090_DEG );--CLOCK_200MHZ_090_DEG );    -- Buffer input 
-- 
-- CLKOP3 : OBUFDS
-- generic map(IOSTANDARD  => "DEFAULT"   )
-- port map(   O           => CLOCKS3_2   ,     -- Diff_p output (connect directly to top-level port)
--             OB          => CLOCKS3_1   ,     -- Diff_n output (connect directly to top-level port)
--             I           => CLOCK_200MHZ_180_DEG );--CLOCK_200MHZ_180_DEG );    -- Buffer input 
-- 
-- CLKOP4 : OBUFDS
-- generic map(IOSTANDARD  => "DEFAULT"   )
-- port map(   O           => CLOCKS4_2   ,     -- Diff_p output (connect directly to top-level port)
--             OB          => CLOCKS4_1   ,     -- Diff_n output (connect directly to top-level port)
--             I           => CLOCK_200MHZ_270_DEG );--CLOCK_200MHZ_270_DEG );    -- Buffer input 

CLKOP1 : OBUFDS
generic map(IOSTANDARD  => "DEFAULT"   )
port map(   O           => CLOCKS1_2   ,     -- Diff_p output (connect directly to top-level port)
            OB          => CLOCKS1_1   ,     -- Diff_n output (connect directly to top-level port)
            I           => GCLOCK );    -- Buffer input 
                               

CLKOP2 : OBUFDS
generic map(IOSTANDARD  => "DEFAULT"   )
port map(   O           => CLOCKS2_2   ,     -- Diff_p output (connect directly to top-level port)
            OB          => CLOCKS2_1   ,     -- Diff_n output (connect directly to top-level port)
            I           => GCLOCK );--CLOCK_200MHZ_090_DEG );    -- Buffer input 

CLKOP3 : OBUFDS
generic map(IOSTANDARD  => "DEFAULT"   )
port map(   O           => CLOCKS3_2   ,     -- Diff_p output (connect directly to top-level port)
            OB          => CLOCKS3_1   ,     -- Diff_n output (connect directly to top-level port)
            I           => GCLOCK );--CLOCK_200MHZ_180_DEG );    -- Buffer input 

CLKOP4 : OBUFDS
generic map(IOSTANDARD  => "DEFAULT"   )
port map(   O           => CLOCKS4_2   ,     -- Diff_p output (connect directly to top-level port)
            OB          => CLOCKS4_1   ,     -- Diff_n output (connect directly to top-level port)
            I           => GCLOCK );--CLOCK_200MHZ_270_DEG );    -- Buffer input 




DOWN1	<= CLK_180MHZ_210MHZ	;   
DOWN2	<= CLK_180MHZ_210MHZ	;		 
DOWN3	<= CLK_180MHZ_210MHZ	;		 
DOWN4	<= CLK_180MHZ_210MHZ	;		
           
END RTL;





