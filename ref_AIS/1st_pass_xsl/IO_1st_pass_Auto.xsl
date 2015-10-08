<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xalan="http://xml.apache.org/xalan" 
                xmlns:math="java.lang.Math" 
                xmlns:date="java.util.Date"                
                xmlns:vector="java.util.Vector"                
                extension-element-prefixes="date vector math">
<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<xsl:param name ="ATM39_Ch_count" select="count(//ATM39)" ></xsl:param>
<xsl:param name ="L99MC6_Ch_count" select="count(//L99MC6)" ></xsl:param>
<xsl:param name ="MC33972_Ch_count" select="count(//MC33972)" ></xsl:param>
<xsl:param name ="HC151_Ch_count" select="count(//HC151)" ></xsl:param>




<xsl:template match="/"> 
<xsl:variable name="MAIN_TIMER_Resources" select="//MANIN_TIMER_EMIOS[not(./@Timer_Resource=preceding::MANIN_TIMER_EMIOS/@Timer_Resource)]"/>


<xsl:comment>
============================================================================
                       Autron  SOFTWARE  GROUP                              
============================================================================
                        OBJECT SPECIFICATION                                
============================================================================
* source file for 1st pass Xml generation 
* %Name:                IO_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
						
* %xsd file version 	1.io_1st_pass_generic.xsd
						2.io_generic_schema.xsd
						3.io_1st_pass_standard_hal.xsd
						4.io_1st_pass_timers_hal.xsd
						
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
  1.0.0      | 14/Jan/2014 |                               | Seungwoo. Lee
  - Init version
  1.0.1      | 16/May/2014 |                               | Seungwoo. Lee
  - condition change for making 'VOLTAGE_MONITORING/@IGN_MONITORING_Enable'
  1.0.2      | 07/Jul/2014 |                               | Seungwoo. Lee
  - 'ADC_SETTINGS' change 
  - 'AnalogInputPeriodicUpdate' is set by '//SRS/IO/GENERAL/@Analog_periodic_update_support'
  1.0.3      | 31/Dec/2014 |                               | Seungwoo. Lee  
  - add condition '//SRS/IO/BATMON/@Enable='Yes'' for making value of 'IGN_MONITORING_Enable' 
  1.0.4      | 28/Jan/2015 |                               | Seungwoo. Lee  
  - make PORT 'I' Group and 'J' Group for 176pin Case
  1.0.5      | 03/Jun/2015 |                               | Seungwoo. Lee    
  - ADC_1 setting will be made only if ADC_1 Channel attribute is exist(it's according to Excel control)
  1.0.6      | 13/Jul/2015 |                               | Seungwoo. Lee      
  - error fix for reference attribute name from @Mode -> @Init_Mode
    these attribute under 'INPUT_SUPPLY_SWITCH' element
    (DigitalSupplySwitch1InitMode, DigitalSupp2ySwitch1InitMode, DigitalSupplySwitch3InitMode)
  - add error message for missing value of @Init_Mode attribute
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
IO 1st pass XML Generaiton Message
==========================================================================
</xsl:message>  


<IO Name="IO_1st_pass" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="io_1st_pass_generic.xsd">
	    <IO_GENERAL_CONFIG AnalogInputs="{//SRS/IO/GENERAL/@AnalogInputs}" DigitalInputs="{//SRS/IO/GENERAL/@DigitalInputs}" DigitalOutputs="{//SRS/IO/GENERAL/@DigitalOutputs}" FastDigitalInputs="{//SRS/IO/GENERAL/@FastDigitalInputs}" IO_LPFlagSet="Yes" MCAL_Version="{//SRS/IO/GENERAL/@MCAL_Version}" MultipleActivationDelay="{//SRS/IO/GENERAL/@MultipleActivationDelay}" VirtualInputs="{//SRS/IO/GENERAL/@VirtualInputs}">
		
		<xsl:call-template name="make_input_supply_switch">
		</xsl:call-template>
		
		<xsl:element name="VOLTAGE_MONITORING">
				<xsl:attribute name="Enable"><xsl:value-of select="//SRS/IO/BATMON/@Enable"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="//SRS/IO/BATMON/@Enable='Yes' and //SRS/IO/BATMON/@Enable_Ignmon='Yes' and //SRS/IO/BATMON/@Ignmon !='' and //SRS/IO/BATMON/@Ignmon !='NA'">
						<xsl:attribute name="IGN_MONITORING_Enable">Yes</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="IGN_MONITORING_Enable">No</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:element>
		
		<xsl:element name="ADC_SETTINGS">
			<!-- =====================ADC 0 Setting =========================-->
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC0_Enable='Yes'"><xsl:attribute name="ADC0">USED</xsl:attribute></xsl:when>
				<xsl:otherwise><xsl:attribute name="ADC0">NOT_USED</xsl:attribute></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC0_INPCMP=''">
					<xsl:attribute name="ADC0_HP_ComparisonTime">2</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ADC0_HP_ComparisonTime"><xsl:value-of select="//SRS/IO/ADC/@ADC0_INPCMP"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC0_INPSAMP=''">
					<xsl:attribute name="ADC0_HP_SamplingTime">17</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ADC0_HP_SamplingTime"><xsl:value-of select="//SRS/IO/ADC/@ADC0_INPSAMP"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC0_LPMODE_INPCMP=''">
					<xsl:attribute name="ADC0_LP_ComparisonTime">1</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ADC0_LP_ComparisonTime"><xsl:value-of select="//SRS/IO/ADC/@ADC0_LPMODE_INPCMP"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC0_LPMODE_Direct_CLock_Used=''">
					<xsl:attribute name="ADC0_LP_DirectClkUsed">No</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ADC0_LP_DirectClkUsed"><xsl:value-of select="//SRS/IO/ADC/@ADC0_LPMODE_Direct_CLock_Used"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC0_LPMODE_INPSAMP=''">
					<xsl:attribute name="ADC0_LP_SamplingTime">5</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ADC0_LP_SamplingTime"><xsl:value-of select="//SRS/IO/ADC/@ADC0_LPMODE_INPSAMP"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<!-- =====================ADC 0 Setting =========================-->
			<!-- =====================ADC 1 Setting =========================-->
		<xsl:if test="count(//SRS/IO/ADC/@ADC1_Enable)='1'">  <!-- It means that ADC 1 is exist -->
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC1_Enable='Yes'"><xsl:attribute name="ADC1">USED</xsl:attribute></xsl:when>
				<xsl:otherwise><xsl:attribute name="ADC1">NOT_USED</xsl:attribute></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC1_INPCMP=''">
					<xsl:attribute name="ADC1_HP_ComparisonTime">0</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ADC1_HP_ComparisonTime"><xsl:value-of select="//SRS/IO/ADC/@ADC1_INPCMP"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC1_INPSAMP=''">
					<xsl:attribute name="ADC1_HP_SamplingTime">17</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ADC1_HP_SamplingTime"><xsl:value-of select="//SRS/IO/ADC/@ADC1_INPSAMP"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC1_LPMODE_INPCMP=''">
					<xsl:attribute name="ADC1_LP_ComparisonTime">1</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ADC1_LP_ComparisonTime"><xsl:value-of select="//SRS/IO/ADC/@ADC1_LPMODE_INPCMP"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC1_LPMODE_Direct_CLock_Used=''">
					<xsl:attribute name="ADC1_LP_DirectClkUsed">No</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ADC1_LP_DirectClkUsed"><xsl:value-of select="//SRS/IO/ADC/@ADC1_LPMODE_Direct_CLock_Used"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//SRS/IO/ADC/@ADC1_LPMODE_INPSAMP=''">
					<xsl:attribute name="ADC1_LP_SamplingTime">8</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ADC1_LP_SamplingTime"><xsl:value-of select="//SRS/IO/ADC/@ADC1_LPMODE_INPSAMP"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>  <!-- It means that ADC 1 is exist -->
			<!-- =====================ADC 1 Setting =========================-->
		</xsl:element>
		
		
		<xsl:element name="MUX_HC151_SETTINGS">
			<xsl:choose>
				<xsl:when test="//SRS/IO/MUXIN/MUXIN_HC151/@Number_of_Chip ='' or //SRS/IO/MUXIN/MUXIN_HC151/@Number_of_Chip ='0'">
					<xsl:attribute name="Enable">No</xsl:attribute>
					<xsl:attribute name="NumberOfUsedMux">0</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="Enable">Yes</xsl:attribute>
					<xsl:attribute name="NumberOfUsedMux"><xsl:value-of select="//SRS/IO/MUXIN/MUXIN_HC151/@Number_of_Chip"/>
				</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="StabilisationDelay">100</xsl:attribute>
		</xsl:element>
		
		<xsl:element name="MUX_MC33972_SETTINGS">
			<xsl:choose>
				<xsl:when test="//SRS/IO/MUXIN/MUXIN_MC33972/@Number_of_Chip='0' or //SRS/IO/MUXIN/MUXIN_MC33972/@Number_of_Chip=''">
						<xsl:attribute name="Enable">No</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>	
						<xsl:attribute name="Enable">Yes</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
						<xsl:attribute name="CS_Control">Manual</xsl:attribute>
						<xsl:attribute name="NumberOfUsedMux"><xsl:value-of select="//SRS/IO/MUXIN/MUXIN_MC33972/@Number_of_Chip"/> </xsl:attribute>
		</xsl:element>
		<xsl:element name="DEMUX_ATM39_SETTINGS">
			<xsl:choose>
				<xsl:when test="//SRS/IO/MUXOUT/MUXOUT_ATM39/@Number_of_Chip='0'">
						<xsl:attribute name="Enable">No</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>	
						<xsl:attribute name="Enable">Yes</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
						<xsl:attribute name="CS_Control">Manual</xsl:attribute>
						<xsl:attribute name="DIAG_USED">No</xsl:attribute>
						<xsl:attribute name="NumberOfUsedDemux"><xsl:value-of select="//SRS/IO/MUXOUT/MUXOUT_ATM39/@Number_of_Chip"/> </xsl:attribute>
		</xsl:element>
		<xsl:element name="DEMUX_L99MC6_SETTINGS">
			<xsl:choose>
				<xsl:when test="//SRS/IO/MUXOUT/MUXOUT_L99MC6/@Number_of_Chip='0'">
						<xsl:attribute name="Enable">No</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>	
						<xsl:attribute name="Enable">Yes</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
						<xsl:attribute name="CS_Control">Manual</xsl:attribute>
						<xsl:attribute name="NumberOfUsedDemux"><xsl:value-of select="//SRS/IO/MUXOUT/MUXOUT_L99MC6/@Number_of_Chip"/></xsl:attribute>
		</xsl:element>
		<xsl:element name="DEMUX_TLE7240SL_SETTINGS">
			<xsl:choose>
				<xsl:when test="//SRS/IO/MUXOUT/MUXOUT_TLE7240SL/@Number_of_Chip='0' or //SRS/IO/MUXOUT/MUXOUT_TLE7240SL/@Number_of_Chip='' ">
						<xsl:attribute name="Enable">No</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>	
						<xsl:attribute name="Enable">Yes</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="CS_Control">Manual</xsl:attribute>	
				<xsl:choose>
					<xsl:when test="//SRS/IO/MUXOUT/MUXOUT_TLE7240SL/@Number_of_Chip=''">
							<xsl:attribute name="NumberOfUsedDemux">0</xsl:attribute>	
					</xsl:when>
					<xsl:otherwise>	
							<xsl:attribute name="NumberOfUsedDemux"><xsl:value-of select="//SRS/IO/MUXOUT/MUXOUT_TLE7240SL/@Number_of_Chip"/></xsl:attribute>	
					</xsl:otherwise>
				</xsl:choose>
			<xsl:attribute name="DIAG_USED">No</xsl:attribute>	
		</xsl:element>
		<xsl:comment>'CS_Control, DIAG_USED  are set by XSD default value</xsl:comment>
		<xsl:element name="MUX_ADDRESS_LINES_BIDIR">
			<xsl:attribute name="MultiplexedAddressLines">No</xsl:attribute>	
		</xsl:element>
		<xsl:comment>'MultiplexedAddressLines is set by legacy value</xsl:comment>
		<xsl:element name="IO_PERIODIC_UPDATE_SETTINGS">
			<xsl:choose>
				<xsl:when test="//SRS/IO/GENERAL/@Analog_periodic_update_support=''">
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/IO/GENERAL/@Analog_periodic_update_support 값이 없음			
=======================================================================================================================</xsl:message>  
				</xsl:when>
				<xsl:otherwise>	
						<xsl:attribute name="AnalogInputPeriodicUpdate"><xsl:value-of select="//SRS/IO/GENERAL/@Analog_periodic_update_support"/></xsl:attribute>	
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="DigitalInputPeriodicUpdate">Yes</xsl:attribute>	
			<xsl:attribute name="DigitalOutputPeriodicUpdate">Yes</xsl:attribute>	
		</xsl:element>
		<xsl:comment>'DigitalInputPeriodicUpdate, DigitalOutputPeriodicUpdate  are set by XSD default value</xsl:comment>
    </IO_GENERAL_CONFIG>
	
    <DIRECT_PORTS>
        <xsl:call-template name="package_select">
				<xsl:with-param name = "package" select="//SRS/MCU/SPEC/@Package"/>
		</xsl:call-template>
    </DIRECT_PORTS>
    <MATRIX_PORTS/>
	<MUX_OUT_PORTS/>
	<MUX_IN_PORTS/>
    <MUX_ANALOG_PORTS/>
    <TIMER_RESOURCES>
			<xsl:call-template name="make_main_timer_and_pit_timer">
				<xsl:with-param name = "fast_timer" select="//SRS/CORE/TIMER/@Fast"/>
				<xsl:with-param name = "system_timer" select="//SRS/CORE/TIMER/@System_Base_Timer"/>
				<xsl:with-param name = "os_timer" select="//SRS/OS/@Systemtime"/>
				<xsl:with-param name = "MAIN_TIMER_Resources" select="$MAIN_TIMER_Resources"/>
			</xsl:call-template>
			<xsl:call-template name="make_pwm_module">
			</xsl:call-template>
    </TIMER_RESOURCES>
    <TIMER_COUNTERS/>
    <CODE_GENERATION>
        <TEMPLATE Name="biostartup_c.xsl" OutFile="biostartup.c"
            Used="true" XSLTemplate="biostartup_c.xsl">
            <XSL_PARAMETER DescriptionValues=""
                ParameterName="io_2nd_pass_schema_file" ParameterValue="../src/io_2nd_pass_standard_hal.xsd"/>
        </TEMPLATE>
        <TEMPLATE Name="digital_hwaccess_hal_h.xsl"
            OutFile="digital_hwaccess_hal.h" Used="true" XSLTemplate="digital_hwaccess_hal_h.xsl"/>
        <TEMPLATE Name="swp_data_c.xsl" OutFile="swp_data.c" Used="true" XSLTemplate="swp_data_c.xsl"/>
        <TEMPLATE Name="swp_config_h.xsl" OutFile="swp_config.h"
            Used="true" XSLTemplate="swp_config_h.xsl"/>
        <TEMPLATE Name="io_timer_h.xsl" OutFile="io_timer.h" Used="true" XSLTemplate="io_timer_h.xsl"/>
        <TEMPLATE Name="io_timer_c.xsl" OutFile="io_timer.c" Used="true" XSLTemplate="io_timer_c.xsl"/>
    </CODE_GENERATION>
    <CONSISTENCY_CHECKER>
    </CONSISTENCY_CHECKER>
    <DOCUMENTATION_GENERATION>
        <TEMPLATE Name="io_port_pin_list_html.xsl"
            OutFile="io_port_pin_list.html" Used="true" XSLTemplate="io_port_pin_list_html.xsl"/>
        <TEMPLATE Name="swp_io_func_list_html.xsl"
            OutFile="swp_io_func_list.html" Used="true" XSLTemplate="swp_io_func_list_html.xsl"/>
    </DOCUMENTATION_GENERATION>
	
</IO>
</xsl:template>



<xsl:template name= "make_port_group">  <!-- Port를 그룹 단위로 생성-->
<xsl:param name = "port_group"/>
	<xsl:for-each select="//PORT[contains(./@AIS_port_pin,$port_group)]">
		<xsl:sort select="./@AIS_Numbering" data-type="number" order = "ascending"  case-order ="upper-first"/>			
		<xsl:message  terminate ="no">'<xsl:value-of select="name(.)"/> Port Numbering = <xsl:value-of select="./@AIS_Numbering"/></xsl:message>  
		<xsl:if test="./@AIS_Port_usage !='MCAL_DUMMY'">  <!--실제 Port 추가 부분 MCAL DUMMY가 아닐때만 동작하도록 -->
				<xsl:choose>					
					<xsl:when test="./@AIS_port_pin" >
					<xsl:element name="{./@AIS_port_pin}">
						<xsl:message  terminate ="no">'PORT <xsl:value-of select="."/> port_pin value'= <xsl:value-of select="./@AIS_port_pin"  disable-output-escaping = "yes"/></xsl:message>  
						<xsl:message  terminate ="no">'PORT <xsl:value-of select="."/> direction value'= <xsl:value-of select="./@AIS_direction"  disable-output-escaping = "yes"/></xsl:message> 
						<xsl:message  terminate ="no">'PORT <xsl:value-of select="."/> InitValue value'= <xsl:value-of select="./@AIS_InitValue"  disable-output-escaping = "yes"/></xsl:message> 
						<xsl:message  terminate ="no">'PORT <xsl:value-of select="."/> Polarity value'= <xsl:value-of select="./@AIS_Polarity"  disable-output-escaping = "yes"/></xsl:message>
						<xsl:message  terminate ="no">'PORT <xsl:value-of select="."/> port_name value'= <xsl:value-of select="./@AIS_port_name"  disable-output-escaping = "yes"/></xsl:message> 
							<xsl:for-each select="./@*[not(contains(name(.),'AIS_'))]">
								<xsl:attribute name="{name(.)}"><xsl:value-of select="."/></xsl:attribute>
							</xsl:for-each>
							
							<xsl:choose> <!--Port pin의 값 설정-->
							<!--Direction 여부 설정-->
								<xsl:when test="./@AIS_direction!=''">
									<xsl:attribute name="Direction"><xsl:value-of select="./@AIS_direction"/></xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="Direction">Output</xsl:attribute> <!--사용자가 설정한 포트가 아닐 경우 기본값으로 설정-->
								</xsl:otherwise>
							</xsl:choose>
							
							<!--General_IO 여부 설정-->
							<xsl:attribute name="General_IO"><xsl:value-of select="./@AIS_General_IO"/></xsl:attribute>
							
							<!--init value  설정 -->
							<xsl:choose>
								<xsl:when test="./@AIS_InitValue">
									<xsl:attribute name="InitValue"><xsl:value-of select="./@AIS_InitValue"/></xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="InitValue">Low</xsl:attribute>	    <!--사용자가 설정한 포트가 아닐 경우 기본값으로 설정-->
								</xsl:otherwise>
							</xsl:choose>
							
							<!--Polarity 설정-->
							<xsl:choose>
								<xsl:when test="./@AIS_Polarity">
									<xsl:attribute name="Polarity"><xsl:value-of select="./@AIS_Polarity"/></xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="Polarity">High</xsl:attribute>   <!--사용자가 설정한 포트가 아닐 경우 기본값으로 설정-->
								</xsl:otherwise>
							</xsl:choose>
							
							<!--1st pass Pin 할당 -->
							<xsl:if test="./@AIS_Port_usage ='1st_pass'">  <!--실제 Port 추가 부분 Port_usage 1st pass 일때만 동작하도록 -->
								<xsl:if test="./@AIS_port_name!=''">  <!--실제 Port 추가 부분-->
									<xsl:choose>
										<xsl:when test="./@AIS_type='SWP_OUT_DIGITAL'"> 
											<xsl:element name="{./@AIS_type}">
												<xsl:attribute name="InitValue"><xsl:value-of select="./@AIS_InitValue"/></xsl:attribute>
												<xsl:attribute name="Name"><xsl:value-of select="./@AIS_port_name"/></xsl:attribute>
												<xsl:attribute name="Polarity"><xsl:value-of select="./@AIS_Polarity"/></xsl:attribute> 
											</xsl:element> 
										</xsl:when>
										<xsl:when test="./@AIS_type='SWP_DIGITAL_IN_LOGICAL'"> 
											<xsl:element name="{./@AIS_type}">
												<xsl:attribute name="Name"><xsl:value-of select="./@AIS_port_name"/></xsl:attribute>
												<xsl:attribute name="Polarity"><xsl:value-of select="./@AIS_Polarity"/></xsl:attribute> 
											</xsl:element> 
										</xsl:when>
										<xsl:when test="./@AIS_type='SWP_IN_DIGITAL'">
											<xsl:element name="{./@AIS_type}">
												<xsl:attribute name="Name"><xsl:value-of select="./@AIS_port_name"/></xsl:attribute>
												<xsl:attribute name="Polarity"><xsl:value-of select="./@AIS_Polarity"/></xsl:attribute> 
											</xsl:element> 
										</xsl:when>
										<xsl:when test="./@AIS_type='EXTERNAL_INTERRUPT'">
											<xsl:element name="{./@AIS_type}">
												<xsl:attribute name="Name"><xsl:value-of select="./@AIS_port_name"/></xsl:attribute>
												<xsl:if test="./@AIS_ISR_Function_Name!=''">  
												<xsl:element name="ISR">
													<xsl:attribute name="FunctionName"><xsl:value-of select="./@AIS_ISR_Function_Name"/></xsl:attribute>
													<xsl:attribute name="ID">ES<xsl:value-of select="generate-id()"/></xsl:attribute>
													<xsl:attribute name="Name"><xsl:value-of select="./@AIS_ISR_Source"/></xsl:attribute>
												</xsl:element>
												</xsl:if>
											</xsl:element>
										</xsl:when>
										<xsl:when test="./@AIS_type='ESR_INTERRUPT'">
											<xsl:element name="{./@AIS_type}">
												<xsl:attribute name="Name"><xsl:value-of select="./@AIS_port_name"/></xsl:attribute>
												<xsl:if test="./@AIS_ISR_Function_Name!=''">  
												<xsl:element name="ISR">
													<xsl:attribute name="FunctionName"><xsl:value-of select="./@AIS_ISR_Function_Name"/></xsl:attribute>
													<xsl:attribute name="ID">ES<xsl:value-of select="generate-id()"/></xsl:attribute>
													<xsl:attribute name="Name"><xsl:value-of select="./@AIS_ISR_Source"/></xsl:attribute>
												</xsl:element>
												</xsl:if>
											</xsl:element>
										</xsl:when>
										<xsl:when test="./@AIS_type='WKPU_INTERRUPT'">
											<xsl:element name="{./@AIS_type}">
												<xsl:attribute name="Name"><xsl:value-of select="./@AIS_port_name"/></xsl:attribute>
												<xsl:if test="./@AIS_ISR_Function_Name!=''">  
												<xsl:element name="ISR">
													<xsl:attribute name="FunctionName"><xsl:value-of select="./@AIS_ISR_Function_Name"/></xsl:attribute>
													<xsl:attribute name="ID">WK<xsl:value-of select="generate-id()"/></xsl:attribute>
													<xsl:attribute name="Name"><xsl:value-of select="./@AIS_Wkpu_Source"/></xsl:attribute>
												</xsl:element>
												</xsl:if>
											</xsl:element>
										</xsl:when>
										<xsl:when test="./@AIS_type='KEY_INTERRUPT'">
											<xsl:element name="{./@AIS_type}">
												<xsl:attribute name="Name"><xsl:value-of select="./@AIS_port_name"/></xsl:attribute>
												<xsl:if test="./@AIS_ISR_Function_Name!=''">  
												<xsl:element name="ISR">
													<xsl:attribute name="FunctionName"><xsl:value-of select="./@AIS_ISR_Function_Name"/></xsl:attribute>
													<xsl:attribute name="ID">KE<xsl:value-of select="generate-id()"/></xsl:attribute>
													<xsl:attribute name="Name"><xsl:value-of select="./@AIS_ISR_Source"/></xsl:attribute>
												</xsl:element>
												</xsl:if>
											</xsl:element>
										</xsl:when>
										<xsl:when test="./@AIS_type='SWP_IN_ANALOG'">
											<xsl:element name="{./@AIS_type}">
												<xsl:attribute name="Name"><xsl:value-of select="./@AIS_port_name"/></xsl:attribute>
											</xsl:element> 
										</xsl:when>
										<xsl:when test="./@AIS_type='DUMMY_ANALOG'">
											<xsl:element name="{./@AIS_type}"/>
										</xsl:when>
									</xsl:choose>
								</xsl:if>
							</xsl:if>
						</xsl:element>
					</xsl:when>
				</xsl:choose>
		</xsl:if>
	</xsl:for-each>
</xsl:template>
	
<xsl:template name= "package_select">  <!-- Port를 그룹 단위로 생성-->
	<xsl:param name = "package"/>
						<PORT_A Dio_PortName="DioPort_0">
							<xsl:call-template name="make_port_group">
								<xsl:with-param name = "port_group" select="'PA'"/>
							</xsl:call-template>
						</PORT_A>
						<PORT_B Dio_PortName="DioPort_1">
							<xsl:call-template name="make_port_group">
								<xsl:with-param name = "port_group" select="'PB'"/>
							</xsl:call-template>
						</PORT_B>
						
						<PORT_C Dio_PortName="DioPort_2">
							<xsl:call-template name="make_port_group">
								<xsl:with-param name = "port_group" select="'PC'"/>
							</xsl:call-template>
						</PORT_C>
						<PORT_D Dio_PortName="DioPort_3">
							<xsl:call-template name="make_port_group">
								<xsl:with-param name = "port_group" select="'PD'"/>
							</xsl:call-template>
						</PORT_D>
						<PORT_E Dio_PortName="DioPort_4">
							<xsl:call-template name="make_port_group">
								<xsl:with-param name = "port_group" select="'PE'"/>
							</xsl:call-template>
						</PORT_E>
						
						<xsl:if  test= "$package='PACKAGE_144' or $package='PACKAGE_176'">
						<PORT_F Dio_PortName="DioPort_5">
							<xsl:call-template name="make_port_group">
								<xsl:with-param name = "port_group" select="'PF'"/>
							</xsl:call-template>
						</PORT_F>						
						<PORT_G Dio_PortName="DioPort_6">
							<xsl:call-template name="make_port_group">
								<xsl:with-param name = "port_group" select="'PG'"/>
							</xsl:call-template>
						</PORT_G>
						</xsl:if>
						
						<PORT_H Dio_PortName="DioPort_7">
							<xsl:call-template name="make_port_group">
								<xsl:with-param name = "port_group" select="'PH'"/>
							</xsl:call-template>
						</PORT_H>
						
						<xsl:if  test= "$package='PACKAGE_176'">
						<PORT_I Dio_PortName="DioPort_8">
							<xsl:call-template name="make_port_group">
								<xsl:with-param name = "port_group" select="'PI'"/>
							</xsl:call-template>
						</PORT_I>						
						<PORT_J Dio_PortName="DioPort_9">
							<xsl:call-template name="make_port_group">
								<xsl:with-param name = "port_group" select="'PJ'"/>
							</xsl:call-template>
						</PORT_J>
						</xsl:if>
						
</xsl:template>


	
<xsl:template name= "make_main_timer_and_pit_timer">  <!-- main timer 생성-->
	<xsl:param name = "fast_timer"/>
	<xsl:param name = "system_timer"/>
	<xsl:param name = "os_timer"/>
	<xsl:param name = "MAIN_TIMER_Resources"/>
		<xsl:element name="MAIN_TIMER_COUNTER">
			<xsl:for-each select="$MAIN_TIMER_Resources">
				<xsl:if test="@AssociatedEmiosCh !=''"> 
					<xsl:element name="{@Timer_Resource}">
						<xsl:attribute name="AssociatedEmiosCh"><xsl:value-of select="@AssociatedEmiosCh"/></xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:for-each>
		</xsl:element>
	  <xsl:element name="SPECIAL_TIMER_COUNTER">
			<xsl:for-each select="//SRS/IO/TIMER/SPECIAL_TIMER/*">
				<xsl:if test="@AssociatedHWCh !=''"> 
					<xsl:element name="{@Timer_Resource}">
						<xsl:attribute name="AssociatedHWCh"><xsl:value-of select="@AssociatedHWCh"/></xsl:attribute>
						<xsl:if test="//SRS/CORE/TIMER/@System_time_usage ='ENABLE'"> 
							<xsl:if test="@Comment ='SystemTimer'">
								<COMPARE_TIMER Name="TIMER_TS"/>
							</xsl:if>
						</xsl:if>
					</xsl:element>
				</xsl:if>
			</xsl:for-each>
	  </xsl:element>
</xsl:template>
	
	<xsl:template name= "make_pwm_module">  <!-- pwm_module생성-->
		<xsl:element name="PWM_MODULE">
				<xsl:for-each select="//SRS/IO/PWM/@*">
					<xsl:message  terminate ="no">'PWM <xsl:value-of select="name(.)"/> value'= <xsl:value-of select="."/> </xsl:message>  
					<xsl:attribute name="{name(.)}"><xsl:value-of select="."/></xsl:attribute>
				</xsl:for-each>
				<xsl:for-each select="//SRS/IO/PWM/*">
					<xsl:if test = "@AssociatedHWPin !=''">
					<xsl:message  terminate ="no">'PWM <xsl:value-of select="name(.)"/> pwm value'= <xsl:value-of select="position()-1"/></xsl:message>  
					<xsl:element name="PWM_CHANNEL_{@Channel}">
						<xsl:attribute name="AssociatedHWPin"><xsl:value-of select="@AssociatedHWPin"/></xsl:attribute>
						<xsl:choose>
							<xsl:when test="@DefaultPeriod=''"><xsl:attribute name="DefaultPeriod">0</xsl:attribute></xsl:when>
							<xsl:otherwise><xsl:attribute name="DefaultPeriod"><xsl:value-of select="@DefaultPeriod"/></xsl:attribute></xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="@Used_PWMType='UNUSED' or @Used_PWMType=''"><xsl:attribute name="Used_PWMType">NOT_USED</xsl:attribute></xsl:when>
							<xsl:otherwise><xsl:attribute name="Used_PWMType"><xsl:value-of select="@Used_PWMType"/></xsl:attribute></xsl:otherwise>
						</xsl:choose>
					</xsl:element>
					</xsl:if>
				</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
	<xsl:template name= "make_input_supply_switch">  
			<xsl:element name="INPUT_SUPPLY_SWITCH">
				
				<xsl:attribute name="AnalogSupplySwitch"><xsl:value-of select="//SRS/IO/INSWITCH/ASW/@Enable"/></xsl:attribute>
				<xsl:choose> 
					<xsl:when test="//SRS/IO/INSWITCH/ASW/@Delay='' or //SRS/IO/INSWITCH/ASW/@Delay='NA'">
						<xsl:attribute name="AnalogSupplySwitchDelay">100</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="AnalogSupplySwitchDelay"><xsl:value-of select="//SRS/IO/INSWITCH/ASW/@Delay"/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="//SRS/IO/INSWITCH/DSW/@Enable='Yes'">
						<xsl:attribute name="DigitalSupplySwitch"><xsl:value-of select="//SRS/IO/INSWITCH/DSW/@Enable"/></xsl:attribute>
						<xsl:choose> 
							<xsl:when test="//SRS/IO/INSWITCH/DSW1/@Port != '' and //SRS/IO/INSWITCH/DSW1/@Port != 'NA' and //SRS/IO/INSWITCH/DSW1/@Init_Mode=''">
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/IO/INSWITCH/DSW1/@Init_Mode 값이 없음			
=======================================================================================================================</xsl:message>  
							</xsl:when>
							<xsl:when test="//SRS/IO/INSWITCH/DSW2/@Port != '' and //SRS/IO/INSWITCH/DSW2/@Port != 'NA' and //SRS/IO/INSWITCH/DSW2/@Init_Mode=''">
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/IO/INSWITCH/DSW2/@Init_Mode 값이 없음			
=======================================================================================================================</xsl:message>  
							</xsl:when>
							<xsl:when test="//SRS/IO/INSWITCH/DSW3/@Port != '' and //SRS/IO/INSWITCH/DSW3/@Port != 'NA' and //SRS/IO/INSWITCH/DSW3/@Init_Mode=''">
								<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/IO/INSWITCH/DSW3/@Init_Mode 값이 없음			
=======================================================================================================================</xsl:message>  
							</xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="//SRS/IO/INSWITCH/DSW1/@Port = '' or //SRS/IO/INSWITCH/DSW1/@Port = 'NA'">
								<xsl:attribute name="DigitalSupplySwitch1InitMode">SW_OFF</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="DigitalSupplySwitch1InitMode"><xsl:value-of select="concat('SW_',//SRS/IO/INSWITCH/DSW1/@Init_Mode)"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="//SRS/IO/INSWITCH/DSW2/@Port = '' or //SRS/IO/INSWITCH/DSW2/@Port = 'NA'">
								<xsl:attribute name="DigitalSupplySwitch2InitMode">SW_OFF</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="DigitalSupplySwitch2InitMode"><xsl:value-of select="concat('SW_',//SRS/IO/INSWITCH/DSW2/@Init_Mode)"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="//SRS/IO/INSWITCH/DSW3/@Port = '' or //SRS/IO/INSWITCH/DSW3/@Port = 'NA'">
								<xsl:attribute name="DigitalSupplySwitch3InitMode">SW_OFF</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="DigitalSupplySwitch3InitMode"><xsl:value-of select="concat('SW_',//SRS/IO/INSWITCH/DSW3/@Init_Mode)"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:attribute name="DigitalSupplySwitchControl_inApp"><xsl:value-of select="//SRS/IO/INSWITCH/DSW/@DigitalSupplySwitchControl_inApp"/></xsl:attribute>
						<xsl:choose> 
							<xsl:when test="//SRS/IO/INSWITCH/DSW/@DigitalSupplySwitchDelay='' or //SRS/IO/INSWITCH/DSW/@DigitalSupplySwitchDelay='NA'">
								<xsl:attribute name="DigitalSupplySwitchDelay">100</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="DigitalSupplySwitchDelay"><xsl:value-of select="//SRS/IO/INSWITCH/DSW/@DigitalSupplySwitchDelay"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						
						
						
						<xsl:attribute name="DigitalSupplySwitchLP"><xsl:value-of select="//SRS/IO/INSWITCH/DSW/@DigitalSupplySwitchLP"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="DigitalSupplySwitch">No</xsl:attribute>
						<xsl:attribute name="DigitalSupplySwitch1InitMode">SW_OFF</xsl:attribute>
						<xsl:attribute name="DigitalSupplySwitch2InitMode">SW_OFF</xsl:attribute>
						<xsl:attribute name="DigitalSupplySwitch3InitMode">SW_OFF</xsl:attribute>
						<xsl:attribute name="DigitalSupplySwitchControl_inApp">No</xsl:attribute>
						<xsl:choose> 
							<xsl:when test="//SRS/IO/INSWITCH/DSW/@DigitalSupplySwitchDelay='' or //SRS/IO/INSWITCH/DSW/@DigitalSupplySwitchDelay='NA'">
								<xsl:attribute name="DigitalSupplySwitchDelay">100</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="DigitalSupplySwitchDelay"><xsl:value-of select="//SRS/IO/INSWITCH/DSW/@DigitalSupplySwitchDelay"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:attribute name="DigitalSupplySwitchLP">No</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				
				
			</xsl:element>
	</xsl:template>
</xsl:stylesheet>