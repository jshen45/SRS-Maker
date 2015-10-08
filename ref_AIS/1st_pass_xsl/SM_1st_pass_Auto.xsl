<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xalan="http://xml.apache.org/xalan" 
                xmlns:math="java.lang.Math" 
                xmlns:date="java.util.Date"                
                xmlns:vector="java.util.Vector"                
                extension-element-prefixes="date vector math">
<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<xsl:template match="/"> 
<xsl:comment>
============================================================================
                       Autron  SOFTWARE  GROUP                              
============================================================================
                        OBJECT SPECIFICATION                                
============================================================================
* source file for 1st pass Xml generation 
* %name:                SM_1st_pass_Auto.xsl%
* %MCU:                	SPC560B %
* %version of module which include xsd file : 
						
* %xsd file version 							
* dependency 			None
* %xsl file version:    1.0.6 %
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
  1.0.0      | 27/Jan/2014 |                               | Seungwoo. Lee
  - Init version
  1.0.1      | 27/Jan/2014 |                               | Seungwoo. Lee
  - generation logic Change 'GOTO_NORMAL_MODE_MC33972'
  - generation logic Change 'GOTO_SLEEP_MODE_MC33972'
  1.0.2      | 16/May/2014 |                               | Seungwoo. Lee
  - condition change for making value of '@CHECK_IGN_SUPPLY_VOLTAGE'
  1.0.3      | 16/May/2014 |                               | Seungwoo. Lee  
  - remove 'vector_can_check_c' template (according to CAN module update)
  1.0.4      | 29/Dec/2014 |                               | Seungwoo. Lee  
  - add condition for 'CHECK_IGN_SUPPLY_VOLTAGE' attribute 
  - add error handle for 'TRANSITION_CALLBACK' associate with 'MC33972'
  - add error handle for @NM, @TP attribute each CAN Channel
  - add error handle for 'NUMBER_OF_CONTROL_PINS' each CAN Channel
  - change name of 'TRCV_CTRL_IO_PER_CHANNEL' element from 'ch' to 'LOGICAL_INDEX_'
  - change name of 'CAN_INTERFACE_INTEGRATION/CAN_CHANNEL' element from '' to 'LOGICAL_INDEX_'
  1.0.5      | 08/Jan/2015 |                               | Seungwoo. Lee    
  - fix XSL grammar error
  1.0.6      | 22/Apr/2015 |                               | Seungwoo. Lee    
  - add attribute 'SUPPORT_INDIVIDUAL_INITIALIZATION_API' with default value 'NO' under 'MAIN_OPTIONS'
  - add attribute 'VOLTAGE_DELAY' with default value '180' under 'MAIN_OPTIONS'
  - change order of attributes under 'MAIN_OPTIONS'
 ===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
Station Manager 1st pass XML Generaiton Message
==========================================================================
</xsl:message>  

<STATION_MANAGER_1ST xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="sm_1st_cfg.xsd">
<!--=============================================================================================================================================-->
	<xsl:element name ="MAIN_OPTIONS">
		<xsl:attribute 	name="CHECK_IGN_SUPPLY_VOLTAGE">
		<xsl:choose>
				<xsl:when test="//IO/BATMON/@Enable='Yes'">
					<xsl:choose>
						<xsl:when test="//SRS/IO/BATMON/@Enable_Ignmon='Yes' and //SRS/IO/BATMON/@Ignmon !='' and //SRS/IO/BATMON/@Ignmon !='NA'">YES</xsl:when>
						<xsl:otherwise>NO</xsl:otherwise>
					</xsl:choose>
					<xsl:message  terminate ="no">  	
						'CHECK_IGN_SUPPLY_VOLTAGE' = <xsl:value-of select="//IO/BATMON/@Ignmon"  disable-output-escaping = "yes"/> 
					</xsl:message>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>NO</xsl:text>
				</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
		<xsl:attribute 	name="CHECK_SUPPLY_VOLTAGE">
				<xsl:choose>
					<xsl:when test="//IO/BATMON/@Enable='Yes'">YES</xsl:when>
					<xsl:when test="//IO/BATMON/@Enable=''">
						<xsl:message  terminate ="yes">  	
=======================================================================================================================			
'Error			//IO/BATMON/@Enable 에 잘못된 값 입력됨
=======================================================================================================================			
						</xsl:message>
					</xsl:when>
					<xsl:otherwise>NO</xsl:otherwise>
				</xsl:choose>
				<xsl:message  terminate ="no">  	
				 	'CHECK_SUPPLY_VOLTAGE' = <xsl:value-of select="//IO/BATMON/@Enable"  disable-output-escaping = "yes"/> 
				 </xsl:message>
		</xsl:attribute>
		<xsl:attribute 	name = "NETWORK_ACTIVATION_DELAY" >100</xsl:attribute>
		<xsl:choose>
			<xsl:when test="//SRS/COM/CAN/@IL_control_APIs_option='Yes' or //SRS/CORE/UDS/@Usage ='Yes' ">
				<xsl:attribute name = "SUPPORT_IL_CONTROL_API" >YES</xsl:attribute> 
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name = "SUPPORT_IL_CONTROL_API" >NO</xsl:attribute> 
			</xsl:otherwise>
		</xsl:choose>
		<xsl:attribute 	name = "SUPPORT_INDIVIDUAL_INITIALIZATION_API" >NO</xsl:attribute>
		<xsl:choose>
			<xsl:when test="//SRS/COM/CAN/@IL_control_APIs_option='Yes' or //SRS/CORE/UDS/@Usage ='Yes' ">
				<xsl:attribute name = "SUPPORT_NM_CONTROL_API" >YES</xsl:attribute> 
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name = "SUPPORT_NM_CONTROL_API" >NO</xsl:attribute> 
			</xsl:otherwise>
		</xsl:choose>
		<xsl:attribute 	name = "TIMEOUT_START_DELAY" >1000</xsl:attribute>
		<xsl:attribute 	name = "VOLTAGE_DELAY" >180</xsl:attribute>
	</xsl:element>
<!--=============================================================================================================================================-->	
	<xsl:element name ="TRANSITION_CALLBACKS">
			<xsl:element name ="SLEEP_TO_NORMAL">
				<xsl:for-each select="//SRS/COM/CAN/CHANNELS/*">
					<xsl:if test="//SRS/IO/MUXIN/MUXIN_MC33972/@Number_of_Chip !='0' and position() = '1' and //SRS/IO/MUXIN/MUXIN_MC33972/@Linked_CAN_Channel != 'No' ">
					<xsl:element name ="TRANSITION_CALLBACK">
						<xsl:choose>
								<xsl:when test="//SRS/IO/MUXIN/MUXIN_MC33972/@Linked_CAN_Channel = ''">
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/IO/MUXIN/MUXIN_MC33972/@Linked_CAN_Channel 에 잘못된 값 입력됨
=======================================================================================================================</xsl:message>  
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute 	name ="Channel"><xsl:value-of select="//SRS/IO/MUXIN/MUXIN_MC33972/@Linked_CAN_Channel"/></xsl:attribute>
									<xsl:attribute 	name ="Name">GOTO_NORMAL_MODE_MC33972</xsl:attribute>
								</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
					</xsl:if>
					<!--
					<xsl:element name ="TRANSITION_CALLBACK">
						<xsl:attribute 	name ="Channel"><xsl:value-of select="@Index"/></xsl:attribute>
						<xsl:attribute 	name ="Name">CanTrcv_Sleep_To_Normal_<xsl:value-of select="@Index"/></xsl:attribute>
					</xsl:element>
					-->
				</xsl:for-each>
			</xsl:element>
			<xsl:element name ="NORMAL_TO_SLEEP">
				<xsl:for-each select="//SRS/COM/CAN/CHANNELS/*">
					<xsl:if test="//SRS/IO/MUXIN/MUXIN_MC33972/@Number_of_Chip !='0' and position() = '1' and //SRS/IO/MUXIN/MUXIN_MC33972/@Linked_CAN_Channel != 'No' ">
					<xsl:element name ="TRANSITION_CALLBACK">
						<xsl:choose>
								<xsl:when test="//SRS/IO/MUXIN/MUXIN_MC33972/@Linked_CAN_Channel = ''">
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/IO/MUXIN/MUXIN_MC33972/@Linked_CAN_Channel 에 잘못된 값 입력됨
=======================================================================================================================</xsl:message>  
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute 	name ="Channel"><xsl:value-of select="//SRS/IO/MUXIN/MUXIN_MC33972/@Linked_CAN_Channel"/></xsl:attribute>
									<xsl:attribute 	name ="Name">GOTO_SLEEP_MODE_MC33972</xsl:attribute>
								</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
					</xsl:if>
					<!--
					<xsl:element name ="TRANSITION_CALLBACK">
						<xsl:attribute 	name ="Channel"><xsl:value-of select="@Index"/></xsl:attribute>
						<xsl:attribute 	name ="Name">CanTrcv_Normal_To_Sleep_<xsl:value-of select="@Index"/></xsl:attribute>
					</xsl:element>
					-->
				</xsl:for-each>
			</xsl:element>
	</xsl:element>

	<xsl:element name ="CAN_INTERFACE_INTEGRATION"  >
		<xsl:attribute 	name = "CAN_IF_CYCLE_TIME" >10</xsl:attribute>
		<xsl:attribute 	name = "ECU_HEADER_NAME" ><xsl:value-of select="//SRS/MCU/SPEC/@ecu"  disable-output-escaping = "yes"/>.h</xsl:attribute>
		<xsl:for-each select="//SRS/COM/CAN/CHANNELS/*">
				<!-- <xsl:element name ="{name(.)}">	-->
				<xsl:element name ="CAN_CHANNEL">
					<xsl:attribute 	name ="Name">LOGICAL_INDEX_<xsl:value-of select="@Index"/></xsl:attribute>
					<xsl:attribute 	name ="CHANNEL_INDEX"><xsl:value-of select="@Index"/></xsl:attribute>
					<xsl:attribute 	name ="DRV_IL_USED">YES</xsl:attribute>
					<xsl:choose>
							<xsl:when test="@NM='PT_BASIC'">
								<xsl:attribute 	name ="NM_TYPE">NM_BASIC</xsl:attribute>
							</xsl:when>
							<xsl:when test="@NM='OSEK_DIR'">
								<xsl:attribute 	name ="NM_TYPE">NM_OSEK_D</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//CAN_CHANNEL/@NM 에 잘못된 값 입력됨
=======================================================================================================================</xsl:message>  
							</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
							<xsl:when test="@TP='Yes'">
								<xsl:attribute 	name ="TP_USED">YES</xsl:attribute>
							</xsl:when>
							<xsl:when test="@TP='No'">
								<xsl:attribute 	name ="TP_USED">NO</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//CAN_CHANNEL/@TP 에 잘못된 값 입력됨
=======================================================================================================================</xsl:message>  							
							</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
		</xsl:for-each>
		<xsl:comment> 'DRV_IL_USED' value set by legacy value</xsl:comment>
		<xsl:comment> 'CAN_IF_CYCLE_TIME' value set by legacy value</xsl:comment>
	</xsl:element>
<!--=============================================================================================================================================-->	
	<xsl:element name ="INCLUDE_OSEK_API_HEADER">
			<xsl:element name = "OSEK_API">
				<xsl:attribute 	name ="Name">Os.h</xsl:attribute>
			</xsl:element>
			<xsl:comment> 'INCLUDE_OSEK_API_HEADER' value set by legacy value</xsl:comment>	
	</xsl:element>
<!--=============================================================================================================================================-->	
	<xsl:element name ="TRCV_CTRL_IO_SETTINGS">
			<xsl:for-each select="//SRS/COM/CAN/CHANNELS/*">
					<xsl:element name = "TRCV_CTRL_IO_PER_CHANNEL">
						<xsl:attribute 	name ="Name">LOGICAL_INDEX_<xsl:value-of select="@Index"/></xsl:attribute>
						<xsl:choose>
							<xsl:when test="@CAN_Tranciver_Control='NONE'">
								<xsl:attribute 	name ="NUMBER_OF_CONTROL_PINS">NONE</xsl:attribute>
							</xsl:when>
							<xsl:when test="@CAN_Tranciver_Control='1PinControl'"> 
								<xsl:attribute 	name ="NUMBER_OF_CONTROL_PINS">ONE_PIN</xsl:attribute>
							</xsl:when>
							<xsl:when test="@CAN_Tranciver_Control='2PinControl'">
								<xsl:attribute 	name ="NUMBER_OF_CONTROL_PINS">TWO_PIN</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//CAN_CHANNEL/@CAN_Tranciver_Control 에 잘못된 값 입력됨
=======================================================================================================================</xsl:message>  							
							</xsl:otherwise>
						</xsl:choose>
						<xsl:attribute 	name ="STANDBY_PIN_ACTIVE_LEVEL"><xsl:value-of select="@standby_pin_active"/></xsl:attribute>
						<xsl:attribute 	name ="ENABLE_PIN_ACTIVE_LEVEL"><xsl:value-of select="@Enable_pin_active"/></xsl:attribute>
					</xsl:element>
			</xsl:for-each>
	</xsl:element>
<!--=============================================================================================================================================-->	
	<xsl:element name ="CODE_GENERATION">
		<xsl:comment> fixed part</xsl:comment>	
		<TEMPLATE Name="sm_1st_cfg_c" OutFile="sm_1st_cfg.c" Used="true" XSLTemplate="sm_1st_cfg_c.xsl"/>
        <TEMPLATE Name="sm_1st_cfg_h" OutFile="sm_1st_cfg.h" Used="true" XSLTemplate="sm_1st_cfg_h.xsl"/>
        <TEMPLATE Name="il_inc_h" OutFile="il_inc.h" Used="true" XSLTemplate="il_inc_h.xsl"/>
        <TEMPLATE Name="can_inc_h" OutFile="can_inc.h" Used="true" XSLTemplate="can_inc_h.xsl"/>
	</xsl:element>
<!--=============================================================================================================================================-->	
	<CONSISTENCY_CHECKER>
        <TEMPLATE Name="CC_sm_1stpass_Generic"
            OutFile="CC_sm_1stpass_Generic.xml" Used="true" XSLTemplate="CC_sm_1stpass_Generic.xsl"/>
    </CONSISTENCY_CHECKER>
<!--=============================================================================================================================================-->
	<xsl:element name ="DOCUMENTATION_GENERATION"  >
	</xsl:element>
<!--=============================================================================================================================================-->
</STATION_MANAGER_1ST>
</xsl:template>
</xsl:stylesheet>