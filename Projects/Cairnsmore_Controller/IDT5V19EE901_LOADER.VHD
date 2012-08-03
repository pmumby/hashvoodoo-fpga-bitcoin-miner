--READ CYCLE IS NOT YET DEBUGGED

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY IDT5V19EE901_LOADER IS

GENERIC( CLOCK_FREQ_IN_MHZ       :           INTEGER RANGE 0 TO 500:=25);                                     

PORT(    CLOCK                   :     IN    STD_LOGIC;
         RESET                   :     IN    STD_LOGIC;
         CLOCK_EN_200KHZ         :     OUT   STD_LOGIC;

         START_ADDRESS           :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);
         END_ADDRESS             :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);
         DEVICE_ADDRESS          :     IN    STD_LOGIC_VECTOR( 6 DOWNTO 0); 
         REQUEST_WRITE           :     IN    STD_LOGIC;
         REQUEST_READ            :     IN    STD_LOGIC;                       --NOT IMPLEMENTED YET
         REQUEST_EEPROM_STORE    :     IN    STD_LOGIC;                       --NOT IMPLEMENTED YET
         REQUEST_EEPROM_RESTORE  :     IN    STD_LOGIC;                       --NOT IMPLEMENTED YET
         LOADER_BUSY             :     OUT   STD_LOGIC;
      
         READ_DATA               :     OUT   STD_LOGIC_VECTOR( 7 DOWNTO 0);
         READ_ADDRESS            :     OUT   STD_LOGIC_VECTOR( 7 DOWNTO 0);
         READ_DATA_VALID         :     OUT   STD_LOGIC;
      
         REG_VALUE_00            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_01            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_02            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_03            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_04            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_05            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_06            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_07            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_08            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_09            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0A            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0B            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0C            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0D            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0E            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_0F            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      

         REG_VALUE_10            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_11            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_12            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_13            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_14            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_15            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_16            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_17            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_18            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_19            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1A            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1B            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1C            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1D            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1E            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_1F            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      

         REG_VALUE_20            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_21            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_22            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_23            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_24            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_25            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_26            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_27            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_28            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_29            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2A            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2B            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2C            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2D            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2E            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_2F            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      

         REG_VALUE_30            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_31            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_32            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_33            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_34            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_35            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_36            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_37            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_38            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_39            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3A            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3B            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3C            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3D            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3E            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_3F            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      

         REG_VALUE_40            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_41            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_42            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_43            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_44            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_45            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_46            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_47            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_48            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_49            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4A            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4B            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4C            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4D            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4E            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_4F            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      

         REG_VALUE_50            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_51            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_52            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_53            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_54            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_55            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_56            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_57            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_58            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_59            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5A            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5B            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5C            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5D            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5E            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_5F            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    
      
         REG_VALUE_60            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_61            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_62            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_63            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_64            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_65            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_66            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_67            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_68            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_69            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6A            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6B            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6C            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6D            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6E            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_6F            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_70            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_71            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_72            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_73            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_74            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_75            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_76            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_77            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_78            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_79            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7A            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7B            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7C            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7D            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7E            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_7F            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_80            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_81            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_82            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_83            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_84            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_85            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_86            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_87            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_88            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_89            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8A            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8B            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8C            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8D            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8E            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_8F            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_90            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_91            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_92            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_93            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_94            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_95            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_96            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_97            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_98            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_99            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9A            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9B            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9C            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9D            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9E            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_9F            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_A0            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A1            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A2            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A3            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A4            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A5            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A6            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A7            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A8            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_A9            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AA            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AB            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AC            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AD            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AE            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_AF            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_B0            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B1            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B2            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B3            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B4            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B5            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B6            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B7            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B8            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_B9            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BA            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BB            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BC            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BD            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BE            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_BF            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         REG_VALUE_C0            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C1            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C2            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C3            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C4            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C5            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C6            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C7            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C8            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_C9            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CA            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CB            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CC            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CD            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CE            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);      
         REG_VALUE_CF            :     IN    STD_LOGIC_VECTOR( 7 DOWNTO 0);    

         IDT5V19EE901_SCLK       :     OUT   STD_LOGIC;
         IDT5V19EE901_SDAT_OUT   :     OUT   STD_LOGIC;  
         IDT5V19EE901_SDAT_OE    :     OUT   STD_LOGIC;  
         IDT5V19EE901_SDAT_IN    :     IN    STD_LOGIC  

    );
END IDT5V19EE901_LOADER;

ARCHITECTURE A0 OF IDT5V19EE901_LOADER  IS

CONSTANT WRITE_VALUE             :  STD_LOGIC:='0';
CONSTANT COMMAND_WR              :  STD_LOGIC_VECTOR( 7 DOWNTO 0):="00000000";

SIGNAL CURRENT_ADDRESS          : STD_LOGIC_VECTOR( 7 DOWNTO 0);

TYPE SM_IDT5V19EE901_LOADER_TYPE IS ( SM_IDT5V19EE901_LOADER_IDLE                    ,

                                 SM_IDT5V19EE901_LOADER_SDAT_START_LOW_CLOCK_HIGH          ,
                                 SM_IDT5V19EE901_LOADER_SDAT_START_LOW_CLOCK_LOW          ,

                                 SM_IDT5V19EE901_LOADER_DADDRESS6_CLOCK_LOW     ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS6_CLOCK_HIGH    ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS5_CLOCK_LOW     ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS5_CLOCK_HIGH    ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS4_CLOCK_LOW     ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS4_CLOCK_HIGH    ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS3_CLOCK_LOW     ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS3_CLOCK_HIGH    ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS2_CLOCK_LOW     ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS2_CLOCK_HIGH    ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS1_CLOCK_LOW     ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS1_CLOCK_HIGH    ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS0_CLOCK_LOW     ,
                                 SM_IDT5V19EE901_LOADER_DADDRESS0_CLOCK_HIGH    ,
                                 SM_IDT5V19EE901_LOADER_WRITE_CLOCK_LOW         ,
                                 SM_IDT5V19EE901_LOADER_WRITE_CLOCK_HIGH        ,  
                                 SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_LOW   ,
                                 SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_HIGH  ,  

                                 SM_IDT5V19EE901_LOADER_WR_COMMAND7_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND7_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND6_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND6_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND5_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND5_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND4_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND4_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND3_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND3_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND2_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND2_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND1_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND1_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND0_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMAND0_CLOCK_HIGH     , 
                                 SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_LOW    ,
                                 SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_HIGH   , 

                                 SM_IDT5V19EE901_LOADER_ADDRESS7_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS7_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS6_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS6_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS5_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS5_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS4_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS4_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS3_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS3_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS2_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS2_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS1_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS1_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS0_CLOCK_LOW      ,
                                 SM_IDT5V19EE901_LOADER_ADDRESS0_CLOCK_HIGH     ,
                                 SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_LOW    ,
                                 SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_HIGH   ,  

                                 SM_IDT5V19EE901_LOADER_WRDATA7_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_WRDATA7_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_WRDATA6_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_WRDATA6_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_WRDATA5_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_WRDATA5_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_WRDATA4_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_WRDATA4_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_WRDATA3_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_WRDATA3_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_WRDATA2_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_WRDATA2_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_WRDATA1_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_WRDATA1_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_WRDATA0_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_WRDATA0_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_LOW     ,
                                 SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_HIGH    ,  

                                 SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_LOW       ,
                                 SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_HIGH      ,
                                 SM_IDT5V19EE901_LOADER_RDDATAACK_CLOCK_LOW     ,
                                 SM_IDT5V19EE901_LOADER_RDDATAACK_CLOCK_HIGH    ,  

                                 SM_IDT5V19EE901_LOADER_STOP7_CLOCK_LOW         ,
                                 SM_IDT5V19EE901_LOADER_STOP7_CLOCK_HIGH        ,
                                 SM_IDT5V19EE901_LOADER_STOP6_CLOCK_LOW         ,
                                 SM_IDT5V19EE901_LOADER_STOP6_CLOCK_HIGH        ,
                                 SM_IDT5V19EE901_LOADER_STOP5_CLOCK_LOW         ,
                                 SM_IDT5V19EE901_LOADER_STOP5_CLOCK_HIGH        ,
                                 SM_IDT5V19EE901_LOADER_STOP4_CLOCK_LOW         ,
                                 SM_IDT5V19EE901_LOADER_STOP4_CLOCK_HIGH        ,
                                 SM_IDT5V19EE901_LOADER_STOP3_CLOCK_LOW         ,
                                 SM_IDT5V19EE901_LOADER_STOP3_CLOCK_HIGH        ,
                                 SM_IDT5V19EE901_LOADER_STOP2_CLOCK_LOW         ,
                                 SM_IDT5V19EE901_LOADER_STOP2_CLOCK_HIGH        ,
                                 SM_IDT5V19EE901_LOADER_STOP1_CLOCK_LOW         ,
                                 SM_IDT5V19EE901_LOADER_STOP1_CLOCK_HIGH        ,
                                 SM_IDT5V19EE901_LOADER_STOP0_CLOCK_LOW         ,
                                 SM_IDT5V19EE901_LOADER_STOP0_CLOCK_HIGH        );
                                 
                                 
SIGNAL SM_IDT5V19EE901_LOADER            :  SM_IDT5V19EE901_LOADER_TYPE;                                 

SIGNAL INT_IDT5V19EE901_SCLK             :  STD_LOGIC;
SIGNAL INT_IDT5V19EE901_SDAT_OUT         :  STD_LOGIC;
SIGNAL MUXED_DATA                   :  STD_LOGIC_VECTOR( 7 DOWNTO 0);
SIGNAL SHIFT_REGISTER               :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL INT_READ_DATA                :  STD_LOGIC_VECTOR( 7 DOWNTO 0);
SIGNAL INT_READ_ADDRESS             :  STD_LOGIC_VECTOR( 7 DOWNTO 0);

SIGNAL IDT5V19EE901_SDAT_OUT_1           :  STD_LOGIC; 
SIGNAL IDT5V19EE901_SDAT_OUT_2           :  STD_LOGIC; 
SIGNAL IDT5V19EE901_SDAT_OUT_3           :  STD_LOGIC; 
SIGNAL IDT5V19EE901_SDAT_OUT_4           :  STD_LOGIC; 
SIGNAL IDT5V19EE901_SDAT_OUT_5           :  STD_LOGIC; 

SIGNAL CLOCK_EN_COUNTER          : INTEGER RANGE 0 TO 65536;
SIGNAL CLOCK_ENABLE          : STD_LOGIC;

   
BEGIN



CLKEN : PROCESS(RESET,CLOCK)
BEGIN
IF (RESET = '1') THEN
   CLOCK_EN_COUNTER  <= ((CLOCK_FREQ_IN_MHZ * 5) - 1);
   CLOCK_ENABLE      <= '0';
ELSIF (CLOCK'EVENT  AND CLOCK='1') THEN
   IF (CLOCK_EN_COUNTER = 0) THEN
      CLOCK_EN_COUNTER  <= ((CLOCK_FREQ_IN_MHZ * 5) - 1);
      CLOCK_ENABLE      <= '1';
   ELSE
      CLOCK_EN_COUNTER <= CLOCK_EN_COUNTER -1;
      CLOCK_ENABLE      <= '0';
   END IF;   
END IF;
END PROCESS CLKEN;


CLOCK_EN_200KHZ <= CLOCK_ENABLE;


MUX : PROCESS(RESET,CLOCK)
BEGIN
IF (RESET = '1') THEN
   MUXED_DATA <= (OTHERS => '0');
   
ELSIF (CLOCK'EVENT  AND CLOCK='1') THEN
   CASE CURRENT_ADDRESS IS
      WHEN X"00" => MUXED_DATA <= REG_VALUE_00;
      WHEN X"01" => MUXED_DATA <= REG_VALUE_01;
      WHEN X"02" => MUXED_DATA <= REG_VALUE_02;
      WHEN X"03" => MUXED_DATA <= REG_VALUE_03;
      WHEN X"04" => MUXED_DATA <= REG_VALUE_04;
      WHEN X"05" => MUXED_DATA <= REG_VALUE_05;
      WHEN X"06" => MUXED_DATA <= REG_VALUE_06;
      WHEN X"07" => MUXED_DATA <= REG_VALUE_07;
      WHEN X"08" => MUXED_DATA <= REG_VALUE_08;
      WHEN X"09" => MUXED_DATA <= REG_VALUE_09;
      WHEN X"0A" => MUXED_DATA <= REG_VALUE_0A;
      WHEN X"0B" => MUXED_DATA <= REG_VALUE_0B;
      WHEN X"0C" => MUXED_DATA <= REG_VALUE_0C;
      WHEN X"0D" => MUXED_DATA <= REG_VALUE_0D;
      WHEN X"0E" => MUXED_DATA <= REG_VALUE_0E;
      WHEN X"0F" => MUXED_DATA <= REG_VALUE_0F;

      WHEN X"10" => MUXED_DATA <= REG_VALUE_10;
      WHEN X"11" => MUXED_DATA <= REG_VALUE_11;
      WHEN X"12" => MUXED_DATA <= REG_VALUE_12;
      WHEN X"13" => MUXED_DATA <= REG_VALUE_13;
      WHEN X"14" => MUXED_DATA <= REG_VALUE_14;
      WHEN X"15" => MUXED_DATA <= REG_VALUE_15;
      WHEN X"16" => MUXED_DATA <= REG_VALUE_16;
      WHEN X"17" => MUXED_DATA <= REG_VALUE_17;
      WHEN X"18" => MUXED_DATA <= REG_VALUE_18;
      WHEN X"19" => MUXED_DATA <= REG_VALUE_19;
      WHEN X"1A" => MUXED_DATA <= REG_VALUE_1A;
      WHEN X"1B" => MUXED_DATA <= REG_VALUE_1B;
      WHEN X"1C" => MUXED_DATA <= REG_VALUE_1C;
      WHEN X"1D" => MUXED_DATA <= REG_VALUE_1D;
      WHEN X"1E" => MUXED_DATA <= REG_VALUE_1E;
      WHEN X"1F" => MUXED_DATA <= REG_VALUE_1F;

      WHEN X"20" => MUXED_DATA <= REG_VALUE_20;
      WHEN X"21" => MUXED_DATA <= REG_VALUE_21;
      WHEN X"22" => MUXED_DATA <= REG_VALUE_22;
      WHEN X"23" => MUXED_DATA <= REG_VALUE_23;
      WHEN X"24" => MUXED_DATA <= REG_VALUE_24;
      WHEN X"25" => MUXED_DATA <= REG_VALUE_25;
      WHEN X"26" => MUXED_DATA <= REG_VALUE_26;
      WHEN X"27" => MUXED_DATA <= REG_VALUE_27;
      WHEN X"28" => MUXED_DATA <= REG_VALUE_28;
      WHEN X"29" => MUXED_DATA <= REG_VALUE_29;
      WHEN X"2A" => MUXED_DATA <= REG_VALUE_2A;
      WHEN X"2B" => MUXED_DATA <= REG_VALUE_2B;
      WHEN X"2C" => MUXED_DATA <= REG_VALUE_2C;
      WHEN X"2D" => MUXED_DATA <= REG_VALUE_2D;
      WHEN X"2E" => MUXED_DATA <= REG_VALUE_2E;
      WHEN X"2F" => MUXED_DATA <= REG_VALUE_2F;

      WHEN X"30" => MUXED_DATA <= REG_VALUE_30;
      WHEN X"31" => MUXED_DATA <= REG_VALUE_31;
      WHEN X"32" => MUXED_DATA <= REG_VALUE_32;
      WHEN X"33" => MUXED_DATA <= REG_VALUE_33;
      WHEN X"34" => MUXED_DATA <= REG_VALUE_34;
      WHEN X"35" => MUXED_DATA <= REG_VALUE_35;
      WHEN X"36" => MUXED_DATA <= REG_VALUE_36;
      WHEN X"37" => MUXED_DATA <= REG_VALUE_37;
      WHEN X"38" => MUXED_DATA <= REG_VALUE_38;
      WHEN X"39" => MUXED_DATA <= REG_VALUE_39;
      WHEN X"3A" => MUXED_DATA <= REG_VALUE_3A;
      WHEN X"3B" => MUXED_DATA <= REG_VALUE_3B;
      WHEN X"3C" => MUXED_DATA <= REG_VALUE_3C;
      WHEN X"3D" => MUXED_DATA <= REG_VALUE_3D;
      WHEN X"3E" => MUXED_DATA <= REG_VALUE_3E;
      WHEN X"3F" => MUXED_DATA <= REG_VALUE_3F;

      WHEN X"40" => MUXED_DATA <= REG_VALUE_40;
      WHEN X"41" => MUXED_DATA <= REG_VALUE_41;
      WHEN X"42" => MUXED_DATA <= REG_VALUE_42;
      WHEN X"43" => MUXED_DATA <= REG_VALUE_43;
      WHEN X"44" => MUXED_DATA <= REG_VALUE_44;
      WHEN X"45" => MUXED_DATA <= REG_VALUE_45;
      WHEN X"46" => MUXED_DATA <= REG_VALUE_46;
      WHEN X"47" => MUXED_DATA <= REG_VALUE_47;
      WHEN X"48" => MUXED_DATA <= REG_VALUE_48;
      WHEN X"49" => MUXED_DATA <= REG_VALUE_49;
      WHEN X"4A" => MUXED_DATA <= REG_VALUE_4A;
      WHEN X"4B" => MUXED_DATA <= REG_VALUE_4B;
      WHEN X"4C" => MUXED_DATA <= REG_VALUE_4C;
      WHEN X"4D" => MUXED_DATA <= REG_VALUE_4D;
      WHEN X"4E" => MUXED_DATA <= REG_VALUE_4E;
      WHEN X"4F" => MUXED_DATA <= REG_VALUE_4F;

      WHEN X"50" => MUXED_DATA <= REG_VALUE_50;
      WHEN X"51" => MUXED_DATA <= REG_VALUE_51;
      WHEN X"52" => MUXED_DATA <= REG_VALUE_52;
      WHEN X"53" => MUXED_DATA <= REG_VALUE_53;
      WHEN X"54" => MUXED_DATA <= REG_VALUE_54;
      WHEN X"55" => MUXED_DATA <= REG_VALUE_55;
      WHEN X"56" => MUXED_DATA <= REG_VALUE_56;
      WHEN X"57" => MUXED_DATA <= REG_VALUE_57;
      WHEN X"58" => MUXED_DATA <= REG_VALUE_58;
      WHEN X"59" => MUXED_DATA <= REG_VALUE_59;
      WHEN X"5A" => MUXED_DATA <= REG_VALUE_5A;
      WHEN X"5B" => MUXED_DATA <= REG_VALUE_5B;
      WHEN X"5C" => MUXED_DATA <= REG_VALUE_5C;
      WHEN X"5D" => MUXED_DATA <= REG_VALUE_5D;
      WHEN X"5E" => MUXED_DATA <= REG_VALUE_5E;
      WHEN X"5F" => MUXED_DATA <= REG_VALUE_5F;

      WHEN X"60" => MUXED_DATA <= REG_VALUE_60;
      WHEN X"61" => MUXED_DATA <= REG_VALUE_61;
      WHEN X"62" => MUXED_DATA <= REG_VALUE_62;
      WHEN X"63" => MUXED_DATA <= REG_VALUE_63;
      WHEN X"64" => MUXED_DATA <= REG_VALUE_64;
      WHEN X"65" => MUXED_DATA <= REG_VALUE_65;
      WHEN X"66" => MUXED_DATA <= REG_VALUE_66;
      WHEN X"67" => MUXED_DATA <= REG_VALUE_67;
      WHEN X"68" => MUXED_DATA <= REG_VALUE_68;
      WHEN X"69" => MUXED_DATA <= REG_VALUE_69;
      WHEN X"6A" => MUXED_DATA <= REG_VALUE_6A;
      WHEN X"6B" => MUXED_DATA <= REG_VALUE_6B;
      WHEN X"6C" => MUXED_DATA <= REG_VALUE_6C;
      WHEN X"6D" => MUXED_DATA <= REG_VALUE_6D;
      WHEN X"6E" => MUXED_DATA <= REG_VALUE_6E;
      WHEN X"6F" => MUXED_DATA <= REG_VALUE_6F;

      WHEN X"70" => MUXED_DATA <= REG_VALUE_70;
      WHEN X"71" => MUXED_DATA <= REG_VALUE_71;
      WHEN X"72" => MUXED_DATA <= REG_VALUE_72;
      WHEN X"73" => MUXED_DATA <= REG_VALUE_73;
      WHEN X"74" => MUXED_DATA <= REG_VALUE_74;
      WHEN X"75" => MUXED_DATA <= REG_VALUE_75;
      WHEN X"76" => MUXED_DATA <= REG_VALUE_76;
      WHEN X"77" => MUXED_DATA <= REG_VALUE_77;
      WHEN X"78" => MUXED_DATA <= REG_VALUE_78;
      WHEN X"79" => MUXED_DATA <= REG_VALUE_79;
      WHEN X"7A" => MUXED_DATA <= REG_VALUE_7A;
      WHEN X"7B" => MUXED_DATA <= REG_VALUE_7B;
      WHEN X"7C" => MUXED_DATA <= REG_VALUE_7C;
      WHEN X"7D" => MUXED_DATA <= REG_VALUE_7D;
      WHEN X"7E" => MUXED_DATA <= REG_VALUE_7E;
      WHEN X"7F" => MUXED_DATA <= REG_VALUE_7F;

      WHEN X"80" => MUXED_DATA <= REG_VALUE_80;
      WHEN X"81" => MUXED_DATA <= REG_VALUE_81;
      WHEN X"82" => MUXED_DATA <= REG_VALUE_82;
      WHEN X"83" => MUXED_DATA <= REG_VALUE_83;
      WHEN X"84" => MUXED_DATA <= REG_VALUE_84;
      WHEN X"85" => MUXED_DATA <= REG_VALUE_85;
      WHEN X"86" => MUXED_DATA <= REG_VALUE_86;
      WHEN X"87" => MUXED_DATA <= REG_VALUE_87;
      WHEN X"88" => MUXED_DATA <= REG_VALUE_88;
      WHEN X"89" => MUXED_DATA <= REG_VALUE_89;
      WHEN X"8A" => MUXED_DATA <= REG_VALUE_8A;
      WHEN X"8B" => MUXED_DATA <= REG_VALUE_8B;
      WHEN X"8C" => MUXED_DATA <= REG_VALUE_8C;
      WHEN X"8D" => MUXED_DATA <= REG_VALUE_8D;
      WHEN X"8E" => MUXED_DATA <= REG_VALUE_8E;
      WHEN X"8F" => MUXED_DATA <= REG_VALUE_8F;

      WHEN X"90" => MUXED_DATA <= REG_VALUE_90;
      WHEN X"91" => MUXED_DATA <= REG_VALUE_91;
      WHEN X"92" => MUXED_DATA <= REG_VALUE_92;
      WHEN X"93" => MUXED_DATA <= REG_VALUE_93;
      WHEN X"94" => MUXED_DATA <= REG_VALUE_94;
      WHEN X"95" => MUXED_DATA <= REG_VALUE_95;
      WHEN X"96" => MUXED_DATA <= REG_VALUE_96;
      WHEN X"97" => MUXED_DATA <= REG_VALUE_97;
      WHEN X"98" => MUXED_DATA <= REG_VALUE_98;
      WHEN X"99" => MUXED_DATA <= REG_VALUE_99;
      WHEN X"9A" => MUXED_DATA <= REG_VALUE_9A;
      WHEN X"9B" => MUXED_DATA <= REG_VALUE_9B;
      WHEN X"9C" => MUXED_DATA <= REG_VALUE_9C;
      WHEN X"9D" => MUXED_DATA <= REG_VALUE_9D;
      WHEN X"9E" => MUXED_DATA <= REG_VALUE_9E;
      WHEN X"9F" => MUXED_DATA <= REG_VALUE_9F;

      WHEN X"A0" => MUXED_DATA <= REG_VALUE_A0;
      WHEN X"A1" => MUXED_DATA <= REG_VALUE_A1;
      WHEN X"A2" => MUXED_DATA <= REG_VALUE_A2;
      WHEN X"A3" => MUXED_DATA <= REG_VALUE_A3;
      WHEN X"A4" => MUXED_DATA <= REG_VALUE_A4;
      WHEN X"A5" => MUXED_DATA <= REG_VALUE_A5;
      WHEN X"A6" => MUXED_DATA <= REG_VALUE_A6;
      WHEN X"A7" => MUXED_DATA <= REG_VALUE_A7;
      WHEN X"A8" => MUXED_DATA <= REG_VALUE_A8;
      WHEN X"A9" => MUXED_DATA <= REG_VALUE_A9;
      WHEN X"AA" => MUXED_DATA <= REG_VALUE_AA;
      WHEN X"AB" => MUXED_DATA <= REG_VALUE_AB;
      WHEN X"AC" => MUXED_DATA <= REG_VALUE_AC;
      WHEN X"AD" => MUXED_DATA <= REG_VALUE_AD;
      WHEN X"AE" => MUXED_DATA <= REG_VALUE_AE;
      WHEN X"AF" => MUXED_DATA <= REG_VALUE_AF;

      WHEN X"B0" => MUXED_DATA <= REG_VALUE_B0;
      WHEN X"B1" => MUXED_DATA <= REG_VALUE_B1;
      WHEN X"B2" => MUXED_DATA <= REG_VALUE_B2;
      WHEN X"B3" => MUXED_DATA <= REG_VALUE_B3;
      WHEN X"B4" => MUXED_DATA <= REG_VALUE_B4;
      WHEN X"B5" => MUXED_DATA <= REG_VALUE_B5;
      WHEN X"B6" => MUXED_DATA <= REG_VALUE_B6;
      WHEN X"B7" => MUXED_DATA <= REG_VALUE_B7;
      WHEN X"B8" => MUXED_DATA <= REG_VALUE_B8;
      WHEN X"B9" => MUXED_DATA <= REG_VALUE_B9;
      WHEN X"BA" => MUXED_DATA <= REG_VALUE_BA;
      WHEN X"BB" => MUXED_DATA <= REG_VALUE_BB;
      WHEN X"BC" => MUXED_DATA <= REG_VALUE_BC;
      WHEN X"BD" => MUXED_DATA <= REG_VALUE_BD;
      WHEN X"BE" => MUXED_DATA <= REG_VALUE_BE;
      WHEN X"BF" => MUXED_DATA <= REG_VALUE_BF;

      WHEN X"C0" => MUXED_DATA <= REG_VALUE_C0;
      WHEN X"C1" => MUXED_DATA <= REG_VALUE_C1;
      WHEN X"C2" => MUXED_DATA <= REG_VALUE_C2;
      WHEN X"C3" => MUXED_DATA <= REG_VALUE_C3;
      WHEN X"C4" => MUXED_DATA <= REG_VALUE_C4;
      WHEN X"C5" => MUXED_DATA <= REG_VALUE_C5;
      WHEN X"C6" => MUXED_DATA <= REG_VALUE_C6;
      WHEN X"C7" => MUXED_DATA <= REG_VALUE_C7;
      WHEN X"C8" => MUXED_DATA <= REG_VALUE_C8;
      WHEN X"C9" => MUXED_DATA <= REG_VALUE_C9;
      WHEN X"CA" => MUXED_DATA <= REG_VALUE_CA;
      WHEN X"CB" => MUXED_DATA <= REG_VALUE_CB;
      WHEN X"CC" => MUXED_DATA <= REG_VALUE_CC;
      WHEN X"CD" => MUXED_DATA <= REG_VALUE_CD;
      WHEN X"CE" => MUXED_DATA <= REG_VALUE_CE;
      WHEN X"CF" => MUXED_DATA <= REG_VALUE_CF;

      WHEN OTHERS => MUXED_DATA <= REG_VALUE_5F;
   END CASE;
   
END IF;
END PROCESS MUX;  


SM1 : PROCESS(RESET,CLOCK)
BEGIN
IF (RESET = '1') THEN
   SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_IDLE;
   LOADER_BUSY       <= '0';

ELSIF (CLOCK'EVENT  AND CLOCK='1') THEN
   IF (CLOCK_ENABLE = '1') THEN
      CASE SM_IDT5V19EE901_LOADER IS                                                                
         WHEN SM_IDT5V19EE901_LOADER_IDLE                    => 
            IF ((REQUEST_WRITE = '1') OR (REQUEST_READ = '1')) THEN
               SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_SDAT_START_LOW_CLOCK_HIGH;
            ELSE
               SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_IDLE;
            END IF;
         
         WHEN SM_IDT5V19EE901_LOADER_SDAT_START_LOW_CLOCK_HIGH         => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_SDAT_START_LOW_CLOCK_LOW     ;
         WHEN SM_IDT5V19EE901_LOADER_SDAT_START_LOW_CLOCK_LOW          => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS6_CLOCK_LOW     ;
                                                                                
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS6_CLOCK_LOW     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS6_CLOCK_HIGH    ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS6_CLOCK_HIGH    => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS5_CLOCK_LOW     ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS5_CLOCK_LOW     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS5_CLOCK_HIGH    ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS5_CLOCK_HIGH    => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS4_CLOCK_LOW     ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS4_CLOCK_LOW     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS4_CLOCK_HIGH    ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS4_CLOCK_HIGH    => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS3_CLOCK_LOW     ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS3_CLOCK_LOW     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS3_CLOCK_HIGH    ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS3_CLOCK_HIGH    => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS2_CLOCK_LOW     ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS2_CLOCK_LOW     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS2_CLOCK_HIGH    ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS2_CLOCK_HIGH    => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS1_CLOCK_LOW     ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS1_CLOCK_LOW     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS1_CLOCK_HIGH    ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS1_CLOCK_HIGH    => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS0_CLOCK_LOW     ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS0_CLOCK_LOW     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESS0_CLOCK_HIGH    ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS0_CLOCK_HIGH    => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRITE_CLOCK_LOW         ;
         WHEN SM_IDT5V19EE901_LOADER_WRITE_CLOCK_LOW         => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRITE_CLOCK_HIGH        ;
         WHEN SM_IDT5V19EE901_LOADER_WRITE_CLOCK_HIGH        => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_LOW   ;  
         WHEN SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_LOW   => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_HIGH  ;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_HIGH  => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND7_CLOCK_LOW   ;  

         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND7_CLOCK_LOW   => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND7_CLOCK_HIGH  ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND7_CLOCK_HIGH  => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND6_CLOCK_LOW   ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND6_CLOCK_LOW   => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND6_CLOCK_HIGH  ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND6_CLOCK_HIGH  => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND5_CLOCK_LOW   ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND5_CLOCK_LOW   => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND5_CLOCK_HIGH  ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND5_CLOCK_HIGH  => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND4_CLOCK_LOW   ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND4_CLOCK_LOW   => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND4_CLOCK_HIGH  ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND4_CLOCK_HIGH  => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND3_CLOCK_LOW   ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND3_CLOCK_LOW   => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND3_CLOCK_HIGH  ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND3_CLOCK_HIGH  => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND2_CLOCK_LOW   ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND2_CLOCK_LOW   => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND2_CLOCK_HIGH  ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND2_CLOCK_HIGH  => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND1_CLOCK_LOW   ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND1_CLOCK_LOW   => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND1_CLOCK_HIGH  ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND1_CLOCK_HIGH  => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND0_CLOCK_LOW   ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND0_CLOCK_LOW   => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMAND0_CLOCK_HIGH  ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND0_CLOCK_HIGH  => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_LOW ;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_LOW => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_HIGH;
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_HIGH=> SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS7_CLOCK_LOW      ;

         WHEN SM_IDT5V19EE901_LOADER_ADDRESS7_CLOCK_LOW      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS7_CLOCK_HIGH     ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS7_CLOCK_HIGH     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS6_CLOCK_LOW      ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS6_CLOCK_LOW      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS6_CLOCK_HIGH     ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS6_CLOCK_HIGH     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS5_CLOCK_LOW      ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS5_CLOCK_LOW      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS5_CLOCK_HIGH     ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS5_CLOCK_HIGH     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS4_CLOCK_LOW      ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS4_CLOCK_LOW      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS4_CLOCK_HIGH     ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS4_CLOCK_HIGH     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS3_CLOCK_LOW      ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS3_CLOCK_LOW      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS3_CLOCK_HIGH     ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS3_CLOCK_HIGH     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS2_CLOCK_LOW      ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS2_CLOCK_LOW      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS2_CLOCK_HIGH     ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS2_CLOCK_HIGH     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS1_CLOCK_LOW      ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS1_CLOCK_LOW      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS1_CLOCK_HIGH     ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS1_CLOCK_HIGH     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS0_CLOCK_LOW      ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS0_CLOCK_LOW      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESS0_CLOCK_HIGH     ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS0_CLOCK_HIGH     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_LOW    ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_LOW    => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_HIGH   ;
         WHEN SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_HIGH   => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA7_CLOCK_LOW       ;  
                                                                                 
         WHEN SM_IDT5V19EE901_LOADER_WRDATA7_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA7_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA7_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA6_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA6_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA6_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA6_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA5_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA5_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA5_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA5_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA4_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA4_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA4_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA4_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA3_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA3_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA3_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA3_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA2_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA2_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA2_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA2_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA1_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA1_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA1_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA1_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA0_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA0_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA0_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATA0_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_LOW     ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_LOW     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_HIGH    ;
         WHEN SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_HIGH    => 
            IF (CURRENT_ADDRESS = END_ADDRESS) THEN
               SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP7_CLOCK_LOW;  
            ELSE
               SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_WRDATA7_CLOCK_LOW;
            END IF;
                                                                                 
         WHEN SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_LOW       ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_LOW       => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_HIGH      ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_HIGH      => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATAACK_CLOCK_LOW     ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATAACK_CLOCK_LOW     => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATAACK_CLOCK_HIGH    ;
         WHEN SM_IDT5V19EE901_LOADER_RDDATAACK_CLOCK_HIGH    => 
            IF (CURRENT_ADDRESS = END_ADDRESS) THEN
               SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP7_CLOCK_LOW;  
            ELSE
               SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_LOW;
            END IF;

         WHEN SM_IDT5V19EE901_LOADER_STOP7_CLOCK_LOW         => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP7_CLOCK_HIGH        ;
         WHEN SM_IDT5V19EE901_LOADER_STOP7_CLOCK_HIGH        => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP6_CLOCK_LOW         ;
         WHEN SM_IDT5V19EE901_LOADER_STOP6_CLOCK_LOW         => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP6_CLOCK_HIGH        ;
         WHEN SM_IDT5V19EE901_LOADER_STOP6_CLOCK_HIGH        => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP5_CLOCK_LOW         ;
         WHEN SM_IDT5V19EE901_LOADER_STOP5_CLOCK_LOW         => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP5_CLOCK_HIGH        ;
         WHEN SM_IDT5V19EE901_LOADER_STOP5_CLOCK_HIGH        => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP4_CLOCK_LOW         ;
         WHEN SM_IDT5V19EE901_LOADER_STOP4_CLOCK_LOW         => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP4_CLOCK_HIGH        ;
         WHEN SM_IDT5V19EE901_LOADER_STOP4_CLOCK_HIGH        => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP3_CLOCK_LOW         ;
         WHEN SM_IDT5V19EE901_LOADER_STOP3_CLOCK_LOW         => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP3_CLOCK_HIGH        ;
         WHEN SM_IDT5V19EE901_LOADER_STOP3_CLOCK_HIGH        => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP2_CLOCK_LOW         ;
         WHEN SM_IDT5V19EE901_LOADER_STOP2_CLOCK_LOW         => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP2_CLOCK_HIGH        ;
         WHEN SM_IDT5V19EE901_LOADER_STOP2_CLOCK_HIGH        => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP1_CLOCK_LOW         ;
         WHEN SM_IDT5V19EE901_LOADER_STOP1_CLOCK_LOW         => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP1_CLOCK_HIGH        ;
         WHEN SM_IDT5V19EE901_LOADER_STOP1_CLOCK_HIGH        => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP0_CLOCK_LOW         ;
         WHEN SM_IDT5V19EE901_LOADER_STOP0_CLOCK_LOW         => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_STOP0_CLOCK_HIGH        ;
         WHEN SM_IDT5V19EE901_LOADER_STOP0_CLOCK_HIGH        => SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER_IDLE                    ;
      END CASE;
   ELSE
      SM_IDT5V19EE901_LOADER <= SM_IDT5V19EE901_LOADER;   
   END IF; 
   
   IF (SM_IDT5V19EE901_LOADER = SM_IDT5V19EE901_LOADER_IDLE) THEN
      LOADER_BUSY   <= '0';   
   ELSE
      LOADER_BUSY   <= '1';   
   END IF;  
END IF;
END PROCESS SM1;

ADDR : PROCESS(RESET,CLOCK)
BEGIN
IF (RESET = '1') THEN
   CURRENT_ADDRESS <= (OTHERS => '0');
   
ELSIF (CLOCK'EVENT  AND CLOCK='1') THEN
   IF (SM_IDT5V19EE901_LOADER = SM_IDT5V19EE901_LOADER_IDLE) THEN
      CURRENT_ADDRESS <= START_ADDRESS;
   ELSIF (CLOCK_ENABLE = '1') AND (SM_IDT5V19EE901_LOADER = SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_HIGH) THEN
      CURRENT_ADDRESS <= CURRENT_ADDRESS + 1;   
   ELSIF (CLOCK_ENABLE = '1') AND (SM_IDT5V19EE901_LOADER = SM_IDT5V19EE901_LOADER_RDDATAACK_CLOCK_HIGH) THEN
      CURRENT_ADDRESS <= CURRENT_ADDRESS + 1;   
   ELSE
      CURRENT_ADDRESS <= CURRENT_ADDRESS;   
   END IF;
END IF;
END PROCESS ADDR;


OPDATA : PROCESS(RESET,CLOCK)
BEGIN
IF (RESET = '1') THEN
   IDT5V19EE901_SDAT_OUT_1 <= '1';
   IDT5V19EE901_SDAT_OUT_2 <= '1';
   IDT5V19EE901_SDAT_OUT_3 <= '1';
   IDT5V19EE901_SDAT_OUT_4 <= '1';
   IDT5V19EE901_SDAT_OUT_5 <= '1';
   IDT5V19EE901_SDAT_OUT   <= '1';
   
ELSIF (CLOCK'EVENT  AND CLOCK='1') THEN
      CASE SM_IDT5V19EE901_LOADER IS                                                                
         WHEN SM_IDT5V19EE901_LOADER_IDLE                    => IDT5V19EE901_SDAT_OUT_1 <= '1';

         WHEN SM_IDT5V19EE901_LOADER_SDAT_START_LOW_CLOCK_HIGH          => IDT5V19EE901_SDAT_OUT_1 <= '0';
         WHEN SM_IDT5V19EE901_LOADER_SDAT_START_LOW_CLOCK_LOW           => IDT5V19EE901_SDAT_OUT_1 <= '0';
                                                                                
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS6_CLOCK_LOW       => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(6);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS6_CLOCK_HIGH      => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(6);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS5_CLOCK_LOW       => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(5);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS5_CLOCK_HIGH      => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(5);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS4_CLOCK_LOW       => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(4);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS4_CLOCK_HIGH      => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(4);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS3_CLOCK_LOW       => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(3);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS3_CLOCK_HIGH      => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(3);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS2_CLOCK_LOW       => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(2);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS2_CLOCK_HIGH      => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(2);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS1_CLOCK_LOW       => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(1);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS1_CLOCK_HIGH      => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(1);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS0_CLOCK_LOW       => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(0);
         WHEN SM_IDT5V19EE901_LOADER_DADDRESS0_CLOCK_HIGH      => IDT5V19EE901_SDAT_OUT_1 <= DEVICE_ADDRESS(0);
         WHEN SM_IDT5V19EE901_LOADER_WRITE_CLOCK_LOW           => IDT5V19EE901_SDAT_OUT_1 <= WRITE_VALUE;
         WHEN SM_IDT5V19EE901_LOADER_WRITE_CLOCK_HIGH          => IDT5V19EE901_SDAT_OUT_1 <= WRITE_VALUE;  
         WHEN SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_LOW     => IDT5V19EE901_SDAT_OUT_1 <= WRITE_VALUE;
         WHEN SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_HIGH    => IDT5V19EE901_SDAT_OUT_1 <= WRITE_VALUE;  

         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND7_CLOCK_LOW     => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(7);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND7_CLOCK_HIGH    => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(7);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND6_CLOCK_LOW     => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(6);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND6_CLOCK_HIGH    => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(6);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND5_CLOCK_LOW     => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(5);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND5_CLOCK_HIGH    => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(5);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND4_CLOCK_LOW     => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(4);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND4_CLOCK_HIGH    => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(4);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND3_CLOCK_LOW     => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(3);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND3_CLOCK_HIGH    => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(3);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND2_CLOCK_LOW     => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(2);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND2_CLOCK_HIGH    => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(2);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND1_CLOCK_LOW     => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(1);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND1_CLOCK_HIGH    => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(1);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND0_CLOCK_LOW     => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(0);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMAND0_CLOCK_HIGH    => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(0);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_LOW   => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(0);
         WHEN SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_HIGH  => IDT5V19EE901_SDAT_OUT_1 <= COMMAND_WR(0);  
                                                                              
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS7_CLOCK_LOW        => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(7);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS7_CLOCK_HIGH       => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(7);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS6_CLOCK_LOW        => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(6);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS6_CLOCK_HIGH       => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(6);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS5_CLOCK_LOW        => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(5);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS5_CLOCK_HIGH       => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(5);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS4_CLOCK_LOW        => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(4);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS4_CLOCK_HIGH       => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(4);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS3_CLOCK_LOW        => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(3);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS3_CLOCK_HIGH       => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(3);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS2_CLOCK_LOW        => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(2);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS2_CLOCK_HIGH       => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(2);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS1_CLOCK_LOW        => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(1);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS1_CLOCK_HIGH       => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(1);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS0_CLOCK_LOW        => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(0);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESS0_CLOCK_HIGH       => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(0);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_LOW      => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(0);
         WHEN SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_HIGH     => IDT5V19EE901_SDAT_OUT_1 <= CURRENT_ADDRESS(0);  
                                                                                 
         WHEN SM_IDT5V19EE901_LOADER_WRDATA7_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(7);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA7_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(7);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA6_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(6);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA6_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(6);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA5_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(5);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA5_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(5);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA4_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(4);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA4_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(4);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA3_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(3);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA3_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(3);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA2_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(2);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA2_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(2);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA1_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(1);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA1_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(1);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA0_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(0);
         WHEN SM_IDT5V19EE901_LOADER_WRDATA0_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(0);
         WHEN SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_LOW       => IDT5V19EE901_SDAT_OUT_1 <= '0';
         WHEN SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_HIGH      => IDT5V19EE901_SDAT_OUT_1 <= '0';

         WHEN SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(7);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(7);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(6);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(6);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(5);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(5);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(4);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(4);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(3);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(3);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(2);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(2);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(1);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(1);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_LOW         => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(0);
         WHEN SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_HIGH        => IDT5V19EE901_SDAT_OUT_1 <= MUXED_DATA(0);
         WHEN SM_IDT5V19EE901_LOADER_RDDATAACK_CLOCK_LOW       => IDT5V19EE901_SDAT_OUT_1 <= '0';
         WHEN SM_IDT5V19EE901_LOADER_RDDATAACK_CLOCK_HIGH      => IDT5V19EE901_SDAT_OUT_1 <= '0';
                                                                                 
         WHEN SM_IDT5V19EE901_LOADER_STOP7_CLOCK_LOW           => IDT5V19EE901_SDAT_OUT_1 <= '0';
         WHEN SM_IDT5V19EE901_LOADER_STOP7_CLOCK_HIGH          => IDT5V19EE901_SDAT_OUT_1 <= '0';
         WHEN SM_IDT5V19EE901_LOADER_STOP6_CLOCK_LOW           => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP6_CLOCK_HIGH          => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP5_CLOCK_LOW           => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP5_CLOCK_HIGH          => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP4_CLOCK_LOW           => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP4_CLOCK_HIGH          => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP3_CLOCK_LOW           => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP3_CLOCK_HIGH          => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP2_CLOCK_LOW           => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP2_CLOCK_HIGH          => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP1_CLOCK_LOW           => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP1_CLOCK_HIGH          => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP0_CLOCK_LOW           => IDT5V19EE901_SDAT_OUT_1 <= '1';
         WHEN SM_IDT5V19EE901_LOADER_STOP0_CLOCK_HIGH          => IDT5V19EE901_SDAT_OUT_1 <= '1';
      END CASE;

   --DELAY TO ACHIEVE HOLD TIME FROM SCLK FALLING
   IDT5V19EE901_SDAT_OUT_2 <= IDT5V19EE901_SDAT_OUT_1;
   IDT5V19EE901_SDAT_OUT_3 <= IDT5V19EE901_SDAT_OUT_2 ;
   IDT5V19EE901_SDAT_OUT_4 <= IDT5V19EE901_SDAT_OUT_3 ;
   IDT5V19EE901_SDAT_OUT_5 <= IDT5V19EE901_SDAT_OUT_4 ;
   IDT5V19EE901_SDAT_OUT   <= IDT5V19EE901_SDAT_OUT_5 ;
 
END IF;
END PROCESS OPDATA;

OPTRI : PROCESS(RESET,CLOCK)
BEGIN
IF (RESET = '1') THEN
   IDT5V19EE901_SDAT_OE <= '0';
   
ELSIF (CLOCK'EVENT  AND CLOCK='1') THEN
   CASE SM_IDT5V19EE901_LOADER IS  
     --ACK COMING BACK DO NOT DRIVE                                                            
      WHEN     SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_LOW
            |  SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_HIGH  
            |  SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_LOW    
            |  SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_HIGH     
            |  SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_LOW       
            |  SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_HIGH  
            |  SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_HIGH     
            |  SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_HIGH     
            |  SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_HIGH     
            |  SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_HIGH     
            |  SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_HIGH     
            |  SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_HIGH     
            |  SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_HIGH     
            |  SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_HIGH     
            |  SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_LOW    
            |  SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_HIGH   =>   

         IDT5V19EE901_SDAT_OE <= '0';
      
      --DATA OR ADDRESS SO DRIVE
      WHEN OTHERS                                     => 
         IDT5V19EE901_SDAT_OE <= '1';
      
   END CASE; 
END IF;
END PROCESS OPTRI;

CLKGEN : PROCESS(RESET,CLOCK)
BEGIN
IF (RESET = '1') THEN
   IDT5V19EE901_SCLK <= '1';
ELSIF (CLOCK'EVENT  AND CLOCK='1') THEN
   CASE SM_IDT5V19EE901_LOADER IS
      WHEN     SM_IDT5V19EE901_LOADER_SDAT_START_LOW_CLOCK_LOW         

            |  SM_IDT5V19EE901_LOADER_DADDRESS6_CLOCK_LOW    
            |  SM_IDT5V19EE901_LOADER_DADDRESS5_CLOCK_LOW    
            |  SM_IDT5V19EE901_LOADER_DADDRESS4_CLOCK_LOW    
            |  SM_IDT5V19EE901_LOADER_DADDRESS3_CLOCK_LOW    
            |  SM_IDT5V19EE901_LOADER_DADDRESS2_CLOCK_LOW    
            |  SM_IDT5V19EE901_LOADER_DADDRESS1_CLOCK_LOW    
            |  SM_IDT5V19EE901_LOADER_DADDRESS0_CLOCK_LOW    
            |  SM_IDT5V19EE901_LOADER_WRITE_CLOCK_LOW        
            |  SM_IDT5V19EE901_LOADER_DADDRESSACK_CLOCK_LOW  

            |  SM_IDT5V19EE901_LOADER_WR_COMMAND7_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WR_COMMAND6_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WR_COMMAND5_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WR_COMMAND4_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WR_COMMAND3_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WR_COMMAND2_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WR_COMMAND1_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WR_COMMAND0_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WR_COMMANDACK_CLOCK_LOW    

            |  SM_IDT5V19EE901_LOADER_ADDRESS7_CLOCK_LOW     
            |  SM_IDT5V19EE901_LOADER_ADDRESS6_CLOCK_LOW     
            |  SM_IDT5V19EE901_LOADER_ADDRESS5_CLOCK_LOW     
            |  SM_IDT5V19EE901_LOADER_ADDRESS4_CLOCK_LOW     
            |  SM_IDT5V19EE901_LOADER_ADDRESS3_CLOCK_LOW     
            |  SM_IDT5V19EE901_LOADER_ADDRESS2_CLOCK_LOW     
            |  SM_IDT5V19EE901_LOADER_ADDRESS1_CLOCK_LOW     
            |  SM_IDT5V19EE901_LOADER_ADDRESS0_CLOCK_LOW     
            |  SM_IDT5V19EE901_LOADER_ADDRESSACK_CLOCK_LOW   

            |  SM_IDT5V19EE901_LOADER_WRDATA7_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WRDATA6_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WRDATA5_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WRDATA4_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WRDATA3_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WRDATA2_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WRDATA1_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WRDATA0_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_WRDATAACK_CLOCK_LOW    

            |  SM_IDT5V19EE901_LOADER_RDDATA7_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA6_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA5_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA4_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA3_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA2_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA1_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_LOW      
            |  SM_IDT5V19EE901_LOADER_RDDATAACK_CLOCK_LOW  =>  

         IDT5V19EE901_SCLK <= '0';

      WHEN OTHERS => 
         IDT5V19EE901_SCLK <= '1';
   END CASE;
   
END IF;
END PROCESS CLKGEN;

RDDAT : PROCESS(RESET,CLOCK)
BEGIN
IF (RESET = '1') THEN
   SHIFT_REGISTER    <= (OTHERS => '0');
   INT_READ_DATA     <= (OTHERS => '0');
   INT_READ_ADDRESS  <= (OTHERS => '0');
   READ_DATA_VALID   <= '0';
   
ELSIF (CLOCK'EVENT  AND CLOCK='1') THEN
   IF (CLOCK_ENABLE = '1') THEN
      SHIFT_REGISTER <= SHIFT_REGISTER(14 DOWNTO 0) & IDT5V19EE901_SDAT_IN;   
      IF (SM_IDT5V19EE901_LOADER = SM_IDT5V19EE901_LOADER_RDDATA0_CLOCK_LOW) THEN
         INT_READ_DATA     <= SHIFT_REGISTER(15) & SHIFT_REGISTER(13) & SHIFT_REGISTER(11) & SHIFT_REGISTER(9) & SHIFT_REGISTER(7) & SHIFT_REGISTER(5) & SHIFT_REGISTER(3) & SHIFT_REGISTER(1);
         INT_READ_ADDRESS  <= CURRENT_ADDRESS;
         READ_DATA_VALID   <= '1';
      ELSE
         INT_READ_DATA     <= INT_READ_DATA   ;  
         INT_READ_ADDRESS  <= INT_READ_ADDRESS;  
         READ_DATA_VALID   <= '0';
      END IF;   
   ELSE
      SHIFT_REGISTER    <= SHIFT_REGISTER    ;
      INT_READ_DATA     <= INT_READ_DATA     ;  
      INT_READ_ADDRESS  <= INT_READ_ADDRESS  ;  
      READ_DATA_VALID   <= '0';
   END IF;   
END IF;
END PROCESS RDDAT;
--  
READ_DATA     <= INT_READ_DATA     ;
READ_ADDRESS  <= INT_READ_ADDRESS  ;
--
END A0 ;    

