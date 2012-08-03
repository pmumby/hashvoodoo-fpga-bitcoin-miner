library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity CLOCKPHASE3 is
port(    CLKIN_IN          :  in    std_logic; 
         RST_IN            :  in    std_logic;
         
         CLOCK_STOP        :  IN    STD_LOGIC; 
         
         CLKIN_IBUFG_OUT   :  out   std_logic; 
         CLK0_OUT          :  out   std_logic; 
         CLK90_OUT         :  out   std_logic; 
         CLK180_OUT        :  out   std_logic; 
         CLK270_OUT        :  out   std_logic; 
         LOCKED_OUT        :  out   std_logic);
end CLOCKPHASE3;

architecture BEHAVIORAL of CLOCKPHASE3 is

   signal CLKFB_IN        : std_logic;
   signal CLKIN_IBUFG     : std_logic;
   signal CLK0_BUF        : std_logic;
   signal CLK90_BUF       : std_logic;
   signal CLK180_BUF      : std_logic;
   signal CLK270_BUF      : std_logic;
   signal GND_BIT         : std_logic;

begin
   GND_BIT <= '0';
   
   CLKIN_IBUFG_OUT <= CLKIN_IBUFG;
   

   CLKIN_IBUFG_INST : IBUFG
      port map (I=>CLKIN_IN,
                O=>CLKIN_IBUFG);
   
   
   
DCM_SP_INST : DCM_SP
generic map(CLK_FEEDBACK            => "1X",
            CLKDV_DIVIDE            => 2.0,
            CLKFX_DIVIDE            => 1,
            CLKFX_MULTIPLY          => 4,
            CLKIN_DIVIDE_BY_2       => FALSE,
            CLKIN_PERIOD            => 5.000,
            CLKOUT_PHASE_SHIFT      => "NONE",
            DESKEW_ADJUST           => "SYSTEM_SYNCHRONOUS",
            DFS_FREQUENCY_MODE      => "LOW",
            DLL_FREQUENCY_MODE      => "LOW",
            DUTY_CYCLE_CORRECTION   => TRUE,
            FACTORY_JF              => x"C080",
            PHASE_SHIFT             => 0,
            STARTUP_WAIT            => FALSE)
            
port map(   CLKFB                   => CLKFB_IN,
            CLKIN                   => CLKIN_IBUFG,
            DSSEN                   => GND_BIT,
            PSCLK                   => GND_BIT,
            PSEN                    => GND_BIT,
            PSINCDEC                => GND_BIT,
            RST                     => RST_IN,
            CLKDV                   => open,
            CLKFX                   => open,
            CLKFX180                => open,
            CLK0                    => CLK0_BUF,
            CLK2X                   => open,
            CLK2X180                => open,
            CLK90                   => CLK90_BUF,
            CLK180                  => CLK180_BUF,
            CLK270                  => CLK270_BUF,
            LOCKED                  => LOCKED_OUT,
            PSDONE                  => open,
            STATUS                  => open);

--FEEDBACK  
CLK0_BUFG_INST : BUFG
PORT MAP (I    => CLK0_BUF    ,
          O    => CLKFB_IN    );

-- --PHASED CLOCKS
-- BGMUX_ON_OFF1 : BUFGMUX
-- PORT MAP(O 	   =>	CLK0_OUT    ,    
--          I0    =>	CLK0_BUF    ,
--          I1    => '0'         ,  
--          S 	   => CLOCK_STOP  );

CLK0_OUT <= CLKFB_IN;

-- BUFG1 : BUFG
-- PORT MAP (I    => CLK0_BUF    ,
--           O    => CLK0_OUT    );
         
-- BGMUX_ON_OFF2 : BUFGMUX
-- PORT MAP(O 	   =>	CLK90_OUT   ,    
--          I0    =>	CLK90_BUF   ,
--          I1    => '0'         ,  
--          S 	   => CLOCK_STOP  );

BUFG2 : BUFG
PORT MAP (I    => CLK90_BUF   ,
          O    => CLK90_OUT   );

-- BGMUX_ON_OFF3 : BUFGMUX
-- PORT MAP(O 	   =>	CLK180_OUT  ,    
--          I0    =>	CLK180_BUF  ,
--          I1    => '0'         ,  
--          S 	   => CLOCK_STOP  );

BUFG3 : BUFG
PORT MAP (I    => CLK180_BUF    ,
          O    => CLK180_OUT    );


-- BGMUX_ON_OFF4 : BUFGMUX
-- PORT MAP(O 	   =>	CLK270_OUT  ,    
--          I0    =>	CLK270_BUF  ,
--          I1    => '0'         ,  
--          S 	   => CLOCK_STOP  );
         
BUFG4 : BUFG
PORT MAP (I    => CLK270_BUF    ,
          O    => CLK270_OUT    );


   
end BEHAVIORAL;


