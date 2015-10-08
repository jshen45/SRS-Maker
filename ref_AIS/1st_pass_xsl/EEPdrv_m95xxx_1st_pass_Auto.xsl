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
* %Name:                EEPdrv_m95xxx_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
						
						
* %xsd file version 	eepdrv_ar.xsd
					
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
  1.0.0      | 10/Jan/2014 |                               | Seungwoo. Lee
  - Init version
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
EEPDRV_M95XXX 1st pass XML Generaiton Message
AR_EEPROM ST_M95320
==========================================================================
</xsl:message>  
<AR_EEPROM Name="ST_M95320"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="eepdrv_ar.xsd">
    <AUTOSAR_EEPROM_GENERAL_CONF EEP_DEV_ERROR_DETECT="OFF"
        EEP_USE_INTERRUPTS="OFF" EEP_VERSION_INFO_API="ON" EEP_WRITE_CYCLE_REDUCTION="OFF"/>
    <AUTOSAR_EEPROM_INIT_CONF EEP_BASE_ADDRESS="0"
        EEP_DEFAULT_MODE="FAST" EEP_FAST_READ_BLOCK_SIZE="{//SRS/MEM/EEPROM/DEVICE/@EEPROM_Page_Size}"
        EEP_FAST_WRITE_BLOCK_SIZE="{//SRS/MEM/EEPROM/DEVICE/@EEPROM_Page_Size}" EEP_JOB_CALL_CYCLE="5"
        EEP_JOB_END_NOTIFICATION="bscomeep_JobEndNotification"
        EEP_JOB_ERROR_NOTIFICATION="bscomeep_JobErrorNotification"
        EEP_NORMAL_READ_BLOCK_SIZE="1" EEP_NORMAL_WRITE_BLOCK_SIZE="1" EEP_SIZE="{//SRS/MEM/EEPROM/DEVICE/@Size}"/>
    <AUTOSAR_EEPROM_DEVICE EEP_PAGE_SIZE="{//SRS/MEM/EEPROM/DEVICE/@EEPROM_Page_Size}"/>
    <CODE_GENERATION>
        <TEMPLATE Name="Eep_cfg_h_xsl" OutFile="Eep_cfg.h" Used="true" XSLTemplate="Eep_cfg_h.xsl"/>
    </CODE_GENERATION>
    <CONSISTENCY_CHECKER/>
</AR_EEPROM>
<!-- for  ST_M95020 
<AR_EEPROM Name="ST_M95020"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="eepdrv_ar.xsd">
    <AUTOSAR_EEPROM_GENERAL_CONF EEP_DEV_ERROR_DETECT="OFF"
        EEP_USE_INTERRUPTS="OFF" EEP_VERSION_INFO_API="ON" EEP_WRITE_CYCLE_REDUCTION="OFF"/>
    <AUTOSAR_EEPROM_INIT_CONF EEP_BASE_ADDRESS="0"
        EEP_DEFAULT_MODE="FAST" EEP_FAST_READ_BLOCK_SIZE="16"
        EEP_FAST_WRITE_BLOCK_SIZE="16" EEP_JOB_CALL_CYCLE="5"
        EEP_JOB_END_NOTIFICATION="bscomeep_JobEndNotification"
        EEP_JOB_ERROR_NOTIFICATION="bscomeep_JobErrorNotification"
        EEP_NORMAL_READ_BLOCK_SIZE="1" EEP_NORMAL_WRITE_BLOCK_SIZE="1" EEP_SIZE="{//SRS/MEM/EEPROM/DEVICE/@Size}"/>
    <AUTOSAR_EEPROM_DEVICE EEP_PAGE_SIZE="16"/>
    <CODE_GENERATION>
        <TEMPLATE Name="Eep_cfg_h_xsl" OutFile="Eep_cfg.h" Used="true" XSLTemplate="Eep_cfg_h.xsl"/>
    </CODE_GENERATION>
    <CONSISTENCY_CHECKER/>
</AR_EEPROM>
-->	
</xsl:template>
</xsl:stylesheet>