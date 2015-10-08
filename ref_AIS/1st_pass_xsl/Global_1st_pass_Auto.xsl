<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xalan="http://xml.apache.org/xalan" 
                xmlns:math="java.lang.Math" 
                xmlns:date="java.util.Date"                
                xmlns:vector="java.util.Vector"                
                extension-element-prefixes="date vector math">
<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<xsl:param name ="ATM39_Ch_count" select="//SRS/IO/MUXOUT/MUXOUT_ATM39/@Number_of_Chip" ></xsl:param>
<xsl:param name ="L99MC6_Ch_count" select="//SRS/IO/MUXOUT/MUXOUT_L99MC6/@Number_of_Chip" ></xsl:param>
<xsl:param name ="TLE7240SL_Ch_count" select="//SRS/IO/MUXOUT/MUXOUT_TLE7240SL/@Number_of_Chip" ></xsl:param>
<xsl:param name ="MC33972_Ch_count" select="//SRS/IO/MUXIN/MUXIN_MC33972/@Number_of_Chip" ></xsl:param>




<xsl:template match="/"> 
<xsl:comment>
============================================================================
                       Autron  SOFTWARE  GROUP                              
============================================================================
                        OBJECT SPECIFICATION                                
============================================================================
* source file for 1st pass Xml generation 
* %Name:                Global_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
						
* %xsd file version 	
* dependency 			None
* %xsl file version:    1.0.7 %
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
  1.0.0      | 14/Jan/2014 |                               | Seungwoo. Lee
  - Init version
  1.0.1      | 16/Apr/2014 |                               | Seungwoo. Lee
  - SPI_EVENT_(N) setting changed.
  1.0.2      | 17/Apr/2014 |                               | Seungwoo. Lee
  - SPI_EVENT_(N) setting changed. (up to MCU name)
  1.0.3      | 23/Apr/2014 |                               | Seungwoo. Lee
  - SPI Config add for 'TLE7240SL'
  1.0.4      | 09/Jun/2014 |                               | Seungwoo. Lee
  - to Change Logic for making SPI Config setting
  1.0.5      | 03/Jun/2015 |                               | Seungwoo. Lee  
  - SPI element will be made only if Using SPI
  1.0.6      | 13/Jul/2015 |                               | Seungwoo. Lee  
  - change reference of SPI/SPI_CLIENT/@ChannelIndex attribute from 'SPI_Mcal_Job_index' to 'SPI_Mcal_index' 
  1.0.7      | 18/Aug/2015 |                               | Seungwoo. Lee    
  - add "SPI_EVENT_4" when PACKAGE_144 case (according to code change of bscomspi.c)
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
Global 1st pass XML Generaiton Message
==========================================================================

</xsl:message>  

<COMPONENT ID="N15D8D75" Name="Global 1st pass SWP objects" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="function_local_config.xsd">
		<xsl:element name = "SOFTWARE_PLATFORM_OBJECTS">
				<xsl:element name = "FAST_TIMERS">
						<xsl:if test="//SRS/MEM/EEPROM/DEVICE/@Internal ='Yes'">
							<FAST_TIMER Name="EEPROM_WR_TIME" NotificationFunction="bscomeep_WriteIT"/>
							<xsl:comment> 'EEPROM_WR_TIME' element is fixed, when using internal EEPROM</xsl:comment>
						</xsl:if>
						<xsl:if test="//SRS/CORE/KLINE/@Usage ='Yes'"> <!-- If 'enable' value is 'Yes'  -->
							<FAST_TIMER Name="Timer_Asc_Com" NotificationFunction="zdtimer_On_Event_Timer_Asc_Com_Timeout"/>
							<xsl:comment>'Timer_Asc_Com' elements is fixed for using K-Line Diagnosis</xsl:comment>
						</xsl:if> <!-- If 'enable' value is 'Yes'  -->
				</xsl:element>
				<xsl:element name = "SLOW_TIMERS">
						<xsl:if test="//SRS/CORE/KLINE/@Usage ='Yes'"> <!-- If 'enable' value is 'Yes'  -->
							<SLOW_TIMER Name="Timer_Dpkw2000_Short_Timeout" Resolution="10ms">
								<EVENT Name="Event_Dpkw2000_Short_Timeout"/>
							</SLOW_TIMER>
							<xsl:comment>'Timer_Dpkw2000_Short_Timeout' elements are fixed for using K-Line Diagnosis</xsl:comment>
							<SLOW_TIMER Name="Timer_Dpkw2000_Long_Timeout" Resolution="100ms">
								<EVENT Name="Event_Dpkw2000_Long_Timeout"/>
							</SLOW_TIMER>
							<xsl:comment>'Timer_Dpkw2000_Long_Timeout' elements are fixed for using K-Line Diagnosis</xsl:comment>
							<SLOW_TIMER Name="Timer_Slow_Asc_Com" Resolution="10ms">
								<EVENT Name="Event_AscCom_Slow_Timer"/>
							</SLOW_TIMER>
							<xsl:comment>'Timer_Slow_Asc_Com' elements are fixed for using K-Line Diagnosis</xsl:comment>
						</xsl:if> <!-- If 'enable' value is 'Yes'  -->
				</xsl:element>
				<xsl:element name = "EVENTS">
						<xsl:if test="//SRS/MEM/EEPROM/DEVICE/@Internal ='Yes'">
							<EVENT Name="Event_EEPROM_WR_FINISHED"/>
							<xsl:comment> 'Event_EEPROM_WR_FINISHED' element is fixed, when using internal EEPROM</xsl:comment>
						</xsl:if>
						<xsl:choose> 
							<xsl:when test="//SRS/MCU/SPEC/@Name ='MPC5605B' or //SRS/MCU/SPEC/@Name ='MPC5606B' or //SRS/MCU/SPEC/@Name ='MPC5607B'  or //SRS/MCU/SPEC/@Name ='SPC560B54' or //SRS/MCU/SPEC/@Name ='SPC560B60' or //SRS/MCU/SPEC/@Name ='SPC560B64'">
									<xsl:choose> 
										<xsl:when test="//SRS/MCU/SPEC/@Package ='PACKAGE_144'">
											<EVENT Name="SPI_EVENT_0"/>
											<EVENT Name="SPI_EVENT_1"/>
											<EVENT Name="SPI_EVENT_2"/>
											<EVENT Name="SPI_EVENT_3"/>
											<EVENT Name="SPI_EVENT_4"/>
											<xsl:comment> PACKAGE_144 Setting 'SPI_EVENT_' element is fixed</xsl:comment>
										</xsl:when>
										<xsl:when test="//SRS/MCU/SPEC/@Package ='PACKAGE_176'">
											<EVENT Name="SPI_EVENT_0"/>
											<EVENT Name="SPI_EVENT_1"/>
											<EVENT Name="SPI_EVENT_2"/>
											<EVENT Name="SPI_EVENT_3"/>
											<EVENT Name="SPI_EVENT_4"/>
											<EVENT Name="SPI_EVENT_5"/>
											<xsl:comment> PACKAGE_176 Setting 'SPI_EVENT_' element is fixed</xsl:comment>
										</xsl:when>
										<xsl:otherwise>
											<EVENT Name="SPI_EVENT_0"/>
											<EVENT Name="SPI_EVENT_1"/>
											<EVENT Name="SPI_EVENT_2"/>
											<xsl:comment> PACKAGE_100 Setting 'SPI_EVENT_' element is fixed</xsl:comment>
										</xsl:otherwise>
									</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
									<EVENT Name="SPI_EVENT_0"/>
									<EVENT Name="SPI_EVENT_1"/>
									<EVENT Name="SPI_EVENT_2"/>
									<xsl:comment> 'SPI_EVENT_' element is fixed</xsl:comment>
							</xsl:otherwise>
						</xsl:choose>
				</xsl:element>
				<xsl:element name = "EVENT_CLIENTS">
					<xsl:if test="//SRS/MEM/EEPROM/DEVICE/@Internal ='Yes'">
						<EVENT_CLIENT EventNameReference="Event_EEPROM_WR_FINISHED" Name="EEPROM_WR_FINISHED_Client" NotificationFunction="bscomeep_MainFunction"/>
						<xsl:comment> 'Event_EEPROM_WR_FINISHED' element is fixed, when using internal EEPROM</xsl:comment>
					</xsl:if>
						<xsl:if test="//SRS/CORE/KLINE/@Usage ='Yes'"> <!-- If 'enable' value is 'Yes'  -->
							<EVENT_CLIENT EventNameReference="Event_AscCom_Slow_Timer" Name="Event_AscCom_Slow_Timer" NotificationFunction="zdtimer_On_Event_Timer_Asc_Com_Timeout" />
							<EVENT_CLIENT EventNameReference="Event_Dpkw2000_Short_Timeout" Name="Event_Dpkw2000_Short_Timeout" NotificationFunction="zdtimer_On_Event_Dpkw2000_Short_Timeout" />
							<EVENT_CLIENT EventNameReference="Event_Dpkw2000_Long_Timeout" Name="Event_Dpkw2000_Long_Timeout" NotificationFunction="zdtimer_On_Event_Dpkw2000_Long_Timeout" />
							<xsl:comment>'Event_AscCom_Slow_Timer', 'Event_Dpkw2000_Short_Timeout' and 'Event_Dpkw2000_Long_Timeout' elements are fixed for using K-Line Diagnosis</xsl:comment>
						</xsl:if> <!-- If 'enable' value is 'Yes'  -->
				</xsl:element>
				
				<xsl:element name = "CONTROLLED_RAM">
				</xsl:element>
				
			<xsl:if test="//SRS/COM/SPIS/*[@Enable ='Yes']">				  		
				<xsl:element name = "SPI">
					<xsl:for-each select="//SPI_CHANNEL_SETTING[(contains(./@SPI_Channel_name,'MC33972_')) or (contains(./@SPI_Channel_name,'ATM39_')) or (contains(./@SPI_Channel_name,'L99MC6_')) or (contains(./@SPI_Channel_name,'TLE7240SL_')) or (contains(./@SPI_Channel_name,'M93XXX')) or (contains(./@SPI_Channel_name,'25LCXXX')) or (contains(./@SPI_Channel_name,'M95XXX'))]">
						<xsl:choose> 
							<xsl:when test="contains(./@SPI_Channel_name,'M93XXX') or contains(./@SPI_Channel_name,'25LCXXX') or contains(./@SPI_Channel_name,'M95XXX')">
								<SPI_CLIENT Name="EEPROM_SPI_COMM" SequenceIndex="{@SPI_Mcal_Job_index}" JobIndex="{@SPI_Mcal_Job_index}" ChannelIndex="{@SPI_Mcal_index}"/>
							</xsl:when>
							<xsl:otherwise>
								<SPI_CLIENT Name="{@SPI_Job_name}" SequenceIndex="{@SPI_Mcal_Job_index}" JobIndex="{@SPI_Mcal_Job_index}" ChannelIndex="{@SPI_Mcal_index}"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:for-each select="//SPI_CHANNEL_SETTING[(contains(./@SPI_Channel_name,'MC33972_')) or (contains(./@SPI_Channel_name,'ATM39_')) or (contains(./@SPI_Channel_name,'L99MC6_')) or (contains(./@SPI_Channel_name,'TLE7240SL_')) or (contains(./@SPI_Channel_name,'M93XXX')) or (contains(./@SPI_Channel_name,'25LCXXX')) or (contains(./@SPI_Channel_name,'M95XXX'))]">
						<xsl:choose> 
							<xsl:when test="contains(./@SPI_Channel_name,'M93XXX') or contains(./@SPI_Channel_name,'25LCXXX') or contains(./@SPI_Channel_name,'M95XXX') ">
								<SPI_CONFIG Name="EEPROM_CONF_MC_25LC"/>
								<xsl:comment>'EEPROM_CONF_MC_25LC', elements are fixed for using Externel EEPROM</xsl:comment>
							</xsl:when>
							<xsl:otherwise>
								<SPI_CONFIG Name="{@SPI_Job_name}_CONF"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:element>			
			</xsl:if>
			
				<xsl:element name = "CODE_GENERATION">
						<TEMPLATE Name="SlowTimers_1st_pass" OutFile="zslowtimer.h" Used="true" XSLTemplate="zslowtimer_h.xsl"/>
						<TEMPLATE Name="FastTimers_1st_pass" OutFile="zfasttimer.h" Used="true" XSLTemplate="zfasttimer_h.xsl"/>
						<TEMPLATE Name="Events_1st_pass" OutFile="zevtdata.h" Used="true" XSLTemplate="zevtdata_h.xsl"/>
						<xsl:if test="//SRS/COM/SPIS/*[@Enable ='Yes']">				  		
							<TEMPLATE Name="SPI_1st_pass" OutFile="ssc_driver_api.h" Used="true" XSLTemplate="ssc_driver_api_h.xsl"/>
							<TEMPLATE Name="bscomspiC" OutFile="bscomspi_cfg.c" Used="true" XSLTemplate="bscomspi_cfg_c.xsl"/>
						</xsl:if>
				</xsl:element>								
				<xsl:element name = "CONSISTENCY_CHECKER">
				</xsl:element>								
				<xsl:element name = "DOCUMENTATION_GENERATION">
				</xsl:element>								
				<xsl:element name = "WATCHDOG_DEBUG">
		
				</xsl:element>				
		</xsl:element> 
</COMPONENT>
</xsl:template>
</xsl:stylesheet>
