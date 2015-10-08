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
                         Autron  PAT  TEAM                              
============================================================================
                        OBJECT SPECIFICATION                                
============================================================================
* source file for 1st pass Xml generation 
* %Name:                PM_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
						
* %xsd file version 	
* dependency 			None
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
  - LP_HAL_CONFIG Element removed.
  - LP_HAL_1st_CONFIG Element added
  1.0.2      | 29/May/2014 |                               | Seungwoo. Lee
  - LP_FLAG 'LP_LIN_NET' is add 
  1.0.3      | 04/Jul/2014 |                               | Seungwoo. Lee
  - add 'bxstman_l2h' element under TRANSITIONS_L2H when using CAN 
  - add 'bxstman_h2l' element under TRANSITIONS_H2L when using CAN 
  1.0.4      | 26/Dec/2014 |                               | Seungwoo. Lee  
  - remove LP_TASK 'IO_MANAGE_LP' element
  1.0.5      | 20/Jul/2015 |                               | Seungwoo. Lee  
  - error fix for making element 'bxstman_l2h' and 'bxstman_h2l'
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
Power Manager 1st pass XML Generaiton Message
==========================================================================
</xsl:message>  

<POWER_MANAGER Name="POWER_MANAGER_1st_pass" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="pm_1st_cfg.xsd">
	<TRANSITIONS_L2H>
        <TRANSITION_FUNCTION_L2H Name="beepmana_InitL2h"/>
        <TRANSITION_FUNCTION_L2H Name="biomanag_l2h"/>
		
		<xsl:if test ="//SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN0' or //SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN1' or //SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN2' or //SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN3' or //SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN4' or //SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN5'">
		<TRANSITION_FUNCTION_L2H Name="bxstman_l2h"/>
		</xsl:if>
		
		<xsl:comment>'beepmana_InitL2h' and 'biomanag_l2h' elements are fixed, 'bxstman_l2h' is used when use CAN</xsl:comment>
    </TRANSITIONS_L2H>
    <TRANSITIONS_H2L>
        <TRANSITION_FUNCTION_H2L Name="beepmana_InitH2l"/>
        <TRANSITION_FUNCTION_H2L Name="biomanag_h2l"/>
		<xsl:if test ="//SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN0' or //SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN1' or //SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN2' or //SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN3' or //SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN4' or //SRS/COM/CAN/CHANNELS/*/@channel='FLEXCAN5'">
		<TRANSITION_FUNCTION_H2L Name="bxstman_h2l"/>
		</xsl:if>
		<xsl:comment>'beepmana_InitH2l' and 'biomanag_h2l' elements are fixed, 'bxstman_h2l' is used when use CAN</xsl:comment>
    </TRANSITIONS_H2L>
	<xsl:element name="LP_TASKS">
	</xsl:element>
    <LP_FLAGS>
        <LP_FLAG Name="HPM_IO"/>
        <LP_FLAG Name="LP_SM"/>
        <LP_FLAG Name="EEPROM"/>
        <LP_FLAG Name="HPM_OS"/>
		<xsl:comment>'HPM_IO','LP_SM','EEPROM','HPM_OS' elements are fixed </xsl:comment>
		<xsl:if test= "//SRS/CORE/KLINE/@Usage ='Yes'">
			<LP_FLAG Name="DIAGNOSIS"/>
			<xsl:comment> for using diag K-line </xsl:comment>
		</xsl:if>
		<xsl:if test= "//SRS/MEM/CHECK/@Enable ='Yes'">
			<LP_FLAG Name="MEMCHK"/>
			<xsl:comment> for using Memcheck </xsl:comment>
		</xsl:if>
		<xsl:if test ="//SRS/COM/ASCS/*/@Enable='Yes' and //SRS/COM/ASCS/*/@Usage_Mode='LIN'">
		<xsl:if test ="//SRS/COM/LIN/*/@LIN_Enable='Yes' and //SRS/COM/LIN/*/@LIN_ASC_Channel !=''">
			<LP_FLAG Name="LP_LIN_NET"/>
			<xsl:comment> for using LIN </xsl:comment>
		</xsl:if>
		</xsl:if>
	</LP_FLAGS>
	
	<LP_HAL_1st_CONFIG AdaptPrescalerInLP="false"/>
	<xsl:comment>'LP_HAL_1st_CONFIG is set by XSD default value</xsl:comment>

    <CODE_GENERATION>
        <TEMPLATE Name="pm_1st_cfg.h" OutFile="pm_1st_cfg.h" Used="true" XSLTemplate="pm_1st_cfg_h.xsl"/>
		<xsl:comment>'pm_1st_cfg' Template is fixed </xsl:comment>
    </CODE_GENERATION>
</POWER_MANAGER>
</xsl:template>
</xsl:stylesheet>