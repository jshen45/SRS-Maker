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
<xsl:param name ="MC33972_Ch_count" select="//SRS/IO/MUXIN/MUXIN_MC33972/@Number_of_Chip" ></xsl:param>
<xsl:param name ="HC151_Ch_count" select="//SRS/IO/MUXIN/@HC151" ></xsl:param>


<xsl:variable name="SPI_CHANNEL_NUMBER" select="//COM/SPIS/SPI_CHANNEL_SETTING[not(./@HW_channel=preceding::SPI_CHANNEL_SETTING/@HW_channel)]"/>

<xsl:template match="/"> 
<xsl:comment>
============================================================================
                       Autron  SOFTWARE  GROUP                              
============================================================================
                        OBJECT SPECIFICATION                                
============================================================================
* source file for 1st pass Xml generation 
* %Name:                System_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
						
						
* %xsd file version 	
						
* dependency 			
* %xsl file version:    1.0.5 %
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
  1.0.1      | 16/Apr/2014 |                               | Seungwoo. Lee
  - add 'Disable_Ext_WDG_in_LPM' attribute 
  1.0.2      | 07/Jul/2014 |                               | Seungwoo. Lee  
  - add 'LVD45_RESET' element 
  - DEBUGGING_TIMER_SETTINGS/@StartTickValue change to 4194240
  - logic change for making 'SYSTEM_SETTINGS/@LIN_USE'
  1.0.3      | 04/Sep/2014 |                               | Seungwoo. Lee  
  - change logic of 'make_spi_channel' template  
  1.0.5      | 28/Nov/2014 |                               | Seungwoo. Lee  
  - for applying Delivery box 'cw48_14_a' 
  - add 'DEBUGGING_FEATURES_SETTINGS/@TaskMonitoring'  
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
System 1st pass XML Generaiton Message
==========================================================================
</xsl:message>  


<SYSTEM ID="SY{generate-id()}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="system.xsd">
		<SYSTEM_SETTINGS/>
		<xsl:element name="INTEGRATION_SETTINGS">
			
			
			<xsl:choose>
				<xsl:when test ="//SRS/COM/ASCS/*[@Enable = 'Yes']">	
						<xsl:attribute name="ASC_USE">Yes</xsl:attribute>
				</xsl:when>
				<xsl:otherwise> 
						<xsl:attribute name="ASC_USE">No</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="CAN_USE">Yes</xsl:attribute>
			
			<xsl:choose>
				<xsl:when test ="//SRS/COM/CAN/@CCP_Usage ='Yes'">	
						<xsl:attribute name="CCP_USE">Yes</xsl:attribute>
				</xsl:when>
				<xsl:otherwise> 
						<xsl:attribute name="CCP_USE">No</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<xsl:attribute name="CORE_USE">Yes</xsl:attribute>
			
			<xsl:choose>
				<xsl:when test ="//SRS/CORE/KLINE/@Usage = 'Yes'">	
						<xsl:attribute name="DIAG_KWP_USE">Yes</xsl:attribute>
				</xsl:when>
				<xsl:otherwise> 
						<xsl:attribute name="DIAG_KWP_USE">No</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test ="//SRS/CORE/UDS/@Usage = 'Yes'">	
						<xsl:attribute name="DIAG_UDS_USE">Yes</xsl:attribute>
				</xsl:when>
				<xsl:otherwise> 
						<xsl:attribute name="DIAG_UDS_USE">No</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:attribute name="EEPROM_USE">Yes</xsl:attribute>
			<xsl:attribute name="EOL_USE">Yes</xsl:attribute>
			<xsl:attribute name="IO_USE">Yes</xsl:attribute>

			<xsl:choose>
				<xsl:when test ="//SRS/COM/ASCS/*[@Usage_Mode='LIN' and @Enable = 'Yes']">	
					<xsl:choose>
					<xsl:when test ="//SRS/COM/LIN/*[@LIN_Enable='Yes' and @LIN_ASC_Channel !='']">
						<xsl:attribute name="LIN_USE">Yes</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:message  terminate ="yes">
=======================================================================================================================
'Error 		ASC Setting에서는 Lin을 사용한다고 표시되어 있으나, LIN Setting이 누락되어 있음
=======================================================================================================================</xsl:message>  												
					</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
						<xsl:attribute name="LIN_USE">No</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:choose>
				<xsl:when test ="//SRS/MEM/CHECK/@Enable = 'Yes'">	
						<xsl:attribute name="MEMCHK_USE">Yes</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
						<xsl:attribute name="MEMCHK_USE">No</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="MEM_USE">Yes</xsl:attribute>
			<xsl:attribute name="PM_USE">Yes</xsl:attribute>
			<xsl:choose>
				<xsl:when test ="//SRS/COM/SPIS/*[@Enable = 'Yes']">	
						<xsl:attribute name="SPI_USE">Yes</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
						<xsl:attribute name="SPI_USE">No</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="SRX_USE">No</xsl:attribute>
			<xsl:attribute name="VFB_USE">Yes</xsl:attribute>
		</xsl:element>	

		<IT_HANDLER_SETTINGS ID="IH{generate-id()}" VirtualVectorSize="16" VirtualVectorTableAddress="{//SRS/OS/OS_GENERAL/@Virtua_Vector_Table_Address}"/>
		<MCU_SETTINGS  MCU_Family="BOLERO"  MCU_Name="{//SRS/MCU/SPEC/@Name}" PACKAGE_INFO="{//SRS/MCU/SPEC/@Package}">
			<xsl:call-template name="make_it_handling">
				<xsl:with-param name="it_handling" select="//SRS/OS/ISR/*"/>
			</xsl:call-template> 
	
			<xsl:call-template name="make_isr">
				<xsl:with-param name="isr" select="//SRS/OS/ISR/*[@Type='USED' and @ISRName !='']"/>
			</xsl:call-template> 
		
			<DEBUGGING_TIMER_SETTINGS Debug_Features_Timer="{//SRS/OS/DEBUG/@Debuging_Calculation_Timer}" ID="DT{generate-id()}" StartTickValue="{//SRS/OS/DEBUG/@Debuging_Tick}"/>
			<OS_OSEK_TIMER_SETTINGS ID="OO{generate-id()}" Osek_Timer="{//SRS/OS/OS_GENERAL/@OS_System_Timer}" StartTickValue="{//SRS/OS/OS_GENERAL/@OSEK_Tick}"/>
			<FAST_TIMER_SETTINGS FastTimer_BaseHWTimer="{//SRS/CORE/TIMER/@Fast_timer}" ID="FT{generate-id()}"/>
			<xsl:element name="WATCHDOG_TIMER_SETTINGS">
			<xsl:choose>
				<xsl:when test="//SRS/CORE/WDG/@Disable_Ext_WDG_in_LPM = 'Yes'">
					<xsl:attribute name="Disable_Ext_WDG_in_LPM"><xsl:value-of select="//SRS/CORE/WDG/@Disable_Ext_WDG_in_LPM"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="//SRS/CORE/WDG/@Disable_Ext_WDG_in_LPM = 'No'">
					<xsl:attribute name="Disable_Ext_WDG_in_LPM"><xsl:value-of select="//SRS/CORE/WDG/@Disable_Ext_WDG_in_LPM"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="External_Watchdog"><xsl:value-of select="//SRS/CORE/WDG/@Ext_Wdg_Pin_toggleOutput"/></xsl:attribute>
			</xsl:element>

			<xsl:choose>
				<xsl:when test="//SRS/MCU/LVD_RESET/@LVD_RESET_Usage = ''">
				<xsl:message  terminate ="yes">
=======================================================================================================================

'Error 		//SRS/MCU/LVD_RESET/@LVD_RESET_Usage 값이 비어있음

=======================================================================================================================</xsl:message>  												
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="LVD_RESET">
						<xsl:attribute name="LVD45_RESET"><xsl:value-of select="//SRS/MCU/LVD_RESET/@LVD_RESET_Usage"/></xsl:attribute>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
			
		<xsl:if test="//SRS/COM/SPIS/*/@Enable ='Yes'">
			<xsl:element name="SPI_CHANNELS">
				<xsl:call-template name="make_spi_channel">
					<xsl:with-param name="spi_channel" select="$SPI_CHANNEL_NUMBER"/>
				</xsl:call-template> 
			</xsl:element>
		</xsl:if>
        </MCU_SETTINGS>
		<FAST_TIMER_SETTINGS BaseTimerResolution_Denom="{//SRS/MCU/SPEC/@Cclock}" BaseTimerResolution_Numer="1" ID="FS{generate-id()}"/>
		<xsl:element name="SYSTEM_TIME_SETTINGS">
			<xsl:attribute name="BaseTimerResolution_Denom"><xsl:value-of select="//SRS/CORE/TIMER/@system_Base_timer_Resolution_Denom_reference"/></xsl:attribute>
			<xsl:attribute name="BaseTimerResolution_Numer"><xsl:value-of select="//SRS/CORE/TIMER/@system_Base_timer_Resolution_Numer_reference"/></xsl:attribute>
			<xsl:attribute name="LowPowerTimerResolution">499</xsl:attribute>
			<xsl:choose>
				<xsl:when test="//SRS/CORE/TIMER/@System_time_usage='ENABLE'">
						<xsl:attribute name="SystemTimeEnabled">true</xsl:attribute>
				</xsl:when>
				<xsl:otherwise> 
						<xsl:attribute name="SystemTimeEnabled">false</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	
	<xsl:call-template name="make_alarm_handling">
		<xsl:with-param name="alarm_handling" select="//SRS/OS/ALARMS/*"/>
	</xsl:call-template> 
	
    <EVENT_MANAGER_SETTINGS ID="EM{generate-id()}" MaxNumberOfEventClients="{//SRS/CORE/EVENT/@MaxNumberOfEventClients}"
        MaxNumberOfEvents="{//SRS/CORE/EVENT/@MaxNumberOfEvents}" TimeLimit="300"/>
	<DEBUGGING_FEATURES_SETTINGS CPULoad="{//SRS/OS/DEBUG/@CPULoad}" ID="DF{generate-id()}" ITLoad="{//SRS/OS/DEBUG/@ITLoad}" StackDepth="{//SRS/OS/DEBUG/@StackDepth}"  TaskMonitoring="{//SRS/OS/DEBUG/@TaskMonitoring}" />

	
    <WARM_RESET_MANAGER_SETTINGS DelayBeforeCounterClear="{//SRS/CORE/WARMRESET/@DelayBeforeCounterClear}" ID="WR{generate-id()}" MaxNumberOfWarmReset="{//SRS/CORE/WARMRESET/@MaxNumberOfWarmReset}"/>
		

    <WATCHDOG_SETTINGS ID="WS{generate-id()}">
        <WATCHDOG_COUNTERS ID="WC{generate-id()}" Size_Watchdog_Counters="16"/>
        <xsl:element name="TASKS_SUPPORTING_WATCHDOG">		<!--TASKS_SUPPORTING_WATCHDOG-->
			<xsl:attribute name="ID">TS<xsl:value-of select="generate-id()"/></xsl:attribute>
			<xsl:for-each select ="//SRS/CORE/IWDG/MONITORED_TASK">
				<xsl:element name="SUPPORTING_TASK_LONG">
					<xsl:attribute name="Name"><xsl:value-of select="@Name"/></xsl:attribute>
					<xsl:attribute name="MaskValue"><xsl:value-of select="@Min_Value"/></xsl:attribute>
					<xsl:attribute name="CheckValue"><xsl:value-of select="@Max_Value"/></xsl:attribute>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
    </WATCHDOG_SETTINGS>

    
	<xsl:element name="REGISTER_MONITORING_SETTINGS">		<!--SYSTEM_REGISTERS TASKS -->
		<xsl:attribute name="ID">RM<xsl:value-of select="generate-id()"/></xsl:attribute>
		<xsl:element name="SYSTEM_REGISTERS">		
			<xsl:attribute name="ID">SR<xsl:value-of select="generate-id()"/></xsl:attribute>
			<xsl:for-each select ="//SRS/CORE/REGMONITOR/SYSTEM_REG">
				<xsl:element name="SYSTEM_REGISTER">
					<xsl:attribute name="Name"><xsl:value-of select="@Name"/></xsl:attribute>
					<xsl:attribute name="MaskValue"><xsl:value-of select="@Mask_Value"/></xsl:attribute>
					<xsl:attribute name="CheckValue"><xsl:value-of select="@Check_Value"/></xsl:attribute>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
		<xsl:element name="IO_REGISTERS">		<!--IO_REGISTERS TASKS -->
			<xsl:attribute name="ID">IR<xsl:value-of select="generate-id()"/></xsl:attribute>
			<xsl:for-each select ="//SRS/CORE/REGMONITOR/IO_REG">
				<xsl:element name="IO_REGISTER">
					<xsl:attribute name="Name"><xsl:value-of select="@Name"/></xsl:attribute>
					<xsl:attribute name="MaskValue"><xsl:value-of select="@Mask_Value"/></xsl:attribute>
					<xsl:attribute name="CheckValue"><xsl:value-of select="@Check_Value"/></xsl:attribute>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
    </xsl:element>
	<xsl:if test= "//SRS/CORE/RANDOM/@Enable ='ENABLE'">
		<xsl:element name="RANDOM_SETTINGS">		<!--RANDOM_SETTINGS -->
			<xsl:attribute name="History_Init">3</xsl:attribute>
			<xsl:attribute name="History_Size">6</xsl:attribute>
			<xsl:attribute name="Right_Rotation_1">5</xsl:attribute>
			<xsl:attribute name="Right_Rotation_2">3</xsl:attribute>
		</xsl:element>
	<xsl:comment>'RANDOM_SETTINGS' is set by default value. it is according to SIMTP document. </xsl:comment>
	</xsl:if>
    <CODE_GENERATION ID="ID000036">
		<TEMPLATE Name="zdrstmanH" OutFile="zdrstman.h" Used="true" XSLTemplate="zdrstman_h.xsl"/>
        <TEMPLATE Name="zdrandomH" OutFile="zdrandom.h" Used="true" XSLTemplate="zdrandom_h.xsl"/>
        <TEMPLATE Name="wdog_dataH" OutFile="wdog_data.h" Used="true" XSLTemplate="wdog_data_h.xsl"/>
        <TEMPLATE Name="wdog_dataC" OutFile="wdog_data.c" Used="true" XSLTemplate="wdog_data_c.xsl"/>
        <TEMPLATE Name="zevtmanH" OutFile="zevtman.h" Used="true" XSLTemplate="zevtman_h.xsl"/>
        <TEMPLATE Name="zisrmanagC" OutFile="zisrmanag.c" Used="true" XSLTemplate="zisrmanag_c.xsl"/>
        <TEMPLATE Name="zfalarmC" OutFile="zfalarms.c" Used="true" XSLTemplate="zfalarms_c.xsl"/>
        <TEMPLATE Name="zfalarmH" OutFile="zfalarms.h" Used="true" XSLTemplate="zfalarms_h.xsl"/>
        <TEMPLATE Name="zhsysdefH" OutFile="zhsysdef.h" Used="false" XSLTemplate="zhsysdef_h.xsl"/>
        <TEMPLATE Name="zhwvectH" OutFile="zhwvect.h" Used="true" XSLTemplate="zhwvect_h.xsl"/>
        <TEMPLATE Name="zvirvectH" OutFile="zvirvect.h" Used="true" XSLTemplate="zvirvect_h.xsl"/>
        <TEMPLATE Name="zdwdtH" OutFile="zdwdt.h" Used="true" XSLTemplate="zdwdt_h.xsl"/>
        <TEMPLATE Name="zdsecuriC" OutFile="zdsecuri.c" Used="true" XSLTemplate="zdsecuri_c.xsl"/>
    </CODE_GENERATION>
    <CONSISTENCY_CHECKER ID="ID0024">
        <TEMPLATE Name="CC_SPI" OutFile="CC_SPI.xml" Used="true" XSLTemplate="CC_SPI.xsl"/>
		<TEMPLATE Name="CC_SYSTEM" OutFile="CC_SYSTEM.xml" Used="true" XSLTemplate="CC_SYSTEM.xsl"/>
		<TEMPLATE Name="CC_OS_1stpass_Generic" OutFile="CC_OS_1stpass_Generic.xml" Used="true" XSLTemplate="CC_OS_1stpass_Generic.xsl"/>
    </CONSISTENCY_CHECKER>
    <DOCUMENTATION_GENERATION ID="ID0025"/>	
</SYSTEM>
</xsl:template>


<xsl:template name= "make_it_handling">  <!-- it_handling 생성을 위한 템플릿 -->
<xsl:param name="it_handling"/>
			<IT_HANDLING>
				<xsl:for-each select="$it_handling">
					<xsl:element name="{name(.)}">
						<xsl:attribute name="ID">IT<xsl:value-of select="generate-id()"/></xsl:attribute>
						<xsl:choose>
							<xsl:when test="@Vector_No=''">
								<xsl:message  terminate ="yes">'Vector_No is not defined. plz check -<xsl:value-of select="name(.)"/>- Interrupt </xsl:message>  
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="Vector_No"><xsl:value-of select="@Vector_No"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="@Type='UNUSED'">
								<xsl:element name="NOT_USED">
									<xsl:attribute name="ID">UN<xsl:value-of select="generate-id()"/></xsl:attribute>
									<xsl:message  terminate ="no">'Interrupt <xsl:value-of select="name(.)"/> is NOT_USED</xsl:message>  
								</xsl:element>
							</xsl:when>
							<xsl:when test="@Type='USED'">
								<xsl:element name="USED">
										<xsl:attribute name="ID">US<xsl:value-of select="generate-id()"/></xsl:attribute>
										<xsl:message  terminate ="no">'Interrupt <xsl:value-of select="name(.)"/> is USED</xsl:message>  
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<xsl:message  terminate ="yes">'Type is not defined. plz check -<xsl:value-of select="name(.)"/>- Interrupt </xsl:message>  
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
				</xsl:for-each>
        </IT_HANDLING>
</xsl:template>


<xsl:template name= "make_alarm_handling">  <!-- alarm_handling 생성을 위한 템플릿 -->
<xsl:param name="alarm_handling"/>
		<xsl:element name="ALARM_HANDLING">
			<xsl:attribute name="ID"><xsl:value-of select="generate-id()"/></xsl:attribute>
			<xsl:choose>
						<xsl:when test="//SRS/CORE/TIMER/@System_time_usage=''"> <!-- system time에 입력된 값이 없으면 오류 출력 -->
							<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/CORE/TIMER/@System에 system time의 사용여부에 대한 값이 없음			
                (LowPower의 Task 주기에 영향을 미칠수 있음)
=======================================================================================================================</xsl:message>  
						</xsl:when>
						<xsl:when test="//SRS/CORE/TIMER/@System_time_usage ='ENABLE'"> <!-- system time  사용시-->
							<xsl:element name="RELATIVE_ALARM">
								<xsl:attribute name="ID"><xsl:value-of select="generate-id()"/></xsl:attribute>
								<xsl:attribute name="Cycle">2</xsl:attribute>
								<xsl:attribute name="Name">Alarm_SWP_SystemTime</xsl:attribute>
								<xsl:attribute name="Offset">1</xsl:attribute>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise>
						</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each select="$alarm_handling">
					<xsl:message  terminate ="no">'alarm_handling <xsl:value-of select="name(.)"/> alarm_handling position'= <xsl:value-of select="position()-1"/></xsl:message>  
							<xsl:element name="RELATIVE_ALARM">
								<xsl:attribute name="ID"><xsl:value-of select="generate-id()"/></xsl:attribute>
								<xsl:attribute name="Cycle"><xsl:value-of select="@Cycle"/></xsl:attribute>
								<xsl:attribute name="Name"><xsl:value-of select="@Name"/></xsl:attribute>
								<xsl:attribute name="Offset"><xsl:value-of select="@Offset"/></xsl:attribute>
							</xsl:element>
			</xsl:for-each>
		</xsl:element>
</xsl:template>


<xsl:template name= "make_isr">  <!-- isr 생성을 위한 템플릿 -->
<xsl:param name="isr"/>
		<xsl:element name="ISRs">
			<xsl:attribute name="ID">I<xsl:value-of select="generate-id()"/></xsl:attribute>
				<xsl:for-each select="$isr">
					<xsl:element name="ISR">
						<xsl:attribute name="ID">ISR<xsl:value-of select="generate-id()"/></xsl:attribute>
						<xsl:attribute name="FunctionName"><xsl:value-of select="@ISRName"/></xsl:attribute>
						<xsl:attribute name="Name"><xsl:value-of select="name(.)"/></xsl:attribute>
					</xsl:element>
				</xsl:for-each>
		</xsl:element>
</xsl:template>


<xsl:template name= "make_spi_channel">  <!-- SPI 채널 설정 위한 템플릿-->
	<xsl:param name="spi_channel"/>
				<xsl:for-each select="$spi_channel">
					<xsl:element name="SPI_CHANNEL">
							<xsl:attribute name="Name"><xsl:value-of select="@HW_channel"/></xsl:attribute>
								<xsl:call-template name="make_spi_client">
									<xsl:with-param name="channel_num" select="@HW_channel"/>
								</xsl:call-template>
					</xsl:element>
				</xsl:for-each>
</xsl:template>

<xsl:template name= "make_spi_client">  <!-- 각 해당 SPI 채널에 Ref client 설정하기 위한 템플릿-->
	<xsl:param name="channel_num"/>
					<xsl:for-each select="//SPI_CHANNEL_SETTING[(contains(./@SPI_Channel_name,'MC33972')) or (contains(./@SPI_Channel_name,'ATM39')) or (contains(./@SPI_Channel_name,'L99MC6')) or (contains(./@SPI_Channel_name,'TLE7240SL')) or (contains(./@SPI_Channel_name,'M93XXX')) or (contains(./@SPI_Channel_name,'25LCXXX')) or (contains(./@SPI_Channel_name,'M95XXX'))]">
						<xsl:choose> 
							<xsl:when test="contains(./@SPI_Channel_name,'M93XXX') or contains(./@SPI_Channel_name,'25LCXXX') or contains(./@SPI_Channel_name,'M95XXX')">
								<xsl:if test = "@HW_channel =$channel_num">
										<xsl:element name="REF_SPI_CLIENT">
											<xsl:attribute name="UserName">EEPROM_SPI_COMM</xsl:attribute>
										</xsl:element>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test = "@HW_channel =$channel_num">
										<xsl:element name="REF_SPI_CLIENT">
											<xsl:attribute name="UserName">
												<xsl:value-of select="@SPI_Job_name"/>
											</xsl:attribute>
										</xsl:element>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
</xsl:template>


</xsl:stylesheet>