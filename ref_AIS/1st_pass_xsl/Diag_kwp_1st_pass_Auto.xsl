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
* %Name:                Diag_kwp_1st_pass_Auto.xsl%
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
  1.0.0      | 09/Jan/2014 |                               | Seungwoo. Lee
  - Init version
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
Diag kwp 2000 1st Pass XML Generation Message
==========================================================================
</xsl:message>  

<Diag_1st_Pass ID="N15831407" Name="DIAG_KWP"  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="diag_schema_1st_pass.xsd">
    <DIAG_MANAGER_SETTINGS>
        <HEADER_LENGTH length="{//SRS/CORE/KLINE/@Header_Length}"/>
        <BUFFER_SIZE size="255"/>
        <CHANNEL asc_channel="{translate(//SRS/CORE/KLINE/@ASC_Channel,'ASC','')}"/>
        <CODE_GENERATION>
            <TEMPLATE Name="zdiag_1st_pass_config.h"
                OutFile="zdiag_1st_pass_config.h" Used="true" XSLTemplate="zdiag_1st_pass_config_h.xsl"/>
            <TEMPLATE Name="zevtdata.h" OutFile="zevtdata.h" Used="true" XSLTemplate="zevtdata_h.xsl"/>
            <TEMPLATE Name="zevtdata.c" OutFile="zevtdata.c" Used="true" XSLTemplate="zevtdata_c.xsl"/>
            <TEMPLATE Name="zfasttimer.h" OutFile="zfasttimer.h"
                Used="true" XSLTemplate="zfasttimer_h.xsl"/>
            <TEMPLATE Name="zfasttimer.c" OutFile="zfasttimer.c"
                Used="true" XSLTemplate="zfasttimer_c.xsl"/>
            <TEMPLATE Name="zslowtimer.h" OutFile="zslowtimer.h"
                Used="true" XSLTemplate="zslowtimer_h.xsl"/>
            <TEMPLATE Name="zslowtimer.c" OutFile="zslowtimer.c"
                Used="true" XSLTemplate="zslowtimer_c.xsl"/>
        </CODE_GENERATION>
		<CONSISTENCY_CHECKER>
        <TEMPLATE Name="CC_DIAG_1stpass_V850"
            OutFile="CC_DIAG_1stpass_V850.xml" Used="true" XSLTemplate="CC_DIAG_1stpass_Generic.xsl"/>
		</CONSISTENCY_CHECKER>
    </DIAG_MANAGER_SETTINGS>
</Diag_1st_Pass>

</xsl:template>
</xsl:stylesheet>
