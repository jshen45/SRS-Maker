<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xalan="http://xml.apache.org/xalan" 
                xmlns:math="java.lang.Math" 
                xmlns:date="java.util.Date"                
                xmlns:vector="java.util.Vector"                
                extension-element-prefixes="date vector math">
<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<xsl:param name ="REPROGRAMMING_CAN_CHANNEL" select="//SRS/EOL/@Channel" ></xsl:param>
<xsl:param name ="CORE_CLOCK" select="//SRS/MCU/SPEC/@Cclock" ></xsl:param>
<xsl:param name ="BUS_CLOCK" select="//SRS/MCU/SPEC/@Bclock" ></xsl:param>
<xsl:param name ="OSCILLATOR_CLOCK" select="//SRS/MCU/SPEC/@Frequency" ></xsl:param>

<xsl:template match="/"> 
<xsl:comment>
============================================================================
                       Autron  SOFTWARE  GROUP                              
============================================================================
                        OBJECT SPECIFICATION                                
============================================================================
* source file for 1st pass Xml generation 
* %Name:                FBL_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* dependency 			None
* %xsl file version:    1.0.9 %
* %created_by:        	ca071 %
*===========================================================================
 COPYRIGHT (C) Autron 2012                                             
 AUTOMOTIVE ELECTRONICS                                                     
 ALL RIGHTS RESERVED                                                        
============================================================================
                               OBJECT HISTORY                               
============================================================================
  REVISION |   DATE      |                               |      AUTHOR      
============================================================================
  1.0.0      | 13/Jan/2014 |                               | Seungwoo. Lee
  - Init version
  1.0.1      | 23/APr/2014 |                               | Seungwoo. Lee
  - Error fix  condition change '//SRS/MCU/SPEC/@FLASH_SIZE' (Line 353)
  1.0.2      | 07/May/2014 |                               | Seungwoo. Lee
  - 'TimeQuantum' value under 'CAN_BIT_TIME_CONFIG' Element is according to 
     calculated value in Excel 
  1.0.3      | 07/May/2014 |                               | Seungwoo. Lee
  - 'PROPSEG' value under 'CAN_BIT_TIME_CONFIG' Element is according to 
     calculated value in Excel 
  1.0.4      | 07/May/2014 |                               | Seungwoo. Lee
  - 'Start_Add_Tbx_RAM' value under 'FLASH_CONFIG' Element is fixed to 
    '40003000'
  1.0.5      | 07/Jul/2014 |                               | Seungwoo. Lee
  - 'FLASHTOOLBOX_CONFIG' Element removed
  - 'CLOCK_OUTPUT_CONFIG' Element removed
  - 'MCU_SPECIFIC_CONFIG/@MCU_Name removed
  - 'MCUMODE_CONFIG/@Flash_InitSize removed
  - 'MCUMODE_CONFIG/@Ram_InitSize removed
  - 'MemoryAccessRight' element removed
  - 'TOOL_SIGNATURE' element removed
  - Logic added for making 'DIAG_SPECIFIC_CONFIG' element
  - logic change for making code generation template of 'zbbdiagcfg.h' 
  - logic added for 'CAN_CONFIG_SPC56X/CAN_Port_Config'
 1.0.6      | 21/Oct/2014 |                               | Seungwoo. Lee
  - change value of "//SRS/FBL/FDIAG/@Specification" from 'ISO_14229' to 'ES95486'  
 1.0.7      | 09/Jan/2015 |                               | Seungwoo. Lee
  - remove '//SRS/CORE/UDS/@Usage='Yes''
  - change 'Local_Identifier_Value' from '04' to '01'
  - change 'WDG_Reload_Value' from '16000000' to '128000' for 1s watchdog setting
  - remove '//SRS/CORE/KLINE/@SCI_Tx_Port_control'
  - add error handle for 'CAN_Identifier_Format' attribute under 'CAN_CONFIG'
  - add error handle for 'CAN_Default_Speed' attribute under 'CAN_CONFIG'   
  - add logic for 'TIMER_CONFIG/@Timer_Prescaler' value
  - BUS_Clock_in_FBL_Mode_mhz value is accoding to //SRS/MCU/SPEC/@Peripheral_Clock_Set_2
  - change 'Start_Add_Tbx_RAM' value from '40003000' to '40000800' according to 'FBL SCM Document'
  - add 'CCP_REPROGRAMMING' element under 'DIAG_SPECIFIC_CONFIG'
 1.0.8      | 18/Aug/2015 |                               | Seungwoo. Lee  
  - add 'Date_Auto_Config' attribute under 'IDENTIFICATION_CONFIG' element
  - add 'SYSTEM_SPECIFIC_FBL_CONFIG' element
  - add error handle for 'PROPSEG' attribute
 1.0.9      | 25/Sep/2015 |                               | Seungwoo. Lee    
  - add logic for 'ECU_Specific_Init_code' 
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
Flash Boot Loader 1st pass XML Generaiton Message
1. BUS_Clock_in_FBL_Mode_mhz value is accoding to //SRS/MCU/SPEC/@Peripheral_Clock_Set_2

==========================================================================
</xsl:message>  


<BOOT Name="fbl" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="fbl.xsd">
	<PLL_SETUP BUS_Clock_in_FBL_Mode_mhz="{//SRS/MCU/SPEC/@Peripheral_Clock_Set_2}"
        CPU_Clock_in_FBL_Mode_mhz="{//SRS/MCU/SPEC/@Cclock}" QUARTZ_Clock_in_FBL_Mode_mhz="{//SRS/MCU/SPEC/@Frequency}"/>
	
	<xsl:element name="STARTUP_CONFIG">
		<xsl:attribute name="BootHold_Condition">
			<xsl:choose>
				<xsl:when test= "//SRS/FBL/START/@BootHold_Condition='ENABLE'">Enabled</xsl:when>
				<xsl:when test= "//SRS/FBL/START/@BootHold_Condition='DISABLE'">Disabled</xsl:when>
			</xsl:choose>
		</xsl:attribute>
		<xsl:choose>
			<xsl:when test="//SRS/FBL/START/@BootHold_Condition='DISABLE' and //SRS/FBL/START/@Condition=''">
				<xsl:attribute name="BootHold_Condition_String">0</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="BootHold_Condition_String">
					<xsl:value-of select="//SRS/FBL/START/@Condition"/>
				</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="//SRS/FBL/START/@Timeout=''">
					<xsl:attribute name="Timeout1_in_ms">0</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="Timeout1_in_ms">
					<xsl:value-of select="//SRS/FBL/START/@Timeout"/>
				</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:attribute name="Detect_Spurious_Reset">Yes</xsl:attribute>
	</xsl:element>
	
	
	<xsl:element name="BOOTCORE_CONFIG">
				<xsl:attribute name="COMM_Driver_Used"><xsl:value-of select="//SRS/EOL/@Type"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="//SRS/FBL/CORE/@Diag_Job='Yes'">
							<xsl:attribute name="Diag_Job">Yes</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
							<xsl:attribute name="Diag_Job">No</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:attribute name="ECU_Specific_Job"><xsl:value-of select="//SRS/FBL/CORE/@ECU_Specific_Job"/></xsl:attribute>
				<xsl:attribute name="Restart_if_Idle"><xsl:value-of select="//SRS/FBL/CORE/@Restart_if_Idle"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="//SRS/FBL/CORE/@Diag_Job='Yes'">
							<xsl:attribute name="FLASH_Enabled">Yes</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
							<xsl:attribute name="FLASH_Enabled">No</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:attribute name="EEPROM_Enabled">No</xsl:attribute>
				<xsl:attribute name="FBL_Test_Enabled">No</xsl:attribute>
				<xsl:attribute name="Force_Security_Access">No</xsl:attribute>
				<xsl:choose>
					<xsl:when test="//SRS/FBL/CORE/@Restart_if_Idle ='Yes' and //SRS/FBL/CORE/@Timeout=''">
					<xsl:message  terminate ="yes">
==========================================================================
 -ERROR-
 '//SRS/FBL/CORE/@Timeout' value is blank, Please check this
==========================================================================
				</xsl:message>  
						<xsl:attribute name="Timeout2_in_ms">0</xsl:attribute>
						<xsl:comment>Timeout2_in_ms is set by default value </xsl:comment>
					</xsl:when>
					<xsl:when test="//SRS/FBL/CORE/@Restart_if_Idle !='Yes' and //SRS/FBL/CORE/@Timeout=''">
						<xsl:attribute name="Timeout2_in_ms">0</xsl:attribute>
						<xsl:comment>Timeout2_in_ms is set by default value </xsl:comment>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="Timeout2_in_ms"><xsl:value-of select="//SRS/FBL/CORE/@Timeout"/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
	</xsl:element>
	
	<xsl:element name="IDENTIFICATION_CONFIG">
			<xsl:attribute name="Customer"><xsl:value-of select="//SRS/FBL/IDENT/@Customer"/></xsl:attribute>
			<xsl:attribute name="Date"><xsl:value-of select="//SRS/FBL/IDENT/@Date"/></xsl:attribute>
			<xsl:choose> 
					<xsl:when test="//SRS/FBL/IDENT/@Date_Auto_Config='Yes'"><xsl:attribute name="Date_Auto_Config">Yes</xsl:attribute></xsl:when> 
					<xsl:when test="//SRS/FBL/IDENT/@Date_Auto_Config='No'"><xsl:attribute name="Date_Auto_Config">No</xsl:attribute></xsl:when> 
				<xsl:otherwise>
					<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/FBL/IDENT/@Date_Auto_Config 에 잘못된 값 입력됨
=======================================================================================================================</xsl:message>  					
				</xsl:otherwise>
			</xsl:choose> 
			<xsl:attribute name="Prod_Var"><xsl:value-of select="//SRS/FBL/IDENT/@Prod_Var"/></xsl:attribute>
			<xsl:attribute name="Product"><xsl:value-of select="//SRS/FBL/IDENT/@Product"/></xsl:attribute>
			<xsl:attribute name="SW_Int_Version"><xsl:value-of select="//SRS/FBL/IDENT/@SW_Int_Version"/></xsl:attribute>
			<xsl:attribute name="SW_Version"><xsl:value-of select="//SRS/FBL/IDENT/@SW_Major_Version"/></xsl:attribute>
			<xsl:attribute name="Synchro1"><xsl:value-of select="//SRS/FBL/IDENT/@Synchro1"/></xsl:attribute>
			<xsl:attribute name="Synchro2"><xsl:value-of select="//SRS/FBL/IDENT/@Synchro2"/></xsl:attribute>
	</xsl:element>
	
	
	<xsl:element name="CAN_CONFIG">
			<xsl:attribute name="CAN_Cell"><xsl:value-of select="//SRS/EOL/@Channel"/></xsl:attribute>
			<xsl:choose>
					<xsl:when test="//SRS/EOL/@ID_type='CAN_STD_ID'">
						<xsl:attribute name="CAN_Identifier_Format">11_Bits</xsl:attribute>
					</xsl:when>
					<xsl:when test="//SRS/EOL/@ID_type='CAN_EXT_ID'">
						<xsl:attribute name="CAN_Identifier_Format">29_Bits</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/EOL/@ID_type  값이 입력되지 않음
=======================================================================================================================</xsl:message>  										
					</xsl:otherwise>
			</xsl:choose>
			
			<xsl:choose>
				<xsl:when test="//SRS/FBL/FBLCAN/@speed = ''">
					<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/FBL/FBLCAN/@speed  값이 입력되지 않음
=======================================================================================================================</xsl:message>  										
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="CAN_Default_Speed"><xsl:value-of select="//SRS/FBL/FBLCAN/@speed"/>KBPS</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
					
						<xsl:choose>
							<xsl:when test="//SRS/EOL/@DIAG_FUNC_RX='' and //SRS/EOL/@ID_type='CAN_STD_ID'">
									<xsl:attribute name="DIAG_func_rx_id">071F</xsl:attribute>
									<xsl:message  terminate ="no">
=======================================================================================================================
				DIAG_func_rx_id is set by default value
=======================================================================================================================</xsl:message>
							</xsl:when>
							<xsl:when test="//SRS/EOL/@DIAG_FUNC_RX='' and //SRS/EOL/@ID_type='CAN_EXT_ID'">
									<xsl:attribute name="DIAG_func_rx_id">18DBFFF9</xsl:attribute>
									<xsl:message  terminate ="no">
=======================================================================================================================
				DIAG_func_rx_id is set by default value
=======================================================================================================================</xsl:message>
							</xsl:when>
							<xsl:otherwise>
									<xsl:attribute name="DIAG_func_rx_id"><xsl:value-of select="//SRS/EOL/@DIAG_FUNC_RX"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="//SRS/EOL/@DIAG_RX='' and //SRS/EOL/@ID_type='CAN_STD_ID'">
									<xsl:attribute name="DIAG_rx_id">0706</xsl:attribute>
									<xsl:message  terminate ="no">
=======================================================================================================================
				DIAG_rx_id is set by default value
=======================================================================================================================</xsl:message>
							</xsl:when>
							<xsl:when test="//SRS/EOL/@DIAG_RX='' and //SRS/EOL/@ID_type='CAN_EXT_ID'">
									<xsl:attribute name="DIAG_rx_id">18DA1DF9</xsl:attribute>
									<xsl:message  terminate ="no">
=======================================================================================================================
				DIAG_rx_id is set by default value
=======================================================================================================================</xsl:message>
							</xsl:when>
							<xsl:otherwise>
									<xsl:attribute name="DIAG_rx_id"><xsl:value-of select="//SRS/EOL/@DIAG_RX"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="//SRS/EOL/@DIAG_TX='' and //SRS/EOL/@ID_type='CAN_STD_ID'">
									<xsl:attribute name="DIAG_tx_id">0726</xsl:attribute>
									<xsl:message  terminate ="no">
=======================================================================================================================
				DIAG_tx_id is set by default value
=======================================================================================================================</xsl:message>
							</xsl:when>
							<xsl:when test="//SRS/EOL/@DIAG_TX='' and //SRS/EOL/@ID_type='CAN_EXT_ID'">
									<xsl:attribute name="DIAG_tx_id">18DAF91D</xsl:attribute>
									<xsl:message  terminate ="no">
=======================================================================================================================
				DIAG_tx_id is set by default value
=======================================================================================================================</xsl:message>
							</xsl:when>
							<xsl:otherwise>
									<xsl:attribute name="DIAG_tx_id"><xsl:value-of select="//SRS/EOL/@DIAG_TX"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="//SRS/EOL/@EOL_RX='' and //SRS/EOL/@ID_type='CAN_STD_ID'">
									<xsl:attribute name="EOL_rx_id">05AD</xsl:attribute>
									<xsl:message  terminate ="no">
=======================================================================================================================
				EOL_Rx_id is set by default value
=======================================================================================================================</xsl:message>  																							
							</xsl:when>
							<xsl:when test="//SRS/EOL/@EOL_RX='' and //SRS/EOL/@ID_type='CAN_EXT_ID'">
									<xsl:attribute name="EOL_rx_id">18DA1DF1</xsl:attribute>
									<xsl:message  terminate ="no">
=======================================================================================================================
				EOL_Rx_id is set by default value
=======================================================================================================================</xsl:message>  																																
							</xsl:when>
							<xsl:otherwise>
									<xsl:attribute name="EOL_rx_id"><xsl:value-of select="//SRS/EOL/@EOL_RX"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="//SRS/EOL/@EOL_TX='' and //SRS/EOL/@ID_type='CAN_STD_ID'">
									<xsl:attribute name="EOL_tx_id">05B0</xsl:attribute>
									<xsl:message  terminate ="no">
=======================================================================================================================
				EOL_Tx_id is set by default value
=======================================================================================================================</xsl:message>  																																
							</xsl:when>
							<xsl:when test="//SRS/EOL/@EOL_TX='' and //SRS/EOL/@ID_type='CAN_EXT_ID'">
									<xsl:attribute name="EOL_tx_id">18DA1DF2</xsl:attribute>
									<xsl:message  terminate ="no">
=======================================================================================================================
				EOL_Tx_id is set by default value
=======================================================================================================================</xsl:message>
							</xsl:when>
							<xsl:otherwise>
									<xsl:attribute name="EOL_tx_id"><xsl:value-of select="//SRS/EOL/@EOL_TX"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
	</xsl:element>
	
	
	<xsl:element name="KLINE_CONFIG">
			<xsl:choose>
				<xsl:when test="//SRS/EOL/@Type='KLINE'">
						<xsl:attribute name="ASC_Cell"><xsl:value-of select="//SRS/EOL/@Channel"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
						<xsl:attribute name="ASC_Cell">0</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="CheckTxError">Disable</xsl:attribute>
			<xsl:attribute name="BCM_Address">40</xsl:attribute>
			<xsl:attribute name="Message_Format">80</xsl:attribute>
			<xsl:attribute name="SID_EOL_ACT_REQ">70</xsl:attribute>
			<xsl:attribute name="SID_EOL_ACT_RSP">71</xsl:attribute>
			<xsl:attribute name="SID_EOL_TBX_REQ">72</xsl:attribute>
			<xsl:attribute name="SID_EOL_TBX_RSP">73</xsl:attribute>
			<xsl:attribute name="Tester_Address">F1</xsl:attribute>
	</xsl:element>
	<xsl:comment>BCM_Address, CheckTxError,Message_Format,SID_EOL_ACT_REQ,SID_EOL_ACT_RSP,SID_EOL_TBX_REQ,SID_EOL_TBX_RSP,Tester_Address attribute is set by XSD default value </xsl:comment>
	
	<xsl:element name="FLASH_CONFIG">
			<xsl:attribute name="Alignment">16</xsl:attribute>
			<xsl:attribute name="Change_Boot_Service">Disabled</xsl:attribute>
			<xsl:attribute name="FlashMassErase">ENABLE</xsl:attribute>
			<xsl:attribute name="HasAlignmentConstraints">Yes</xsl:attribute>
			<xsl:attribute name="HasWriteSizeConstraints">Yes</xsl:attribute>
			<xsl:attribute name="Start_Add_Tbx_RAM">40000800</xsl:attribute>
			<xsl:attribute name="WriteMaxBlockSize">256</xsl:attribute>
	</xsl:element>
	<xsl:comment>Alignment, Change_Boot_Service,FlashMassErase,HasAlignmentConstraints,HasWriteSizeConstraints,Start_Add_Tbx_RAM,WriteMaxBlockSize attribute is fixed value </xsl:comment>
	
	
	<xsl:element name="EOL_CONFIG">
			<xsl:attribute name="Antiscanning_Delay_in_ms"><xsl:value-of select="//SRS/EOL/@Delay"/></xsl:attribute>
			<xsl:attribute name="Antiscanning_Eeprom_Add">00</xsl:attribute>
			<xsl:attribute name="Antiscanning_Eeprom_Value">00</xsl:attribute>
			<xsl:attribute name="Antiscanning_Mode">Level_0</xsl:attribute>
			<xsl:attribute name="Local_Identifier">Yes</xsl:attribute>
			<xsl:attribute name="Local_Identifier_Value">01</xsl:attribute>
			<xsl:choose>
				<xsl:when test="//SRS/EOL/@SeedMethod ='FIX'"> 
						<xsl:attribute name="Key_Add">0000<xsl:value-of select="//SRS/EOL/@Key"/></xsl:attribute>	
						<xsl:attribute name="Seed_Add">0000<xsl:value-of select="//SRS/EOL/@Seed"/></xsl:attribute>
						<xsl:attribute name="Security">NO_SEED_KEY</xsl:attribute>
				</xsl:when>
				<xsl:when test="//SRS/EOL/@SeedMethod ='EOL'"> 
						<xsl:attribute name="Key_Add">0000<xsl:value-of select="//SRS/EOL/@Key"/></xsl:attribute>	
						<xsl:attribute name="Seed_Add">0000<xsl:value-of select="//SRS/EOL/@Seed"/></xsl:attribute>
						<xsl:attribute name="Security">USE_ROM_SEED_KEY</xsl:attribute>
				</xsl:when>
				<xsl:when test="//SRS/EOL/@SeedMethod ='RANDOM'"> 
					<xsl:attribute name="Key_Add">00000000</xsl:attribute>	
					<xsl:attribute name="Seed_Add">00000000</xsl:attribute>
					<xsl:attribute name="Security">NO_SEED_KEY</xsl:attribute>
				</xsl:when>
			</xsl:choose>
	</xsl:element>
	
	<xsl:element name="CRC16_CONFIG">
			<xsl:attribute name="CRC16_Block_Size">4096</xsl:attribute>	
			<xsl:attribute name="CRC16_Fixed_Init_Value">00</xsl:attribute>	
			<xsl:attribute name="CRC16_Fixed_Init_Value_Mode">Disabled</xsl:attribute>	
			<xsl:choose>
				<xsl:when test="//SRS/MEM/CHECK/@Enable ='Yes'">
					<xsl:attribute name="FBL_Embeds_CRC_Functions">Yes</xsl:attribute>	
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="FBL_Embeds_CRC_Functions">No</xsl:attribute>	
				</xsl:otherwise>
			</xsl:choose>
	</xsl:element>

	<xsl:element name="MCU_SPECIFIC_CONFIG">
			<xsl:element name="CAN_CONFIG_SPC56X">
				<xsl:element name="CAN_Port_Config">
					<xsl:attribute name="ProtocolClockSelection">XOSC</xsl:attribute>
					
					<xsl:choose>
						<xsl:when test="//SRS/EOL/@Channel=''">
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/EOL/@Channel 값이 없음			
=======================================================================================================================</xsl:message>  
						</xsl:when>
						<xsl:when test="//SRS/FBL/FBLCAN/@RxPort=''">
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/FBL/FBLCAN/@RxPort 값이 없음			
=======================================================================================================================</xsl:message>  
						</xsl:when>
						<xsl:when test="//SRS/FBL/FBLCAN/@TxPort='' ">
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/FBL/FBLCAN/@TxPort 값이 없음			
=======================================================================================================================</xsl:message>  
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="RxPort">SPC560_CAN<xsl:value-of select="//SRS/EOL/@Channel"/>_<xsl:value-of select="//SRS/FBL/FBLCAN/@RxPort"/></xsl:attribute>
							<xsl:attribute name="TxPort">SPC560_CAN<xsl:value-of select="//SRS/EOL/@Channel"/>_<xsl:value-of select="//SRS/FBL/FBLCAN/@TxPort"/></xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:element name="CAN_BIT_TIME_CONFIG">
						<xsl:attribute name="BitTime"><xsl:value-of select="//SRS/FBL/FBLCAN/@bit_time"/></xsl:attribute>
						<xsl:choose>
							<xsl:when test="//SRS/FBL/FBLCAN/@PROPSEG=''">
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/FBL/FBLCAN/@PROPSEG='' 값이 없음. 상위 버전 양식 파일 사용 필요
=======================================================================================================================</xsl:message>  
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="PROPSEG"><xsl:value-of select="//SRS/FBL/FBLCAN/@PROPSEG"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="//SRS/FBL/FBLCAN/@TimeQuantum=''">
								<xsl:choose>
									<xsl:when test="//SRS/FBL/FBLCAN/@speed='500'"><xsl:attribute name="TimeQuantum">125</xsl:attribute></xsl:when> 
									<xsl:otherwise><xsl:attribute name="TimeQuantum">500</xsl:attribute></xsl:otherwise> 
								</xsl:choose>
							</xsl:when> 
							<xsl:otherwise>
								<xsl:attribute name="TimeQuantum"><xsl:value-of select="//SRS/FBL/FBLCAN/@TimeQuantum"/></xsl:attribute>
							</xsl:otherwise> 
						</xsl:choose>
						<xsl:attribute name="Prescaler"><xsl:value-of select="//SRS/FBL/FBLCAN/@Prescaler"/></xsl:attribute>
						<xsl:attribute name="Speed"><xsl:value-of select="//SRS/FBL/FBLCAN/@speed"/>KBPS</xsl:attribute>
						<xsl:attribute name="PSEG1"><xsl:value-of select="//SRS/FBL/FBLCAN/@Pseg1"/></xsl:attribute>
						<xsl:attribute name="PSEG2"><xsl:value-of select="//SRS/FBL/FBLCAN/@Pseg2"/></xsl:attribute>
						<xsl:attribute name="RJW"><xsl:value-of select="//SRS/FBL/FBLCAN/@rjw"/></xsl:attribute>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:element name="MCUMODE_CONFIG">
				<xsl:attribute name="Mcu_Mode">BOLERO_SCORE</xsl:attribute>	
			</xsl:element>
			<xsl:element name="TIMER_CONFIG">
					<xsl:attribute name="Timer_Prescaler"><xsl:value-of select="//SRS/FBL/FBLWDG/@Timer_Prescaler"/></xsl:attribute>	
			</xsl:element>
			
			<xsl:element name="WATCHDOG_CONFIG">
					<xsl:attribute name="WDG_Reload_Value">128000</xsl:attribute>	
			</xsl:element>
			<xsl:comment>WDG_Reload_Value attribute is fixed '1280000' in bolero MCU </xsl:comment>
	</xsl:element>
	
	<xsl:element name="PROJECT_SPECIFIC_CONFIG">
			<xsl:attribute name="MCU_Name"><xsl:value-of select="//SRS/MCU/SPEC/@Name"/></xsl:attribute>	
			<xsl:element name="EXTERNAL_WATCHDOG">
				<xsl:attribute name="Ext_Wdg_Enable">
				<xsl:choose> 
					<xsl:when test="//SRS/CORE/WDG/@Ext_WDG_pin='NA' or //SRS/CORE/WDG/@Ext_WDG_pin=''">DISABLE</xsl:when> 
					<xsl:otherwise>ENABLE</xsl:otherwise> 
				</xsl:choose> 
				</xsl:attribute>
				<xsl:attribute name="Ext_Wdg_Pin_setToOutput"><xsl:value-of select="//SRS/CORE/WDG/@Ext_Wdg_Pin_setToOutput"/></xsl:attribute>
				<xsl:attribute name="Ext_Wdg_Pin_toggleOutput"><xsl:value-of select="//SRS/CORE/WDG/@Ext_Wdg_Pin_toggleOutput"/></xsl:attribute>
				<xsl:choose> 
					<xsl:when test="//SRS/CORE/WDG/@Ext_WDG_Timeout_ms=''">
						<xsl:attribute name="Ext_Wdg_Timeout_in_ms">100</xsl:attribute>	
					</xsl:when> 
					<xsl:otherwise>
						<xsl:attribute name="Ext_Wdg_Timeout_in_ms"><xsl:value-of select="//SRS/CORE/WDG/@Ext_WDG_Timeout_ms"/></xsl:attribute>	
					</xsl:otherwise> 
				</xsl:choose> 
			</xsl:element>
			<xsl:element name="CAN_TRANSCEIVER">
				<xsl:attribute name="Can_Trcv_Enable_Pin_setToOutput"><xsl:value-of select="//SRS/FBL/FBLCAN/@enable_output_setting"/></xsl:attribute>	
				<!-- SIU.PCR[103].B.OBE =1; -->
				<xsl:attribute name="Can_Trcv_Enable_Pin_writeDirect"><xsl:value-of select="//SRS/FBL/FBLCAN/@enable_write"/></xsl:attribute>	
				<xsl:attribute name="Can_Trcv_Error_Pin_setToInput"><xsl:value-of select="//SRS/FBL/FBLCAN/@error_control"/></xsl:attribute>	
				<xsl:attribute name="Can_Trcv_Standby_Pin_setToOutput"><xsl:value-of select="//SRS/FBL/FBLCAN/@stand_by_output_setting"/></xsl:attribute>	
				<xsl:attribute name="Can_Trcv_Standby_Pin_writeDirect"><xsl:value-of select="//SRS/FBL/FBLCAN/@stand_by_write"/></xsl:attribute>	
				<!-- SIU.GPDO[103].B.PDO =0; -->
			</xsl:element>
			<xsl:element name="KLINE_TRANSCEIVER">
				<xsl:attribute name="SCI_Rx_Port_control"></xsl:attribute>
				<xsl:attribute name="SCI_Tx_Port_control"></xsl:attribute>
			</xsl:element>
			<xsl:element name="SYSTEM_SPECIFIC_FBL_CONFIG">
				<xsl:attribute name="ECU_Specific_Init_code"><xsl:value-of select="//SRS/FBL/START/@ECU_Specific_Init_code"/></xsl:attribute>
			</xsl:element>
	</xsl:element>
	
	<xsl:choose>
		<xsl:when test="//SRS/FBL/CORE/@Diag_Job='Yes'">
	<xsl:element name="DIAG_SPECIFIC_CONFIG">
		<xsl:element name="SPECIFICATION">
				<xsl:attribute name="SpecificationDerivative">
				<xsl:choose> 
					<xsl:when test="//SRS/FBL/FDIAG/@Specification='ES95486'">ES95486</xsl:when> 
					<xsl:when test="//SRS/FBL/FDIAG/@Specification='ES95485'">ES95485</xsl:when> 
					<xsl:otherwise>
					<xsl:message  terminate ="yes">
=======================================================================================================================

'Error			//SRS/FBL/FDIAG/@Specification 에 잘못된 값 입력됨

=======================================================================================================================</xsl:message>  					
					</xsl:otherwise>
				</xsl:choose> 
				</xsl:attribute>
		</xsl:element>
		<xsl:element name="TRANSPORT_PROTOCOL">
				<xsl:attribute name="ST_Min"><xsl:value-of select="//SRS/FBL/FDIAG/@STMin"/></xsl:attribute>
		</xsl:element>
		<xsl:element name="DIAGNOSTIC_SERVICE">
			<xsl:attribute name="P2_Can_Server_Max">50</xsl:attribute>
			<xsl:attribute name="P2_Can_Ext_Server_Max">500</xsl:attribute>
			<xsl:attribute name="ServerNumOfBlockLen">
				<xsl:choose> 
					<xsl:when test="//SRS/FBL/FDIAG/@Specification='ES95486'">130</xsl:when> 
					<xsl:when test="//SRS/FBL/FDIAG/@Specification='ES95485'">129</xsl:when> 
					<xsl:otherwise>
					<xsl:message  terminate ="yes">
=======================================================================================================================

'Error			//SRS/FBL/FDIAG/@Specification 에 잘못된 값 입력됨

=======================================================================================================================</xsl:message> 
					</xsl:otherwise> 
				</xsl:choose> 
			</xsl:attribute>
			<xsl:attribute name="FalseAccessAttemptCount">2</xsl:attribute>
		</xsl:element>
		<xsl:element name="CCP_REPROGRAMMING">
			<xsl:attribute name="INCA_Support">No</xsl:attribute>
		</xsl:element>
	</xsl:element>
		</xsl:when>
		<xsl:otherwise>
			
		</xsl:otherwise>
	</xsl:choose>

    <CODE_GENERATION>
        <TEMPLATE Name="zbbprjcfg" OutFile="zbbprjcfg.h" Used="true" XSLTemplate="zbbprjcfg_h.xsl"/>
        <TEMPLATE Name="zbbcorecfg" OutFile="zbbcorecfg.h" Used="true" XSLTemplate="zbbcorecfg_h.xsl"/>
        <TEMPLATE Name="zbbdrvcfg" OutFile="zbbdrvcfg.h" Used="true" XSLTemplate="zbbdrvcfg_h.xsl">
            <XSL_EXTENSION JavaClass="pgcd.jar"/>
        </TEMPLATE>
		<xsl:if test="//SRS/FBL/CORE/@Diag_Job='Yes'">
		<TEMPLATE Name="zbbdiagcfg" OutFile="zbbdiagcfg.h" Used="true" XSLTemplate="zbbdiagcfg_h.xsl"/>
		</xsl:if>
    </CODE_GENERATION>
    <CONSISTENCY_CHECKER>
        <TEMPLATE Name="CC_ECUJOB"
            OutFile="CC_ECUJOB.xml" Used="true" XSLTemplate="CC_ECUJOB.xsl"/>
		<TEMPLATE Name="CC_FBL"
            OutFile="CC_FBL.xml" Used="true" XSLTemplate="CC_FBL.xsl"/>
		<TEMPLATE Name="CC_FBLMCU"
            OutFile="CC_FBLMCU.xml" Used="true" XSLTemplate="CC_FBLMCU.xsl"/>
    </CONSISTENCY_CHECKER>
    <DOCUMENTATION_GENERATION>
			<TEMPLATE Name="a" OutFile="b" Used="true" XSLTemplate="c"/>
	</DOCUMENTATION_GENERATION>
</BOOT>
</xsl:template>
</xsl:stylesheet>
