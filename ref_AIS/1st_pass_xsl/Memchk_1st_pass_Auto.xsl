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
* %Name:                Memchk_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
						
						
* %xsd file version 	memchk_cfg_1st_pass.xsd
					
* dependency 			None
* %xsl file version:    1.0.1 %
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
  1.0.1      | 26/Dec/2014 |                               | Seungwoo. Lee
  - change logic for 'Memchk_Background_Task_Name'
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
MEMCHK 1st pass XML Generaiton Message
==========================================================================
</xsl:message>  

<MEMORY_CHECK_1ST_PASS
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="memchk_cfg_1st_pass.xsd">
    <STATUS_VARIABLES StatusVariablesLocation="Default_RAM"/>
	<xsl:element name = "MEMORY_CHECK_AT_INIT">
			<xsl:attribute name="RAMCheckAtInit">
				<xsl:choose>
					<xsl:when test="//SRS/MEM/CHECK/RAM/@Init='Yes'">TRUE</xsl:when>
					<xsl:when test="//SRS/MEM/CHECK/RAM/@Init='No'">FALSE</xsl:when>
					<xsl:otherwise>SRS input_value_error</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="ROMCheckAtInit">
				<xsl:choose>
					<xsl:when test="//SRS/MEM/CHECK/ROM/@Init='Yes'">TRUE</xsl:when>
					<xsl:when test="//SRS/MEM/CHECK/ROM/@Init='No'">FALSE</xsl:when>
					<xsl:otherwise>SRS input_value_error</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
	</xsl:element>
	<xsl:element name = "MEMORY_CHECK_AT_RUNTIME">
			<xsl:attribute name="RAMCheckAtRuntime">
				<xsl:choose>
					<xsl:when test="//SRS/MEM/CHECK/RAM/@Runtime='Yes'">TRUE</xsl:when>
					<xsl:when test="//SRS/MEM/CHECK/RAM/@Runtime='No'">FALSE</xsl:when>
					<xsl:otherwise>SRS input_value_error</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			
			<xsl:attribute name="ROMCheckAtRuntime">
				<xsl:choose>
					<xsl:when test="//SRS/MEM/CHECK/ROM/@Runtime='Yes'">TRUE</xsl:when>
					<xsl:when test="//SRS/MEM/CHECK/ROM/@Runtime='No'">FALSE</xsl:when>
					<xsl:otherwise>SRS input_value_error</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
	</xsl:element>
	<xsl:element name = "MEMCHK_CRC_INIT_VALUE">
			<xsl:attribute name="CRCFixedInitValueMode">
				<xsl:choose>
					<xsl:when test="//SRS/MEM/CHECK/@Mode='FIXED'">Enabled</xsl:when>
					<xsl:when test="//SRS/MEM/CHECK/@Mode='VERSION_BASED'">Disabled</xsl:when>
					<xsl:otherwise>input_value_error</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="CRCInitValue"><xsl:value-of select="//SRS/MEM/CHECK/@Init"/></xsl:attribute>
	</xsl:element>
	<xsl:element name = "MEMCHK_BACKGROUND_TASK">
			<xsl:attribute name="Memchk_Background_Task_Name">
				<xsl:for-each select ="//SRS/OS/TASKS/*">
					<xsl:if test = "contains(./@Name,'Task_SWP_BG_RAM_ROM_check') ">
						<xsl:value-of select="./@Name"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:attribute>
	</xsl:element>
    <CONSISTENCY_CHECKER/>
    <CODE_GENERATION>
        <TEMPLATE Name="memchk_cfg_h" OutFile="memchk_cfg.h" Used="true" XSLTemplate="memchk_cfg_h.xsl"/>
    </CODE_GENERATION>
</MEMORY_CHECK_1ST_PASS>

</xsl:template>
</xsl:stylesheet>
		