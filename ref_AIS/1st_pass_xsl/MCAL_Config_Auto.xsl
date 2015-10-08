<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xalan="http://xml.apache.org/xalan" 
                xmlns:math="java.lang.Math" 
                xmlns:date="java.util.Date"                
                xmlns:vector="java.util.Vector"                
                extension-element-prefixes="date vector math">
<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<xsl:param name ="STM_GLOBAL_prescaler_factor" select="//SRS/IO/TIMER/SPECIAL_TIMER/@STM_GLOBAL" ></xsl:param>



<xsl:param name ="OSCILLATOR_CLOCK" select="//SRS/MCU/SPEC/@Frequency" ></xsl:param>
<xsl:param name ="Peripheral_Clock_1" select="//SRS/MCU/SPEC/@Peripheral_Clock_Set_1" ></xsl:param>
<xsl:param name ="Peripheral_Clock_2" select="//SRS/MCU/SPEC/@Peripheral_Clock_Set_2" ></xsl:param>
<xsl:param name ="Peripheral_Clock_3" select="//SRS/MCU/SPEC/@Peripheral_Clock_Set_3" ></xsl:param>
<xsl:param name ="CORE_CLOCK" select="//SRS/MCU/SPEC/@Cclock" ></xsl:param>


<xsl:template match="/"> 
<xsl:variable name="MAIN_TIMER_Resources" select="//MANIN_TIMER_EMIOS[not(./@Timer_Resource=preceding::MANIN_TIMER_EMIOS/@Timer_Resource)]"/>
<xsl:variable name="SPI_Channel_name_variable" select="//SPI_CHANNEL_SETTING[not(./@SPI_Channel_name=preceding::SPI_CHANNEL_SETTING/@SPI_Channel_name)]"/>
<!--
============================================================================
                       Autron  SOFTWARE  GROUP                              
==============================================================================================================================================
                        OBJECT SPECIFICATION                                
==============================================================================================================================================
* source file for 1st pass Xml generation 
* %name:                MCAL_Config_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
						
* %xsd file version 	
* dependency 			None
* %xsl file version:    1.1.3 %
* %created_by:        	ca071 %
*=============================================================================================================================================
 COPYRIGHT (C) Autron 2012                                             
 AUTOMOTIVE ELECTRONICS                                                     
 ALL RIGHTS RESERVED                                                        
==============================================================================================================================================
                               OBJECT HISTORY                               
==============================================================================================================================================
  REVISION |   DATE      |                               |      AUTHOR      
==============================================================================================================================================
  1.0.0      | 21/Jan/2014 |                               | Seungwoo. Lee
  - Init version
  
  1.0.2      | 07/May/2014 |                               | Seungwoo. Lee
  - Stask Size change (SWP Task is also according to Resource stack size Except 'Event manager')
    (Task_SWP_FG1_EventManager -> '512' fixed)
  - 'Task_SWP_System_Idle' and 'Task_SWP_Init' keep same. because those Tasks will have own stack.
  
  1.0.3      | 09/Jun/2014 |                               | Seungwoo. Lee
  add "/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskCallScheduler" in 'make_OS_task_Config'
  /TS_T2D13M4I5R0_AS31/Os/OsOS/OsStackMonitoring ->  true
  /TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsExceptionHandling -> false 

  1.0.4     | 04/Jul/2014 |                               | Seungwoo. Lee
  * setting change
  /TS_T2D13M30I4R0/Fls/FlsGeneral/FlsDsiHandlerApi  -> true
  /TS_T2D13M30I4R0/Fee/FeeGeneral/FeeBlockAlwaysAvailable -> true
  /TS_T2D13M30I4R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcWithoutInterrupts -> true for (line 8427)
  
  * attributes of AdcGeneral are to be 'true' except these three attributes
  /TS_T2D13M30I4R0/Adc/AdcGeneral/AdcDevErrorDetect -> false
  /TS_T2D13M30I4R0/Adc/AdcGeneral/AdcHwTriggerApi -> false
  /TS_T2D13M30I4R0/Adc/AdcGeneral/AdcVersionInfoApi -> false
  
  * add Attribute on ICU according to 'e_rtu02_spc560xb-19' Project
  /TS_T2D13M30I4R0/Icu/IcuConfigSet/IcuChannel/IcuSignalMeasureWithoutInterrupt : <false>
  
  * add Attribute on EXT INT according to 'e_rtu02_spc560xb-19' Project
  /TS_T2D13M30I4R0/Icu/IcuConfigSet/IcuChannel/IcuDisableEcumWakeupNotification : <false>

  1.0.5     | 09/Jul/2014 |                               | Seungwoo. Lee
  * All 
  - change 'TS_T2D13M30I4R0' -> 'TS_T2D13M30I5R0'
  * MCU Part
  - /TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRamSectorSettingConf/McuRamSectionSize -> value Change (real Ram size -4)
  - Error case Message add for ' /TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRamSectorSettingConf/McuRamSectionSize'
  - /TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuTimeout '4294967295' -> '4294967294'
  
  * ADC Part
  - '/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcGeneric/Adc1MaxGroupChannels' value change up to Schema (Applying schema Change)
  * SPI Part
  - /TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiCsContinous 'true' -> 'True'
  * FLS Part
  - /TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsAcErase  '0x40006500' -> 'Fls_ACEraseStart'
  - /TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsAcWrite  '0x40006500' -> 'Fls_ACWriteStart'
  
  * FEE Part
  - Logic change 'make_FEE_Config' template, according to mem config SCM 1.0 Doc
  
  1.0.6     | 15/Sep/2014 |                               | Seungwoo. Lee  
  - change '/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiCsContinous' value of dummy SPI Channel from 'true' to 'True'
  - change 'SwPatchVersion' of CommonPublishedInformation in each module from 4 to 5
  - change 'Resource/CommonPublishedInformation/ArMajorVersion' value from 3 to 0
  - remove '/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalOn' according to schema change
  - remove '/TS_T2D13M30I5R0/Pwm/PwmGeneral/MultiPwmChannelSynch' according to schema change
  - change '/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRamSectorSettingConf/McuRamSectionBaseAddress' value from '1073741824' to '0x40000000'
  - error fix - task name (Task_SWP_BG_RAM_ROM_CHECK -> Task_SWP_BG_RAM_ROM_check)
  
  1.0.7     | 29/Sep/2014 |                               | Seungwoo. Lee    
  - add '/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuUnUsedWakeupPinsPullUp' (this attribute makes pull up of WAKEUP INT set 1, it needs to be false)
  1.0.8     | 19/Dec/2014 |                               | Seungwoo. Lee      
  - change value of "TS_T2D13M4I5R0_AS31/Os/OsOS/OsHooks/OsShutdownHook" attribute from 'false' to 'true'
  - add logic for generation of 'Resource_SWP_BG'
  - add logic for '/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/SystemClockSelect' under 'McuModeSettingConf_STOP' container
  - change value of '/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/SIUL/McuPerLowPwrConfig' from 'McuLowPower_1' to 'McuLowPower_0'
  - change value of '/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/RTC_API/McuPerLowPwrConfig' from 'McuLowPower_0' to 'McuLowPower_1'
  - change value of '/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/AddressPipeliningControl' attribute from '5' to '3' under 'McuFlashPFCR0_0'
  - change value of '/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/ReadWaitStateControl' from '5' to '3' under 'McuFlashPFCR0_0'
  - add error handle for '/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiShiftClockIdleLevel' under SPI Setting
  - add error handle for '/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiDataShiftEdge' under SPI Setting
  - add error handle for '/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiTransferStart' under SPI Setting
  - change all attribute of 'SpiGeneral_1' setting to 'false' under SPI Setting
  - add logic for '/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelPrescale'
  - add logic for '/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelPrescale_Alternate'
  - add attribute into IcuChannel '/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuUserModeForDutycycle' as 'SAIC'   
  - add error handle for '/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmChannelClass'    
  - add error handle for '/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPolarity'  
  - add error handle for '/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmIdleState'
  - change value of 'TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27_VREG/McuEnableReset' from 'false' to 'true'
  1.0.9     | 22/Apr/2015 |                               | Seungwoo. Lee        
  - change value of '/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuDisableWakeupApi' from 'true' to 'false'
  - change value of '/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuEnableWakeupApi' from 'true' to 'false'
  - change value of '/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuGetDutyCycleValuesApi' from 'true' to 'false'
  - change value of '/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuGetInputStateApi' from 'true' to 'false'
  1.1.0     | 23/Apr/2015 |                               | Seungwoo. Lee        
  - change value of '/TS_T2D13M30I5R0/Icu/IcuGeneral/IcuReportWakeupSource' from 'true' to 'false'  
  1.1.1     | 03/Jun/2015 |                               | Seungwoo. Lee        
  - add logic for '/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuMaxChannel' when number of using ICU and EXT_INT Channel is 0, this attribute will be set to '1' for dummy channel
  - add logic for 'IcuChannel_1_DUMMY' Element in Case of that number of using ICU and EXT_INT Channel is 0
  - this policy which is Using Dummy ICU channel is approved by IO Module developer "jong-young Won" on Jun 3rd in 2015.
  1.1.2     | 30/Jun/2015 |                               | Seungwoo. Lee          
  - change logic for '/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosBusSelect'. Its BUS source will be according to Emios SRS Setting
  - change logic for '/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/EmiosUnifiedChannelBusSelect' Its BUS source will be according to Emios SRS Setting
  - change logic for '/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmModeSelect' PwmModeSelect value will be according to its BUS source
  - change value for '/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmDutycycleUpdatedEndperiod' from 'true' to 'false', it's according to IO 'SCM' Document.
  - change value for '/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmPeriodUpdatedEndperiod' from 'true' to 'false', it's according to IO 'SCM' Document.  
  1.1.3     | 30/Jul/2015 |                               | Seungwoo. Lee            
  - change value for '/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/AddressPipeliningControl' from '3' to '2' according to EEPROM SCM Doc change (2015.07.16)
  - change value for '/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/WriteWaitStateControl' from '3' to '2' according to EEPROM SCM Doc change (2015.07.16)
  - change value for '/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/ReadWaitStateControl' from '3' to '2' according to EEPROM SCM Doc change (2015.07.16)
==============================================================================================================================================
-->
<xsl:message  terminate ="no">
==========================================================================
MCAL 1st pass XML Generaiton Message
==========================================================================
</xsl:message>  

<AUTOSAR xmlns:AR="http://autosar.org/3.1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://autosar.org/3.1.0 autosar.xsd">
    <ADMIN-DATA>
        <DOC-REVISIONS/>
        <SDGS/>
    </ADMIN-DATA>
    <TOP-LEVEL-PACKAGES>
        <AR-PACKAGE UUID="7209fc40-a0d1-4cda-bb2b-eafdef798c30">
            <SHORT-NAME>AR_ROOT</SHORT-NAME>
            <DESC>
                <L-2/>
            </DESC>
            <ADMIN-DATA>
                <DOC-REVISIONS/>
                <SDGS/>
            </ADMIN-DATA>
            <ELEMENTS>
                <ECU-CONFIGURATION UUID="f77d3ecf-0caa-4cd9-a7e9-1014fe838a24">
                    <SHORT-NAME>MyECU</SHORT-NAME>
                    <DESC>
                        <L-2/>
                    </DESC>
                    <ECU-EXTRACT-REF DEST="SYSTEM">/VehicleProject/MyECU</ECU-EXTRACT-REF>
                    <MODULE-REFS>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/EcuM</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Icu</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Mcu</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Resource</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Os</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Base</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Dio</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Gpt</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Port</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Adc</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Wdg</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Spi</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Pwm</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Fee</MODULE-REF>
                        <MODULE-REF DEST="MODULE-CONFIGURATION">/AR_ROOT/Fls</MODULE-REF>
                    </MODULE-REFS>
                </ECU-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Base</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Base</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Base/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Base/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Base/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Base/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Base/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Base/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Base/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Base/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Base/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Dio</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Dio</DEFINITION-REF>
                    <CONTAINERS>
						<CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>120</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
						<CONTAINER>
                            <SHORT-NAME>DioGeneral_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioGeneral/DioDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioGeneral/DioVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioGeneral/DioReversePortBits</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioGeneral/DioMaskedWritePortApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioGeneral/DioReadZeroForUndefinedPortPins</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
<!--========================================================DIO========================================================-->							
								<xsl:call-template name="make_dio_Config_package_select">
									<xsl:with-param name = "package" select="//SRS/MCU/SPEC/@Package"/>
								</xsl:call-template>
<!--========================================================DIO========================================================-->							
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
				<MODULE-CONFIGURATION>
                    <SHORT-NAME>EcuM</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/EcuM</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>EcuMConfiguration_0</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMConfigConsistencyHash</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMNvramReadallTimeout</DEFINITION-REF>
                                    <VALUE>1.0</VALUE>
                                </FLOAT-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMNvramWriteallTimeout</DEFINITION-REF>
                                    <VALUE>0.0</VALUE>
                                </FLOAT-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMRunMinimumDuration</DEFINITION-REF>
                                    <VALUE>10.0</VALUE>
                                </FLOAT-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMSleepActivityPeriod</DEFINITION-REF>
                                    <VALUE>0.0</VALUE>
                                </FLOAT-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="CHOICE-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMModuleConfigurationRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0</VALUE-REF>
                                </REFERENCE-VALUE>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="CHOICE-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMModuleConfigurationRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Port/PortConfigSet</VALUE-REF>
                                </REFERENCE-VALUE>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="CHOICE-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMModuleConfigurationRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Gpt/GptChannelConfigSet_0</VALUE-REF>
                                </REFERENCE-VALUE>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="CHOICE-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMModuleConfigurationRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Icu/IcuConfigSet</VALUE-REF>
                                </REFERENCE-VALUE>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="CHOICE-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMModuleConfigurationRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Adc/AdcConfigSet</VALUE-REF>
                                </REFERENCE-VALUE>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMDefaultAppMode</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/AppMode</VALUE-REF>
                                </REFERENCE-VALUE>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMNormalMcuModeRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuModeSettingConf_PLL</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>EcuMDefaultShutdownTarget</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMDefaultShutdownTarget</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMDefaultShutdownTarget/EcuMDefaultState</DEFINITION-REF>
                                    <VALUE>EcuMStateSleep</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMDefaultShutdownTarget/EcuMDefaultSleepModeRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/EcuM/EcuMConfiguration_0/EcuMSleepMode_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>EcuMSleepMode_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMSleepMode</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMSleepMode/EcuMSleepModeId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMSleepMode/EcuMSleepModeName</DEFINITION-REF>
                                    <VALUE>EcuMSleepMode</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMSleepMode/EcuMSleepModeSuspend</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMSleepMode/EcuMSleepModeMcuModeRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuModeSettingConf_STOP</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMSleepMode/EcuMWakeupSourceMask</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/EcuM/EcuMConfiguration_0/EcuMWakeupSource_PIT0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>EcuMTTII_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMTTII</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMTTII/EcuMDivisor</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMTTII/EcuMSleepModeRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/EcuM/EcuMConfiguration_0/EcuMSleepMode_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMTTII/EcuMSuccessorRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/EcuM/EcuMConfiguration_0/EcuMSleepMode_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>EcuMUserConfig_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMUserConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMUserConfig/EcuMUser</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>EcuMWakeupSource_PIT0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMWakeupSource</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMWakeupSource/EcuMResetReason</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMWakeupSource/EcuMValidationTimeout</DEFINITION-REF>
                                    <VALUE>0.0</VALUE>
                                    </FLOAT-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMWakeupSource/EcuMWakeupSourceId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMWakeupSource/EcuMWakeupSourcePolling</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>EcuMWakeupSource_EXTI8</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMWakeupSource</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMWakeupSource/EcuMResetReason</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMWakeupSource/EcuMValidationTimeout</DEFINITION-REF>
                                    <VALUE>0.0</VALUE>
                                    </FLOAT-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMWakeupSource/EcuMWakeupSourceId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMConfiguration/EcuMWakeupSource/EcuMWakeupSourcePolling</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>EcuMGeneral</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/EcuM/EcuMGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMGeneral/EcuMDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMGeneral/EcuMIncludeDem</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMGeneral/EcuMIncludeDet</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMGeneral/EcuMIncludeNvramMgr</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMGeneral/EcuMIncludeWdgM</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMGeneral/EcuMMainFunctionPeriod</DEFINITION-REF>
                                    <VALUE>0.01</VALUE>
                                </FLOAT-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMGeneral/EcuMTTIIEnabled</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMGeneral/EcuMVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/EcuM/EcuMGeneral/EcuMTTIISleepModeRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/EcuM/EcuMConfiguration_0/EcuMSleepMode_0</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
				<MODULE-CONFIGURATION>
                    <SHORT-NAME>Gpt</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Gpt</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Gpt/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>100</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>GptChannelConfigSet_0</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet</DEFINITION-REF>
                            <SUB-CONTAINERS>
<!--========================================================GPT========================================================-->
							<xsl:call-template name="make_GptChannel_Config">
								<xsl:with-param name = "fast_timer" select="//SRS/CORE/TIMER/@Fast"/>
								<xsl:with-param name = "system_timer" select="//SRS/CORE/TIMER/@System_Base_Timer"/>
								<xsl:with-param name = "os_timer" select="//SRS/OS/@Systemtime"/>
							</xsl:call-template>
<!--========================================================GPT========================================================-->
                            </SUB-CONTAINERS>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptSTMChannelPrescale</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$STM_GLOBAL_prescaler_factor"/></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>GptConfigurationOfOptApiServices_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Gpt/GptConfigurationOfOptApiServices</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptConfigurationOfOptApiServices/GptDeinitApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptConfigurationOfOptApiServices/GptEnableDisableNotificationApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptConfigurationOfOptApiServices/GptTimeElapsedApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptConfigurationOfOptApiServices/GptTimeRemainingApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptConfigurationOfOptApiServices/GptVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptConfigurationOfOptApiServices/GptWakeupFunctionalityApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>GptDriverConfiguration_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Gpt/GptDriverConfiguration</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptDriverConfiguration/GptDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptDriverConfiguration/GptReportWakeupSource</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>GptNonAUTOSAR_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Gpt/GptNonAUTOSAR</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptNonAUTOSAR/GptEnableDualClockMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Port</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Port</DEFINITION-REF>
                    <CONTAINERS>
						<CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>124</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>PortGeneral_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortGeneral/PortDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortGeneral/PortSetPinDirectionApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortGeneral/PortSetPinModeApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortGeneral/PortVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortGeneral/PortPinAbstractedMode</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
						<CONTAINER>
                            <SHORT-NAME>PortConfigSet</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet</DEFINITION-REF>
                            <SUB-CONTAINERS>
<!--========================================================PORT========================================================-->							
								<xsl:call-template name="make_port_Config_package_select">
									<xsl:with-param name = "package" select="//SRS/MCU/SPEC/@Package"/>
								</xsl:call-template>
<!--========================================================PORT========================================================-->																
                            </SUB-CONTAINERS>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Icu</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Icu</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>IcuConfigSet</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuMaxChannel</DEFINITION-REF>
								<xsl:choose>
									<xsl:when test = "count(//TIMER/*/*[@Software_Use ='IC_FREE_RUN']) + count(//TIMER/*/*[@Software_Use ='EXTINT-ICU']) +count(//EXTERNAL_INTERRUPT_CONFIGURATION/*[@Usage ='USED'])='0'">
										<VALUE>1</VALUE>
									</xsl:when>
									<xsl:otherwise>
										<VALUE><xsl:value-of select="count(//TIMER/*/*[@Software_Use ='IC_FREE_RUN']) + count(//TIMER/*/*[@Software_Use ='EXTINT-ICU']) +count(//EXTERNAL_INTERRUPT_CONFIGURATION/*[@Usage ='USED'])"/></VALUE>
									</xsl:otherwise>
								</xsl:choose>
                                </INTEGER-VALUE>
								<BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuUnUsedWakeupPinsPullUp</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
<!--========================================================ICU========================================================-->							
								<xsl:call-template name="make_ICU_Channel_Config"/>
<!--========================================================ICU========================================================-->								
								
                            </SUB-CONTAINERS>
                        </CONTAINER>
						<CONTAINER>
                            <SHORT-NAME>IcuGeneral</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/IcuGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuGeneral/IcuDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuGeneral/IcuReportWakeupSource</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>IcuNonAUTOSAR_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/IcuNonAUTOSAR</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuNonAUTOSAR/IcuEnableDualClockMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuNonAUTOSAR/IcuGetInputLevelApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>IcuOptionalApis</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuDeInitApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuDisableWakeupApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuEdgeCountApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuEnableWakeupApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuGetDutyCycleValuesApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuGetInputStateApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuGetTimeElapsedApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuGetVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuSetModeApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuSignalMeasurementApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuTimestampApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuOptionalApis/IcuOverflowNotificationApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>122</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Mcu</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Mcu</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>McuGeneralConfiguration</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuPerformResetApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuCalloutBeforePerformReset</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuPerformResetCallout</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuConfigureFlash</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuLPTransitionCheck</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuEnterLowPowerMode</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuConfClkOutput</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuDisableDemReportErrorStatus</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McuSkipFunction</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuGeneralConfiguration/McueMiosConfigureGPRENApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>101</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/CommonPublishedInformation/VendorApiInfix</DEFINITION-REF>
                                    <VALUE/>
                                </STRING-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>McuModuleConfiguration_0</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSrcFailureNotification</DEFINITION-REF>
                                    <VALUE>DISABLED</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuNumberOfMcuModes</DEFINITION-REF>
                                    <VALUE>4</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRamSectors</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>McuClockSettingConfig</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/CrystalFrequencyHz</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$OSCILLATOR_CLOCK"/>000000</VALUE>
                                    </FLOAT-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuTimeout</DEFINITION-REF>
                                    <VALUE>4294967294</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>MCU_CLK_SETTING_PLL_PLL</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClockReferencePointFrequency</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$CORE_CLOCK"/>000000</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralSet1Frequency</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$Peripheral_Clock_1"/>000000</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralSet2Frequency</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$Peripheral_Clock_2"/>000000</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralSet3Frequency</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$Peripheral_Clock_3"/>000000</VALUE>
                                    </FLOAT-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>GeneralClockSettings_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/SystemClockSelect</DEFINITION-REF>
                                    <VALUE>McuPLL</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuStartRunMode</DEFINITION-REF>
                                    <VALUE>RUN0</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuOSC</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuPLLStatus</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuCodeFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuDataFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuRC16MHzOscillator</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuOutputPowerDownControl</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuXtal_A_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalByPass</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalCounterOscillator</DEFINITION-REF>
                                    <VALUE>200</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalMaskInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalDivisor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuXtal_B_32KHz_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalByPass</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalCounterOscillator</DEFINITION-REF>
                                    <VALUE>100</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalMaskInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalDivisor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalOn</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuRC_16MHz_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_16MHz</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_16MHz/McuRCDivisor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_16MHz/McuRCSTANDBYMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuRC_128KHz_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_128KHz</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_128KHz/McuRCDivisor</DEFINITION-REF>
                                    <VALUE>8</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_128KHz/McuRCStandBy</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuClkOutput_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput/McuClkOutput</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/CLOCK_OUTPUT/@Usage='ENABLE'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput/McuClkDivisor</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/CLOCK_OUTPUT/@Usage='ENABLE' and //SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_FMPLL !='' ">DIV_<xsl:value-of select="//SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_FMPLL"/></xsl:when>
										<xsl:otherwise>DIV_1</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput/McuClkSource</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/CLOCK_OUTPUT/@Usage='ENABLE' and //SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_source_FMPLL !='' "><xsl:value-of select="//SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_source_FMPLL"/></xsl:when>
										<xsl:otherwise>PLL</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPll_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllMode</DEFINITION-REF>
                                    <VALUE>Normal</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPllParameter_0</SHORT-NAME>

                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuOutputDivisionFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@MCAL_ODF"/></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuInputDivisionFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@MCAL_IDF"/></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuMultiplicationFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@MCAL_NDIV"/></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuProgressiveClockSwitching</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuEnableFailInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuFmPllParameter_0</SHORT-NAME>

                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter/McuModulationFrequency</DEFINITION-REF>
                                    <VALUE>4000</VALUE>
                                    </INTEGER-VALUE>
                                    <FLOAT-VALUE>

                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter/McuPercentualModulationDepth</DEFINITION-REF>
                                    <VALUE>0.25</VALUE>
                                    </FLOAT-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter/McuSpreadSelection</DEFINITION-REF>
                                    <VALUE>Down_Spread</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McueMIOSSettings_0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/GlobalPrescaler</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/IO/TIMER/MAIN_TIMER/@eMios0_Global"/></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/MdisBit</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/GlobalTimeBaseEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/FreezeBit</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/GlobalPrescalerEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McueMIOSSettings_1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/GlobalPrescaler</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/IO/TIMER/MAIN_TIMER/@eMios1_Global !=''"><xsl:value-of select="//SRS/IO/TIMER/MAIN_TIMER/@eMios1_Global"/></xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/MdisBit</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/@Package='PACKAGE_100'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/GlobalTimeBaseEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/FreezeBit</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/GlobalPrescalerEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPeripheralClkSet_0_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_0/McuPeripheralEnableClk</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_0/McuPeripheralDivisorFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@Peripheral_Clock_Set_1_DivisorFactor"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPeripheralClkSet_1_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_1/McuPeripheralEnableClk</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_1/McuPeripheralDivisorFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@Peripheral_Clock_Set_2_DivisorFactor"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPeripheralClkSet_2_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_2</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_2/McuPeripheralEnableClk</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_2/McuPeripheralDivisorFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@Peripheral_Clock_Set_3_DivisorFactor"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuClkMonitor_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuFmPllMonitor</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuRCOSCSelection</DEFINITION-REF>
                                    <VALUE>CK_IRCfast</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuRCDivisorFactor</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <FLOAT-VALUE>

                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuHighFrequencyRef</DEFINITION-REF>
                                    <VALUE>90000000</VALUE>
                                    </FLOAT-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuLowFrequencyRef</DEFINITION-REF>
                                    <VALUE>23000000</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuFlashPFCR0_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/AddressPipeliningControl</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/WriteWaitStateControl</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/ReadWaitStateControl</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuFlashPFCR1_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1/AddressPipeliningControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1/WriteWaitStateControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1/ReadWaitStateControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>MCU_CLK_SETTING_IRC16MHZ</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClockReferencePointFrequency</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/PM/@FIRC_Clock_division_factor=''">error : Check FIRC_Clock_division_factor </xsl:when>
										<xsl:otherwise><xsl:value-of select="16 div //SRS/PM/@FIRC_Clock_division_factor"/>000000</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralSet1Frequency</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/PM/@FIRC_Clock_division_factor=''">error : Check FIRC_Clock_division_factor </xsl:when>
										<xsl:otherwise><xsl:value-of select="16 div //SRS/PM/@FIRC_Clock_division_factor"/>000000</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralSet2Frequency</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/PM/@FIRC_Clock_division_factor=''">error : Check FIRC_Clock_division_factor </xsl:when>
										<xsl:otherwise><xsl:value-of select="16 div //SRS/PM/@FIRC_Clock_division_factor"/>000000</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralSet3Frequency</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/PM/@FIRC_Clock_division_factor=''">error : Check FIRC_Clock_division_factor </xsl:when>
										<xsl:otherwise><xsl:value-of select="16 div //SRS/PM/@FIRC_Clock_division_factor"/>000000</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </FLOAT-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>GeneralClockSettings_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/SystemClockSelect</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/PM/@FIRC_Clock_division_factor=''">error : Check FIRC_Clock_division_factor </xsl:when>
										<xsl:when test="//SRS/PM/@FIRC_Clock_division_factor='1'">McuIntOscRC16MHz</xsl:when>
										<xsl:otherwise>McuDivIntOscRC16MHz</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuStartRunMode</DEFINITION-REF>
                                    <VALUE>RUN1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuOSC</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuPLLStatus</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuCodeFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuDataFlashStatus</DEFINITION-REF>
                                    <VALUE>PowerDown</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuRC16MHzOscillator</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuOutputPowerDownControl</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuXtal_A_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalByPass</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalCounterOscillator</DEFINITION-REF>
                                    <VALUE>100</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalMaskInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalDivisor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuXtal_B_32KHz_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalByPass</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalCounterOscillator</DEFINITION-REF>
                                    <VALUE>100</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalMaskInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalDivisor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalOn</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuRC_16MHz_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_16MHz</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_16MHz/McuRCDivisor</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/PM/@FIRC_Clock_division_factor=''">error : Check FIRC_Clock_division_factor </xsl:when>
										<xsl:otherwise><xsl:value-of select="//SRS/PM/@FIRC_Clock_division_factor"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_16MHz/McuRCSTANDBYMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuRC_128KHz_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_128KHz</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_128KHz/McuRCDivisor</DEFINITION-REF>
                                    <VALUE>8</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_128KHz/McuRCStandBy</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuClkOutput_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput/McuClkOutput</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/CLOCK_OUTPUT/@Usage='ENABLE'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput/McuClkDivisor</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/CLOCK_OUTPUT/@Usage='ENABLE' and //SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_FIRC !='' ">DIV_<xsl:value-of select="//SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_FIRC"/></xsl:when>
										<xsl:otherwise>DIV_1</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput/McuClkSource</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/CLOCK_OUTPUT/@Usage='ENABLE' and //SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_source_FIRC !='' "><xsl:value-of select="//SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_source_FIRC"/></xsl:when>
										<xsl:otherwise>F16_MHz_RC_Internal</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPll_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllMode</DEFINITION-REF>
                                    <VALUE>Normal</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPllParameter_1</SHORT-NAME>

                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuOutputDivisionFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@MCAL_ODF"/></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuInputDivisionFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@MCAL_IDF"/></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuMultiplicationFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@MCAL_NDIV"/></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuProgressiveClockSwitching</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuEnableFailInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuFmPllParameter_1</SHORT-NAME>

                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter/McuModulationFrequency</DEFINITION-REF>
                                    <VALUE>4000</VALUE>
                                    </INTEGER-VALUE>
                                    <FLOAT-VALUE>

                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter/McuPercentualModulationDepth</DEFINITION-REF>
                                    <VALUE>0.25</VALUE>
                                    </FLOAT-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter/McuSpreadSelection</DEFINITION-REF>
                                    <VALUE>Down_Spread</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McueMIOSSettings_0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/GlobalPrescaler</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/IO/TIMER/MAIN_TIMER/@eMios0_Global"/></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/MdisBit</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/GlobalTimeBaseEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/FreezeBit</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/GlobalPrescalerEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McueMIOSSettings_1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/GlobalPrescaler</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/IO/TIMER/MAIN_TIMER/@eMios1_Global !=''"><xsl:value-of select="//SRS/IO/TIMER/MAIN_TIMER/@eMios1_Global"/></xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/MdisBit</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/@Package='PACKAGE_100'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/GlobalTimeBaseEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/FreezeBit</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/GlobalPrescalerEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPeripheralClkSet_0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_0/McuPeripheralEnableClk</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_0/McuPeripheralDivisorFactor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPeripheralClkSet_1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_1/McuPeripheralEnableClk</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_1/McuPeripheralDivisorFactor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPeripheralClkSet_2_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_2</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_2/McuPeripheralEnableClk</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_2/McuPeripheralDivisorFactor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuClkMonitor_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuFmPllMonitor</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuRCOSCSelection</DEFINITION-REF>
                                    <VALUE>CK_IRCfast</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuRCDivisorFactor</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <FLOAT-VALUE>

                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuHighFrequencyRef</DEFINITION-REF>
                                    <VALUE>90000000</VALUE>
                                    </FLOAT-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuLowFrequencyRef</DEFINITION-REF>
                                    <VALUE>23000000</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuFlashPFCR0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/AddressPipeliningControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/WriteWaitStateControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/ReadWaitStateControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuFlashPFCR1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1/AddressPipeliningControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1/WriteWaitStateControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1/ReadWaitStateControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>MCU_CLK_SETTING_QUARTZ</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClockReferencePointFrequency</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$OSCILLATOR_CLOCK"/>000000</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralSet1Frequency</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$OSCILLATOR_CLOCK"/>000000</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralSet2Frequency</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$OSCILLATOR_CLOCK"/>000000</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralSet3Frequency</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$OSCILLATOR_CLOCK"/>000000</VALUE>
                                    </FLOAT-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>GeneralClockSettings_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/SystemClockSelect</DEFINITION-REF>
                                    <VALUE>McuDivExtQuartzOsc</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuStartRunMode</DEFINITION-REF>
                                    <VALUE>RUN2</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuOSC</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuPLLStatus</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuCodeFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuDataFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuRC16MHzOscillator</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/GeneralClockSettings/McuOutputPowerDownControl</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuXtal_A_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalByPass</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalCounterOscillator</DEFINITION-REF>
                                    <VALUE>100</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalMaskInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_A/McuXtalDivisor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>

                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuXtal_B_32KHz_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalByPass</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalCounterOscillator</DEFINITION-REF>
                                    <VALUE>100</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalMaskInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalDivisor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuXtal_B_32KHz/McuXtalOn</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuRC_16MHz_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_16MHz</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_16MHz/McuRCDivisor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_16MHz/McuRCSTANDBYMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuRC_128KHz_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_128KHz</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_128KHz/McuRCDivisor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuRC_128KHz/McuRCStandBy</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuClkOutput_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput/McuClkOutput</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/CLOCK_OUTPUT/@Usage='ENABLE'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput/McuClkDivisor</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/CLOCK_OUTPUT/@Usage='ENABLE' and //SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_FXOSC !=''">DIV_<xsl:value-of select="//SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_FXOSC"/></xsl:when>
										<xsl:otherwise>DIV_1</xsl:otherwise>
									</xsl:choose>
									</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkOutput/McuClkSource</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/CLOCK_OUTPUT/@Usage='ENABLE' and //SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_source_FXOSC !='' "><xsl:value-of select="//SRS/MCU/SPEC/CLOCK_OUTPUT/@ClockOutput_source_FXOSC"/></xsl:when>
										<xsl:otherwise>Crystal</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPll_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllMode</DEFINITION-REF>
                                    <VALUE>Normal</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPllParameter_1</SHORT-NAME>

                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuOutputDivisionFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@MCAL_ODF"/></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuInputDivisionFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@MCAL_IDF"/></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuMultiplicationFactor</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/SPEC/@MCAL_NDIV"/></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuProgressiveClockSwitching</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuPllParameter/McuEnableFailInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuFmPllParameter_1</SHORT-NAME>

                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter/McuModulationFrequency</DEFINITION-REF>
                                    <VALUE>4000</VALUE>
                                    </INTEGER-VALUE>
                                    <FLOAT-VALUE>

                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter/McuPercentualModulationDepth</DEFINITION-REF>
                                    <VALUE>0.25</VALUE>
                                    </FLOAT-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPll/McuFmPllParameter/McuSpreadSelection</DEFINITION-REF>
                                    <VALUE>Down_Spread</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McueMIOSSettings_0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/GlobalPrescaler</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/IO/TIMER/MAIN_TIMER/@eMios0_Global"/></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/MdisBit</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/GlobalTimeBaseEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/FreezeBit</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_0/GlobalPrescalerEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McueMIOSSettings_1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/GlobalPrescaler</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/IO/TIMER/MAIN_TIMER/@eMios1_Global !=''"><xsl:value-of select="//SRS/IO/TIMER/MAIN_TIMER/@eMios1_Global"/></xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/MdisBit</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/@Package='PACKAGE_100'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/GlobalTimeBaseEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/FreezeBit</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McueMIOSSettings_1/GlobalPrescalerEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPeripheralClkSet_0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_0/McuPeripheralEnableClk</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_0/McuPeripheralDivisorFactor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPeripheralClkSet_1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_1/McuPeripheralEnableClk</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_1/McuPeripheralDivisorFactor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuPeripheralClkSet_2_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_2</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_2/McuPeripheralEnableClk</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuPeripheralClkSet_2/McuPeripheralDivisorFactor</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuClkMonitor_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuFmPllMonitor</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuRCOSCSelection</DEFINITION-REF>
                                    <VALUE>CK_IRCfast</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuRCDivisorFactor</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <FLOAT-VALUE>

                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuHighFrequencyRef</DEFINITION-REF>
                                    <VALUE>90000000</VALUE>
                                    </FLOAT-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuClkMonitor/McuLowFrequencyRef</DEFINITION-REF>
                                    <VALUE>23000000</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuFlashPFCR0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/AddressPipeliningControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/WriteWaitStateControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR0/ReadWaitStateControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>McuFlashPFCR1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1/AddressPipeliningControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1/WriteWaitStateControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuClockSettingConfig/McuClockReferencePoint/McuFlashPFCR1/ReadWaitStateControl</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuModeSettingConf_HALT</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuMode</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuOperatingMode</DEFINITION-REF>
                                    <VALUE>HALT</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuOutputPowerDownControl</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/SystemClock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuVoltageRegulator</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuBootMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuFastTransition</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuAuxiliaryClockSettings</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuRC16MHzOscillator</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/LowPowerClockSettingConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuClockSettingConfig/MCU_CLK_SETTING_PLL_PLL</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>GeneralClockSettings_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/SystemClockSelect</DEFINITION-REF>
                                    <VALUE>McuPLL</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuOSC</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuPLLStatus</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuCodeFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuDataFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuModeSettingConf_QUARTZ</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuMode</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuOperatingMode</DEFINITION-REF>
                                    <VALUE>RUN2</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuOutputPowerDownControl</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/SystemClock</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuVoltageRegulator</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuBootMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuFastTransition</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuAuxiliaryClockSettings</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuRC16MHzOscillator</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/LowPowerClockSettingConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuClockSettingConfig/MCU_CLK_SETTING_QUARTZ</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>GeneralClockSettings_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/SystemClockSelect</DEFINITION-REF>
                                    <VALUE>McuDivExtQuartzOsc</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuOSC</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuPLLStatus</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuCodeFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuDataFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuModeSettingConf_PLL</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuMode</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuOperatingMode</DEFINITION-REF>
                                    <VALUE>RUN0</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuOutputPowerDownControl</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/SystemClock</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuVoltageRegulator</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuBootMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuFastTransition</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuAuxiliaryClockSettings</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuRC16MHzOscillator</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/LowPowerClockSettingConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuClockSettingConfig/MCU_CLK_SETTING_PLL_PLL</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>GeneralClockSettings_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/SystemClockSelect</DEFINITION-REF>
                                    <VALUE>McuPLL</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuOSC</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuPLLStatus</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuCodeFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuDataFlashStatus</DEFINITION-REF>
                                    <VALUE>NormalMode</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuModeSettingConf_STOP</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuMode</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuOperatingMode</DEFINITION-REF>
                                    <VALUE>STOP</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuOutputPowerDownControl</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/SystemClock</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuVoltageRegulator</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuBootMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuFastTransition</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuAuxiliaryClockSettings</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/McuRC16MHzOscillator</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/LowPowerClockSettingConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuClockSettingConfig/MCU_CLK_SETTING_IRC16MHZ</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>GeneralClockSettings_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/SystemClockSelect</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="//SRS/PM/@FIRC_Clock_division_factor=''">error : Check FIRC_Clock_division_factor </xsl:when>
										<xsl:when test="//SRS/PM/@FIRC_Clock_division_factor='1'">McuIntOscRC16MHz</xsl:when>
										<xsl:otherwise>McuDivIntOscRC16MHz</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuOSC</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuPLLStatus</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuCodeFlashStatus</DEFINITION-REF>
                                    <VALUE>PowerDown</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuModeSettingConf/GeneralClockSettings/McuDataFlashStatus</DEFINITION-REF>
                                    <VALUE>PowerDown</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuRamSectorSettingConf_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRamSectorSettingConf</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRamSectorSettingConf/McuRamDefaultValue</DEFINITION-REF>
                                    <VALUE>3132799674</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRamSectorSettingConf/McuRamSectionBaseAddress</DEFINITION-REF>
                                    <VALUE>0x40000000</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRamSectorSettingConf/McuRamSectionSize</DEFINITION-REF>
                                    <xsl:choose>
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='24'"><VALUE>24572</VALUE></xsl:when> 
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='28'"><VALUE>28668</VALUE></xsl:when> 
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='32'"><VALUE>32764</VALUE></xsl:when> 
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='48'"><VALUE>49148</VALUE></xsl:when> 
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='64'"><VALUE>65532</VALUE></xsl:when> 
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='80'"><VALUE>81916</VALUE></xsl:when> 
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='96'"><VALUE>98300</VALUE></xsl:when> 
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='128'"><VALUE>131068</VALUE></xsl:when> 
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='160'"><VALUE>163836</VALUE></xsl:when> 
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='192'"><VALUE>196604</VALUE></xsl:when> 
										<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='256'"><VALUE>262140</VALUE></xsl:when> 
										<xsl:otherwise>
											<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/MCU/SPEC/@RAM_SIZE 가, AIS에서 지원하지 않는 값 (Empty 인 경우 포함)
=======================================================================================================================</xsl:message>  
										</xsl:otherwise> 
										<!-- MCAL 6 적용시에는 이부분에서 Generation Error 발생. 각 실제 RAM size의 값에서 4씩 빼줘야 함. (MCAL Bug로 생각됨) --> 
										<!-- 현재 적어져 있는 값들은 실제값에서 -4씩 한 값들임. --> 
									</xsl:choose>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRamSectorSettingConf/McuRamSectionBaseAddrLinkerSym</DEFINITION-REF>
                                    <VALUE/>
                                    </STRING-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRamSectorSettingConf/McuRamSectionSizeLinkerSym</DEFINITION-REF>
                                    <VALUE/>
                                    </STRING-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuEnableMode</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuEnableMode</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuEnableMode/McuModeSTBY</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuEnableMode/McuModeStop</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuEnableMode/McuModeHalt</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuEnableMode/McuModeRun3</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuEnableMode/McuModeRun2</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuEnableMode/McuModeRun1</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuInterruptTransition</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuInterruptTransition</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuInterruptTransition/McuTransitionComplete</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuInterruptTransition/McuSafeMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuInterruptTransition/McuInvalidMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuInterruptTransition/McuInvalidConfiguration</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuPowerDomain_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPowerDomain</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPowerDomain/McuPwrSTBY</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPowerDomain/McuPwrStop</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPowerDomain/McuPwrHalt</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPowerDomain/McuPwrRun3</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPowerDomain/McuPwrRun2</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPowerDomain/McuPwrRun1</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPowerDomain/McuPwrRun0</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPowerDomain/McuPwrDRun</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPowerDomain/McuPwrSafe</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuDMAMUXandEDMAConfig</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMAMUXandEDMAConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMAMUXandEDMAConfig/eDMAChannelPriority0</DEFINITION-REF>
                                    <VALUE>66051</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMAMUXandEDMAConfig/eDMAChannelPriority4</DEFINITION-REF>
                                    <VALUE>67438087</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMAMUXandEDMAConfig/eDMAChannelPriority8</DEFINITION-REF>
                                    <VALUE>134810123</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMAMUXandEDMAConfig/eDMAChannelPriority12</DEFINITION-REF>
                                    <VALUE>202182159</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMAMUXandEDMAConfig/ERCA</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMAMUXandEDMAConfig/EDBG</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMAMUXandEDMAConfig/EBW</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMAMUXandEDMAConfig/DmaTimeOut</DEFINITION-REF>
                                    <VALUE>100</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuDMA</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI0_TX</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI0_TX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI0_TX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI0_TX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI0_TX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI0_TX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI0_TX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI0_RX</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI0_RX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI0_RX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI0_RX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI0_RX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI0_RX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI0_RX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI1_TX</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI1_TX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI1_TX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI1_TX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI1_TX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI1_TX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI1_TX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI1_RX</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI1_RX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI1_RX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI1_RX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI1_RX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI1_RX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI1_RX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI2_TX</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI2_TX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI2_TX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>4</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI2_TX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI2_TX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI2_TX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI2_TX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI2_RX</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI2_RX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI2_RX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI2_RX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI2_RX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI2_RX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI2_RX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI3_TX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI3_TX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI3_TX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>6</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI3_TX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI3_TX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI3_TX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI3_TX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI3_RX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI3_RX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI3_RX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>7</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI3_RX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI3_RX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI3_RX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI3_RX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI4_TX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI4_TX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI4_TX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>8</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI4_TX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI4_TX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI4_TX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI4_TX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI4_RX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI4_RX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI4_RX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>9</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI4_RX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI4_RX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI4_RX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI4_RX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI5_TX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI5_TX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI5_TX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>10</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI5_TX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI5_TX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI5_TX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI5_TX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI5_RX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI5_RX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI5_RX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>11</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI5_RX/McuDMASource</DEFINITION-REF>
                                    <VALUE>DSPI5_RX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI5_RX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/DSPI5_RX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS0_CH0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH0/DMAChannelId</DEFINITION-REF>
                                    <VALUE>12</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH0/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS0_CH0</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH0/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH0/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS0_CH1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH1/DMAChannelId</DEFINITION-REF>
                                    <VALUE>13</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH1/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS0_CH1</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH1/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH1/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS0_CH9_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH9</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH9/DMAChannelId</DEFINITION-REF>
                                    <VALUE>14</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH9/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS0_CH9</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH9/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH9/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS0_CH18_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH18</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH18/DMAChannelId</DEFINITION-REF>
                                    <VALUE>15</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH18/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS0_CH18</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH18/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH18/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS0_CH25_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH25</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH25/DMAChannelId</DEFINITION-REF>
                                    <VALUE>16</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH25/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS0_CH25</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH25/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH25/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS0_CH26_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH26</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH26/DMAChannelId</DEFINITION-REF>
                                    <VALUE>17</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH26/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS0_CH26</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH26/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS0_CH26/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS1_CH0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH0/DMAChannelId</DEFINITION-REF>
                                    <VALUE>18</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH0/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS1_CH0</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH0/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH0/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS1_CH9_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH9</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH9/DMAChannelId</DEFINITION-REF>
                                    <VALUE>19</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH9/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS1_CH9</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH9/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH9/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS1_CH17_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH17</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH17/DMAChannelId</DEFINITION-REF>
                                    <VALUE>20</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH17/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS1_CH17</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH17/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH17/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS1_CH18_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH18</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH18/DMAChannelId</DEFINITION-REF>
                                    <VALUE>21</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH18/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS1_CH18</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH18/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH18/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS1_CH25_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH25</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH25/DMAChannelId</DEFINITION-REF>
                                    <VALUE>22</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH25/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS1_CH25</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH25/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH25/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EMIOS1_CH26_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH26</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH26/DMAChannelId</DEFINITION-REF>
                                    <VALUE>23</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH26/McuDMASource</DEFINITION-REF>
                                    <VALUE>EMIOS1_CH26</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH26/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/EMIOS1_CH26/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>ADC0_EOC_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ADC0_EOC</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ADC0_EOC/DMAChannelId</DEFINITION-REF>
                                    <VALUE>24</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ADC0_EOC/McuDMASource</DEFINITION-REF>
                                    <VALUE>ADC0_EOC</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ADC0_EOC/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ADC0_EOC/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>ADC1_EOC_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ADC1_EOC</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ADC1_EOC/DMAChannelId</DEFINITION-REF>
                                    <VALUE>25</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ADC1_EOC/McuDMASource</DEFINITION-REF>
                                    <VALUE>ADC1_EOC</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ADC1_EOC/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ADC1_EOC/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>IIC_RX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/IIC_RX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/IIC_RX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>26</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/IIC_RX/McuDMASource</DEFINITION-REF>
                                    <VALUE>IIC_RX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/IIC_RX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/IIC_RX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>IIC_TX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/IIC_TX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/IIC_TX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/IIC_TX/McuDMASource</DEFINITION-REF>
                                    <VALUE>IIC_TX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/IIC_TX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/IIC_TX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LINFLEX0_RX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX0_RX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX0_RX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>28</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX0_RX/McuDMASource</DEFINITION-REF>
                                    <VALUE>LINFLEX0_RX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX0_RX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX0_RX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LINFLEX0_TX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX0_TX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX0_TX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>29</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX0_TX/McuDMASource</DEFINITION-REF>
                                    <VALUE>LINFLEX0_TX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX0_TX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX0_TX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LINFLEX1_RX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX1_RX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX1_RX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>30</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX1_RX/McuDMASource</DEFINITION-REF>
                                    <VALUE>LINFLEX1_RX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX1_RX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX1_RX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LINFLEX1_TX_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX1_TX</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX1_TX/DMAChannelId</DEFINITION-REF>
                                    <VALUE>31</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX1_TX/McuDMASource</DEFINITION-REF>
                                    <VALUE>LINFLEX1_TX</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX1_TX/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/LINFLEX1_TX/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>ALWAYS_ENABLED_0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_0/DMAChannelId</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_0/McuDMASource</DEFINITION-REF>
                                    <VALUE>ALWAYS_ENABLED_0</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_0/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_0/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>ALWAYS_ENABLED_1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_1/DMAChannelId</DEFINITION-REF>
                                    <VALUE>33</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_1/McuDMASource</DEFINITION-REF>
                                    <VALUE>ALWAYS_ENABLED_1</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_1/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_1/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>ALWAYS_ENABLED_2_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_2</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_2/DMAChannelId</DEFINITION-REF>
                                    <VALUE>34</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_2/McuDMASource</DEFINITION-REF>
                                    <VALUE>ALWAYS_ENABLED_2</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_2/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_2/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>ALWAYS_ENABLED_3_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_3</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_3/DMAChannelId</DEFINITION-REF>
                                    <VALUE>35</VALUE>
                                    </INTEGER-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_3/McuDMASource</DEFINITION-REF>
                                    <VALUE>ALWAYS_ENABLED_3</VALUE>
                                    </STRING-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_3/DMAChannelEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuDMA/ALWAYS_ENABLED_3/DMAChannelTriggerEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuRunConfig_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun3</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun2</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun1</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun0</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeDRun</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeSafe</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuRunConfig_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun3</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun2</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun1</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun0</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeDRun</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeSafe</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuRunConfig_2</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun3</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun2</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun1</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun0</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeDRun</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeSafe</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuRunConfig_3</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun3</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun2</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun1</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun0</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeDRun</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeSafe</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuRunConfig_4</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun3</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun2</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun1</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun0</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeDRun</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeSafe</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuRunConfig_5</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun3</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun2</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun1</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun0</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeDRun</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeSafe</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuRunConfig_6</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun3</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun2</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun1</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun0</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeDRun</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeSafe</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuRunConfig_7</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun3</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun2</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun1</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeRun0</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeDRun</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuRunConfig/McuModeSafe</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuLowPower_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuSTBY</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuStop</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuHalt</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuLowPower_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuSTBY</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuStop</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuHalt</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuLowPower_2</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuSTBY</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuStop</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuHalt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuLowPower_3</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuSTBY</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuStop</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuHalt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuLowPower_4</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuSTBY</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuStop</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuHalt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuLowPower_5</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuSTBY</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuStop</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuHalt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuLowPower_6</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuSTBY</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuStop</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuHalt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuLowPower_7</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuSTBY</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuStop</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuLowPower/McuHalt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuPeriphal</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI0</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI0/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI0/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI1</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI1/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI1/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI2</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI2</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI2/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI2/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI3</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI3</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI3/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI3/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI4</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI4</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI4/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI4/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DSPI5</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI5</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI5/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DSPI5/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LIN_FLEX8</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX8</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX8/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX8/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LIN_FLEX9</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX9</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX9/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX9/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>FlexCAN0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN0</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN0/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN0/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>FlexCAN1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN1</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN1/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN1/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>FlexCAN2</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN2</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN2/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN2/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>FlexCAN3</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN3</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN3/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN3/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>FlexCAN4</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN4</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN4/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN4/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>FlexCAN5</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN5</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN5/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/FlexCAN5/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>DMA_CH_MUX</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DMA_CH_MUX</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DMA_CH_MUX/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/DMA_CH_MUX/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>ADC0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/ADC0</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/ADC0/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/ADC0/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>ADC1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/ADC1</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/ADC1/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/ADC1/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LIN_FLEX2</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX2</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX2/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX2/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LIN_FLEX3</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX3</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX3/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX3/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LIN_FLEX4</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX4</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX4/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX4/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LIN_FLEX5</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX5</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX5/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX5/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LIN_FLEX6</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX6</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX6/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX6/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LIN_FLEX7</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX7</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX7/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX7/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>CTU</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/CTU</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/CTU/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/CTU/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>I2C0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/I2C0</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/I2C0/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/I2C0/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LIN_FLEX0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX0</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX0/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX0/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LIN_FLEX1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX1</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX1/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/LIN_FLEX1/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>CANSampler</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/CANSampler</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/CANSampler/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/CANSampler/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>SIUL</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/SIUL</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/SIUL/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/SIUL/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>WKPU</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/WKPU</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/WKPU/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/WKPU/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_1</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>eMIOS0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/eMIOS0</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/eMIOS0/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/eMIOS0/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>eMIOS1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/eMIOS1</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/eMIOS1/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/eMIOS1/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>RTC_API</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/RTC_API</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/RTC_API/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/RTC_API/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_1</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>PIT_RTI</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/PIT_RTI</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/PIT_RTI/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/PIT_RTI/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>CMU0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/CMU0</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/CMU0/McuPerRunConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuRunConfig_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuPeriphal/CMU0/McuPerLowPwrConfig</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuLowPower_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuResetSource</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>JTAG</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/JTAG</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/JTAG/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/JTAG/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/JTAG/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/JTAG/McuResetPin</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>CORE</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CORE</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CORE/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CORE/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CORE/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CORE/McuResetPin</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>SOFT</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/SOFT</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/SOFT/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/SOFT/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/SOFT/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/SOFT/McuResetPin</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LVD12PD0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD12PD0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD12PD0/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD12PD0/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD12PD0/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD12PD0/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LVD12PD1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD12PD1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD12PD1/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD12PD1/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD12PD1/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD12PD1/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>SWT</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/SWT</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/SWT/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/SWT/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/SWT/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/SWT/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>CHKSTOP_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CHKSTOP</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CHKSTOP/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CHKSTOP/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CHKSTOP/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CHKSTOP/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>PLL_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/PLL</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/PLL/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/PLL/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/PLL/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/PLL/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>XTAL_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/XTAL</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/XTAL/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/XTAL/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/XTAL/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/XTAL/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>CMU_FHL_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CMU_FHL</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CMU_FHL/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CMU_FHL/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CMU_FHL/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/CMU_FHL/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LVD45_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD45</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD45/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD45/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD45/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD45/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>FLASH_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/FLASH</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/FLASH/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/FLASH/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/FLASH/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/FLASH/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>EXR</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/EXR</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/EXR/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/EXR/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/EXR/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/EXR/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LVD27_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>LVD27_VREG</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27_VREG</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27_VREG/McuEnableReset</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27_VREG/McuEnableInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27_VREG/McuResetPhase</DEFINITION-REF>
                                    <VALUE>PHASE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuResetSource/LVD27_VREG/McuResetPin</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuFlashPFCR0_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFCR0</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFCR0/ReadWhileWriteControl</DEFINITION-REF>
                                    <VALUE>7</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFCR0/Port0PageBufferConfiguration</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFCR0/Port0DataPrefetchEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFCR0/Port0InstructionPrefetchEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFCR0/Port0PrefetchLimit</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFCR0/Port0BufferEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuFlashPFCR1_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFCR1</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFCR1/ReadWhileWriteControl</DEFINITION-REF>
                                    <VALUE>7</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFCR1/Port0BufferEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>McuFlashPFAPR_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFAPR</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFAPR/Master0PrefetchDisable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFAPR/Master2PrefetchDisable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFAPR/Master0AccessProtection</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Mcu/McuModuleConfiguration/McuFlashPFAPR/Master2AccessProtection</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Resource</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Resource</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Resource/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Resource/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Resource/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Resource/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Resource/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Resource/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Resource/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Resource/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Resource/CommonPublishedInformation/VendorApiInfix</DEFINITION-REF>
                                    <VALUE/>
                                </STRING-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Resource/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>ResourceGeneral</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Resource/ResourceGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Resource/ResourceGeneral/ResourceSubderivative</DEFINITION-REF>
									<xsl:choose>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5602B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>mpc5602bxll_lqfp100</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5602B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>mpc5602bxll_lqfp144</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5603B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>mpc5603bxll_lqfp100</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5603B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>mpc5603bxlq_lqfp144</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5604B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>mpc5604bxll_lqfp100</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5604B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>mpc5604bxlq_lqfp144</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5605B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>mpc5605bxll_lqfp100</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5605B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>mpc5605bxlq_lqfp144</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5605B') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>mpc5605bxlu_lqfp176</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5606B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>mpc5606bxlq_lqfp144</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5606B') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>mpc5606bxlu_lqfp176</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5607B') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>mpc5607bxlu_lqfp176</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B40') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>spc560b40_lqfp100</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B40') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>spc560b40_lqfp144</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B44') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>spc560b44_lqfp100</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B44') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>spc560b44_lqfp144</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B50') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>spc560b50_lqfp100</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B50') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>spc560b50_lqfp144</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B54') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>spc560b54_lqfp100</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B54') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>spc560b54_lqfp144</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B54') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>spc560b54_lqfp176</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B60') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>spc560b60_lqfp144</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B60') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>spc560b60_lqfp176</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B64') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>spc560b64_lqfp176</VALUE>
										</xsl:when>
										<xsl:otherwise>
											<VALUE>plz Select MCU by manual</VALUE>
										</xsl:otherwise>
									</xsl:choose>
                                </ENUMERATION-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Os</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M4I5R0_AS31/Os</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>4</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>32</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation/VendorApiInfix</DEFINITION-REF>
                                    <VALUE/>
                                </STRING-VALUE>
                                <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/CommonPublishedInformation/Release</DEFINITION-REF>
                                    <VALUE>_PA_XPC560XB</VALUE>
                                </STRING-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
<!--========================================================OS========================================================-->							
							<xsl:call-template name="make_AUTOSAR_OS_setting"/>
<!--========================================================OS========================================================-->
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Adc</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Adc</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>AdcConfigSet</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet</DEFINITION-REF>
                            <SUB-CONTAINERS>
							
						<xsl:if test = "//SRS/IO/ADC/@ADC0_Enable = 'Yes'">
<!--========================================================ADC========================================================-->
								<xsl:call-template name="make_ADC_Channel_Config">
									<xsl:with-param name = "ADC_HW_CHANNEL_NUMBER" select="'0'"/>
									<xsl:with-param name = "ADC_T_clk" select="//SRS/IO/ADC/@ADC0_T_clk"/>
									<xsl:with-param name = "ADC_INPSAMP" select="//SRS/IO/ADC/@ADC0_INPSAMP"/>
									<xsl:with-param name = "ADC_INPCMP" select="//SRS/IO/ADC/@ADC0_INPCMP"/>
									<xsl:with-param name = "ADC_INPLATCH" select="//SRS/IO/ADC/@ADC0_INPLATCH"/>
									<xsl:with-param name = "ADC_T_conv" select="//SRS/IO/ADC/@ADC0_T_conv"/>
								</xsl:call-template>
<!--========================================================ADC========================================================-->
						</xsl:if>
						<xsl:if test = "//SRS/IO/ADC/@ADC1_Enable = 'Yes'">
<!--========================================================ADC========================================================-->
								<xsl:call-template name="make_ADC_Channel_Config">
									<xsl:with-param name = "ADC_HW_CHANNEL_NUMBER" select="'1'"/>
									<xsl:with-param name = "ADC_T_clk" select="//SRS/IO/ADC/@ADC1_T_clk"/>
									<xsl:with-param name = "ADC_INPSAMP" select="//SRS/IO/ADC/@ADC1_INPSAMP"/>
									<xsl:with-param name = "ADC_INPCMP" select="//SRS/IO/ADC/@ADC1_INPCMP"/>
									<xsl:with-param name = "ADC_INPLATCH" select="//SRS/IO/ADC/@ADC1_INPLATCH"/>
									<xsl:with-param name = "ADC_T_conv" select="//SRS/IO/ADC/@ADC1_T_conv"/>
								</xsl:call-template>
<!--========================================================ADC========================================================-->
						</xsl:if>

								<CONTAINER>
                                    <SHORT-NAME>AdcGeneric_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcGeneric</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcGeneric/AdcPriorityQueueMaxDepth</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcGeneric/Adc0MaxGroupChannels</DEFINITION-REF>
									<xsl:choose>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5602B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>56</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5602B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>64</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5603B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>56</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5603B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>64</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5604B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>56</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5604B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>64</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5605B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>54</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5605B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>62</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5605B') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>76</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5606B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>62</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5606B') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>76</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5607B') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>76</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B40') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>56</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B40') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>64</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B44') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>56</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B44') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>64</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B50') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>56</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B50') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>64</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B54') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>56</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B54') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>62</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B54') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>76</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B60') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>62</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B60') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>76</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B64') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>76</VALUE>
										</xsl:when>
										<xsl:otherwise>
											<VALUE>plz choose Adc0MaxGroupChannels manually</VALUE>
										</xsl:otherwise>
									</xsl:choose>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcGeneric/Adc1MaxGroupChannels</DEFINITION-REF>
                                    <xsl:choose>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5602B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5602B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5603B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5603B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5604B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5604B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5605B') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5605B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5605B') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5606B') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5606B') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='MPC5607B') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B40') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B40') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B44') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B44') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B50') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B50') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>0</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B54') and //SRS/MCU/SPEC/@Package='PACKAGE_100'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B54') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B54') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B60') and //SRS/MCU/SPEC/@Package='PACKAGE_144'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B60') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:when test="(//SRS/MCU/SPEC/@Name='SPC560B64') and //SRS/MCU/SPEC/@Package='PACKAGE_176'">
											<VALUE>24</VALUE>
										</xsl:when>
										<xsl:otherwise>
											<VALUE>plz choose Adc1MaxGroupChannels manually</VALUE>
										</xsl:otherwise>
									</xsl:choose>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcGeneric/AdcTransferType</DEFINITION-REF>
                                    <VALUE>ADC_INTERRUPT</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>AdcGeneral_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcDeInitApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcSetModeApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/ADCDisableDemReportErrorStatus</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcEnableStartStopGroupApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcGrpNotifCapability</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcHwTriggerApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcReadGroupApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcPriorityImplementation</DEFINITION-REF>
                                    <VALUE>ADC_PRIORITY_NONE</VALUE>
                                </ENUMERATION-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcEnableQueuing</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcConvTimeOnce</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcPreSamplingOnce</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcSetOnceRegisters</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcGeneral/AdcTimeout</DEFINITION-REF>
                                    <VALUE>65535</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>AdcPublishedInformation_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcPublishedInformation/AdcChannelValueSigned</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcPublishedInformation/AdcGroupFirstChannelFixed</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcPublishedInformation/AdcMaxChannelResolution</DEFINITION-REF>
                                    <VALUE>10</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>123</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>NonAutosar_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar/AdcEnableDualClockMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar/AdcEnableHwTrigNonAutosarApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar/AdcChIndexSymNames</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar/AdcBypassConsistencyLoop</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar/AdcEnableChDisableChApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar/AdcErrataInterruptedNormalGroup</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar/AdcErrataOptimizedSwAbort</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar/AdcLeftAlignment</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar/AdcEnableThresholdConfiguration</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/NonAutosar/AdcGetInjectedConvStatusApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
				<MODULE-CONFIGURATION>
                    <SHORT-NAME>Wdg</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Wdg</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>WdgExternalConfiguration</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Wdg/WdgExternalConfiguration</DEFINITION-REF>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="CHOICE-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgExternalConfiguration/WdgExternalContainerRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER"/>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>WdgGeneral</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Wdg/WdgGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgGeneral/WdgDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgGeneral/WdgDisableAllowed</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgGeneral/WdgDisableDemReportErrorStatus</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgGeneral/WdgMasterAccessProtection</DEFINITION-REF>
                                    <VALUE>ALL_MAPx</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgGeneral/WdgIndex</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Wdg/WdgGeneral/WdgCallbackNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Wdg/WdgGeneral/WdgTriggerLocation</DEFINITION-REF>
                                    <VALUE>a</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgGeneral/WdgVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>WdgModeConfig</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgDefaultMode</DEFINITION-REF>
                                    <VALUE>SlowMode</VALUE>
                                </ENUMERATION-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgKeyedService</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgServiceKeyValue</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>WdgSettingsOff_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsOff</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsOff/WdgSoftLock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsOff/WdgHardLock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>WdgSettingsSlow_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow/WdgSoftLock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow/WdgHardLock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow/WdgWindowMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow/WdgRunsInStopMode</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow/WdgRunsInDebugMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow/WdgOperationMode</DEFINITION-REF>
                                    <VALUE>ResetOnTimeOut</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow/WdgResetOnInvalidAccess</DEFINITION-REF>
                                    <VALUE>SystemReset</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow/WdgClockSelection</DEFINITION-REF>
                                    <VALUE>OscillatorClock</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow/WdgTimeoutPeriod</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//CORE/WDG/@Timeout_ms"/></VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsSlow/WdgWindowPeriod</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </FLOAT-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>WdgSettingsFast_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast/WdgSoftLock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast/WdgHardLock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast/WdgWindowMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast/WdgRunsInStopMode</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast/WdgRunsInDebugMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast/WdgOperationMode</DEFINITION-REF>
                                    <VALUE>ResetOnTimeOut</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast/WdgResetOnInvalidAccess</DEFINITION-REF>
                                    <VALUE>BusError</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast/WdgClockSelection</DEFINITION-REF>
                                    <VALUE>OscillatorClock</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast/WdgTimeoutPeriod</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgModeConfig/WdgSettingsFast/WdgWindowPeriod</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </FLOAT-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Wdg/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>102</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>WdgPublishedInformation_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Wdg/WdgPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgPublishedInformation/WdgMaxTimeout</DEFINITION-REF>
                                    <VALUE>33554.4319921875</VALUE>
                                </FLOAT-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgPublishedInformation/WdgMinTimeout</DEFINITION-REF>
                                    <VALUE>0.002</VALUE>
                                </FLOAT-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgPublishedInformation/WdgResolution</DEFINITION-REF>
                                    <VALUE>7.8125E-6</VALUE>
                                </FLOAT-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Wdg/WdgPublishedInformation/WdgTriggerMode</DEFINITION-REF>
                                    <VALUE>WDG_BOTH</VALUE>
                                </ENUMERATION-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
				<MODULE-CONFIGURATION>
                    <SHORT-NAME>Spi</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Spi</DEFINITION-REF>
                    <CONTAINERS>
						<CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>83</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>SpiDriver_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver</DEFINITION-REF>
                            <SUB-CONTAINERS>
<!--========================================================SPI========================================================-->							
							
								<xsl:call-template name="make_SPI_Channel_Config">
									<xsl:with-param name = "SPI_Channel_name_variable" select="$SPI_Channel_name_variable"/>
								</xsl:call-template>
<!--========================================================SPI========================================================-->
                            </SUB-CONTAINERS>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiMaxChannel</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="count($SPI_Channel_name_variable) = '0'">1</xsl:when>
										<xsl:otherwise><xsl:value-of select="count($SPI_Channel_name_variable)"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiMaxJob</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="count(//SPI_CHANNEL_SETTING) = '0'">1</xsl:when>
										<xsl:otherwise><xsl:value-of select="count(//SPI_CHANNEL_SETTING)"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiMaxSequence</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="count(//SPI_CHANNEL_SETTING) = '0'">1</xsl:when>
										<xsl:otherwise><xsl:value-of select="count(//SPI_CHANNEL_SETTING)"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>SpiGeneral_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiCancelApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiChannelBuffersAllowed</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiHwStatusApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiInterruptibleSeqAllowed</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
								<BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiDisableDemReportErrorStatus</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiLevelDelivered</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiGlobalDmaEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiSyncTransmitTimeout</DEFINITION-REF>
                                    <VALUE>50000</VALUE>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiOptimizeOneJobSequences</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiOptimizedSeqNumber</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiOptimizedChannelsNumber</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>SpiPhyUnit_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyUnitMapping</DEFINITION-REF>
                                    <VALUE>DSPI_0</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyUnitSync</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyUnitAsyncMethod</DEFINITION-REF>
                                    <VALUE>PIO_FIFO</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyTxDmaChannel</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyTxDmaChannelAux</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyRxDmaChannel</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>SpiPhyUnit_2</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyUnitMapping</DEFINITION-REF>
                                    <VALUE>DSPI_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyUnitSync</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyUnitAsyncMethod</DEFINITION-REF>
                                    <VALUE>PIO_FIFO</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyTxDmaChannel</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyTxDmaChannelAux</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyRxDmaChannel</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>SpiPhyUnit_3</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyUnitMapping</DEFINITION-REF>
                                    <VALUE>DSPI_2</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyUnitSync</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyUnitAsyncMethod</DEFINITION-REF>
                                    <VALUE>PIO_FIFO</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyTxDmaChannel</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyTxDmaChannelAux</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiPhyUnit/SpiPhyRxDmaChannel</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiGeneral/SpiClockRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuClockSettingConfig/MCU_CLK_SETTING_PLL_PLL</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>SpiNonAUTOSAR_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiNonAUTOSAR</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiNonAUTOSAR/SpiEnableMultiSyncTransmit</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiNonAUTOSAR/SpiAllowBigSizeCollections</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiNonAUTOSAR/SpiEnableHWUnitAsyncMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiNonAUTOSAR/SpiEnableDualClockMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiNonAUTOSAR/SpiJobStartNotificationenable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiNonAUTOSAR/SpiForceDataType</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiNonAUTOSAR/SpiAlternateClockRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuClockSettingConfig/MCU_CLK_SETTING_PLL_PLL</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Pwm</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Pwm</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>PwmChannelConfigSet</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet</DEFINITION-REF>
                            <SUB-CONTAINERS>
<!--========================================================PWM========================================================-->							
							<xsl:call-template name="make_PWM_Channel_Config"/>
<!--========================================================PWM========================================================-->                              
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>PwmConfigurationOfOptApiServices_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Pwm/PwmConfigurationOfOptApiServices</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmConfigurationOfOptApiServices/PwmDeInitApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmConfigurationOfOptApiServices/PwmGetOutputState</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmConfigurationOfOptApiServices/PwmSetDutyCycle</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmConfigurationOfOptApiServices/PwmSetOutputToIdle</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmConfigurationOfOptApiServices/PwmSetPeriodAndDuty</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmConfigurationOfOptApiServices/PwmVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>PwmNonAUTOSAR_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Pwm/PwmNonAUTOSAR</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmNonAUTOSAR/PwmSetCounterBusApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmNonAUTOSAR/PwmSetChannelOutputApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmNonAUTOSAR/PwmEnableDualClockMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmNonAUTOSAR/PwmSetTriggerDelay</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>PwmGeneral_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmDevErorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmDisableDemReportErrorStatus</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmChangeRegisterA</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmDutycycleUpdatedEndperiod</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmNotificationSupported</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmPeriodUpdatedEndperiod</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmIndex</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmClockFromMCU</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmEmiosClockValue</DEFINITION-REF>
                                    <VALUE>1000000</VALUE>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmGenerateClockTreeDebugInfo</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmGeneral/PwmCpuClockRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Mcu/McuModuleConfiguration_0/McuClockSettingConfig/MCU_CLK_SETTING_PLL_PLL</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Pwm/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>121</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Fee</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Fee</DEFINITION-REF>
                    <CONTAINERS>
						<CONTAINER>
                            <SHORT-NAME>FeeClusterGroup_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup</DEFINITION-REF>
                            <SUB-CONTAINERS>
							
                                <CONTAINER>
                                    <SHORT-NAME>FeeCluster_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>FeeSector_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster/FeeSector</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster/FeeSector/FeeSectorRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Fls/FlsConfigSet_1/FlsSectorList_1/FlsSector_DF0_L00</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
							
							
                                <CONTAINER>
                                    <SHORT-NAME>FeeCluster_2</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>FeeSector_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster/FeeSector</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster/FeeSector/FeeSectorRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Fls/FlsConfigSet_1/FlsSectorList_1/FlsSector_DF1_L01</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
							
								
							<xsl:if test="//SRS/MEM/EEPROM/DEVICE/@Calibration_Flash_Size = '16384'">
								<CONTAINER>
                                    <SHORT-NAME>FeeCluster_3</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>FeeSector_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster/FeeSector</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster/FeeSector/FeeSectorRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Fls/FlsConfigSet_1/FlsSectorList_1/FlsSector_DF2_L02</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
								</CONTAINER>
							</xsl:if>
								
                            </SUB-CONTAINERS>
                        </CONTAINER>
					
					<xsl:if test="//SRS/MEM/EEPROM/DEVICE/@Calibration_Flash_Size = '0'">
						<CONTAINER>
                            <SHORT-NAME>FeeClusterGroup_2</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup</DEFINITION-REF>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>FeeCluster_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>FeeSector_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster/FeeSector</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster/FeeSector/FeeSectorRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Fls/FlsConfigSet_1/FlsSectorList_1/FlsSector_DF2_L02</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>FeeCluster_2</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>FeeSector_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster/FeeSector</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeClusterGroup/FeeCluster/FeeSector/FeeSectorRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Fls/FlsConfigSet_1/FlsSectorList_1/FlsSector_DF3_L03</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
					</xsl:if>

						
						<xsl:call-template name="make_FEE_Config">
							<xsl:with-param name ="BLOCK_NUMBER" select="1"/>
							<xsl:with-param name = "NUMBER_OF_FEE_BLOCK" select="//SRS/MEM/EEPROM/DEVICE/@Block_count"/>
							<xsl:with-param name = "DATA_FLASH_SIZE" select="//SRS/MEM/EEPROM/DEVICE/@Calibration_Flash_Size"/>
							<xsl:with-param name = "FEE_BLOCK_SIZE" select="//SRS/MEM/EEPROM/DEVICE/@Fee_Block_Size"/>
						</xsl:call-template>
						
 
                        <CONTAINER>
                            <SHORT-NAME>FeeGeneral_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeGeneral/FeeDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeGeneral/FeeIndex</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Fee/FeeGeneral/FeeNvmJobEndNotification</DEFINITION-REF>
                                    <VALUE>bscomeep_JobEndNotification</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Fee/FeeGeneral/FeeNvmJobErrorNotification</DEFINITION-REF>
                                    <VALUE>bscomeep_JobErrorNotification</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeGeneral/FeePollingMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeGeneral/FeeVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeGeneral/FeeVirtualPageSize</DEFINITION-REF>
                                    <VALUE>16</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeGeneral/FeeDataBufferSize</DEFINITION-REF>
                                    <VALUE>64</VALUE>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeGeneral/FeeBlockAlwaysAvailable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>21</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Fee/CommonPublishedInformation/VendorApiInfix</DEFINITION-REF>
                                    <VALUE/>
                                </STRING-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>FeePublishedInformation_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeePublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeePublishedInformation/FeeBlockOverhead</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeePublishedInformation/FeeMaximumBlockingTime</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </FLOAT-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeePublishedInformation/FeePageOverhead</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
                <MODULE-CONFIGURATION>
                    <SHORT-NAME>Fls</SHORT-NAME>
                    <DEFINITION-REF DEST="MODULE-DEF">/TS_T2D13M30I5R0/Fls</DEFINITION-REF>
                    <CONTAINERS>
                        <CONTAINER>
                            <SHORT-NAME>FlsConfigSet_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsAcErase</DEFINITION-REF>
                                    <VALUE>Fls_ACEraseStart</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsAcWrite</DEFINITION-REF>
                                    <VALUE>Fls_ACWriteStart</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsAcErasePointer</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsAcWritePointer</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsCallCycle</DEFINITION-REF>
                                    <VALUE>0.0</VALUE>
                                </FLOAT-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsACCallback</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsJobEndNotification</DEFINITION-REF>
                                    <VALUE>bscomeep_Fls_JobEndNotification</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsJobErrorNotification</DEFINITION-REF>
                                    <VALUE>bscomeep_Fls_JobErrorNotification</VALUE>
                                </FUNCTION-NAME-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsMaxReadFastMode</DEFINITION-REF>
                                    <VALUE>1048576</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsMaxReadNormalMode</DEFINITION-REF>
                                    <VALUE>1024</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsMaxWriteFastMode</DEFINITION-REF>
                                    <VALUE>256</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsMaxWriteNormalMode</DEFINITION-REF>
                                    <VALUE>64</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsProtection</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>FlsSectorList_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>FlsSector_DF0_L00</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPhysicalSectorUnlock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPhysicalSector</DEFINITION-REF>
                                    <VALUE>FLS_DATA_ARRAY_0_L00</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsNumberOfSectors</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPageSize</DEFINITION-REF>
                                    <VALUE>8</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorSize</DEFINITION-REF>
                                    <VALUE>16384</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorStartaddress</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
									<ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsProgrammingSize</DEFINITION-REF>
                                    <VALUE>FLS_WRITE_DOUBLE_WORD</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorEraseAsynch</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPageWriteAsynch</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>FlsSector_DF1_L01</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPhysicalSectorUnlock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPhysicalSector</DEFINITION-REF>
                                    <VALUE>FLS_DATA_ARRAY_0_L01</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsNumberOfSectors</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPageSize</DEFINITION-REF>
                                    <VALUE>8</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorSize</DEFINITION-REF>
                                    <VALUE>16384</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorStartaddress</DEFINITION-REF>
                                    <VALUE>16384</VALUE>
                                    </INTEGER-VALUE>
									<ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsProgrammingSize</DEFINITION-REF>
                                    <VALUE>FLS_WRITE_DOUBLE_WORD</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorEraseAsynch</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPageWriteAsynch</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>FlsSector_DF2_L02</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPhysicalSectorUnlock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPhysicalSector</DEFINITION-REF>
                                    <VALUE>FLS_DATA_ARRAY_0_L02</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsNumberOfSectors</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPageSize</DEFINITION-REF>
                                    <VALUE>8</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorSize</DEFINITION-REF>
                                    <VALUE>16384</VALUE>
                                    </INTEGER-VALUE>
									<ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsProgrammingSize</DEFINITION-REF>
                                    <VALUE>FLS_WRITE_DOUBLE_WORD</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorStartaddress</DEFINITION-REF>
                                    <VALUE>32768</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorEraseAsynch</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPageWriteAsynch</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    <CONTAINER>
                                    <SHORT-NAME>FlsSector_DF3_L03</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPhysicalSectorUnlock</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPhysicalSector</DEFINITION-REF>
                                    <VALUE>FLS_DATA_ARRAY_0_L03</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsNumberOfSectors</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPageSize</DEFINITION-REF>
                                    <VALUE>8</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorSize</DEFINITION-REF>
                                    <VALUE>16384</VALUE>
                                    </INTEGER-VALUE>
									<ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsProgrammingSize</DEFINITION-REF>
                                    <VALUE>FLS_WRITE_DOUBLE_WORD</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorStartaddress</DEFINITION-REF>
                                    <VALUE>49152</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsSectorEraseAsynch</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsConfigSet/FlsSectorList/FlsSector/FlsPageWriteAsynch</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>FlsGeneral_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsAcLoadOnJobStart</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsDisableDemReportErrorStatus</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsBaseAddress</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsCancelApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsCompareApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsDevErrorDetect</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsDriverIndex</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsGetJobResultApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsGetStatusApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsSetModeApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsTotalSize</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsUseInterrupts</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsVersionInfoApi</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsDsiHandlerApi</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsEraseBlankCheck</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsWriteBlankCheck</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsWriteVerifyCheck</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsMaxEraseBlankCheck</DEFINITION-REF>
                                    <VALUE>256</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsOperationTimeout</DEFINITION-REF>
                                    <VALUE>2147483647</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsGeneral/FlsAbortTimeout</DEFINITION-REF>
                                    <VALUE>32767</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>CommonPublishedInformation_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fls/CommonPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/CommonPublishedInformation/ArMajorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/CommonPublishedInformation/ArMinorVersion</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/CommonPublishedInformation/ArPatchVersion</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/CommonPublishedInformation/ModuleId</DEFINITION-REF>
                                    <VALUE>92</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/CommonPublishedInformation/SwMajorVersion</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/CommonPublishedInformation/SwMinorVersion</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/CommonPublishedInformation/SwPatchVersion</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                                <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Fls/CommonPublishedInformation/VendorApiInfix</DEFINITION-REF>
                                    <VALUE/>
                                </STRING-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/CommonPublishedInformation/VendorId</DEFINITION-REF>
                                    <VALUE>27</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>FlsPublishedInformation_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fls/FlsPublishedInformation</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsPublishedInformation/FlsAcLocationErase</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsPublishedInformation/FlsAcLocationWrite</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsPublishedInformation/FlsAcSizeErase</DEFINITION-REF>
                                    <VALUE>84</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsPublishedInformation/FlsAcSizeWrite</DEFINITION-REF>
                                    <VALUE>84</VALUE>
                                </INTEGER-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsPublishedInformation/FlsEraseTime</DEFINITION-REF>
                                    <VALUE>5.0</VALUE>
                                </FLOAT-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsPublishedInformation/FlsErasedValue</DEFINITION-REF>
                                    <VALUE>4294967295</VALUE>
                                </INTEGER-VALUE>
                                <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsPublishedInformation/FlsExpectedHwId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </STRING-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsPublishedInformation/FlsSpecifiedEraseCycles</DEFINITION-REF>
                                    <VALUE>100000</VALUE>
                                </INTEGER-VALUE>
                                <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Fls/FlsPublishedInformation/FlsWriteTime</DEFINITION-REF>
                                    <VALUE>0.0005</VALUE>
                                </FLOAT-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                    </CONTAINERS>
                </MODULE-CONFIGURATION>
            </ELEMENTS>
            <SUB-PACKAGES/>
        </AR-PACKAGE>
    </TOP-LEVEL-PACKAGES>
</AUTOSAR>



</xsl:template> 




<xsl:template name= "make_AUTOSAR_OS_setting">
								<CONTAINER>
                            <SHORT-NAME>Alarm_SWP_5ms</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm</DEFINITION-REF>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmCounterRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/SYSTEM_COUNTER</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsAlarmAction</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>OsAlarmActivateTask</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask/OsAlarmActivateTaskRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Task_SWP_FG1_5ms</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
					<xsl:if test = "//CORE/TIMER/@System_time_usage = 'ENABLE' ">
                        <CONTAINER>
                            <SHORT-NAME>Alarm_SWP_SystemTime</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm</DEFINITION-REF>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmCounterRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/SYSTEM_COUNTER</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsAlarmAction</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>OsAlarmCallback_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmCallback</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmCallback/OsAlarmCallbackName</DEFINITION-REF>
                                    <VALUE>Alarm_Callback_SystemTime</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                     </xsl:if>
                        <CONTAINER>
                            <SHORT-NAME>Alarm_SWP_10ms</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm</DEFINITION-REF>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmCounterRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/SYSTEM_COUNTER</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsAlarmAction_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>OsAlarmActivateTask_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask/OsAlarmActivateTaskRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Task_SWP_FG1_10ms</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        
                        <CONTAINER>
                            <SHORT-NAME>Alarm_SWP_20ms</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm</DEFINITION-REF>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmCounterRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/SYSTEM_COUNTER</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsAlarmAction_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>OsAlarmActivateTask_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask/OsAlarmActivateTaskRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Task_SWP_FG1_20ms</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        
                        
                        <CONTAINER>
                            <SHORT-NAME>Alarm_SWP_100ms</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm</DEFINITION-REF>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmCounterRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/SYSTEM_COUNTER</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsAlarmAction_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>OsAlarmActivateTask_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask/OsAlarmActivateTaskRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Task_SWP_FG1_100ms</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        
                        <CONTAINER>
                            <SHORT-NAME>Alarm_SWP_1s</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm</DEFINITION-REF>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmCounterRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/SYSTEM_COUNTER</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsAlarmAction_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>OsAlarmActivateTask_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask/OsAlarmActivateTaskRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Task_SWP_FG1_1s</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        
                        
                        <CONTAINER>
                            <SHORT-NAME>AppMode</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAppMode</DEFINITION-REF>
                            <REFERENCE-VALUES/>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>SYSTEM_COUNTER</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsCounter</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsCounter/OsCounterMaxAllowedValue</DEFINITION-REF>
                                    <VALUE>0xffffffff</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsCounter/OsCounterMinCycle</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsCounter/OsCounterTicksPerBase</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsCounter/OsCounterType</DEFINITION-REF>
                                    <VALUE>SOFTWARE</VALUE>
                                </ENUMERATION-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS/>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>OsOS</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsScalabilityClass</DEFINITION-REF>
                                    <VALUE>SC1</VALUE>
                                </ENUMERATION-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsStackMonitoring</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsStatus</DEFINITION-REF>
                                    <VALUE>EXTENDED</VALUE>
                                </ENUMERATION-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsUseGetServiceId</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsUseParameterAccess</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsUseResScheduler</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsCC</DEFINITION-REF>
                                    <VALUE>ECC1</VALUE>
                                </ENUMERATION-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsTrace</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsExtra_Runtime_Checks</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsStartupChecks</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsServiceTrace</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsSourceOptimization</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                </BOOLEAN-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsStackOptimization</DEFINITION-REF>
                                    <VALUE>GLOBAL</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsProtection</DEFINITION-REF>
                                    <VALUE>OFF</VALUE>
                                </ENUMERATION-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsUseLastError</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsTracebuffer</DEFINITION-REF>
                                    <VALUE>100</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsSchedule</DEFINITION-REF>
                                    <VALUE>MIXED</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsMicrocontroller</DEFINITION-REF>
                                    <VALUE>XPC560XB</VALUE>
                                </ENUMERATION-VALUE>
								<BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsGenerateSWCD</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsPAInterruptVectorMode</DEFINITION-REF>
                                    <VALUE>INTC_HARDWARE</VALUE>
                                </ENUMERATION-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsTrappingKernel</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsHooks</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsHooks</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsHooks/OsErrorHook</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsHooks/OsPostTaskHook</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsHooks/OsPreTaskHook</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsHooks/OsProtectionHook</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsHooks/OsShutdownHook</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsHooks/OsStartupHook</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsHooks/OsPreISRHook</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsHooks/OsPostISRHook</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>OsAutosarCustomization</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsExceptionHandling</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsErrorHandling</DEFINITION-REF>
                                    <VALUE>AUTOSAR</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsStrictServiceProtection</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsCat1DirectCall</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsFastInterruptLocking</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsInterruptLockingChecks</DEFINITION-REF>
                                    <VALUE>AUTOSAR</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsCallIsr</DEFINITION-REF>
                                    <VALUE>DIRECTLY</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsCallAppErrorHook</DEFINITION-REF>
                                    <VALUE>DIRECTLY</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsCallAppStartupShutdownHook</DEFINITION-REF>
                                    <VALUE>DIRECTLY</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsPermitSystemObjects</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsOS/OsAutosarCustomization/OsUserTaskReturn</DEFINITION-REF>
                                    <VALUE>KILL_TASK</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>Resource_SWP_FG1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsResource</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsResource/OsResourceProperty</DEFINITION-REF>
                                    <VALUE>INTERNAL</VALUE>
                                </ENUMERATION-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>Resource_SWP_FG2</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsResource</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsResource/OsResourceProperty</DEFINITION-REF>
                                    <VALUE>INTERNAL</VALUE>
                                </ENUMERATION-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
						
					<xsl:if test ="//SRS/OS/TASKS/*[contains(@Name,'ASW_BG')] or //SRS/OS/TASKS/*[contains(@Name,'SWP_BG')]">
                        <CONTAINER>
                            <SHORT-NAME>Resource_SWP_BG</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsResource</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsResource/OsResourceProperty</DEFINITION-REF>
                                    <VALUE>INTERNAL</VALUE>
                                </ENUMERATION-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
					</xsl:if>
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_Init</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>250</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>NON</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>BASIC</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE>256</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES/>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsTaskAutostart</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskAutostart</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskAutostart/OsTaskAppModeRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/AppMode</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_System_Idle</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>FULL</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE>256</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsTaskAutostart_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskAutostart</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskAutostart/OsTaskAppModeRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/AppMode</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_FG1_5ms</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>199</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>FULL</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskCallScheduler</DEFINITION-REF>
                                    <VALUE>NO</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>BASIC</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/STACK/@FG1_TASK_Stack"/></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskResourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Resource_SWP_FG1</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS/>
                        </CONTAINER>
                        
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_FG1_10ms</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>190</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>FULL</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskCallScheduler</DEFINITION-REF>
                                    <VALUE>NO</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>BASIC</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/STACK/@FG1_TASK_Stack"/></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskResourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Resource_SWP_FG1</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                        </CONTAINER>
                        
                        
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_FG1_20ms</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>170</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>FULL</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskCallScheduler</DEFINITION-REF>
                                    <VALUE>NO</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>BASIC</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/STACK/@FG1_TASK_Stack"/></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskResourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Resource_SWP_FG1</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                        </CONTAINER>
                        
                        
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_FG1_100ms</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>120</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>FULL</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskCallScheduler</DEFINITION-REF>
                                    <VALUE>NO</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>BASIC</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/STACK/@FG1_TASK_Stack"/></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskResourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Resource_SWP_FG1</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                        </CONTAINER>
                        
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_FG1_1s</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>107</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>FULL</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskCallScheduler</DEFINITION-REF>
                                    <VALUE>NO</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>BASIC</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/STACK/@FG1_TASK_Stack"/></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskResourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Resource_SWP_FG1</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                        </CONTAINER>
                        
                        
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_FG1_biomanag</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>195</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>FULL</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskCallScheduler</DEFINITION-REF>
                                    <VALUE>NO</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>BASIC</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/STACK/@FG1_TASK_Stack"/></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskResourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Resource_SWP_FG1</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS/>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_FG2_biomanag</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>230</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>FULL</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskCallScheduler</DEFINITION-REF>
                                    <VALUE>NO</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>BASIC</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/STACK/@FG2_TASK_Stack"/></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskResourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Resource_SWP_FG2</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS/>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_FG2_LPM</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>255</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>FULL</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskCallScheduler</DEFINITION-REF>
                                    <VALUE>NO</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>BASIC</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/STACK/@FG2_TASK_Stack"/></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskResourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Resource_SWP_FG2</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS/>
                        </CONTAINER>
                        <CONTAINER>
                            <SHORT-NAME>Task_SWP_FG1_EventManager</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE>180</VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE>FULL</VALUE>
                                </ENUMERATION-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>EXTENDED</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="//SRS/MCU/STACK/@Event_Notification_Functions_Stack"/></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskEventRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Event_SWP_Notification</VALUE-REF>
                                </REFERENCE-VALUE>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskResourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/Resource_SWP_FG1</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsTaskAutostart_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskAutostart</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskAutostart/OsTaskAppModeRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/AppMode</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
                        
                        <CONTAINER>
                            <SHORT-NAME>Event_SWP_Notification</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsEvent</DEFINITION-REF>
                            <PARAMETER-VALUES/>
                        </CONTAINER>
		
<!--========================================================TASK========================================================-->
		<xsl:call-template name="make_OS_task_Config"/>
<!--========================================================ALARM========================================================-->	
		<xsl:call-template name="make_OS_alarm_Config"/>
<!--========================================================ISR========================================================-->		
		<xsl:call-template name="make_OS_ISR_Config"/>
<!--===================================================================================================================-->		

</xsl:template>	


<xsl:template name= "make_OS_ISR_Config">

<xsl:for-each select ="//SRS/OS/ISR/*">
	<xsl:choose>
		<xsl:when test = "./@category='NA' or ./@category='' ">
			<xsl:message  terminate ="yes">
=========================================================================
		OSEK ISR Error 
		Element = <xsl:value-of select="name(.)"/> 
=========================================================================
		</xsl:message>  
		</xsl:when>
		<xsl:when test = "./@Type ='USED' and ./@category !=''">
						<CONTAINER>
                            <SHORT-NAME>Isr_<xsl:value-of select="name()"/></SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsIsr</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsIsr/OsIsrCategory</DEFINITION-REF>
                                    <VALUE>CATEGORY_<xsl:value-of select="@category"/></VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsIsr/OsStacksize</DEFINITION-REF>
                                    <VALUE>120</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsIsr/OsPAIrqLevel</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@priority"/></VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsIsr/OsPAVector</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@OsPAVector_name"/></VALUE>
                                </ENUMERATION-VALUE>
                            </PARAMETER-VALUES>
                        </CONTAINER>
		</xsl:when>
		<xsl:otherwise>

		</xsl:otherwise>
	</xsl:choose>
</xsl:for-each>
</xsl:template>	

<xsl:template name= "make_OS_task_Config">
	<xsl:for-each select ="//SRS/OS/TASKS/*">
		<xsl:if test ="contains(@Name,'Task_SWP_BG_RAM_ROM_check') or contains(@Name,'ASW')">
				<xsl:message  terminate ="no">'Task Name =<xsl:value-of select="@Name"/>= </xsl:message>  					
						<CONTAINER>
                            <SHORT-NAME><xsl:value-of select="@Name"/></SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskActivation</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskPriority</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@priority"/></VALUE>
                                </INTEGER-VALUE>
                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskSchedule</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="@preemptive='NONE'">NON</xsl:when>
										<xsl:otherwise>FULL</xsl:otherwise>
									</xsl:choose></VALUE>
                                </ENUMERATION-VALUE>
								
								<ENUMERATION-VALUE>
									<DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskCallScheduler</DEFINITION-REF>
									<VALUE>NO</VALUE>
								</ENUMERATION-VALUE>

                                <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskType</DEFINITION-REF>
                                    <VALUE>BASIC</VALUE>
                                </ENUMERATION-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsStacksize</DEFINITION-REF>
                                    <VALUE><xsl:choose>
									<xsl:when test="contains(@Name,'_BG') or contains(@Name,'_bg')"><xsl:value-of select="//SRS/MCU/STACK/@BG_TASK_Stack"/></xsl:when>
									<xsl:when test="contains(@Name,'_FG1') or contains(@Name,'_fg1')"><xsl:value-of select="//SRS/MCU/STACK/@FG1_TASK_Stack"/></xsl:when>
									<xsl:when test="contains(@Name,'_FG2') or contains(@Name,'_fg2')"><xsl:value-of select="//SRS/MCU/STACK/@FG2_TASK_Stack"/></xsl:when>
									<xsl:otherwise>error : resource_name should be included (BG, FG1, FG2)</xsl:otherwise>
									</xsl:choose></VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsTask/OsTaskResourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/<xsl:choose>
									<xsl:when test="contains(@Name,'_BG') or contains(@Name,'_bg')">Resource_SWP_BG</xsl:when>
									<xsl:when test="contains(@Name,'_FG1') or contains(@Name,'_fg1')">Resource_SWP_FG1</xsl:when>
									<xsl:when test="contains(@Name,'_FG2') or contains(@Name,'_fg2')">Resource_SWP_FG2</xsl:when>
									<xsl:otherwise>error : resource_name should be included (BG, FG1, FG2)</xsl:otherwise>
									</xsl:choose></VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS/>
                        </CONTAINER>
		</xsl:if>
	</xsl:for-each>
</xsl:template>	

<xsl:template name= "make_OS_alarm_Config">
			<xsl:for-each select ="//SRS/OS/ALARMS/*">
				<xsl:choose>
					<xsl:when test = "contains(./@Name,'SWP')"></xsl:when>
						<xsl:otherwise>
							<CONTAINER>
                            <SHORT-NAME><xsl:value-of select="@Name"/></SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm</DEFINITION-REF>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmCounterRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/SYSTEM_COUNTER</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
                            <SUB-CONTAINERS>
                                <CONTAINER>
                                    <SHORT-NAME>OsAlarmAction</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction</DEFINITION-REF>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>OsAlarmActivateTask</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask</DEFINITION-REF>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M4I5R0_AS31/Os/OsAlarm/OsAlarmAction/OsAlarmActivateTask/OsAlarmActivateTaskRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Os/<xsl:value-of select="@task"/></VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
</xsl:template>

<xsl:template name= "make_GptChannel_Config">
	<xsl:param name = "fast_timer"/>
	<xsl:param name = "system_timer"/>
	<xsl:param name = "os_timer"/>
			<xsl:for-each select="//TIMER/*/*[./@MCAL_Channel_Numbering !='' and (./@Software_Use = 'CT_FREE_RUN' or ./@Software_Use = 'OC_FREE_RUN' or ./@Software_Use = 'CT_ONE_SHOT')]"> 
							<CONTAINER>
                                <SHORT-NAME>Gpt_Channel<xsl:value-of select="@MCAL_Channel_Numbering"/></SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelId</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="position()-1"/></VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptHwChannel</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@MCAL_GPTHwChannel"/></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelMode</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="@Software_Use='CT_ONE_SHOT'">GPT_MODE_ONESHOT</xsl:when>
										<xsl:otherwise>GPT_MODE_CONTINOUS</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
									<INTEGER-VALUE>
											<DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelClkSrc</DEFINITION-REF>
											<VALUE>0</VALUE>
									</INTEGER-VALUE>
<!-- 
									<xsl:choose>
										<xsl:when test="@MCAL_GPTHwChannel = 'STM_CH_0' and //CORE/TIMER/@System_Base_Timer='TIMER_STM0' ">
											<INTEGER-VALUE>
											<DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelClkSrc</DEFINITION-REF>
											<VALUE>0</VALUE>
											</INTEGER-VALUE>
										</xsl:when>
										<xsl:when test="@MCAL_GPTHwChannel = 'STM_CH_1' and //CORE/TIMER/@System_Base_Timer='TIMER_STM1' ">
											<INTEGER-VALUE>
											<DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelClkSrc</DEFINITION-REF>
											<VALUE>0</VALUE>
											</INTEGER-VALUE>
										</xsl:when>
										<xsl:when test="@MCAL_GPTHwChannel = 'STM_CH_2' and //CORE/TIMER/@System_Base_Timer='TIMER_STM2' ">
											<INTEGER-VALUE>
											<DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelClkSrc</DEFINITION-REF>
											<VALUE>0</VALUE>
											</INTEGER-VALUE>
										</xsl:when>
										<xsl:when test="@MCAL_GPTHwChannel = 'STM_CH_3' and //CORE/TIMER/@System_Base_Timer='TIMER_STM3' ">
											<INTEGER-VALUE>
											<DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelClkSrc</DEFINITION-REF>
											<VALUE>0</VALUE>
											</INTEGER-VALUE>
										</xsl:when>
										<xsl:otherwise>
										</xsl:otherwise>
									</xsl:choose>
-->
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelPrescale</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="@MCAL_GptChannelPrescale=''">1</xsl:when>
										<xsl:otherwise><xsl:value-of select="@MCAL_GptChannelPrescale"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
									<INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptChannelPrescale_Alternate</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="@MCAL_GptChannelPrescale=''">1</xsl:when>
										<xsl:otherwise><xsl:value-of select="@MCAL_GptChannelPrescale"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptFreezeEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptEnableWakeup</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="@Timer_Resource='STIMER_RES_0'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
									</PARAMETER-VALUES>
									<xsl:if test="@Timer_Resource = 'STIMER_RES_0'" >
									<SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>GptWakeupConfiguration_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptWakeupConfiguration</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptWakeupConfiguration/GptDisableEcumWakeupNotification</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Gpt/GptChannelConfigSet/GptChannelConfiguration/GptWakeupConfiguration/GptWakeupSourceRef</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/EcuM/EcuMConfiguration_0/EcuMWakeupSource_PIT0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
									</xsl:if>
                            </CONTAINER>
			</xsl:for-each>
</xsl:template>

<xsl:template name= "make_ICU_Channel_Config">
			<xsl:for-each select="//TIMER/*/*[./@Software_Use = 'IC_FREE_RUN' or ./@Software_Use ='EXTINT-ICU']">
							<CONTAINER>
                                    <SHORT-NAME>Icu_Channel_I<xsl:value-of select="@Channel"/></SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuChannelId</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="position()-1"/></VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuHwChannel</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@MCAL_GPTHwChannel"/></VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEXT_ISR_IFERDigitalFilter</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEXT_ISR_IFMCDigitalFilter</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuWKPU_ISR_WIPUER</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosFreeze</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosPrescaler</DEFINITION-REF>
                                    <VALUE>EMIOS_PRESCALER_DIVIDE_<xsl:value-of select="@MCAL_GptChannelPrescale"/></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosPrescaler_Alternate</DEFINITION-REF>
                                    <VALUE>EMIOS_PRESCALER_DIVIDE_<xsl:value-of select="@MCAL_GptChannelPrescale"/></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosDigitalFilter</DEFINITION-REF>
                                    <VALUE>EMIOS_DIGITAL_FILTER_BYPASSED</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosBusSelect</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@EmiosBusSelect ='BUS_INTERNAL'">EMIOS_BUS_INTERNAL_COUNTER</xsl:when>
										<xsl:when test="./@EmiosBusSelect ='BUS_DIVERSE'">EMIOS_BUS_DIVERSE</xsl:when>
										<xsl:when test="./@EmiosBusSelect ='BUS_A'">EMIOS_BUS_A</xsl:when>
										<xsl:otherwise>
										<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			ICU Channel <xsl:value-of select="@Channel"/> 의 @EmiosBusSelect 값이 유효하지 않음
=======================================================================================================================</xsl:message>  										
										</xsl:otherwise>
									</xsl:choose>
									</VALUE> 
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuDefaultStartEdge</DEFINITION-REF>
                                    <VALUE>ICU_BOTH_EDGES</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuMeasurementMode</DEFINITION-REF>
                                    <VALUE>ICU_MODE_TIMESTAMP</VALUE>
                                    </ENUMERATION-VALUE>
 				    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuUserModeForDutycycle</DEFINITION-REF>
                                    <VALUE>SAIC</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuOverflowNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuWakeupCapability</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
									<BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuSignalMeasureWithoutInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
									<BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuDisableEcumWakeupNotification</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>IcuTimestampMeasurement_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuTimestampMeasurement</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuTimestampMeasurement/IcuTimestampMeasurementProperty</DEFINITION-REF>
                                    <VALUE>ICU_CIRCULAR_BUFFER</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuTimestampMeasurement/IcuTimestampNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
			</xsl:for-each>
			<xsl:for-each select="//EXTERNAL_INTERRUPT_CONFIGURATION/*[./@Usage = 'USED']">
								<CONTAINER>
                                    <SHORT-NAME>Icu_Channel_E<xsl:value-of select="@MCAL_Channel_Numbering"/></SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuChannelId</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//TIMER/*/*[@Software_Use ='IC_FREE_RUN']) + count(//TIMER/*/*[@Software_Use ='EXTINT-ICU']) + position()-1"/></VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuHwChannel</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@MCAL_GPTHwChannel"/></VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEXT_ISR_IFERDigitalFilter</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEXT_ISR_IFMCDigitalFilter</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuWKPU_ISR_WIPUER</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosFreeze</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosPrescaler</DEFINITION-REF>
                                    <VALUE>EMIOS_PRESCALER_DIVIDE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosPrescaler_Alternate</DEFINITION-REF>
                                    <VALUE>EMIOS_PRESCALER_DIVIDE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosDigitalFilter</DEFINITION-REF>
                                    <VALUE>EMIOS_DIGITAL_FILTER_BYPASSED</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosBusSelect</DEFINITION-REF>
                                    <VALUE>EMIOS_BUS_INTERNAL_COUNTER</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuDefaultStartEdge</DEFINITION-REF>
                                    <VALUE>ICU_BOTH_EDGES</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuMeasurementMode</DEFINITION-REF>
                                    <VALUE>ICU_MODE_SIGNAL_EDGE_DETECT</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuOverflowNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuWakeupCapability</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
									<BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuDisableEcumWakeupNotification</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
									<SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>IcuSignalEdgeDetection_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuSignalEdgeDetection</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuSignalEdgeDetection/IcuSignalNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
			</xsl:for-each>
			<xsl:if test = "count(//TIMER/*/*[@Software_Use ='IC_FREE_RUN']) + count(//TIMER/*/*[@Software_Use ='EXTINT-ICU']) +count(//EXTERNAL_INTERRUPT_CONFIGURATION/*[@Usage ='USED'])='0'">
								<CONTAINER>
                                    <SHORT-NAME>IcuChannel_1_DUMMY</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuChannelId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuHwChannel</DEFINITION-REF>
                                    <VALUE>EMIOS_0_CH_0</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEXT_ISR_IFERDigitalFilter</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEXT_ISR_IFMCDigitalFilter</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuWKPU_ISR_WIPUER</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosFreeze</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosPrescaler</DEFINITION-REF>
                                    <VALUE>EMIOS_PRESCALER_DIVIDE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosPrescaler_Alternate</DEFINITION-REF>
                                    <VALUE>EMIOS_PRESCALER_DIVIDE_1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosDigitalFilter</DEFINITION-REF>
                                    <VALUE>EMIOS_DIGITAL_FILTER_BYPASSED</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuEmiosBusSelect</DEFINITION-REF>
                                    <VALUE>EMIOS_BUS_INTERNAL_COUNTER</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuDefaultStartEdge</DEFINITION-REF>
                                    <VALUE>ICU_RISING_EDGE</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuMeasurementMode</DEFINITION-REF>
                                    <VALUE>ICU_MODE_TIMESTAMP</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuDMAEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuUserModeForDutycycle</DEFINITION-REF>
                                    <VALUE>SAIC</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuOverflowNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuWakeupCapability</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuSignalMeasureWithoutInterrupt</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuDisableEcumWakeupNotification</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>IcuTimestampMeasurement_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuTimestampMeasurement</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuTimestampMeasurement/IcuTimestampMeasurementProperty</DEFINITION-REF>
                                    <VALUE>ICU_CIRCULAR_BUFFER</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Icu/IcuConfigSet/IcuChannel/IcuTimestampMeasurement/IcuTimestampNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
			</xsl:if>
			
			
			
</xsl:template>


<xsl:template name= "make_PWM_Channel_Config">
			<xsl:for-each select="//PWM/*[./@Used_PWMType != 'UNUSED']">
							<CONTAINER>
                                    <SHORT-NAME>PwmChannel_<xsl:value-of select="@Channel"/></SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmChannelClass</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@Used_PWMType ='PWM_VAR'">PWM_VARIABLE_PERIOD</xsl:when>
										<xsl:when test="./@Used_PWMType ='PWM_FIX'">PWM_FIXED_PERIOD</xsl:when>
										<xsl:otherwise><xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//PWM 설정중 @Used_PWMType  값이 입력되지 않음
=======================================================================================================================</xsl:message>
										</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmChannelId</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="position()-1"/></VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmHwChannel</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@MCAL_GPTHwChannel"/></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPolarity</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@Polarity ='HighActive'">PWM_HIGH</xsl:when>
										<xsl:when test="./@Polarity ='LowActive'">PWM_LOW</xsl:when>
										<xsl:otherwise><xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//PWM 설정중 @Polarity  값이 입력되지 않음
=======================================================================================================================</xsl:message></xsl:otherwise>
									</xsl:choose>
									</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPeriodDefaultUnits</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@MCAL_Channel_Numbering !='' ">Period_in_ticks</xsl:when>
										<xsl:otherwise>Period_in_ticks</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPeriodDefault</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@DefaultPeriod"/></VALUE>
                                    </FLOAT-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmDutycycleDefault</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="floor(@DefaultPeriod div 2)"/></VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmIdleState</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@Polarity ='HighActive'">PWM_LOW</xsl:when>
										<xsl:when test="./@Polarity ='LowActive'">PWM_HIGH</xsl:when>
										<xsl:otherwise><xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//PWM 설정중 @Polarity  값이 입력되지 않음
=======================================================================================================================</xsl:message></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmNotification</DEFINITION-REF>
                                    <VALUE>NULL</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmModeSelect</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@Counter_Bus ='BUS_INTERNAL'">PWM_MODE_OPWFMB</xsl:when>
										<xsl:when test="./@Counter_Bus ='BUS_DIVERSE'">PWM_MODE_OPWMB</xsl:when>
										<xsl:when test="./@Counter_Bus ='BUS_A'">PWM_MODE_OPWMB</xsl:when>
										<xsl:otherwise>
										<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			PWM channel <xsl:value-of select="@Channel"/> 의 @Counter_Bus 값이 유효하지 않음
=======================================================================================================================</xsl:message>  										
										</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/EmiosUnifiedChannelBusSelect</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@Counter_Bus ='BUS_INTERNAL'">PWM_BUS_INTERNAL_COUNTER</xsl:when>
										<xsl:when test="./@Counter_Bus ='BUS_DIVERSE'">PWM_BUS_DIVERSE</xsl:when>
										<xsl:when test="./@Counter_Bus ='BUS_A'">PWM_BUS_A</xsl:when>
										<xsl:otherwise>
										<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			PWM channel <xsl:value-of select="@Channel"/> 의 @Counter_Bus 값이 유효하지 않음
=======================================================================================================================</xsl:message>  										
										</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPrescaler</DEFINITION-REF>
                                    <VALUE>PwmPrescalerDiv<xsl:value-of select="@MCAL_GptChannelPrescale"/></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPrescaler_Alternate</DEFINITION-REF>
                                    <VALUE>PwmPrescalerDiv<xsl:value-of select="@MCAL_GptChannelPrescale"/></VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmOffset</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmTriggerDelay</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
									<INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/Pwm_Deadtime</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/OffsetDelayAdjust</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmFreezeEnable</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
			</xsl:for-each>
			<xsl:if test = "count(//PWM/*[./@Used_PWMType != 'UNUSED'])='0'">
								<CONTAINER>
                                    <SHORT-NAME>DUMMY_PwmChannel_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmChannelClass</DEFINITION-REF>
                                    <VALUE>PWM_VARIABLE_PERIOD</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmChannelId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmHwChannel</DEFINITION-REF>
                                    <VALUE>EMIOS_0_CH_0</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPolarity</DEFINITION-REF>
                                    <VALUE>PWM_HIGH</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPeriodDefaultUnits</DEFINITION-REF>
                                    <VALUE>Period_in_seconds</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPeriodDefault</DEFINITION-REF>
                                    <VALUE>0.0005</VALUE>
                                    </FLOAT-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmDutycycleDefault</DEFINITION-REF>
                                    <VALUE>16384</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmIdleState</DEFINITION-REF>
                                    <VALUE>PWM_LOW</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmNotification</DEFINITION-REF>
                                    <VALUE>NULL</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmModeSelect</DEFINITION-REF>
                                    <VALUE>PWM_MODE_OPWFMB</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/EmiosUnifiedChannelBusSelect</DEFINITION-REF>
                                    <VALUE>PWM_BUS_INTERNAL_COUNTER</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPrescaler</DEFINITION-REF>
                                    <VALUE>PwmPrescalerDiv1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmPrescaler_Alternate</DEFINITION-REF>
                                    <VALUE>PwmPrescalerDiv1</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmOffset</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmTriggerDelay</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/Pwm_Deadtime</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/OffsetDelayAdjust</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Pwm/PwmChannelConfigSet/PwmChannel/PwmFreezeEnable</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
			</xsl:if>
</xsl:template>


<xsl:template name= "make_ADC_Channel_Config">
		<xsl:param name = "ADC_HW_CHANNEL_NUMBER"/>
		<xsl:param name = "ADC_T_clk"/>
		<xsl:param name = "ADC_INPSAMP"/>
		<xsl:param name = "ADC_INPCMP"/>
		<xsl:param name = "ADC_INPLATCH"/>
		<xsl:param name = "ADC_T_conv"/>
						<CONTAINER>
							<SHORT-NAME>AdcHwUnit_<xsl:value-of select="$ADC_HW_CHANNEL_NUMBER"/></SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit</DEFINITION-REF>
                            <PARAMETER-VALUES>
                            <INTEGER-VALUE>
                                <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcHwUnitId</DEFINITION-REF>
                                <VALUE><xsl:value-of select="$ADC_HW_CHANNEL_NUMBER"/></VALUE>
                                </INTEGER-VALUE>
								<INTEGER-VALUE>
                                <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcPrescale</DEFINITION-REF>
                                <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcPowerDownDelay</DEFINITION-REF>
                                <VALUE>15</VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcMuxDelay</DEFINITION-REF>
                                <VALUE>15</VALUE>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcAutoClockOff</DEFINITION-REF>
                                <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <BOOLEAN-VALUE>
                                <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcBypassSampling</DEFINITION-REF>
                                <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <ENUMERATION-VALUE>
                                <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcPresamplingEnableSignal</DEFINITION-REF>
                                <VALUE>ADC_PRESAMP_VOLTAGE_0</VALUE>
                                </ENUMERATION-VALUE>
                                </PARAMETER-VALUES>
                                    
							<SUB-CONTAINERS>

			<xsl:for-each select="//ADC/*[./@ADC_Group = $ADC_HW_CHANNEL_NUMBER and ./@Usage = 'USED' ]">
								<CONTAINER>
                                    <SHORT-NAME>AdcChannel_<xsl:value-of select="@ADC_Channel_number"/></SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel/AdcChannelId</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="position()-1"/></VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel/AdcHwChannel</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@MCAL_Adc_Hw_Channel"/></VALUE>
                                    </ENUMERATION-VALUE>
									<INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel/AdcChannelResolution</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@ADC_Group ='0'">10</xsl:when>
										<xsl:when test="./@ADC_Group ='1'">12</xsl:when>
										<xsl:otherwise>Error</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel/AdcEnablePresampling</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>AdcThresholdControl_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel/AdcThresholdControl</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>

                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel/AdcThresholdControl/AdcEnableThresholds</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel/AdcThresholdControl/AdcThresholdControlRegister</DEFINITION-REF>
                                    <VALUE>ADC_THRESHOLD_REG_0</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel/AdcThresholdControl/AdcHighThreshold</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@ADC_Group ='0'">1023</xsl:when>
										<xsl:when test="./@ADC_Group ='1'">4095</xsl:when>
										<xsl:otherwise>Error</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel/AdcThresholdControl/AdcLowThreshold</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcChannel/AdcThresholdControl/AdcWdogNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                 </CONTAINER>
			</xsl:for-each>
			
								<CONTAINER>
                                    <SHORT-NAME>Adc<xsl:value-of select="$ADC_HW_CHANNEL_NUMBER"/>_AllChannelGroup</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupAccessMode</DEFINITION-REF>
                                    <VALUE>ADC_ACCESS_MODE_SINGLE</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionMode</DEFINITION-REF>
                                    <VALUE>ADC_CONV_MODE_ONESHOT</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionType</DEFINITION-REF>
                                    <VALUE>ADC_CONV_TYPE_NORMAL</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupPriority</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupReplacement</DEFINITION-REF>
                                    <VALUE>ADC_GROUP_REPL_ABORT_RESTART</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupTriggSrc</DEFINITION-REF>
                                    <VALUE>ADC_TRIGG_SRC_SW</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcHwTrigSignal</DEFINITION-REF>
                                    <VALUE>ADC_HW_TRIG_RISING_EDGE</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcNotification</DEFINITION-REF>
                                    <VALUE>bianadir_Adc<xsl:value-of select="$ADC_HW_CHANNEL_NUMBER"/>AllGrpNf</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcStreamingBufferMode</DEFINITION-REF>
                                    <VALUE>ADC_STREAM_BUFFER_LINEAR</VALUE>
                                    </ENUMERATION-VALUE>
                                    <LINKER-SYMBOL-VALUE>
                                    <DEFINITION-REF DEST="LINKER-SYMBOL-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcResultBufferPointer</DEFINITION-REF>
                                    <VALUE>Adc<xsl:value-of select="$ADC_HW_CHANNEL_NUMBER"/>ResultBufferForAllChannel</VALUE>
                                    </LINKER-SYMBOL-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcStreamingNumSamples</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
									<BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcEnableChDisableChGroup</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcWithoutInterrupts</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcMultipleHardwareTriggerGroup</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                            <xsl:for-each select="//ADC/*[./@ADC_Group = $ADC_HW_CHANNEL_NUMBER and ./@Usage = 'USED' ]">
									<REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupDefinition</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Adc/AdcConfigSet/AdcHwUnit_<xsl:value-of select="$ADC_HW_CHANNEL_NUMBER"/>/AdcChannel_<xsl:value-of select="@ADC_Channel_number"/></VALUE-REF>
                                    </REFERENCE-VALUE>
							</xsl:for-each>
                                    </REFERENCE-VALUES>
                                    <SUB-CONTAINERS>
									<CONTAINER>
                                    <SHORT-NAME>AdcGroupConversionConfiguration_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionConfiguration</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionConfiguration/AdcLatchingDuration</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="$ADC_INPLATCH ='1'">ADC_ONE_CLOCK_CYCLE</xsl:when>
										<xsl:when test="$ADC_INPLATCH ='0.5'">ADC_HALF_CLOCK_CYCLE</xsl:when>
										<xsl:otherwise>Error</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionConfiguration/AdcComparisonDuration</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="$ADC_INPCMP ='1'">ADC_ONE_LATCH_CYCLE</xsl:when>
										<xsl:when test="$ADC_INPCMP ='2'">ADC_TWO_LATCH_CYCLE</xsl:when>
										<xsl:when test="$ADC_INPCMP ='3'">ADC_THREE_LATCH_CYCLE</xsl:when>
										<xsl:when test="$ADC_INPCMP ='4'">ADC_FOUR_LATCH_CYCLE</xsl:when>
										<xsl:otherwise>Error</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionConfiguration/AdcSamplingDuration</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="$ADC_INPSAMP =''">error : value is blank</xsl:when>
										<xsl:otherwise><xsl:value-of select="$ADC_INPSAMP"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>

			<xsl:for-each select="//ADC/*[./@ADC_Group = $ADC_HW_CHANNEL_NUMBER and ./@Usage = 'USED' ]">
								<CONTAINER>
                                    <SHORT-NAME>AdcGroup_<xsl:value-of select="@ADC_Channel_number"/></SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupAccessMode</DEFINITION-REF>
                                    <VALUE>ADC_ACCESS_MODE_SINGLE</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionMode</DEFINITION-REF>
                                    <VALUE>ADC_CONV_MODE_ONESHOT</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionType</DEFINITION-REF>
                                    <VALUE>ADC_CONV_TYPE_NORMAL</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupId</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="position()"/></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupPriority</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupReplacement</DEFINITION-REF>
                                    <VALUE>ADC_GROUP_REPL_ABORT_RESTART</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupTriggSrc</DEFINITION-REF>
                                    <VALUE>ADC_TRIGG_SRC_SW</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcHwTrigSignal</DEFINITION-REF>
                                    <VALUE>ADC_HW_TRIG_RISING_EDGE</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcStreamingBufferMode</DEFINITION-REF>
                                    <VALUE>ADC_STREAM_BUFFER_LINEAR</VALUE>
                                    </ENUMERATION-VALUE>
                                    <LINKER-SYMBOL-VALUE>
                                    <DEFINITION-REF DEST="LINKER-SYMBOL-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcResultBufferPointer</DEFINITION-REF>
                                    <VALUE>Adc0ResultBufferForOneChannel</VALUE>
                                    </LINKER-SYMBOL-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcStreamingNumSamples</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
									<BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcEnableChDisableChGroup</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcWithoutInterrupts</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcMultipleHardwareTriggerGroup</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupDefinition</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Adc/AdcConfigSet/AdcHwUnit_<xsl:value-of select="$ADC_HW_CHANNEL_NUMBER"/>/AdcChannel_<xsl:value-of select="@ADC_Channel_number"/></VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                    <SUB-CONTAINERS>
                                    <CONTAINER>
                                    <SHORT-NAME>AdcGroupConversionConfiguration_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionConfiguration</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionConfiguration/AdcLatchingDuration</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="$ADC_INPLATCH ='1'">ADC_ONE_CLOCK_CYCLE</xsl:when>
										<xsl:when test="$ADC_INPLATCH ='0.5'">ADC_HALF_CLOCK_CYCLE</xsl:when>
										<xsl:otherwise>Error</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>

                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionConfiguration/AdcComparisonDuration</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="$ADC_INPCMP ='1'">ADC_ONE_LATCH_CYCLE</xsl:when>
										<xsl:when test="$ADC_INPCMP ='2'">ADC_TWO_LATCH_CYCLE</xsl:when>
										<xsl:when test="$ADC_INPCMP ='3'">ADC_THREE_LATCH_CYCLE</xsl:when>
										<xsl:when test="$ADC_INPCMP ='4'">ADC_FOUR_LATCH_CYCLE</xsl:when>
										<xsl:otherwise>Error</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>

                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Adc/AdcConfigSet/AdcHwUnit/AdcGroup/AdcGroupConversionConfiguration/AdcSamplingDuration</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="$ADC_INPSAMP =''">error : value is blank</xsl:when>
										<xsl:otherwise><xsl:value-of select="$ADC_INPSAMP"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
                                    </SUB-CONTAINERS>
                                </CONTAINER>
				</xsl:for-each>
							</SUB-CONTAINERS>
                        </CONTAINER>
</xsl:template>

<xsl:template name= "make_port_Config">  <!-- Port를 그룹 단위로 생성-->
<xsl:param name = "port_group"/>
	<xsl:for-each select="//PORT">
		<xsl:sort select="./@AIS_MCAL_Port_ID" data-type="number" order = "ascending"  case-order ="upper-first"/>			
		<xsl:if test="contains(./@AIS_Port_group, $port_group)">  
			<xsl:message  terminate ="no">'<xsl:value-of select="name(.)"/> Port Numbering = <xsl:value-of select="./@AIS_MCAL_Port_ID"/> PCR NUMBER = <xsl:value-of select="./@AIS_MCAL_PCR_Numbering"/> </xsl:message>  
					                <CONTAINER>
                                    <SHORT-NAME><xsl:value-of select="./@Port_PinName"/></SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinWpe</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_MCAL_PORT_Pull_Up_Down='USED' or ./@AIS_MCAL_PORT_Pull_Up_Down='PULL_UP' or  ./@AIS_MCAL_PORT_Pull_Up_Down='PULL_DOWN'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinWps</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_MCAL_PORT_Pull_Up_Down='PULL_UP'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinOde</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_MCAL_PORT_ODE='ENABLE'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinSafeMode</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_MCAL_PORT_Safe_Mode_Control='ENABLE'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinDirectionChangeable</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_Port_direction_changeable='true'">true</xsl:when>
										<xsl:otherwise>false</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinReadback</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinId</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_MCAL_Port_ID=''">error</xsl:when>
										<xsl:otherwise><xsl:value-of select="./@AIS_MCAL_Port_ID"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinPcr</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_MCAL_PCR_Numbering=''">error</xsl:when>
										<xsl:otherwise><xsl:value-of select="./@AIS_MCAL_PCR_Numbering"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinMode</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_Port_pin_mode_for_Mcal=''">Error</xsl:when>
										<xsl:otherwise><xsl:value-of select="./@AIS_Port_pin_mode_for_Mcal"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinInitialMode</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_Port_init_mode_for_Mcal=''">Error</xsl:when>
										<xsl:otherwise><xsl:value-of select="./@AIS_Port_init_mode_for_Mcal"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinDirection</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_direction='Input'">PortPinDirectionIn</xsl:when>
										<xsl:otherwise>PortPinDirectionOut</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinLevelValue</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_InitValue='High'">PortPinLevelHigh</xsl:when>
										<xsl:otherwise>PortPinLevelLow</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
									<ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortPin/PortPinSlewRate</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="./@AIS_MCAL_PORT_Slew_Rate_Control='FASTEST'">FastestConfiguration</xsl:when>
										<xsl:otherwise>SlowestConfiguration</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                    </CONTAINER>
		</xsl:if>
</xsl:for-each>
</xsl:template>


<xsl:template name= "make_dio_Config">  <!-- Port를 그룹 단위로 생성-->
<xsl:param name = "port_group"/>
	<xsl:for-each select="//PORT">
		<xsl:sort select="./@AIS_MCAL_Port_ID" data-type="number" order = "ascending"  case-order ="upper-first"/>			
		<xsl:if test="contains(./@AIS_Port_group, $port_group)"> 
                                <CONTAINER>
                                    <SHORT-NAME><xsl:value-of select="@Dio_PinName"/></SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioChannel</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioChannel/DioChannelId</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@PinBitCarrier"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
		</xsl:if>
</xsl:for-each>
</xsl:template>

<xsl:template name= "make_dio_Config_package_select">  <!-- DIO 를 그룹 단위로 생성-->
	<xsl:param name = "package"/>
						<CONTAINER>
                            <SHORT-NAME>DioPort_0</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioPortId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
								<xsl:call-template name="make_dio_Config">
									<xsl:with-param name = "port_group" select="'PA'"/>
								</xsl:call-template>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						<CONTAINER>
                            <SHORT-NAME>DioPort_1</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioPortId</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
								<xsl:call-template name="make_dio_Config">
									<xsl:with-param name = "port_group" select="'PB'"/>
								</xsl:call-template>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						<xsl:if test ="//PORT[@AIS_Port_group='PC']">	
						<CONTAINER>
                            <SHORT-NAME>DioPort_2</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioPortId</DEFINITION-REF>
                                    <VALUE>2</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
								<xsl:call-template name="make_dio_Config">
									<xsl:with-param name = "port_group" select="'PC'"/>
								</xsl:call-template>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PD']">	
						<CONTAINER>
                            <SHORT-NAME>DioPort_3</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioPortId</DEFINITION-REF>
                                    <VALUE>3</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
								<xsl:call-template name="make_dio_Config">
									<xsl:with-param name = "port_group" select="'PD'"/>
								</xsl:call-template>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PE']">	
						<CONTAINER>
                            <SHORT-NAME>DioPort_4</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioPortId</DEFINITION-REF>
                                    <VALUE>4</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
								<xsl:call-template name="make_dio_Config">
									<xsl:with-param name = "port_group" select="'PE'"/>
								</xsl:call-template>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						</xsl:if>
						
						
						<xsl:if test ="//PORT[@AIS_Port_group='PF']">	
						<CONTAINER>
                            <SHORT-NAME>DioPort_5</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioPortId</DEFINITION-REF>
                                    <VALUE>5</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
								<xsl:call-template name="make_dio_Config">
									<xsl:with-param name = "port_group" select="'PF'"/>
								</xsl:call-template>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PG']">	
						<CONTAINER>
                            <SHORT-NAME>DioPort_6</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioPortId</DEFINITION-REF>
                                    <VALUE>6</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
								<xsl:call-template name="make_dio_Config">
									<xsl:with-param name = "port_group" select="'PG'"/>
								</xsl:call-template>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PH']">	
						<CONTAINER>
                            <SHORT-NAME>DioPort_7</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioPortId</DEFINITION-REF>
                                    <VALUE>7</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
								<xsl:call-template name="make_dio_Config">
									<xsl:with-param name = "port_group" select="'PH'"/>
								</xsl:call-template>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PI']">	
						<CONTAINER>
                            <SHORT-NAME>DioPort_8</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioPortId</DEFINITION-REF>
                                    <VALUE>8</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
								<xsl:call-template name="make_dio_Config">
									<xsl:with-param name = "port_group" select="'PI'"/>
								</xsl:call-template>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PJ']">	
						<CONTAINER>
                            <SHORT-NAME>DioPort_9</SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Dio/DioPort</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Dio/DioPort/DioPortId</DEFINITION-REF>
                                    <VALUE>9</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <SUB-CONTAINERS>
								<xsl:call-template name="make_dio_Config">
									<xsl:with-param name = "port_group" select="'PJ'"/>
								</xsl:call-template>
                            </SUB-CONTAINERS>
                        </CONTAINER>
						</xsl:if>
</xsl:template>



	
<xsl:template name= "make_port_Config_package_select">  <!-- Port를 그룹 단위로 생성-->
	<xsl:param name = "package"/>
							<CONTAINER>
                                    <SHORT-NAME>UnUsedPortPin_1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/UnUsedPortPin</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/UnUsedPortPin/PortPinInitialMode</DEFINITION-REF>
                                    <VALUE>PORT_GPIO_MODE</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/UnUsedPortPin/PortPinWpe</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/UnUsedPortPin/PortPinReadback</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/UnUsedPortPin/PortPinSafeMode</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/UnUsedPortPin/PortPinWps</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/UnUsedPortPin/PortPinDirection</DEFINITION-REF>
                                    <VALUE>PortPinDisableDirection</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/UnUsedPortPin/PortPinLevelValue</DEFINITION-REF>
                                    <VALUE>PortPinLevelLow</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                            </CONTAINER>
							<CONTAINER>
                                    <SHORT-NAME>PortGroup0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortNumberOfPortPins</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//PORT[@AIS_Port_group ='PA'])"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
							
							<xsl:call-template name="make_port_Config">
								<xsl:with-param name = "port_group" select="'PA'"/>
							</xsl:call-template>
									</SUB-CONTAINERS>
                            </CONTAINER>
						
							<CONTAINER>
									<SHORT-NAME>PortGroup1</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortNumberOfPortPins</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//PORT[@AIS_Port_group ='PB'])"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
							<xsl:call-template name="make_port_Config">
								<xsl:with-param name = "port_group" select="'PB'"/>
							</xsl:call-template>
									</SUB-CONTAINERS>
                            </CONTAINER>
							
						<xsl:if test ="//PORT[@AIS_Port_group='PC']">	
							<CONTAINER>
                                    <SHORT-NAME>PortGroup2</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortNumberOfPortPins</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//PORT[@AIS_Port_group ='PC'])"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
							<xsl:call-template name="make_port_Config">
								<xsl:with-param name = "port_group" select="'PC'"/>
							</xsl:call-template>
									</SUB-CONTAINERS>
                            </CONTAINER>						
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PD']">	
							<CONTAINER>
                                    <SHORT-NAME>PortGroup3</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortNumberOfPortPins</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//PORT[@AIS_Port_group ='PD'])"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
							<xsl:call-template name="make_port_Config">
								<xsl:with-param name = "port_group" select="'PD'"/>
							</xsl:call-template>
									</SUB-CONTAINERS>
                            </CONTAINER>							
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PE']">	
							<CONTAINER>
                                    <SHORT-NAME>PortGroup4</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortNumberOfPortPins</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//PORT[@AIS_Port_group ='PE'])"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
							<xsl:call-template name="make_port_Config">
								<xsl:with-param name = "port_group" select="'PE'"/>
							</xsl:call-template>
									</SUB-CONTAINERS>
                            </CONTAINER>							
						</xsl:if>
						
						<xsl:if test ="//PORT[@AIS_Port_group='PF']">	
							<CONTAINER>
                                    <SHORT-NAME>PortGroup5</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortNumberOfPortPins</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//PORT[@AIS_Port_group ='PF'])"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
						
							<xsl:call-template name="make_port_Config">
								<xsl:with-param name = "port_group" select="'PF'"/>
							</xsl:call-template>
									</SUB-CONTAINERS>
                            </CONTAINER>			
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PG']">	
							<CONTAINER>
                                    <SHORT-NAME>PortGroup6</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortNumberOfPortPins</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//PORT[@AIS_Port_group ='PG'])"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
							<xsl:call-template name="make_port_Config">
								<xsl:with-param name = "port_group" select="'PG'"/>
							</xsl:call-template>
									</SUB-CONTAINERS>
                            </CONTAINER>			
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PH']">	
							<CONTAINER>
                                    <SHORT-NAME>PortGroup7</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortNumberOfPortPins</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//PORT[@AIS_Port_group ='PH'])"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
							<xsl:call-template name="make_port_Config">
								<xsl:with-param name = "port_group" select="'PH'"/>
							</xsl:call-template>
									</SUB-CONTAINERS>
                            </CONTAINER>			
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PI']">	
							<CONTAINER>
                                    <SHORT-NAME>PortGroup8</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortNumberOfPortPins</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//PORT[@AIS_Port_group ='PI'])"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
							<xsl:call-template name="make_port_Config">
								<xsl:with-param name = "port_group" select="'PI'"/>
							</xsl:call-template>
									</SUB-CONTAINERS>
                            </CONTAINER>			
						</xsl:if>
						<xsl:if test ="//PORT[@AIS_Port_group='PJ']">	
							<CONTAINER>
                                    <SHORT-NAME>PortGroup9</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Port/PortConfigSet/PortContainer/PortNumberOfPortPins</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="count(//PORT[@AIS_Port_group ='PJ'])"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <SUB-CONTAINERS>
							<xsl:call-template name="make_port_Config">
								<xsl:with-param name = "port_group" select="'PJ'"/>
							</xsl:call-template>
									</SUB-CONTAINERS>
                            </CONTAINER>			
						</xsl:if>
</xsl:template>



<xsl:template name= "make_SPI_Channel_Config">
	<xsl:param name = "SPI_Channel_name_variable"/>

			<xsl:for-each select="$SPI_Channel_name_variable">
							<CONTAINER>
                                    <SHORT-NAME><xsl:value-of select="@SPI_Channel_name"/>_EB_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiChannelId</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@SPI_Mcal_index"/></VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiChannelType</DEFINITION-REF>
                                    <VALUE>EB</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiDataWidth</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="@Data_Width =''">8</xsl:when>
										<xsl:otherwise><xsl:value-of select="@Data_Width"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiDefaultData</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiEbMaxLength</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="@Max_Buffer =''">32</xsl:when>
										<xsl:otherwise><xsl:value-of select="@Max_Buffer"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiIbNBuffers</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiTransferStart</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="@Bit_Order =''">
											<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			SPI의 @Bit_Order  값이 입력되지 않음
=======================================================================================================================</xsl:message>  										
										</xsl:when>
										<xsl:otherwise><xsl:value-of select="@Bit_Order"/></xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                            </CONTAINER>
			</xsl:for-each>
			<xsl:for-each select="//SPI_CHANNEL_SETTING">
								<CONTAINER>
                                    <SHORT-NAME><xsl:value-of select="@SPI_Job_name"/>_ExternalDevice_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiBaudrate</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@BaudRate"/>000</VALUE>
                                    </FLOAT-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiCsIdentifier</DEFINITION-REF>
                                    <VALUE>PCS<xsl:value-of select="@SPI_Mcal_Job_index"/></VALUE>
                                    </STRING-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiCsPolarity</DEFINITION-REF>
                                    <VALUE>HIGH</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiDataShiftEdge</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="@Phase ='Leading'">LEADING</xsl:when>
										<xsl:when test="@Phase ='Trailing'">TRAILING</xsl:when>
										<xsl:otherwise>
											<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			SPI의 @Phase  값이 입력되지 않음
=======================================================================================================================</xsl:message>
										</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiEnableCs</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiShiftClockIdleLevel</DEFINITION-REF>
                                    <VALUE><xsl:choose>
										<xsl:when test="@Polarity ='High'">HIGH</xsl:when>
										<xsl:when test="@Polarity ='Low'">LOW</xsl:when>
										<xsl:otherwise>
										<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			SPI의 @Polarity  값이 입력되지 않음
=======================================================================================================================</xsl:message>
										</xsl:otherwise>
									</xsl:choose></VALUE>
                                    </ENUMERATION-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiTimeClk2Cs</DEFINITION-REF>
                                    <VALUE>1.0</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiTimeCs2Clk</DEFINITION-REF>
                                    <VALUE>1.0</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiTimeCs2Cs</DEFINITION-REF>
                                    <VALUE>6.4</VALUE>
                                    </FLOAT-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiCsContinous</DEFINITION-REF>
                                    <VALUE>True</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
			</xsl:for-each>
			<xsl:for-each select="//SPI_CHANNEL_SETTING">
								<CONTAINER>
                                    <SHORT-NAME><xsl:value-of select="@SPI_Job_name"/>_Job_EB_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/SpiHwUnit</DEFINITION-REF>
                                    <VALUE>CSIB<xsl:value-of select="@HW_channel"/></VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/SpiJobEndNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/SpiJobStartNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/SpiJobId</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@SPI_Mcal_Job_index"/></VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/SpiJobPriority</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@SPI_Mcal_Job_index mod 4"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/ChannelAssignment</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Spi/SpiDriver_1/<xsl:value-of select="@SPI_Channel_name"/>_EB_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/DeviceAssignment</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Spi/SpiDriver_1/<xsl:value-of select="@SPI_Job_name"/>_ExternalDevice_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                </CONTAINER>
			</xsl:for-each>
			<xsl:for-each select="//SPI_CHANNEL_SETTING">
								<CONTAINER>
                                    <SHORT-NAME><xsl:value-of select="@SPI_Job_name"/>_Sequence_EB_0</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiSequence</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiSequence/SpiInterruptibleSequence</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiSequence/SpiSeqEndNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiSequence/SpiSequenceId</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="@SPI_Mcal_Job_index"/></VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiSequence/JobAssignment</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Spi/SpiDriver_1/<xsl:value-of select="@SPI_Job_name"/>_Job_EB_0</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                </CONTAINER>
			</xsl:for-each>
			
			<xsl:if test = "count(//SPI_CHANNEL_SETTING)='0'">
								<CONTAINER>
                                    <SHORT-NAME>DUMMY_SpiChannel_1_EB</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiChannelId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiChannelType</DEFINITION-REF>
                                    <VALUE>IB</VALUE>
                                    </ENUMERATION-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiDataWidth</DEFINITION-REF>
                                    <VALUE>8</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiDefaultData</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiEbMaxLength</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiIbNBuffers</DEFINITION-REF>
                                    <VALUE>1</VALUE>
                                    </INTEGER-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiChannel/SpiTransferStart</DEFINITION-REF>
                                    <VALUE>MSB</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>DUMMY_SpiExternalDevice_1_EB</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiBaudrate</DEFINITION-REF>
                                    <VALUE>100000</VALUE>
                                    </FLOAT-VALUE>
                                    <STRING-VALUE>
                                    <DEFINITION-REF DEST="STRING-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiCsIdentifier</DEFINITION-REF>
                                    <VALUE>PCS0</VALUE>
                                    </STRING-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiCsPolarity</DEFINITION-REF>
                                    <VALUE>HIGH</VALUE>
                                    </ENUMERATION-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiDataShiftEdge</DEFINITION-REF>
                                    <VALUE>LEADING</VALUE>
                                    </ENUMERATION-VALUE>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiEnableCs</DEFINITION-REF>
                                    <VALUE>true</VALUE>
                                    </BOOLEAN-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiShiftClockIdleLevel</DEFINITION-REF>
                                    <VALUE>HIGH</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiTimeClk2Cs</DEFINITION-REF>
                                    <VALUE>1.0</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiTimeCs2Clk</DEFINITION-REF>
                                    <VALUE>1.0</VALUE>
                                    </FLOAT-VALUE>
                                    <FLOAT-VALUE>
                                    <DEFINITION-REF DEST="FLOAT-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiTimeCs2Cs</DEFINITION-REF>
                                    <VALUE>6.4</VALUE>
                                    </FLOAT-VALUE>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiExternalDevice/SpiCsContinous</DEFINITION-REF>
                                    <VALUE>True</VALUE>
                                    </ENUMERATION-VALUE>
                                    </PARAMETER-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>DUMMY_SpiJob_1_EB</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <ENUMERATION-VALUE>
                                    <DEFINITION-REF DEST="ENUMERATION-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/SpiHwUnit</DEFINITION-REF>
                                    <VALUE>CSIB0</VALUE>
                                    </ENUMERATION-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/SpiJobEndNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/SpiJobStartNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/SpiJobId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/SpiJobPriority</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/ChannelAssignment</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Spi/SpiDriver_1/DUMMY_SpiChannel_1_EB</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiJob/DeviceAssignment</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Spi/SpiDriver_1/DUMMY_SpiExternalDevice_1_EB</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                </CONTAINER>
                                <CONTAINER>
                                    <SHORT-NAME>DUMMY_SpiSequence_1_EB</SHORT-NAME>
                                    <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiSequence</DEFINITION-REF>
                                    <PARAMETER-VALUES>
                                    <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiSequence/SpiInterruptibleSequence</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                    </BOOLEAN-VALUE>
                                    <FUNCTION-NAME-VALUE>
                                    <DEFINITION-REF DEST="FUNCTION-NAME-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiSequence/SpiSeqEndNotification</DEFINITION-REF>
                                    <VALUE>NULL_PTR</VALUE>
                                    </FUNCTION-NAME-VALUE>
                                    <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiSequence/SpiSequenceId</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                    </INTEGER-VALUE>
                                    </PARAMETER-VALUES>
                                    <REFERENCE-VALUES>
                                    <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Spi/SpiDriver/SpiSequence/JobAssignment</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Spi/SpiDriver_1/DUMMY_SpiJob_1_EB</VALUE-REF>
                                    </REFERENCE-VALUE>
                                    </REFERENCE-VALUES>
                                </CONTAINER>
			</xsl:if>
			
</xsl:template>




<xsl:template name= "make_FEE_Config">
	<xsl:param name = "BLOCK_NUMBER"/>
	<xsl:param name = "NUMBER_OF_FEE_BLOCK"/>
	<xsl:param name = "DATA_FLASH_SIZE"/>
	<xsl:param name = "FEE_BLOCK_SIZE"/>
	

	<xsl:choose> <!-- call again or not -->
		<xsl:when test= "$BLOCK_NUMBER = $NUMBER_OF_FEE_BLOCK + 1">
		</xsl:when>
		<xsl:when test= "$NUMBER_OF_FEE_BLOCK=0">
		</xsl:when>
		<xsl:otherwise>
		<!-- make code here -->
						<CONTAINER>
                            <SHORT-NAME>FeeBlockConfiguration_<xsl:value-of select="$BLOCK_NUMBER"/></SHORT-NAME>
                            <DEFINITION-REF DEST="PARAM-CONF-CONTAINER-DEF">/TS_T2D13M30I5R0/Fee/FeeBlockConfiguration</DEFINITION-REF>
                            <PARAMETER-VALUES>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeBlockConfiguration/FeeBlockNumber</DEFINITION-REF>
                                    <VALUE><xsl:value-of select="$BLOCK_NUMBER"/></VALUE>
                                </INTEGER-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeBlockConfiguration/FeeBlockSize</DEFINITION-REF>
									<xsl:choose>
											<xsl:when test ="$FEE_BLOCK_SIZE = '' or $FEE_BLOCK_SIZE = '0' ">
												<xsl:message  terminate ="yes">
=======================================================================================================================
'Error 		'//SRS/MEM/EEPROM/DEVICE/@Fee_Block_Size' Setting이 누락되어 있음
=======================================================================================================================</xsl:message>
											</xsl:when>
											<xsl:otherwise>
												<VALUE><xsl:value-of select="$FEE_BLOCK_SIZE"/></VALUE>
											</xsl:otherwise>
									</xsl:choose>
                                </INTEGER-VALUE>
                                <BOOLEAN-VALUE>
                                    <DEFINITION-REF DEST="BOOLEAN-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeBlockConfiguration/FeeImmediateData</DEFINITION-REF>
                                    <VALUE>false</VALUE>
                                </BOOLEAN-VALUE>
                                <INTEGER-VALUE>
                                    <DEFINITION-REF DEST="INTEGER-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeBlockConfiguration/FeeNumberOfWriteCycles</DEFINITION-REF>
                                    <VALUE>0</VALUE>
                                </INTEGER-VALUE>
                            </PARAMETER-VALUES>
                            <REFERENCE-VALUES>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeBlockConfiguration/FeeClusterGroupRef</DEFINITION-REF>
									<xsl:choose>
									<xsl:when test="$DATA_FLASH_SIZE = '0'">
										<xsl:choose>
												<xsl:when test="$BLOCK_NUMBER mod 2 = 1"><VALUE-REF DEST="CONTAINER">/AR_ROOT/Fee/FeeClusterGroup_1</VALUE-REF></xsl:when>
												<xsl:when test="$BLOCK_NUMBER mod 2 = 0"><VALUE-REF DEST="CONTAINER">/AR_ROOT/Fee/FeeClusterGroup_2</VALUE-REF></xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:when test="$DATA_FLASH_SIZE = '16384'">
										<VALUE-REF DEST="CONTAINER">/AR_ROOT/Fee/FeeClusterGroup_1</VALUE-REF>
									</xsl:when>
									<xsl:when test="$DATA_FLASH_SIZE = '32768'">
										<VALUE-REF DEST="CONTAINER">/AR_ROOT/Fee/FeeClusterGroup_1</VALUE-REF>
									</xsl:when>
									<xsl:when test="$DATA_FLASH_SIZE = ''">
										<xsl:message  terminate ="yes">
=======================================================================================================================
'Error 		'//SRS/MEM/EEPROM/DEVICE/@Calibration_Flash_Size' Setting이 누락되어 있음
=======================================================================================================================</xsl:message>  												
									</xsl:when>
									</xsl:choose>
                                </REFERENCE-VALUE>
                                <REFERENCE-VALUE>
                                    <DEFINITION-REF DEST="SYMBOLIC-NAME-REFERENCE-PARAM-DEF">/TS_T2D13M30I5R0/Fee/FeeBlockConfiguration/FeeDeviceIndex</DEFINITION-REF>
                                    <VALUE-REF DEST="CONTAINER">/AR_ROOT/Fls/FlsGeneral_1</VALUE-REF>
                                </REFERENCE-VALUE>
                            </REFERENCE-VALUES>
						</CONTAINER>
			<xsl:call-template name="make_FEE_Config">
				<xsl:with-param name = "BLOCK_NUMBER" select="$BLOCK_NUMBER + 1"/>
				<xsl:with-param name = "NUMBER_OF_FEE_BLOCK" select="$NUMBER_OF_FEE_BLOCK"/>
				<xsl:with-param name = "DATA_FLASH_SIZE" select="//SRS/MEM/EEPROM/DEVICE/@Calibration_Flash_Size"/>
				<xsl:with-param name = "FEE_BLOCK_SIZE" select="//SRS/MEM/EEPROM/DEVICE/@Fee_Block_Size"/>
				
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>



</xsl:stylesheet>
