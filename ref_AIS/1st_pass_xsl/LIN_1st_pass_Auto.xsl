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
* source file for 2nd pass Xml generation 
* %Name:                LIN_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
						
						
* %xsd file version 	
* dependency 			None
* %xsl file version:    1.0.0 %
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
  1.0.0      | 20/May/2014 |                               | Seungwoo. Lee
  - Init version
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>

<LIN_1ST_CONFIGURATION xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="lin_1st_cfg.xsd">
	<xsl:element name="LIN_CHANNELS">
		<xsl:for-each select="//SRS/COM/LIN/*[contains(./@LIN_Enable,'Yes') and (./@LIN_ASC_Channel != '')]"> 
			<xsl:element name="LIN_CHANNEL">
				<xsl:attribute name="ASC_Channel"><xsl:value-of select="substring-after(./@LIN_ASC_Channel,'ASC')"/></xsl:attribute>
			</xsl:element>
		</xsl:for-each>
    </xsl:element>
    <LIN_OPTION LowPowerMode="USED" SleepMode="USED"/>
    <CODE_GENERATION>
        <TEMPLATE Name="lin_1st_cfg.c" OutFile="lin_1st_cfg.c" Used="true" XSLTemplate="lin_1st_cfg_c.xsl"/>
        <TEMPLATE Name="lin_1st_cfg.h" OutFile="lin_1st_cfg.h" Used="true" XSLTemplate="lin_1st_cfg_h.xsl"/>
    </CODE_GENERATION>
    <CONSISTENCY_CHECKER>
        <TEMPLATE Name="CC_1st_LIN_Generic"
            OutFile="CC_1st_LIN_Generic.xml" Used="true" XSLTemplate="CC_1st_LIN_Generic.xsl"/>
    </CONSISTENCY_CHECKER>
</LIN_1ST_CONFIGURATION>
</xsl:template>
</xsl:stylesheet>


