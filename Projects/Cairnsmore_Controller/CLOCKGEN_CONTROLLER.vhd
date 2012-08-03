LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

-- ------------------------------
   ENTITY CLOCKGEN_CONTROLLER IS
-- ------------------------------
  PORT( 
		CLOCK			          	:  IN 	STD_LOGIC;
      RST_N                	:  IN 	STD_LOGIC;
      CLK_SCLK                :  OUT   STD_LOGIC;
      CLK_SDAT                :  INOUT STD_LOGIC;
		IDT_SCLK      				:  OUT   STD_LOGIC;
		IDT_SDAT_OUT  				:  OUT   STD_LOGIC;  
		IDT_SDAT_OE   				:  OUT   STD_LOGIC;  
		IDT_SDAT_IN					:  OUT 	STD_LOGIC;
		IDT_EN_200KHZ				:  OUT   STD_LOGIC
      );                           
                                  
END CLOCKGEN_CONTROLLER;

-- ------------------------------
    ARCHITECTURE RTL OF CLOCKGEN_CONTROLLER IS
-- ------------------------------

-------------------------------------------------------------------------
-- COMPONENT DECLARATION
-------------------------------------------------------------------------
COMPONENT IDT5V19EE901_LOADER IS
GENERIC( CLOCK_FREQ_IN_MHZ       :           INTEGER RANGE 0 TO 500:=25);                                     

PORT(    CLOCK                   :     IN    STD_LOGIC;
         RESET                   :     IN    STD_LOGIC;
         CLOCK_EN_200KHZ         :     OUT   STD_LOGIC;

         START_ADDRESS           :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);
         END_ADDRESS             :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);
         DEVICE_ADDRESS          :     IN    STD_LOGIC_VECTOR( 6 DOWNTO 0); 
         REQUEST_WRITE           :     IN    STD_LOGIC;
         REQUEST_READ            :     IN    STD_LOGIC;
         REQUEST_EEPROM_STORE    :     IN    STD_LOGIC;
         REQUEST_EEPROM_RESTORE  :     IN    STD_LOGIC;
         LOADER_BUSY             :     OUT   STD_LOGIC;
      
         READ_DATA               :     OUT   STD_LOGIC_VECTOR( 7 DOWNTO 0);
         READ_ADDRESS            :     OUT   STD_LOGIC_VECTOR( 7 DOWNTO 0);
         READ_DATA_VALID         :     OUT   STD_LOGIC;
      
         REG_VALUE_00      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_01      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_02      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_03      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_04      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_05      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_06      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_07      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_08      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_09      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0A      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0B      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0C      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0D      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0E      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0F      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      

         REG_VALUE_10      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_11      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_12      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_13      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_14      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_15      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_16      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_17      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_18      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_19      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1A      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1B      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1C      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1D      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1E      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1F      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      

         REG_VALUE_20      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_21      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_22      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_23      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_24      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_25      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_26      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_27      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_28      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_29      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2A      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2B      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2C      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2D      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2E      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2F      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      

         REG_VALUE_30      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_31      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_32      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_33      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_34      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_35      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_36      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_37      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_38      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_39      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3A      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3B      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3C      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3D      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3E      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3F      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      

         REG_VALUE_40      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_41      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_42      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_43      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_44      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_45      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_46      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_47      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_48      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_49      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4A      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4B      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4C      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4D      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4E      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4F      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      

         REG_VALUE_50      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_51      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_52      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_53      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_54      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_55      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_56      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_57      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_58      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_59      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5A      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5B      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5C      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5D      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5E      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5F      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    
      
         REG_VALUE_60      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_61      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_62      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_63      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_64      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_65      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_66      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_67      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_68      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_69      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6A      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6B      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6C      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6D      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6E      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6F      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_70      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_71      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_72      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_73      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_74      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_75      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_76      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_77      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_78      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_79      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7A      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7B      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7C      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7D      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7E      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7F      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_80      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_81      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_82      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_83      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_84      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_85      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_86      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_87      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_88      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_89      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8A      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8B      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8C      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8D      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8E      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8F      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_90      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_91      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_92      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_93      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_94      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_95      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_96      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_97      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_98      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_99      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9A      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9B      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9C      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9D      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9E      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9F      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_A0      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A1      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A2      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A3      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A4      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A5      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A6      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A7      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A8      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A9      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AA      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AB      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AC      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AD      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AE      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AF      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_B0      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B1      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B2      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B3      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B4      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B5      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B6      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B7      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B8      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B9      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BA      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BB      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BC      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BD      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BE      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BF      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_C0      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C1      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C2      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C3      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C4      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C5      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C6      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C7      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C8      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C9      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CA      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CB      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CC      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CD      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CE      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CF      :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         IDT5V19EE901_SCLK      :     OUT   STD_LOGIC;
         IDT5V19EE901_SDAT_OUT  :     OUT   STD_LOGIC;  
         IDT5V19EE901_SDAT_OE   :     OUT   STD_LOGIC;  
         IDT5V19EE901_SDAT_IN   :     IN    STD_LOGIC  

    );
END COMPONENT;

TYPE SM_CLOCK_LOAD_TYPE IS ( 
										SM_CLOCK_LOAD_IDLE,
										SM_CLOCK_LOAD_START,
										SM_CLOCK_LOAD_WAIT_BUSY,
										SM_CLOCK_LOAD_WAIT_DONE,
										SM_CLOCK_LOAD_HOLD
                              ); 
                              
SIGNAL SM_CLOCK_LOAD          : SM_CLOCK_LOAD_TYPE;            

SIGNAL IDT5V19EE901_LOADER_BUSY_CHAR          			: STD_LOGIC_VECTOR( 7 DOWNTO 0);
SIGNAL IDT5V19EE901_START_ADDRESS                    	: STD_LOGIC_VECTOR( 7 DOWNTO 0);
SIGNAL IDT5V19EE901_END_ADDRESS                      	: STD_LOGIC_VECTOR( 7 DOWNTO 0);
SIGNAL IDT5V19EE901_DEVICE_ADDRESS                   	: STD_LOGIC_VECTOR( 7 DOWNTO 0);
SIGNAL IDT5V19EE901_REQUEST_READ                     	: STD_LOGIC;
SIGNAL IDT5V19EE901_REQUEST_EEPROM_STORE             	: STD_LOGIC;
SIGNAL IDT5V19EE901_REQUEST_EEPROM_RESTORE           	: STD_LOGIC;
SIGNAL idt5v19ee901_loader_write          				: STD_LOGIC;
SIGNAL CLOCK_EN_200KHZ          								: STD_LOGIC;
SIGNAL idt5v19ee901_loader_busy          					: STD_LOGIC;
SIGNAL idt5v19ee901_sclk          							: STD_LOGIC;
SIGNAL idt5v19ee901_sdat_out          						: STD_LOGIC;
SIGNAL idt5v19ee901_sdat_oe          						: STD_LOGIC;
SIGNAL idt5v19ee901_sdat_in          						: STD_LOGIC;

SIGNAL REG_VALUE_00       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_01       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_02       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_03       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_04       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_05       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_06       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_07       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_08       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_09       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_0A       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_0B       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_0C       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_0D       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_0E       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_0F       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_10       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_11       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_12       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_13       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_14       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_15       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_16       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_17       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_18       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_19       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_1A       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_1B       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_1C       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_1D       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_1E       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_1F       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_20       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_21       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_22       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_23       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_24       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_25       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_26       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_27       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_28       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_29       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_2A       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_2B       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_2C       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_2D       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_2E       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_2F       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_30       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_31       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_32       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_33       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_34       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_35       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_36       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_37       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_38       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_39       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_3A       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_3B       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_3C       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_3D       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_3E       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_3F       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_40       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_41       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_42       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_43       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_44       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_45       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_46       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_47       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_48       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_49       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_4A       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_4B       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_4C       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_4D       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_4E       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_4F       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_50       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_51       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_52       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_53       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_54       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_55       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_56       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_57       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_58       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_59       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_5A       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_5B       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_5C       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_5D       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_5E       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_5F       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);   
SIGNAL REG_VALUE_60       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_61       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_62       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_63       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_64       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_65       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_66       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_67       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_68       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_69       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_6A       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_6B       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_6C       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_6D       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_6E       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_6F       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);   
SIGNAL REG_VALUE_70       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_71       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_72       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_73       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_74       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_75       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_76       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_77       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_78       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_79       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_7A       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_7B       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_7C       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_7D       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_7E       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_7F       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);   
SIGNAL REG_VALUE_80       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_81       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_82       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_83       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_84       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_85       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_86       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_87       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_88       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_89       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_8A       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_8B       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_8C       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_8D       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_8E       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_8F       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);   
SIGNAL REG_VALUE_90       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_91       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_92       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_93       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_94       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_95       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_96       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_97       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_98       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_99       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_9A       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_9B       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_9C       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_9D       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_9E       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_9F       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);   
SIGNAL REG_VALUE_A0       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_A1       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_A2       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_A3       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_A4       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_A5       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_A6       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_A7       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_A8       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_A9       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_AA       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_AB       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_AC       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_AD       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_AE       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_AF       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);   
SIGNAL REG_VALUE_B0       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_B1       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_B2       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_B3       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_B4       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_B5       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_B6       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_B7       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_B8       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_B9       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_BA       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_BB       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_BC       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_BD       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_BE       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_BF       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);   
SIGNAL REG_VALUE_C0       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_C1       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_C2       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_C3       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_C4       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_C5       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_C6       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_C7       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_C8       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_C9       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_CA       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_CB       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_CC       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_CD       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_CE       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);     
SIGNAL REG_VALUE_CF       :   STD_LOGIC_VECTOR( 7 DOWNTO 0);   

SIGNAL RESET					:	STD_LOGIC;

BEGIN

RESET <= NOT RST_N;

IDT5V19EE901_START_ADDRESS          <= X"00";
IDT5V19EE901_END_ADDRESS            <= X"CF";
IDT5V19EE901_DEVICE_ADDRESS         <= X"6A";
IDT5V19EE901_REQUEST_READ           <= '0';      
IDT5V19EE901_REQUEST_EEPROM_STORE   <= '0';    
IDT5V19EE901_REQUEST_EEPROM_RESTORE <= '0'; 

CLKGEN_LOADER : IDT5V19EE901_LOADER 
GENERIC MAP(CLOCK_FREQ_IN_MHZ       => 25                                    )
PORT MAP(   CLOCK                   => CLOCK			                            ,
            RESET                   => RESET                                  ,
            CLOCK_EN_200KHZ         => CLOCK_EN_200KHZ                        ,

            START_ADDRESS           => IDT5V19EE901_START_ADDRESS              ,
            END_ADDRESS             => IDT5V19EE901_END_ADDRESS                ,
            DEVICE_ADDRESS          => IDT5V19EE901_DEVICE_ADDRESS(6 DOWNTO 0) , 
            REQUEST_WRITE           => IDT5V19EE901_LOADER_WRITE               ,
            REQUEST_READ            => IDT5V19EE901_REQUEST_READ               ,
            REQUEST_EEPROM_STORE    => IDT5V19EE901_REQUEST_EEPROM_STORE       ,
            REQUEST_EEPROM_RESTORE  => IDT5V19EE901_REQUEST_EEPROM_RESTORE     ,
            LOADER_BUSY             => IDT5V19EE901_LOADER_BUSY                ,
      
            READ_DATA               => OPEN                                    ,
            READ_ADDRESS            => OPEN                                    ,
            READ_DATA_VALID         => OPEN                                    ,
      
            REG_VALUE_00            => REG_VALUE_00,     
            REG_VALUE_01            => REG_VALUE_01,     
            REG_VALUE_02            => REG_VALUE_02,     
            REG_VALUE_03            => REG_VALUE_03,     
            REG_VALUE_04            => REG_VALUE_04,     
            REG_VALUE_05            => REG_VALUE_05,     
            REG_VALUE_06            => REG_VALUE_06,     
            REG_VALUE_07            => REG_VALUE_07,     
            REG_VALUE_08            => REG_VALUE_08,     
            REG_VALUE_09            => REG_VALUE_09,     
            REG_VALUE_0A            => REG_VALUE_0A,     
            REG_VALUE_0B            => REG_VALUE_0B,     
            REG_VALUE_0C            => REG_VALUE_0C,     
            REG_VALUE_0D            => REG_VALUE_0D,     
            REG_VALUE_0E            => REG_VALUE_0E,     
            REG_VALUE_0F            => REG_VALUE_0F,     
            REG_VALUE_10            => REG_VALUE_10,     
            REG_VALUE_11            => REG_VALUE_11,     
            REG_VALUE_12            => REG_VALUE_12,     
            REG_VALUE_13            => REG_VALUE_13,     
            REG_VALUE_14            => REG_VALUE_14,     
            REG_VALUE_15            => REG_VALUE_15,     
            REG_VALUE_16            => REG_VALUE_16,     
            REG_VALUE_17            => REG_VALUE_17,     
            REG_VALUE_18            => REG_VALUE_18,     
            REG_VALUE_19            => REG_VALUE_19,     
            REG_VALUE_1A            => REG_VALUE_1A,     
            REG_VALUE_1B            => REG_VALUE_1B,     
            REG_VALUE_1C            => REG_VALUE_1C,     
            REG_VALUE_1D            => REG_VALUE_1D,     
            REG_VALUE_1E            => REG_VALUE_1E,     
            REG_VALUE_1F            => REG_VALUE_1F,     
            REG_VALUE_20            => REG_VALUE_20,     
            REG_VALUE_21            => REG_VALUE_21,     
            REG_VALUE_22            => REG_VALUE_22,     
            REG_VALUE_23            => REG_VALUE_23,     
            REG_VALUE_24            => REG_VALUE_24,     
            REG_VALUE_25            => REG_VALUE_25,     
            REG_VALUE_26            => REG_VALUE_26,     
            REG_VALUE_27            => REG_VALUE_27,     
            REG_VALUE_28            => REG_VALUE_28,     
            REG_VALUE_29            => REG_VALUE_29,     
            REG_VALUE_2A            => REG_VALUE_2A,     
            REG_VALUE_2B            => REG_VALUE_2B,     
            REG_VALUE_2C            => REG_VALUE_2C,     
            REG_VALUE_2D            => REG_VALUE_2D,     
            REG_VALUE_2E            => REG_VALUE_2E,     
            REG_VALUE_2F            => REG_VALUE_2F,     
            REG_VALUE_30            => REG_VALUE_30,     
            REG_VALUE_31            => REG_VALUE_31,     
            REG_VALUE_32            => REG_VALUE_32,     
            REG_VALUE_33            => REG_VALUE_33,     
            REG_VALUE_34            => REG_VALUE_34,     
            REG_VALUE_35            => REG_VALUE_35,     
            REG_VALUE_36            => REG_VALUE_36,     
            REG_VALUE_37            => REG_VALUE_37,     
            REG_VALUE_38            => REG_VALUE_38,     
            REG_VALUE_39            => REG_VALUE_39,     
            REG_VALUE_3A            => REG_VALUE_3A,     
            REG_VALUE_3B            => REG_VALUE_3B,     
            REG_VALUE_3C            => REG_VALUE_3C,     
            REG_VALUE_3D            => REG_VALUE_3D,     
            REG_VALUE_3E            => REG_VALUE_3E,     
            REG_VALUE_3F            => REG_VALUE_3F,     
            REG_VALUE_40            => REG_VALUE_40,     
            REG_VALUE_41            => REG_VALUE_41,     
            REG_VALUE_42            => REG_VALUE_42,     
            REG_VALUE_43            => REG_VALUE_43,     
            REG_VALUE_44            => REG_VALUE_44,     
            REG_VALUE_45            => REG_VALUE_45,     
            REG_VALUE_46            => REG_VALUE_46,     
            REG_VALUE_47            => REG_VALUE_47,     
            REG_VALUE_48            => REG_VALUE_48,     
            REG_VALUE_49            => REG_VALUE_49,     
            REG_VALUE_4A            => REG_VALUE_4A,     
            REG_VALUE_4B            => REG_VALUE_4B,     
            REG_VALUE_4C            => REG_VALUE_4C,     
            REG_VALUE_4D            => REG_VALUE_4D,     
            REG_VALUE_4E            => REG_VALUE_4E,     
            REG_VALUE_4F            => REG_VALUE_4F,     
            REG_VALUE_50            => REG_VALUE_50,     
            REG_VALUE_51            => REG_VALUE_51,     
            REG_VALUE_52            => REG_VALUE_52,     
            REG_VALUE_53            => REG_VALUE_53,     
            REG_VALUE_54            => REG_VALUE_54,     
            REG_VALUE_55            => REG_VALUE_55,     
            REG_VALUE_56            => REG_VALUE_56,     
            REG_VALUE_57            => REG_VALUE_57,     
            REG_VALUE_58            => REG_VALUE_58,     
            REG_VALUE_59            => REG_VALUE_59,     
            REG_VALUE_5A            => REG_VALUE_5A,     
            REG_VALUE_5B            => REG_VALUE_5B,     
            REG_VALUE_5C            => REG_VALUE_5C,     
            REG_VALUE_5D            => REG_VALUE_5D,     
            REG_VALUE_5E            => REG_VALUE_5E,     
            REG_VALUE_5F            => REG_VALUE_5F,   
            REG_VALUE_60            => REG_VALUE_60,     
            REG_VALUE_61            => REG_VALUE_61,     
            REG_VALUE_62            => REG_VALUE_62,     
            REG_VALUE_63            => REG_VALUE_63,     
            REG_VALUE_64            => REG_VALUE_64,     
            REG_VALUE_65            => REG_VALUE_65,     
            REG_VALUE_66            => REG_VALUE_66,     
            REG_VALUE_67            => REG_VALUE_67,     
            REG_VALUE_68            => REG_VALUE_68,     
            REG_VALUE_69            => REG_VALUE_69,     
            REG_VALUE_6A            => REG_VALUE_6A,     
            REG_VALUE_6B            => REG_VALUE_6B,     
            REG_VALUE_6C            => REG_VALUE_6C,     
            REG_VALUE_6D            => REG_VALUE_6D,     
            REG_VALUE_6E            => REG_VALUE_6E,     
            REG_VALUE_6F            => REG_VALUE_6F,   
            REG_VALUE_70            => REG_VALUE_70,     
            REG_VALUE_71            => REG_VALUE_71,     
            REG_VALUE_72            => REG_VALUE_72,     
            REG_VALUE_73            => REG_VALUE_73,     
            REG_VALUE_74            => REG_VALUE_74,     
            REG_VALUE_75            => REG_VALUE_75,     
            REG_VALUE_76            => REG_VALUE_76,     
            REG_VALUE_77            => REG_VALUE_77,     
            REG_VALUE_78            => REG_VALUE_78,     
            REG_VALUE_79            => REG_VALUE_79,     
            REG_VALUE_7A            => REG_VALUE_7A,     
            REG_VALUE_7B            => REG_VALUE_7B,     
            REG_VALUE_7C            => REG_VALUE_7C,     
            REG_VALUE_7D            => REG_VALUE_7D,     
            REG_VALUE_7E            => REG_VALUE_7E,     
            REG_VALUE_7F            => REG_VALUE_7F,   
            REG_VALUE_80            => REG_VALUE_80,     
            REG_VALUE_81            => REG_VALUE_81,     
            REG_VALUE_82            => REG_VALUE_82,     
            REG_VALUE_83            => REG_VALUE_83,     
            REG_VALUE_84            => REG_VALUE_84,     
            REG_VALUE_85            => REG_VALUE_85,     
            REG_VALUE_86            => REG_VALUE_86,     
            REG_VALUE_87            => REG_VALUE_87,     
            REG_VALUE_88            => REG_VALUE_88,     
            REG_VALUE_89            => REG_VALUE_89,     
            REG_VALUE_8A            => REG_VALUE_8A,     
            REG_VALUE_8B            => REG_VALUE_8B,     
            REG_VALUE_8C            => REG_VALUE_8C,     
            REG_VALUE_8D            => REG_VALUE_8D,     
            REG_VALUE_8E            => REG_VALUE_8E,     
            REG_VALUE_8F            => REG_VALUE_8F,   
            REG_VALUE_90            => REG_VALUE_90,     
            REG_VALUE_91            => REG_VALUE_91,     
            REG_VALUE_92            => REG_VALUE_92,     
            REG_VALUE_93            => REG_VALUE_93,     
            REG_VALUE_94            => REG_VALUE_94,     
            REG_VALUE_95            => REG_VALUE_95,     
            REG_VALUE_96            => REG_VALUE_96,     
            REG_VALUE_97            => REG_VALUE_97,     
            REG_VALUE_98            => REG_VALUE_98,     
            REG_VALUE_99            => REG_VALUE_99,     
            REG_VALUE_9A            => REG_VALUE_9A,     
            REG_VALUE_9B            => REG_VALUE_9B,     
            REG_VALUE_9C            => REG_VALUE_9C,     
            REG_VALUE_9D            => REG_VALUE_9D,     
            REG_VALUE_9E            => REG_VALUE_9E,     
            REG_VALUE_9F            => REG_VALUE_9F,   
            REG_VALUE_A0            => REG_VALUE_A0,     
            REG_VALUE_A1            => REG_VALUE_A1,     
            REG_VALUE_A2            => REG_VALUE_A2,     
            REG_VALUE_A3            => REG_VALUE_A3,     
            REG_VALUE_A4            => REG_VALUE_A4,     
            REG_VALUE_A5            => REG_VALUE_A5,     
            REG_VALUE_A6            => REG_VALUE_A6,     
            REG_VALUE_A7            => REG_VALUE_A7,     
            REG_VALUE_A8            => REG_VALUE_A8,     
            REG_VALUE_A9            => REG_VALUE_A9,     
            REG_VALUE_AA            => REG_VALUE_AA,     
            REG_VALUE_AB            => REG_VALUE_AB,     
            REG_VALUE_AC            => REG_VALUE_AC,     
            REG_VALUE_AD            => REG_VALUE_AD,     
            REG_VALUE_AE            => REG_VALUE_AE,     
            REG_VALUE_AF            => REG_VALUE_AF,   
            REG_VALUE_B0            => REG_VALUE_B0,     
            REG_VALUE_B1            => REG_VALUE_B1,     
            REG_VALUE_B2            => REG_VALUE_B2,     
            REG_VALUE_B3            => REG_VALUE_B3,     
            REG_VALUE_B4            => REG_VALUE_B4,     
            REG_VALUE_B5            => REG_VALUE_B5,     
            REG_VALUE_B6            => REG_VALUE_B6,     
            REG_VALUE_B7            => REG_VALUE_B7,     
            REG_VALUE_B8            => REG_VALUE_B8,     
            REG_VALUE_B9            => REG_VALUE_B9,     
            REG_VALUE_BA            => REG_VALUE_BA,     
            REG_VALUE_BB            => REG_VALUE_BB,     
            REG_VALUE_BC            => REG_VALUE_BC,     
            REG_VALUE_BD            => REG_VALUE_BD,     
            REG_VALUE_BE            => REG_VALUE_BE,     
            REG_VALUE_BF            => REG_VALUE_BF,   
            REG_VALUE_C0            => REG_VALUE_C0,     
            REG_VALUE_C1            => REG_VALUE_C1,     
            REG_VALUE_C2            => REG_VALUE_C2,     
            REG_VALUE_C3            => REG_VALUE_C3,     
            REG_VALUE_C4            => REG_VALUE_C4,     
            REG_VALUE_C5            => REG_VALUE_C5,     
            REG_VALUE_C6            => REG_VALUE_C6,     
            REG_VALUE_C7            => REG_VALUE_C7,     
            REG_VALUE_C8            => REG_VALUE_C8,     
            REG_VALUE_C9            => REG_VALUE_C9,     
            REG_VALUE_CA            => REG_VALUE_CA,     
            REG_VALUE_CB            => REG_VALUE_CB,     
            REG_VALUE_CC            => REG_VALUE_CC,     
            REG_VALUE_CD            => REG_VALUE_CD,     
            REG_VALUE_CE            => REG_VALUE_CE,     
            REG_VALUE_CF            => REG_VALUE_CF,   

            IDT5V19EE901_SCLK       => IDT5V19EE901_SCLK      ,
            IDT5V19EE901_SDAT_OUT   => IDT5V19EE901_SDAT_OUT  ,  
            IDT5V19EE901_SDAT_OE    => IDT5V19EE901_SDAT_OE   ,  
            IDT5V19EE901_SDAT_IN    => IDT5V19EE901_SDAT_IN   ); 

				--
				-- CLOCK GENERATOR VALUES TO PROGRAM
				--
				-- SEL0,1,2 = GND - ONLY CONFIG0 AVAILABLE
				--
				-- OUTPUT	PIN	FREQUENCY
				--	OUT0  	30 	50MHZ
				-- OUT1  	 7		50MHZ
				-- OUT2  	 8		50MHZ
				-- OUT3  	24		50MHZ
				-- OUT4  	10		100MHZ
				-- OUT4b 	11		100MHZ
				-- OUT5  	14		50MHZ
				-- OUT5b 	15		50MHZ	
				-- OUT6  	23		50MHZ
            REG_VALUE_00            <= X"00";
            REG_VALUE_01            <= X"00";
            REG_VALUE_02            <= X"1E";
            REG_VALUE_03            <= X"1E";
            REG_VALUE_04            <= X"0F";
            REG_VALUE_05            <= X"04";
            REG_VALUE_06            <= X"00";
            REG_VALUE_07            <= X"00";
            REG_VALUE_08            <= X"87";
            REG_VALUE_09            <= X"00";
            REG_VALUE_0A            <= X"00";
            REG_VALUE_0B            <= X"00";
            REG_VALUE_0C            <= X"00";
            REG_VALUE_0D            <= X"00";
            REG_VALUE_0E            <= X"00";
            REG_VALUE_0F            <= X"00";
            REG_VALUE_10            <= X"00";
            REG_VALUE_11            <= X"00";
            REG_VALUE_12            <= X"00";
            REG_VALUE_13            <= X"00";
            REG_VALUE_14            <= X"00";
            REG_VALUE_15            <= X"00";
            REG_VALUE_16            <= X"00";
            REG_VALUE_17            <= X"00";
            REG_VALUE_18            <= X"00";
            REG_VALUE_19            <= X"00";
            REG_VALUE_1A            <= X"00";
            REG_VALUE_1B            <= X"00";
            REG_VALUE_1C            <= X"00";
            REG_VALUE_1D            <= X"00";
            REG_VALUE_1E            <= X"00";
            REG_VALUE_1F            <= X"00";
            REG_VALUE_20            <= X"00";
            REG_VALUE_21            <= X"00";
            REG_VALUE_22            <= X"00";
            REG_VALUE_23            <= X"00";
            REG_VALUE_24            <= X"00";
            REG_VALUE_25            <= X"00";
            REG_VALUE_26            <= X"00";
            REG_VALUE_27            <= X"00";
            REG_VALUE_28            <= X"00";
            REG_VALUE_29            <= X"00";
            REG_VALUE_2A            <= X"00";
            REG_VALUE_2B            <= X"00";
            REG_VALUE_2C            <= X"00";
            REG_VALUE_2D            <= X"00";
            REG_VALUE_2E            <= X"00";
            REG_VALUE_2F            <= X"00";
            REG_VALUE_30            <= X"00";
            REG_VALUE_31            <= X"00";
            REG_VALUE_32            <= X"00";
            REG_VALUE_33            <= X"00";
            REG_VALUE_34            <= X"00";
            REG_VALUE_35            <= X"00";
            REG_VALUE_36            <= X"00";
            REG_VALUE_37            <= X"00";
            REG_VALUE_38            <= X"00";
            REG_VALUE_39            <= X"00";
            REG_VALUE_3A            <= X"00";
            REG_VALUE_3B            <= X"00";
            REG_VALUE_3C            <= X"73";
            REG_VALUE_3D            <= X"00";
            REG_VALUE_3E            <= X"00";
            REG_VALUE_3F            <= X"00";
            REG_VALUE_40            <= X"05";
            REG_VALUE_41            <= X"00";
            REG_VALUE_42            <= X"00";
            REG_VALUE_43            <= X"00";
            REG_VALUE_44            <= X"00";
            REG_VALUE_45            <= X"00";
            REG_VALUE_46            <= X"00";
            REG_VALUE_47            <= X"00";
            REG_VALUE_48            <= X"F0";
            REG_VALUE_49            <= X"00";
            REG_VALUE_4A            <= X"00";
            REG_VALUE_4B            <= X"00";
            REG_VALUE_4C            <= X"A0";
            REG_VALUE_4D            <= X"A0";
            REG_VALUE_4E            <= X"A0";
            REG_VALUE_4F            <= X"A0";
            REG_VALUE_50            <= X"A0";
            REG_VALUE_51            <= X"A0";
            REG_VALUE_52            <= X"00";
            REG_VALUE_53            <= X"00";
            REG_VALUE_54            <= X"00";
            REG_VALUE_55            <= X"00";
            REG_VALUE_56            <= X"00";
            REG_VALUE_57            <= X"00";
            REG_VALUE_58            <= X"00";
            REG_VALUE_59            <= X"00";
            REG_VALUE_5A            <= X"00";
            REG_VALUE_5B            <= X"00";
            REG_VALUE_5C            <= X"00";
            REG_VALUE_5D            <= X"00";
            REG_VALUE_5E            <= X"00";
            REG_VALUE_5F            <= X"00";
            REG_VALUE_60            <= X"00";
            REG_VALUE_61            <= X"00";
            REG_VALUE_62            <= X"00";
            REG_VALUE_63            <= X"00";
            REG_VALUE_64            <= X"00";
            REG_VALUE_65            <= X"00";
            REG_VALUE_66            <= X"00";
            REG_VALUE_67            <= X"00";
            REG_VALUE_68            <= X"00";
            REG_VALUE_69            <= X"00";
            REG_VALUE_6A            <= X"00";
            REG_VALUE_6B            <= X"00";
            REG_VALUE_6C            <= X"00";
            REG_VALUE_6D            <= X"00";
            REG_VALUE_6E            <= X"00";
            REG_VALUE_6F            <= X"00";
            REG_VALUE_70            <= X"00";
            REG_VALUE_71            <= X"00";
            REG_VALUE_72            <= X"00";
            REG_VALUE_73            <= X"00";
            REG_VALUE_74            <= X"01";
            REG_VALUE_75            <= X"03";
            REG_VALUE_76            <= X"00";
            REG_VALUE_77            <= X"00";
            REG_VALUE_78            <= X"00";
            REG_VALUE_79            <= X"00";
            REG_VALUE_7A            <= X"00";
            REG_VALUE_7B            <= X"00";
            REG_VALUE_7C            <= X"00";
            REG_VALUE_7D            <= X"00";
            REG_VALUE_7E            <= X"00";
            REG_VALUE_7F            <= X"00";
            REG_VALUE_80            <= X"00";
            REG_VALUE_81            <= X"00";
            REG_VALUE_82            <= X"00";
            REG_VALUE_83            <= X"00";
            REG_VALUE_84            <= X"00";
            REG_VALUE_85            <= X"00";
            REG_VALUE_86            <= X"00";
            REG_VALUE_87            <= X"00";
            REG_VALUE_88            <= X"84";
            REG_VALUE_89            <= X"7F";
            REG_VALUE_8A            <= X"7F";
            REG_VALUE_8B            <= X"7F";
            REG_VALUE_8C            <= X"7F";
            REG_VALUE_8D            <= X"7F";
            REG_VALUE_8E            <= X"7F";
            REG_VALUE_8F            <= X"7F";
            REG_VALUE_90            <= X"82";
            REG_VALUE_91            <= X"7F";
            REG_VALUE_92            <= X"7F";
            REG_VALUE_93            <= X"7F";
            REG_VALUE_94            <= X"8A";
            REG_VALUE_95            <= X"7F";
            REG_VALUE_96            <= X"7F";
            REG_VALUE_97            <= X"7F";
            REG_VALUE_98            <= X"7F";
            REG_VALUE_99            <= X"7F";
            REG_VALUE_9A            <= X"7F";
            REG_VALUE_9B            <= X"7F";
            REG_VALUE_9C            <= X"81";
            REG_VALUE_9D            <= X"7F";
            REG_VALUE_9E            <= X"7F";
            REG_VALUE_9F            <= X"7F";
            REG_VALUE_A0            <= X"7F";
            REG_VALUE_A1            <= X"7F";
            REG_VALUE_A2            <= X"7F";
            REG_VALUE_A3            <= X"7F";
            REG_VALUE_A4            <= X"7F";
            REG_VALUE_A5            <= X"7F";
            REG_VALUE_A6            <= X"7F";
            REG_VALUE_A7            <= X"7F";
            REG_VALUE_A8            <= X"7F";
            REG_VALUE_A9            <= X"7F";
            REG_VALUE_AA            <= X"7F";
            REG_VALUE_AB            <= X"7F";
            REG_VALUE_AC            <= X"00";
            REG_VALUE_AD            <= X"00";
            REG_VALUE_AE            <= X"00";
            REG_VALUE_AF            <= X"00";
            REG_VALUE_B0            <= X"00";
            REG_VALUE_B1            <= X"00";
            REG_VALUE_B2            <= X"00";
            REG_VALUE_B3            <= X"00";
            REG_VALUE_B4            <= X"00";
            REG_VALUE_B5            <= X"00";
            REG_VALUE_B6            <= X"00";
            REG_VALUE_B7            <= X"00";
            REG_VALUE_B8            <= X"11";
            REG_VALUE_B9            <= X"11";
            REG_VALUE_BA            <= X"11";
            REG_VALUE_BB            <= X"11";
            REG_VALUE_BC            <= X"11";
            REG_VALUE_BD            <= X"11";
            REG_VALUE_BE            <= X"AE";
            REG_VALUE_BF            <= X"AE";
            REG_VALUE_C0            <= X"AE";
            REG_VALUE_C1            <= X"AE";
            REG_VALUE_C2            <= X"AE";
            REG_VALUE_C3            <= X"AE";
            REG_VALUE_C4            <= X"6D";
            REG_VALUE_C5            <= X"24";
            REG_VALUE_C6            <= X"24";
            REG_VALUE_C7            <= X"24";
            REG_VALUE_C8            <= X"24";
            REG_VALUE_C9            <= X"24";
            REG_VALUE_CA            <= X"49";
            REG_VALUE_CB            <= X"49";
            REG_VALUE_CC            <= X"4B";
            REG_VALUE_CD            <= X"49";
            REG_VALUE_CE            <= X"49";
            REG_VALUE_CF            <= X"49";
--
SMCLKLOAD : PROCESS(RESET,CLOCK)
BEGIN
IF (RESET = '1') THEN
   SM_CLOCK_LOAD    <= SM_CLOCK_LOAD_IDLE;
	IDT5V19EE901_LOADER_WRITE <= '0';
ELSIF (CLOCK'EVENT  AND CLOCK='1') THEN

   CASE SM_CLOCK_LOAD IS
      WHEN SM_CLOCK_LOAD_IDLE                  => 
			IDT5V19EE901_LOADER_WRITE <= '1';
         SM_CLOCK_LOAD <= SM_CLOCK_LOAD_START;   

      WHEN SM_CLOCK_LOAD_START                  => 
			-- START LOADER
         IF (IDT5V19EE901_LOADER_WRITE = '1') THEN
            SM_CLOCK_LOAD <= SM_CLOCK_LOAD_WAIT_BUSY;   
         ELSE
            SM_CLOCK_LOAD <= SM_CLOCK_LOAD_START;
         END IF;
         
      WHEN SM_CLOCK_LOAD_WAIT_BUSY  => 
			-- CHECK LOADER IS BUSY
         IF (IDT5V19EE901_LOADER_BUSY = '1') THEN
				IDT5V19EE901_LOADER_WRITE <= '0';
            SM_CLOCK_LOAD <= SM_CLOCK_LOAD_WAIT_DONE;   
         ELSE
            SM_CLOCK_LOAD <= SM_CLOCK_LOAD_WAIT_BUSY;
         END IF;

      WHEN SM_CLOCK_LOAD_WAIT_DONE  => 
			-- WAIT UNTIL LOADER IS DONE
         IF (IDT5V19EE901_LOADER_BUSY = '0') THEN
            SM_CLOCK_LOAD <= SM_CLOCK_LOAD_HOLD ;   
         ELSE
            SM_CLOCK_LOAD <= SM_CLOCK_LOAD_WAIT_DONE;
         END IF;     
			
      WHEN SM_CLOCK_LOAD_HOLD  => 
				-- HOLD HERE WERE DONE
            SM_CLOCK_LOAD <= SM_CLOCK_LOAD_HOLD ;   
  
   END CASE;
END IF;
END PROCESS SMCLKLOAD;
--
-- ASSIGN PINS
--
CLK_SCLK             	<= IDT5V19EE901_SCLK;
CLK_SDAT             	<= IDT5V19EE901_SDAT_OUT WHEN (IDT5V19EE901_SDAT_OE = '1') ELSE 'Z';                   
IDT5V19EE901_SDAT_IN 	<= CLK_SDAT;
--
IDT_SCLK    				<= IDT5V19EE901_SCLK;
IDT_SDAT_OUT				<= IDT5V19EE901_SDAT_OUT;
IDT_SDAT_OE 				<= IDT5V19EE901_SDAT_OE;
IDT_SDAT_IN					<= IDT5V19EE901_SDAT_IN;
--
END RTL;







