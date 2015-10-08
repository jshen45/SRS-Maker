<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xalan="http://xml.apache.org/xalan" 
                xmlns:math="java.lang.Math" 
                xmlns:date="java.util.Date"                
                xmlns:vector="java.util.Vector"                
                extension-element-prefixes="date vector math">
<xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:template match="/"> 
/*============================================================================*/
/*                        AUTRON SOFTWARE GROUP                              */
/*============================================================================*/
/*                        OBJECT SPECIFICATION                                */
/*============================================================================*
* %name:              zbbswmap_h_auto.xsl %
* %version:           1.0.2 %
* %created_by:        ca071 %
* %date_created:      Jan 28 2014 %
*=============================================================================*/
/* DESCRIPTION : SW platform initialization                                   */
/*============================================================================*/
/* FUNCTION COMMENT :                                                         */
/*                                                                            */
/*                                                                            */
/*============================================================================*/
/* COPYRIGHT (C) HYUNDAI AUTRON 2012		                                  */
/* ALL RIGHTS RESERVED                                                        */
/*                                                                            */
/*============================================================================*/
/*                               OBJECT HISTORY                               */
/*============================================================================*/
/*  REVISION |   DATE      |                               |      AUTHOR      */
/*----------------------------------------------------------------------------*/
/*  1.0.0    | 28/Jan/2014 |                               | SW Lee           */
/*  1.0.1    | 17/Sep/2014 |                               | SW Lee           
 - add 'L' after address of 'SWM2_IDENT' 
 - add 'L' after address of 'SWM2_CRC' 										  */
/*  1.0.2    | 30/Dec/2014 |                               | SW Lee           
 - change BOOT_CRC address value according to FBL SCM Document 				  */
/*----------------------------------------------------------------------------*/
/*============================================================================*/

#ifndef _ZBBSWMAP_H
#define _ZBBSWMAP_H

 /* Value of the Security Key */
 #define SK_VALUE          (0x90482442UL)
 
 /* Value of the Security Key mask: ULONG_MAX (SK is 4 bytes long) */
 #define SECURITY_KEY_MASK (0xFFFFFFFFUL)

 /* Factory mode: Disabled --> Value is 0 */
 #define SK_FACTORY_MODE   (0x00000000UL)


 #define IS_VALID_SECURITY_KEY_VALUE( value )   ( ( (value^SK_VALUE)        &amp; SECURITY_KEY_MASK ) == 0 )
 #define IS_FACTORY_MODE_SECURITY_KEY( value )  ( ( (value^SK_FACTORY_MODE) &amp; SECURITY_KEY_MASK ) == 0 )

<xsl:choose>
	<xsl:when test="//SRS/MEM/CHECK/@Enable ='Yes'"> 
#define NUMBER_OF_SW_MODULES 3
	</xsl:when>
	<xsl:otherwise>
#define NUMBER_OF_SW_MODULES 2
	</xsl:otherwise>
</xsl:choose>

 /* Define the Main SW Module (with the Main Security Key) */
 #define MAIN_SW_MODULE       E_ASW

 
 <xsl:choose>
	<xsl:when test="//SRS/MEM/CHECK/@Enable ='Yes'"> 
 /* Define the RAM,ROM Check Module */
 #define CODE_CHECK_MODULE    0x02
	</xsl:when>
</xsl:choose>

/* SPC560 */
/* Block   Address      Size */
/* 0       0x0000_0000  32KB (BS) FBL (SCTR.TFE check)*/
/* 1       0x0000_8000  16KB (BS) ASW */
/* 2       0x0000_C000  16KB (BS) ASW */
/* 3       0x0001_0000  32KB (BS) ASW */
/* 4       0x0001_8000  32KB (BS) ASW */
/* 5       0x0002_0000  128KB     ASW */
/* 6       0x0004_0000  128KB     ASW */
/* 7       0x0006_0000  128KB     ASW */


 /* SW module 0: Bootloader */
 #define START_BOOT	 0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@start[../@parameter='FBL']"/>L
 #define END_BOOT	 0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@end[../@parameter='FBL']"/>L
 #define BOOT_IDENT	 (&amp;cs_BootId)
 #define BOOT_CRC	 (const T_CRC_AREA     * FAR_DATA_REF)(&amp;cs_CRCArea)

 
 

 /* SW module 1: RTSW */
 #define START_ASW   0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@start[../@parameter='RTSW']"/>L
 #define END_ASW     0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@end[../@parameter='RTSW']"/>L
 #define ASW_SK      (const T_ULONG        * FAR_DATA_REF)0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@SEC_SEC_start[../@parameter='RTSW']"/>L 
 #define ASW_IDENT   (const T_SW_MODULE_ID * FAR_DATA_REF)0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@SEC_IDT_start[../@parameter='RTSW']"/>L
 #define ASW_CRC     (const T_CRC_AREA     * FAR_DATA_REF)0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@SEC_CRC_start[../@parameter='RTSW']"/>L 
 
 
 <xsl:choose>
	<xsl:when test="//SRS/MEM/CHECK/@Enable ='Yes'"> 
 /* SW module 2: MEM CHECK */
 /* SW module 2: RAM_ROM Check */
 #define START_SWM2    0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@start[../@parameter='MEMCHECK']"/>L
 #define END_SWM2      0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@end[../@parameter='MEMCHECK']"/>L
 #define SWM2_SK      (const T_ULONG        * FAR_DATA_REF)(0)
 #define SWM2_IDENT   (const T_SW_MODULE_ID * FAR_DATA_REF)0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@SEC_IDT_start[../@parameter='MEMCHECK']"/>L
 #define SWM2_CRC     (const T_CRC_AREA     * FAR_DATA_REF)0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@SEC_CRC_start[../@parameter='MEMCHECK']"/>L
 #define SWM2_ACCESS_TYPE     E_READ_ONLY
	</xsl:when>
</xsl:choose>
  
#endif /* _ZBBSWMAP_H */






</xsl:template> 
</xsl:stylesheet>