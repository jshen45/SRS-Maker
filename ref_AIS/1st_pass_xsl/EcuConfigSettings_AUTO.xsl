<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xalan="http://xml.apache.org/xalan" 
                xmlns:math="java.lang.Math" 
                xmlns:date="java.util.Date"                
                xmlns:vector="java.util.Vector"                
                extension-element-prefixes="date vector math">
<xsl:output method="text" indent="yes" encoding="UTF-8" />
<xsl:param name ="MCU_Name" select="//SRS/MCU/SPEC/@Name" ></xsl:param>
<xsl:param name ="MCU_Package" select="//SRS/MCU/SPEC/@Package" ></xsl:param>

<xsl:template match="/"> 
<xsl:message  terminate ="no">
mcu name is <xsl:value-of select="$MCU_Name"/>
mcu package is <xsl:value-of select="$MCU_Package"/>
==========================================================================
EcuConfigSettings 1st pass XML Generaiton Message
AIS Support MCU list 
SPC560B40 PACKAGE_100
SPC560B40 PACKAGE_144
SPC560B44 PACKAGE_100
SPC560B44 PACKAGE_144
SPC560B50 PACKAGE_100
SPC560B50 PACKAGE_144
SPC560B54 PACKAGE_100
SPC560B54 PACKAGE_144
SPC560B54 PACKAGE_176
SPC560B60 PACKAGE_144
SPC560B60 PACKAGE_176
SPC560B64 PACKAGE_176
MPC5602B PACKAGE_100
MPC5602B PACKAGE_144
MPC5603B PACKAGE_100
MPC5603B PACKAGE_144
MPC5604B PACKAGE_100
MPC5604B PACKAGE_144
MPC5605B PACKAGE_100
MPC5605B PACKAGE_144
MPC5605B PACKAGE_176
MPC5606B PACKAGE_144
MPC5606B PACKAGE_176
MPC5607B PACKAGE_176
==========================================================================</xsl:message>
<xsl:choose>
<xsl:when test="contains(//SRS/MCU/SPEC/@Name,'SPC')">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;EcuConfigSettings Vendor="ST_SPC560"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="EcuConfigSettings.xsd"&gt;
	&lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="true" Name="Base" ParameterDefinitionRef="Base.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Dio" ParameterDefinitionRef="Dio_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="EcuM" ParameterDefinitionRef="EcuM.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Gpt" ParameterDefinitionRef="Gpt_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Icu" ParameterDefinitionRef="Icu_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Mcu" ParameterDefinitionRef="Mcu_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Port" ParameterDefinitionRef="Port_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Adc" ParameterDefinitionRef="Adc_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Resource" ParameterDefinitionRef="Resource.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Os" ParameterDefinitionRef="Os.bmd"/&gt;
    &lt;CommonSettings DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef="CAN_BSW_Cfg.xml"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Wdg" ParameterDefinitionRef="Wdg.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Fls" ParameterDefinitionRef="Fls_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Spi" ParameterDefinitionRef="Spi_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Pwm" ParameterDefinitionRef="Pwm_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Fee" ParameterDefinitionRef="Fee.epd"/&gt;
    &lt;CODE_GENERATION&gt;
        &lt;TEMPLATE Name="mcal_inc_h" OutFile="mcal_inc.h" Used="true" XSLTemplate="mcal_inc_h.xsl"/&gt;
    &lt;/CODE_GENERATION&gt;
&lt;/EcuConfigSettings&gt;</xsl:when>
<xsl:when test="(contains(//SRS/MCU/SPEC/@Name,'MPC') and $MCU_Package = 'PACKAGE_100')">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;EcuConfigSettings Vendor="ST_SPC560"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="EcuConfigSettings.xsd"&gt;
	&lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="true" Name="Base" ParameterDefinitionRef="Base.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Dio" ParameterDefinitionRef="Dio_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xll_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="EcuM" ParameterDefinitionRef="EcuM.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Gpt" ParameterDefinitionRef="Gpt_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xll_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Icu" ParameterDefinitionRef="Icu_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xll_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Mcu" ParameterDefinitionRef="Mcu_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xll_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Port" ParameterDefinitionRef="Port_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xll_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Adc" ParameterDefinitionRef="Adc_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xll_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Resource" ParameterDefinitionRef="Resource.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Os" ParameterDefinitionRef="Os.bmd"/&gt;
    &lt;CommonSettings DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef="CAN_BSW_Cfg.xml"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Wdg" ParameterDefinitionRef="Wdg.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Fls" ParameterDefinitionRef="Fls_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xll_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Spi" ParameterDefinitionRef="Spi_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xll_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Pwm" ParameterDefinitionRef="Pwm_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xll_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Fee" ParameterDefinitionRef="Fee.epd"/&gt;
    &lt;CODE_GENERATION&gt;
        &lt;TEMPLATE Name="mcal_inc_h" OutFile="mcal_inc.h" Used="true" XSLTemplate="mcal_inc_h.xsl"/&gt;
    &lt;/CODE_GENERATION&gt;
&lt;/EcuConfigSettings&gt;</xsl:when>
<xsl:when test="(contains(//SRS/MCU/SPEC/@Name,'MPC') and $MCU_Package = 'PACKAGE_144')">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;EcuConfigSettings Vendor="ST_SPC560"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="EcuConfigSettings.xsd"&gt;
	&lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="true" Name="Base" ParameterDefinitionRef="Base.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Dio" ParameterDefinitionRef="Dio_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlq_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="EcuM" ParameterDefinitionRef="EcuM.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Gpt" ParameterDefinitionRef="Gpt_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlq_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Icu" ParameterDefinitionRef="Icu_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlq_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Mcu" ParameterDefinitionRef="Mcu_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlq_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Port" ParameterDefinitionRef="Port_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlq_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Adc" ParameterDefinitionRef="Adc_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlq_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Resource" ParameterDefinitionRef="Resource.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Os" ParameterDefinitionRef="Os.bmd"/&gt;
    &lt;CommonSettings DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef="CAN_BSW_Cfg.xml"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Wdg" ParameterDefinitionRef="Wdg.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Fls" ParameterDefinitionRef="Fls_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlq_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Spi" ParameterDefinitionRef="Spi_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlq_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Pwm" ParameterDefinitionRef="Pwm_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlq_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Fee" ParameterDefinitionRef="Fee.epd"/&gt;
    &lt;CODE_GENERATION&gt;
        &lt;TEMPLATE Name="mcal_inc_h" OutFile="mcal_inc.h" Used="true" XSLTemplate="mcal_inc_h.xsl"/&gt;
    &lt;/CODE_GENERATION&gt;
&lt;/EcuConfigSettings&gt;</xsl:when>
<xsl:when test="(contains(//SRS/MCU/SPEC/@Name,'MPC') and $MCU_Package = 'PACKAGE_176')">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;EcuConfigSettings Vendor="ST_SPC560"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="EcuConfigSettings.xsd"&gt;
	&lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="true" Name="Base" ParameterDefinitionRef="Base.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Dio" ParameterDefinitionRef="Dio_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlu_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="EcuM" ParameterDefinitionRef="EcuM.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Gpt" ParameterDefinitionRef="Gpt_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlu_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Icu" ParameterDefinitionRef="Icu_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlu_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Mcu" ParameterDefinitionRef="Mcu_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlu_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Port" ParameterDefinitionRef="Port_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlu_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Adc" ParameterDefinitionRef="Adc_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlu_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Resource" ParameterDefinitionRef="Resource.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Os" ParameterDefinitionRef="Os.bmd"/&gt;
    &lt;CommonSettings DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef="CAN_BSW_Cfg.xml"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Wdg" ParameterDefinitionRef="Wdg.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Fls" ParameterDefinitionRef="Fls_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlu_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Spi" ParameterDefinitionRef="Spi_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlu_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Pwm" ParameterDefinitionRef="Pwm_<xsl:value-of select="//SRS/MCU/SPEC/@Lower_case_MCU_name"/>xlu_lqfp<xsl:value-of select="//SRS/MCU/SPEC/@replaced_Package_number"/>.epd"/&gt;
    &lt;Module DescriptionRef="<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_SPC560XB_MCAL_Config_1st_pass.xml" GenerationRef=""
        GenerationRequest="false" Name="Fee" ParameterDefinitionRef="Fee.epd"/&gt;
    &lt;CODE_GENERATION&gt;
        &lt;TEMPLATE Name="mcal_inc_h" OutFile="mcal_inc.h" Used="true" XSLTemplate="mcal_inc_h.xsl"/&gt;
    &lt;/CODE_GENERATION&gt;
&lt;/EcuConfigSettings&gt;</xsl:when>
</xsl:choose>
</xsl:template>



</xsl:stylesheet>