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
* %Name:                MEMORY_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
						

* %xsd file version 	memory_1st_pass.xsd-1			(common)		

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
  - add logic for 'ControlledRAMRecovery' attribute
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
MEMORY 1st pass XML Generaiton Message
==========================================================================
</xsl:message>  

<MEMORY xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Name="MEMORY" xsi:noNamespaceSchemaLocation="memory_1st_pass.xsd">
		<xsl:element name="CONTROLLED_RAM_SETUP">
			<xsl:choose>
				<xsl:when test="//SRS/MEM/CONTROLLED_RAM/@Controlled_RAM_recovery='USED'">
					<xsl:attribute name="ControlledRAMRecovery">Used</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="ControlledRAMRecovery">Not used</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
				<xsl:attribute name="ControlledRAMVerifyAtInit">TRUE</xsl:attribute>
				<xsl:attribute name="PlatformArchitecture">BigEndianPlatform</xsl:attribute>
		</xsl:element>
    <CODE_GENERATION>
        <TEMPLATE Name="ctlram_dataC" OutFile="ctlram_data.c" Used="true" XSLTemplate="ctlram_data_c.xsl"/>
        <TEMPLATE Name="ctlram_dataH" OutFile="ctlram_data.h" Used="true" XSLTemplate="ctlram_data_h.xsl"/>
    </CODE_GENERATION>
</MEMORY>

</xsl:template>
</xsl:stylesheet>
