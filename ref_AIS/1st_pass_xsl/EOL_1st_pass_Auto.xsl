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
* %Name:                EOL_1st_pass_Auto.xsl%
* %MCU:                 SPC560B %
* %version of module which include xsd file : 
* %xsd file version 	eol_1st_pass.xsd
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
  1.0.1      | 30/Dec/2014 |                               | Seungwoo. Lee
  - EOL_FCPU value is according to //SRS/MCU/SPEC/@Peripheral_Clock_Set_2
  - add logic for 'COMPILE_OPTIONS/@EOL_NO_29BIT' value
  - add logic for '/@EOL_RAM_SIZE' and value 
  1.0.2      | 08/Oct/2015 |                               | Seungwoo. Lee  
  - EOL Seed Key Algorithm added (USE_HMC_SEED_KEY) case
===========================================================================
Generated on: <xsl:value-of select="date:new()"/> 
===========================================================================
</xsl:comment>
<xsl:message  terminate ="no">
==========================================================================
EOL 1st pass XML Generaiton Message
EOL_FCPU value is according to //SRS/MCU/SPEC/@Peripheral_Clock_Set_2
==========================================================================
</xsl:message>  
<EOL_1st xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="eol_1st_pass.xsd">
	<xsl:element name="COMPILE_OPTIONS">
		<xsl:choose>
					<xsl:when test="//SRS/EOL/@ID_type='CAN_STD_ID'">
						<xsl:attribute name="EOL_NO_29BIT">Yes</xsl:attribute>
					</xsl:when>
					<xsl:when test="//SRS/EOL/@ID_type='CAN_EXT_ID'">
						<xsl:attribute name="EOL_NO_29BIT">No</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/EOL/@ID_type  값이 입력되지 않음
=======================================================================================================================</xsl:message>  										
					</xsl:otherwise>
		</xsl:choose>
		<xsl:attribute name="EOL_NO_CHECK">No</xsl:attribute>
		<xsl:attribute name="EOL_NO_ESCAPE">No</xsl:attribute>
		<xsl:attribute name="EOL_NO_LOCK">No</xsl:attribute>
		<xsl:attribute name="ID">CO<xsl:value-of select="generate-id()"/></xsl:attribute>
	</xsl:element>
	<xsl:element name="EOL_SETTINGS">
		<xsl:attribute name="ANTI_SCANNING_DELAY"><xsl:value-of select="//SRS/EOL/@Delay"/></xsl:attribute>
		<xsl:attribute name="EOL_CAN_CELL"><xsl:value-of select="//SRS/EOL/@Channel"/></xsl:attribute>
		<xsl:attribute name="EOL_ID">
			<xsl:call-template name="make_eol_id"> 
				<xsl:with-param name = "ecu_info" select="//SRS/MCU/SPEC/@ecu"/>
			</xsl:call-template>
		</xsl:attribute>
		<xsl:attribute name="FIXED_KEY"><xsl:value-of select="//SRS/EOL/@Key"/></xsl:attribute>
		<xsl:attribute name="FIXED_SEED"><xsl:value-of select="//SRS/EOL/@Seed"/></xsl:attribute>
		<xsl:attribute name="ID">EI<xsl:value-of select="generate-id()"/></xsl:attribute>
		<xsl:choose>
				<xsl:when test="//SRS/EOL/@SeedMethod ='FIX'"> 
						<xsl:attribute name="SEED_KEY_TYPE">USE_FIXED_SEED_KEY</xsl:attribute>
				</xsl:when>
				<xsl:when test="//SRS/EOL/@SeedMethod ='EOL'"> 
						<xsl:attribute name="SEED_KEY_TYPE">USE_EOL_SEED_KEY</xsl:attribute>
				</xsl:when>
				<xsl:when test="//SRS/EOL/@SeedMethod ='RANDOM'"> 
					<xsl:attribute name="SEED_KEY_TYPE">USE_RANDOM_SEED_KEY</xsl:attribute>
				</xsl:when>
				<xsl:when test="//SRS/EOL/@SeedMethod ='HMC'"> 
					<xsl:attribute name="SEED_KEY_TYPE">USE_HMC_SEED_KEY</xsl:attribute>
				</xsl:when>
		</xsl:choose>
	</xsl:element>
	<xsl:element name="MEMORY_MAP">	
	<xsl:choose>
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='24'">
			<xsl:attribute name="EOL_RAM_SIZE">5000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">400057FF</xsl:attribute>
		</xsl:when> 
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='28'">
			<xsl:attribute name="EOL_RAM_SIZE">6000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">400067FF</xsl:attribute>
		</xsl:when> 
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='32'">
			<xsl:attribute name="EOL_RAM_SIZE">7000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">400077FF</xsl:attribute>
		</xsl:when> 
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='48'">
			<xsl:attribute name="EOL_RAM_SIZE">B000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">4000B7FF</xsl:attribute>
		</xsl:when> 
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='64'">
			<xsl:attribute name="EOL_RAM_SIZE">F000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">4000F7FF</xsl:attribute>
		</xsl:when> 
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='80'">
			<xsl:attribute name="EOL_RAM_SIZE">13000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">400137FF</xsl:attribute>
		</xsl:when> 
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='96'">
			<xsl:attribute name="EOL_RAM_SIZE">17000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">400177FF</xsl:attribute>
		</xsl:when> 
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='128'">
			<xsl:attribute name="EOL_RAM_SIZE">1F000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">4001F7FF</xsl:attribute>
		</xsl:when> 
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='160'">
			<xsl:attribute name="EOL_RAM_SIZE">27000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">400277FF</xsl:attribute>
		</xsl:when> 
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='192'">
			<xsl:attribute name="EOL_RAM_SIZE">2F000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">4002F7FF</xsl:attribute>
		</xsl:when> 
		<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='256'">
			<xsl:attribute name="EOL_RAM_SIZE">3F000</xsl:attribute>
			<xsl:attribute name="EOL_TOP_ADDRESS">4003F7FF</xsl:attribute>
		</xsl:when> 
		<xsl:otherwise>
			<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/MCU/SPEC/@RAM_SIZE  값이 유효하지 않음
=======================================================================================================================</xsl:message> 
		</xsl:otherwise>
</xsl:choose>
		<xsl:attribute name="EOL_FLASH_BASE_ADDRESS">40000800</xsl:attribute>
		<xsl:attribute name="EOL_RAM_BASE_ADDRESS">40000800</xsl:attribute>
		<xsl:attribute name="EOL_REG_BASE_ADDRESS">C3F88000</xsl:attribute>
		<xsl:attribute name="ID">MM<xsl:value-of select="generate-id()"/></xsl:attribute>
		<!-- EOL_REG_BASE_ADDRESS isn't used in Bolero MCU (verify by Park Jin-suk-->
	</xsl:element>
	<xsl:element name="EOL_SYSTEM">
		<xsl:attribute name="EOL_FCPU"><xsl:value-of select="//SRS/MCU/SPEC/@Peripheral_Clock_Set_2"/></xsl:attribute>
		<xsl:attribute name="ID">ES<xsl:value-of select="generate-id()"/></xsl:attribute>
	</xsl:element>
	<CODE_GENERATION>
        <TEMPLATE Name="eol_cfg_1st_h.xsl" OutFile="eol_cfg_1st.h"
            Used="true" XSLTemplate="eol_cfg_1st_h.xsl"/>
    </CODE_GENERATION>
	<CONSISTENCY_CHECKER/>
    <DOCUMENTATION_GENERATION/>
</EOL_1st>
</xsl:template>

<xsl:template name= "make_eol_id">
	<xsl:param name= "ecu_info"/>
		<xsl:choose>
			<xsl:when test="$ecu_info='BCM' or $ecu_info='bcm' ">
				<xsl:value-of select="0"/>
			</xsl:when>
			<xsl:when test="$ecu_info='IPM' or $ecu_info='ipm' ">
				<xsl:value-of select="1"/>
			</xsl:when>
			<xsl:when test="$ecu_info='ADM'or $ecu_info='adm' ">
				<xsl:value-of select="2"/>
			</xsl:when>
			<xsl:when test="$ecu_info='DDM'or $ecu_info='ddm' ">
				<xsl:value-of select="3"/>
			</xsl:when>
			<xsl:when test="$ecu_info='PSM'or $ecu_info='psm' ">
				<xsl:value-of select="4"/>
			</xsl:when>
			<xsl:when test="$ecu_info='SMK'or $ecu_info='smk' ">
				<xsl:value-of select="5"/>
			</xsl:when>
			<xsl:when test="$ecu_info='SCM'or $ecu_info='scm' ">
				<xsl:value-of select="6"/>
			</xsl:when>
			<xsl:when test="$ecu_info='IMS'or $ecu_info='ims' ">
				<xsl:value-of select="7"/>
			</xsl:when>
			<xsl:when test="$ecu_info='GATEWAY'or $ecu_info='gateway' ">
				<xsl:value-of select="8"/>
			</xsl:when>
			<xsl:when test="$ecu_info='SJB'or $ecu_info='sjb' ">
				<xsl:value-of select="9"/>
			</xsl:when>
			<xsl:when test="$ecu_info='IBCM'or $ecu_info='ibcm' ">
				<xsl:value-of select="10"/>
			</xsl:when>
			<xsl:when test="$ecu_info='CMK'or $ecu_info='cmk' ">
				<xsl:value-of select="11"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="99"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>	
