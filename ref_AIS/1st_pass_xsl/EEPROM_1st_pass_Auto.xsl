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
* %Name:                EEPROM_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
* %xsd file version 	
* 					 	 
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
  1.0.0      | 10/Jan/2014 |                               | Seungwoo. Lee
  - Init version
  1.0.1      | 09/Jul/2014 |                               | Seungwoo. Lee
  - attribute name change (Schema Change) 'DFLASH_Start_Addr' -> User_DFLASH_Start_Addr
  - change attributes order under 'AUTOSAR_MCAL_FEE' element
  1.0.2      | 09/Jul/2014 |                               | Seungwoo. Lee  
  -'Block_Size' of 'AUTOSAR_MCAL_FEE' is according to '//SRS/MEM/EEPROM/DEVICE/@Fee_Block_Size'
  - error message added for '//SRS/MEM/EEPROM/DEVICE/@Fee_Block_Size'
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:if test = "//SRS/MEM/EEPROM/DEVICE/@Internal = 'Yes'" >
	<xsl:if test = "//SRS/MEM/EEPROM/DEVICE/@Fee_Block_Size = ''" >
		<xsl:message  terminate ="yes">
=======================================================================================================================
'Error 		'//SRS/MEM/EEPROM/DEVICE/@Fee_Block_Size' Setting이 누락되어 있음
=======================================================================================================================</xsl:message>
	</xsl:if>
</xsl:if>
<xsl:message  terminate ="no">
==========================================================================
EEPROM 1st pass XML Generaiton Message
<xsl:choose>
	<xsl:when test = "//SRS/MEM/EEPROM/DEVICE/@Internal = 'Yes'" >Internal EEPROM USED</xsl:when>
	<xsl:otherwise>External EEPROM USED</xsl:otherwise>
</xsl:choose>
==========================================================================
</xsl:message> 
<EEPROM Name="EEPROM 1st pass"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="EEPROM_1st_pass.xsd">
	<xsl:element name="EEPROM_MANAGMENT">
		<xsl:attribute name="CheckUpdateFunctionality">Yes</xsl:attribute>
		<xsl:attribute name="EEPROMBckgCheckBuffer">20</xsl:attribute>
		<xsl:attribute name="EEPROMSuspendRecurrence">50</xsl:attribute>
		<xsl:attribute name="EEPROMEraseFunction">
			<xsl:choose>
					<xsl:when test="//SRS/MEM/EEPROM/MANAGEMENT/@Erase='USED'">Yes</xsl:when>
					<xsl:otherwise>No</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="ReducedEEPROMManagement">
			<xsl:choose>
					<xsl:when test="//SRS/MEM/EEPROM/MANAGEMENT/@Reduce='USED'">Yes</xsl:when>
					<xsl:otherwise>No</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:element>
	<xsl:comment>'CheckUpdateFunctionality', 'EEPROMBckgCheckBuffer','EEPROMSuspendRecurrence' attributes are set by default value</xsl:comment>
	<EEPROM_DEVICES>
	<xsl:choose>
		<xsl:when test = "//SRS/MEM/EEPROM/DEVICE/@Internal = 'Yes'" >
			<AUTOSAR_MCAL_FEE Alignment="Long" Block_Size="{//SRS/MEM/EEPROM/DEVICE/@Fee_Block_Size}"
            Callback_Fct="beepmana_EEPDrvCbck" DFlash_ReadTime="5" 
            DFlash_WriteTime="5" ErasedValue="FF" FEE_ReadTime="5" 
			FEE_WriteTime="5" No_Start_Block="1" Size="{//SRS/MEM/EEPROM/DEVICE/@Size}" 
			User_DFLASH_Size="{//SRS/MEM/EEPROM/DEVICE/@Calibration_Flash_Size}" User_DFLASH_Start_Addr="{//SRS/MEM/EEPROM/DEVICE/@DFLASH_Start_Addr}"
            User_DFLASH_Start_Offset="0" User_DFLASH_WRITE_UNIT_SIZE="8"/>
		</xsl:when>
		<xsl:otherwise>
			<AUTOSAR_EEP Alignment="Byte" Callback_Fct="beepmana_EEPDrvCbck"
            ErasedValue="FF" InitTime="5" ReadTime="1" Size="{//SRS/MEM/EEPROM/DEVICE/@Size}" WriteTime="5"/>
		</xsl:otherwise>
	</xsl:choose>
	</EEPROM_DEVICES>
    <CODE_GENERATION>
        <TEMPLATE Name="EEPDrv_1st_pass" OutFile="zdcomeep.h"
            Used="true" XSLTemplate="zdcomeep_h.xsl"/>
        <TEMPLATE Name="eepdrv_cfg.h" OutFile="eepdrv_cfg.h" Used="true" XSLTemplate="eepdrv_cfg_h.xsl"/>
        <TEMPLATE Name="EEPMng_1st_pass" OutFile="eepmng_cfg.h"
            Used="true" XSLTemplate="eepmng_cfg_h.xsl"/>
    </CODE_GENERATION>
    <CONSISTENCY_CHECKER>
        <TEMPLATE Name="CC_EEPROM_1stpass_Generic"
            OutFile="CC_EEPROM_1stpass_Generic.xml" Used="true" XSLTemplate="CC_EEPROM_1stpass_Generic.xsl"/>
    </CONSISTENCY_CHECKER>
</EEPROM>


</xsl:template>
</xsl:stylesheet>
