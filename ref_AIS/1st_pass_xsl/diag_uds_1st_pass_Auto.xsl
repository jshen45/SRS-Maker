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
* %Name:                diag_uds_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
						

* %xsd file version 	

* dependency 			None
* %xsl file version:    1.0.2 %
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
  1.0.1      | 28/May/2014 |                               | Seungwoo. Lee
  - DcmSupportES95485 is fixed to 'True' 
  - according to Min-hyuk Lee's guide line since 2014/05/15
  1.0.2      | 21/Oct/2014 |                               | Seungwoo. Lee  
  - add CONSISTENCY_CHECKER 'CC_Diag_UDS_1stpass_Generic'   
  - add 'DcmSecureConnectionSupport' attribute  
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
Diag UDS 1st Pass XML Generation Message
==========================================================================
</xsl:message>  


<Dcm Name="DIAG_UDS_1stpass" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="diag_uds_1stpass_config.xsd">
	<xsl:element name="DcmGlobal">
			<xsl:attribute name="DcmDevErrorDetect">false</xsl:attribute>
			<xsl:attribute name="DcmPendingResponseTimeout"><xsl:value-of select = "//SRS/CORE/UDS/@Pending_Response_Timeout"/></xsl:attribute>
			<xsl:attribute name="DcmRequestIndicationEnabled">true</xsl:attribute>
			<xsl:choose>
				<xsl:when test="count(//SRS/CORE/UDS/@DcmSecureConnectionSupport)='0'">
					<xsl:message  terminate ="yes">  	
=======================================================================================================================			
'Error			'//SRS/CORE/UDS/@DcmSecureConnectionSupport'가 존재하지 않음. Excel 파일 버전 확인 요망
=======================================================================================================================				
					</xsl:message>
				</xsl:when>
				<xsl:when test="//SRS/CORE/UDS/@DcmSecureConnectionSupport='Yes'">
					<xsl:attribute name="DcmSecureConnectionSupport">true</xsl:attribute>
				</xsl:when>
				<xsl:when test="//SRS/CORE/UDS/@DcmSecureConnectionSupport='No'">
					<xsl:attribute name="DcmSecureConnectionSupport">false</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
=======================================================================================================================			
'Error			'//SRS/CORE/UDS/@DcmSecureConnectionSupport' 잘못된 값 입력됨('ES95486','ES95485')만 인정됨.
=======================================================================================================================								
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="DcmSupportES95485">true</xsl:attribute>
			<xsl:attribute name="DcmTaskTime"><xsl:value-of select = "number(//SRS/CORE/UDS/@Task_Timing) div 1000"/></xsl:attribute>
		<xsl:element name="DcmPageBufferCfg">
			<xsl:choose>
				<xsl:when test="//SRS/CORE/UDS/@Paged_Buffer_Usage='Yes'">
					<xsl:attribute name="DcmPageBufferEnabled">true</xsl:attribute>
					<xsl:attribute name="DcmPageBufferTimeout"><xsl:value-of select = "//SRS/CORE/UDS/@Paged_Buffer_Timeout"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="//SRS/CORE/UDS/@Paged_Buffer_Usage='No'">
					<xsl:attribute name="DcmPageBufferEnabled">false</xsl:attribute>
					<xsl:attribute name="DcmPageBufferTimeout">0</xsl:attribute>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:element>
	<xsl:comment>
			DcmSupportES95485 is fixed to 'True', according to Min-hyuk Lee's guide line since 2014/05/15
	</xsl:comment>
    <CODE_GENERATION>
        <TEMPLATE Name="zdiag_uds_1stpass_config.h"
            OutFile="zdiag_uds_1stpass_config.h" Used="true" XSLTemplate="zdiag_uds_1stpass_config_h.xsl"/>
    </CODE_GENERATION>
    <CONSISTENCY_CHECKER>
        <TEMPLATE Name="CC_Diag_UDS_1stpass_Generic"
            OutFile="CC_Diag_UDS_1stpass_Generic.xml" Used="true" XSLTemplate="CC_Diag_UDS_1stpass_Generic.xsl"/>
    </CONSISTENCY_CHECKER>
</Dcm>



</xsl:template>
</xsl:stylesheet>