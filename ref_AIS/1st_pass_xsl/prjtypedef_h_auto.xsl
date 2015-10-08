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
/*============================================================================
* %name:             prjtypedef_h_auto.xsl %								  
* %MCU:              SPC560B %											  	  
* %version:           1.0.0 %												  
* %created_by:        ca071 %												  
* %date_created:      28 Jan 2014 %  										  
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
/*  1.0.0    | 28/Jan/2014 |			                   | SW Lee           
 - Init Version									  */
/*----------------------------------------------------------------------------*/
/*============================================================================*/
/* Generated on: <xsl:value-of select="date:new()"/> 						 */
/*===========================================================================*/


#ifndef PRJTYPEDEF_H                               /* To avoid double inclusion */
#define PRJTYPEDEF_H

#ifndef NULL
#define NULL 0
#endif


#endif

</xsl:template> 
</xsl:stylesheet>