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

##############################################################
### this code made by auto integration ###
### Generated on: <xsl:value-of select="date:new()"/> 


# 'DOS_USE_API_REMOVAL' removed
# 'DOS_BUILD_OPTIMIZED_LIB_FROM_SOURCE=TRUE'  removed

# define '-DOS_EXCLUDE_HW_FP' removed 
# define '-DINIT_SRAM' removed 
# C Source 'bfccu.c' removed

# tool chain 'TS_PLATFORM=gh_ppc_614.14p.bolero_mcal3.0.5hf3' Apply 
### ver 1.0.9
# for applying Delivery box 'cw34_14_a'
# remove 'vector_can_check.c'
# boot memory section changed according to 'b_pf_fbl_st_spc560xb_core-2.6' module update
### ver 1.1.0
# for applying Delivery box 'cw42_14_a'
# step010 change '--prototype_warnings' -> '--prototype_errors'
# step550 remove '--prototype_warnings' when IDE Version was chosen '614_14_mcal_305hf3'
### ver 1.1.1
# for applying Delivery box 'cw43_14_a'
# remove 'mcal_isr_if.c \' 'mcal_isr_if.o|'
# step550 change 'MEMORY' and 'SECTIONS' Part according to FBL SCM Document
# add error handle when value of '//SRS/MCU/SPEC/@RAM_SIZE' is invalid
# change condition of making 'bbbaift.c' 
# remove unnecessary condition associate with FBL
### ver 1.1.2
# remove these code according to mail which sent by Ji-hoon Jung on 14.12.29 
#step 010 :
#-DTS_ARCH_FAMILY=TS_PA 
#-DTS_ARCH_DERIVATE=TS_XPC564XB
#-DGHS_COMPILER_VERSION=614
#step 550:
#-DTS_ARCH_FAMILY=TS_PA 
#-DTS_ARCH_DERIVATE=TS_XPC564XB
#-DGHS_COMPILER_VERSION=614
#-DXPC564XB=1
### ver 1.1.3
# error fix of 'SECTIONS' Part (for 1st section FBL Case)
# remove define '-DOS_MC_BASE_ADR' 
### ver 1.1.4
# tool chain 'TS_PLATFORM=gh_ppc_614.14p.bolero_mcal3.0.5hf5' Apply 
# add 'BOOT_DATA_BASE' in 'DEFAULTS' of 'Step550'
# remove logic for making 'mdata' section in 'MEMORY' of 'Step550'
# caution for 'BOOT_DATA_BASE'. According to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', 
# but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting of 'AIS' and 'SCM'
### ver 1.1.5
# Error fix of Step 550 about case of '//SRS/MCU/SPEC/@IDE_Version'
### ver 1.1.6
## Error fix of compile option (according to which Compile option added on Aug 22 in 2014) 
# add '--short_enum' in step010
# add '--no_commons' in step010
## verify Compile and linker option with Ji-hoon Jung on Jun 9th in 2015
### ver 1.1.7
#remove some comment of ver 1.1.6 history, because it makes unknown error doing 'Make'
### ver 1.1.8
# remove option -DINIT_SRAM=1 in step550 when using toolchain 614_14_mcal_305hf3 and 614_14_mcal_305hf5 case
### ver 1.1.9
## verify 1st pass Compile and linker option with Ji-hoon Jung on Jul 29th in 2015
# when using toolchain 614_14_mcal_305hf3 and 614_14_mcal_305hf5 case
# remove -Oipdeleteglobals in step550 (according to 'b_spc560xb_swp_lib-36')
# remove -delete in step550 (according to 'b_spc560xb_swp_lib-36')
### ver 1.2.0
# add link option(-keep=bbmcu_ExctTable) in step550  (According to Guide line from Jin-suk Park(2015-09-02 16:35))
### ver 1.2.1
# error fix logic of Making Lin Include (step 400, step540)
### ver 1.2.2
# tool chain 'TS_PLATFORM=gh_ppc_614.14p.bolero_mcal3.0.5hf5ts14' Apply 
### ver 1.2.3
# error fix (step550 add case for tool_chain 614_14_mcal_305hf5ts14
##############################################################

<xsl:message  terminate ="no">
==========================================================================
PDR 1st pass Generaiton Message
==========================================================================
</xsl:message>  


[step000#Dod0y0gKADPq9bMcvdrbAA]
FORCE_STANDALONE=0
NO_CW_EDITOR=0
TS_DIR_FILTER=
TS_EXT_FILTER=.850 .asm .bat .c .cfg .cin .cnf .def .h .idc .inc .lib .a .loc .par .pl .pm .src .s .dll .ini .exe .xml .xsl .xsd .jar .arxml .epd .bmd
TS_LOCAL=
<xsl:choose> 
<xsl:when test="//SRS/MCU/SPEC/@IDE_Version ='517'">
TS_PLATFORM=gh_ppc_517bolero_mcal3.0.4hf13
</xsl:when>
<xsl:when test="//SRS/MCU/SPEC/@IDE_Version ='614_14_mcal_304hf13'">
TS_PLATFORM=gh_ppc_614.14p.bolero_mcal3.0.4hf13
</xsl:when>
<xsl:when test="//SRS/MCU/SPEC/@IDE_Version ='614_14_mcal_305hf3'">
TS_PLATFORM=gh_ppc_614.14p.bolero_mcal3.0.5hf3
</xsl:when>
<xsl:when test="//SRS/MCU/SPEC/@IDE_Version ='614_14_mcal_305hf5'">
TS_PLATFORM=gh_ppc_614.14p.bolero_mcal3.0.5hf5
</xsl:when>
<xsl:when test="//SRS/MCU/SPEC/@IDE_Version ='614_14_mcal_305hf5ts14'">
TS_PLATFORM=gh_ppc_614.14p.bolero_mcal3.0.5hf5ts14
</xsl:when>
<xsl:otherwise>
<xsl:message  terminate ="yes">
=======================================================================================================================
'Error 		//SRS/MCU/SPEC/@IDE_Version   ->AIS 지원하지 않는 Toolchain Version (누락된 경우 포함)
=======================================================================================================================</xsl:message>  												
</xsl:otherwise>
</xsl:choose>
TS_VERSION=TS_UNI_V6R4
TS_WA_CHECK=1
TS_ZIPNAME=
VERBOSITY=10

[step003#1B2M2Y8AsgTpgAmY7PhCfg]

[step005#1B2M2Y8AsgTpgAmY7PhCfg]

[step010#qa74XL33MLpJEFaoC5dt4g]
VARIANT=

[step010~asopt.cfg#ivGdaBM/4BnC0e9YCgGtkg]
#check these options with Ji-hoon Jung on Jun 9th in 2015
-c
-MD
-cpu=ppc560xb
-vle
-noSPE
-dwarf2
--prototype_errors
--no_exceptions
-sda=0
-Ogeneral
-DOS_RELEASE_SUFFIX=OS_AS31
-DOS_HAS_MCSR
-DOS_TOOL=OS_ghs 
-DOS_ARCH=OS_PA 
-DOS_CPU=OS_XPC560XB 
-DOS_MEMMAP=0 
-DOS_PA_VLE=1
-D_GREENHILLS_C_PPC_ 
-DOS_KERNEL_TYPE=OS_SYSTEM_CALL
-DAUTRON_XENON_FIX
-dual_debug
-asm=-dwarf
-g

 
[step010~ccopt.cfg#6er1NySpveuWMO6sNfrPyA]
#check these options with Ji-hoon Jung on Jun 9th in 2015
###option only for 1st pass
-DIN_BOOT
-DSCHM_USE_MACROS
###1st pass and 2nd pass
## not included in 'app_bolero_ghsmulti.docx'
-c
-g
-cpu=ppc560xb
## included in 'app_bolero_ghsmulti.docx' 
-vle
-noSPE
-dwarf2
--prototype_errors
--no_exceptions
--no_commons
-sda=0
-Ogeneral
--short_enum
-MD
-DOS_TOOL=OS_ghs
-DOS_ARCH=OS_PA
-DOS_CPU=OS_XPC560XB 
-DOS_MEMMAP=0
-DOS_PA_VLE=1
-D_GREENHILLS_C_PPC_
-DOS_KERNEL_TYPE=OS_SYSTEM_CALL
-DAUTRON_XENON_FIX
-DADC_PRECOMPILE_SUPPORT
-DOS_RELEASE_SUFFIX=OS_AS31
-DOS_HAS_MCSR

###AIS define
<xsl:if test="//SRS/MEM/EEPROM/DEVICE/@Internal ='Yes'">
</xsl:if>
<xsl:for-each select="//SRS/PDR_CODE_DEFINE/*">
-D<xsl:value-of select="@Name"/>
</xsl:for-each>



#[step100#1B2M2Y8AsgTpgAmY7PhCfg]

[step100~cygnusCU.reg#EPab5rnYR/aAyCezyMFMlA]
REGEDIT4

[HKEY_CURRENT_USER\Software\Cygnus Solutions]

[HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin]

[HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin\mounts v2]
"cygdrive prefix"="/cygdrive"
"cygdrive flags"=dword:00000020

[HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin\mounts v2\/]
"native"="%CYGWIN_COMP%"

[HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin\mounts v2\/usr/bin]
"native"="%CYGWIN_COMP%/bin"

[HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin\mounts v2\/usr/lib]
"native"="%CYGWIN_COMP%/lib"

[step100~cygnusLM.reg#OkhrpSYgyPK8ejxo0dgPeQ]
REGEDIT4

[HKEY_LOCAL_MACHINE\Software\Cygnus Solutions]

[HKEY_LOCAL_MACHINE\Software\Cygnus Solutions\Cygwin]

[HKEY_LOCAL_MACHINE\Software\Cygnus Solutions\Cygwin\mounts v2]
"cygdrive prefix"="/cygdrive"
"cygdrive flags"=dword:00000020

[HKEY_LOCAL_MACHINE\Software\Cygnus Solutions\Cygwin\mounts v2\/]
"native"="%CYGWIN_COMP%"

[HKEY_LOCAL_MACHINE\Software\Cygnus Solutions\Cygwin\mounts v2\/usr/bin]
"native"="%CYGWIN_COMP%/bin"

[HKEY_LOCAL_MACHINE\Software\Cygnus Solutions\Cygwin\mounts v2\/usr/lib]
"native"="%CYGWIN_COMP%/lib"


[step110#XpuKfUv6CRzQrVaXDeAQFQ]
M4_SOURCES=
TARGETID=MONO
 
 

[step130#h+Uc4NJ+XsD7WEps6Zulwg]
############################################
#  2nd Pass : ASW XML
############################################
APP_XML_SOURCES=
 
S13_SHOW_OUTPUT=1
############################################
#  1st Pass : SWP XML
############################################
SWP_XML_SOURCES= \
EcuConfigSettings.xml \
						<xsl:for-each select="//SRS/CODE_GENERATION/*"> 
				<xsl:if test="contains(./@OutFile,'xml')">
						<xsl:if test="not(contains(./@OutFile,'xmlprj'))">
						<xsl:if test="not(contains(./@OutFile,'MCAL_Config_1st_pass'))">
						<xsl:if test="not(contains(./@OutFile,'EcuConfigSettings'))">
<xsl:if test="contains(./@OutFile,'1st')">
<xsl:value-of select="substring-after(@OutFile,'\')"/> 	\  
</xsl:if>
						</xsl:if>
						</xsl:if>
						</xsl:if>
				</xsl:if>
			</xsl:for-each>

# THE GENERIC XML PART #
<xsl:if test="//SRS/IO/BATMON/@Enable='Yes'">bibatmon.xml \
</xsl:if>  
<xsl:if test="//SRS/MEM/EEPROM/DEVICE/@Internal ='No'">bscomeep.xml \
</xsl:if>
biomanag.xml

MCAL_XML_SOURCES= \
EcuConfigSettings.xml \
<xsl:for-each select="//SRS/CODE_GENERATION/*"> 
				<xsl:if test="contains(./@OutFile,'xml')">
					<xsl:if test="contains(./@OutFile,'MCAL_Config_1st_pass')">
						<xsl:if test="contains(./@OutFile,'1st')">
<xsl:value-of select="substring-after(@OutFile,'\')"/>
						</xsl:if>
					</xsl:if>
				</xsl:if>
</xsl:for-each>

XML2C_H=1stPASS


#[step150#IUzHd0Ja/Aluf/AwuzE9WQ]
MODEL=BANKED
MODEL_LIB=

[step320#1B2M2Y8AsgTpgAmY7PhCfg]

[step390#1B2M2Y8AsgTpgAmY7PhCfg]

[step400#T0Bqp3DYWqrSBcLIySGW2A]
C_SOURCES= \
############################################
# FBL
############################################
bbstartup.c \
bbplldrv.c \
bbmcuinit.c \
bbtmrdrv.c\
bbwdgdrv.c \
bbhwvect.c \
bbcore.c \
bbswmap.c \
bbidentification.c \
<xsl:if test="//SRS/MEM/CHECK/@Enable ='Yes'"> 
bbbaift.c \
</xsl:if>
trdrv_hal.c \
zdeolos.c \
treolos.c \
bbeoljob.c \
<xsl:if test="//SRS/FBL/CORE/@ECU_Specific_Job ='Yes'">bbecujob.c \</xsl:if>
<xsl:if test="//SRS/EOL/@Type ='CAN'">
bbcandrv.c \
</xsl:if> 
<xsl:if test="//SRS/FBL/CORE/@Diag_Job ='Yes'">
bbsiecrc.c \
bbcantp.c \
bbflashtbx.c \
bbflashdrv.c \
bbdiagjob.c \
</xsl:if>
<xsl:if test="//SRS/EOL/@SeedMethod ='RANDOM'">
brandom.c \
bbrandgen.c \
bbeolseedkey.c \
</xsl:if>
######################
#####	KLINE	 #####
######################
<xsl:if test="//SRS/EOL/@Type ='KLINE'">
bbasc_hal.c \
bbkwpdrv.c \
bbkwpmngr.c \
</xsl:if>
######################
#  EOL Static Code  #
######################
breboot.c \
bsseedsi.c \

############################################
#  MCAL
############################################
######################
#  MCAL Static Code  #
######################
#############
#  Adc      #
#############
ADCDig_LLD.c \
Adc.c \
Adc_Irq.c \
Adc_LLD.c \
Adc_NonASR.c \
ctu_lld.c \
Reg_eSys_ADCDig.c\
#############
#  Dio      #
#############
Dio.c \
Siul_LLD_dio.c \
#############
#  Ecum     #
#############
EcuM.c \
#############
#  Fee      #
#############
Fee.c \
#############
#  Fls      #
#############
Fls.c \
Fls_Ac.c \
#############
#  Gpt      #
#############
Gpt.c \
Gpt_Irq.c \
Gpt_LLD.c \
Gpt_NonASR.c \
Pit_Gpt_LLD.c \
Pit_Gpt_LLD_IRQ.c \
Reg_eSys_EMIOS_Gpt.c \
Rtc_Gpt_LLD.c \
Rtc_Gpt_LLD_IRQ.c \
Stm_Gpt_LLD.c \
Stm_Gpt_LLD_IRQ.c \
eMIOS_Gpt_LLD.c \
#############
#  Icu      #
#############
Icu.c \
Icu_LLD.c \
Icu_NonASR.c \
Reg_eSys_EMIOS_Icu.c \
SIUL_Icu_LLD.c \
SIUL_Icu_LLD_IRQ.c \
WKPU_Icu_LLD.c \
WKPU_Icu_LLD_IRQ.c \
eMIOS_Icu_LLD.c \
eMIOS_Icu_LLD_IRQ.c \
#############
#  Mcu      #
#############
<xsl:if test="//SRS/MCU/SPEC/@Name ='MPC5605B' or //SRS/MCU/SPEC/@Name ='MPC5606B' or //SRS/MCU/SPEC/@Name ='MPC5607B'  or //SRS/MCU/SPEC/@Name ='SPC560B54' or //SRS/MCU/SPEC/@Name ='SPC560B60' or //SRS/MCU/SPEC/@Name ='SPC560B64'">
<xsl:if test="//SRS/MCU/SPEC/@Package ='PACKAGE_144' or //SRS/MCU/SPEC/@Package ='PACKAGE_176'">
Dma_LLD.c \				
Dma_Mcu_LLD.c \				
</xsl:if>
</xsl:if>
Flash_Mcu_LLD.c \
Mcu.c \
Mcu_Irq.c \
Mcu_LLD.c \
Reg_eSys_EMIOS.c \
#############
#  Port     #
#############
Port.c \
Siul_LLD.c \
#############
#  Pwm      #
#############
Pwm.c \
Pwm_Irq.c \
Pwm_LLD.c \
Pwm_NonASR.c \
Reg_eSys_EMIOS_IRQ_PWM.c \
Reg_eSys_EMIOS_PWM.c \
eMIOS_Pwm_LLD.c \
eMIOS_Pwm_LLD_IRQ.c \
#############
#  Spi      #
#############
<xsl:if test="//SRS/MCU/SPEC/@Name ='MPC5605B' or //SRS/MCU/SPEC/@Name ='MPC5606B' or //SRS/MCU/SPEC/@Name ='MPC5607B'  or //SRS/MCU/SPEC/@Name ='SPC560B54' or //SRS/MCU/SPEC/@Name ='SPC560B60' or //SRS/MCU/SPEC/@Name ='SPC560B64'">
<xsl:if test="//SRS/MCU/SPEC/@Package ='PACKAGE_144' or //SRS/MCU/SPEC/@Package ='PACKAGE_176'">
Dma_Spi_LLD.c \		
</xsl:if>
</xsl:if>
Dspi_LLD.c \
Spi.c \
Spi_Irq.c \
#############
#  Wdg      #
#############
Swt_LLD.c \
Wdg.c \
Wdg_Irq.c \
Wdg_LLD.c \
#############
#  Stub     #
#############
Dem.c \
Det.c \
######################
#  MCAL Gen Code     #
######################
Adc_Cfg.c \
Adc_PBcfg.c \
Clocks_LLD.c \
Dio_Cfg.c \
Dio_PBcfg.c \
Fee_Cfg.c \
Fls_PBcfg.c \
Gpt_Cfg.c \
Gpt_PBcfg.c \
Icu_Cfg.c \
Icu_PBcfg.c \
Mcu_Cfg.c \
Mcu_PBcfg.c \
Modes_LLD.c \
Monitor_LLD.c \
Port_Cfg.c \
Port_PBcfg.c \
Power_LLD.c \
Reset_LLD.c \
Wdg_Cfg.c \
Wdg_Lcfg.c \
Wdg_PBcfg.c \
Spi_Cfg.c \
Pwm_Cfg.c \
Pwm_PBcfg.c \
<xsl:if test="//SRS/MCU/SPEC/@Name ='MPC5605B' or //SRS/MCU/SPEC/@Name ='MPC5606B' or //SRS/MCU/SPEC/@Name ='MPC5607B'  or //SRS/MCU/SPEC/@Name ='SPC560B54' or //SRS/MCU/SPEC/@Name ='SPC560B60' or //SRS/MCU/SPEC/@Name ='SPC560B64'">
<xsl:if test="//SRS/MCU/SPEC/@Package ='PACKAGE_144' or //SRS/MCU/SPEC/@Package ='PACKAGE_176'">
Dmamux_LLD.c \ 
</xsl:if>
</xsl:if>
############################################
#  OS Kernal: SC1 
############################################
Os_configuration.c \
Os_configuration_PA.c \
PA_interruptvectors_sw.c \
PA_intdisableconditional.c \
Os_gen.c \
############################################
#  OS BSW
############################################
bstartrtsw.c \
<xsl:if test="//SRS/OS/DEBUG/@CPULoad ='Yes' or //SRS/OS/DEBUG/@ITLoad ='Yes' or //SRS/OS/DEBUG/@StackDepth ='Yes'">
bdebug.c \
</xsl:if> 
os_api.c \

bsalarms.c \
bvirvect.c \
bsysstartup.c \
#sys_startup.c \
oscore.c \
bidletask.c \
bswphook.c \
bspll.c \
zfalarms.c \
zisrmanag.c \
bexception.c \  
############################################
#  CORE
############################################
bfasttimer.c \
bcinterp.c \
bcdivide.c \
bcfilter.c \
bcmodulo.c \
bcmulti.c \
bcwait.c \
brstmanag.c \
bssyserr.c \
bswdogmngr.c \
bslowtimer.c \
evtman.c \
<xsl:if test="//SRS/CORE/RANDOM/@Enable ='ENABLE'">
#random 
bcrandom.c \
</xsl:if>
<xsl:if test="//SRS/CORE/REGMONITOR/@Enable ='ENABLE'">
# in case of using register monitoring------------
bswsecur.c \
zdsecuri.c \
</xsl:if>
############################################
#  PM
############################################
swppm.c \
swppmhal.c \
<xsl:if test="//SRS/CORE/TIMER/@System_time_usage ='ENABLE'">
bsystime.c \
</xsl:if>  
############################################
#  MEMORY
############################################
bsramini.c \
bsramctl.c \
ctlram_data.c \
bcmemuti.c \
bcflgman.c \
############################################
#  RAM/ROM Check
############################################
<xsl:if test="//SRS/MEM/CHECK/@Enable ='Yes'"> 
bsmemchk.c \
bsmemchk_hal.c \
</xsl:if>
<xsl:if test="//SRS/CORE/UDS/@Usage ='Yes'">
############################################
#  DIAG UDS
############################################
Dcm.c \
ComM_Dcm.c \
SchM_Dcm.c \
Dcm_Cbk.c \
Dcm_Dsd.c \
Dcm_DsdInternal.c \
Dcm_Dsl.c \
Dcm_DslInternal.c \
Dcm_DspMain.c \
Dcm_DspServices.c \
Dcm_Ram.c \
</xsl:if>
<xsl:if test="//SRS/CORE/KLINE/@Enable ='Yes'">
############################################
#  DIAG KWP2000
############################################
dpkw2000.c \
xsasccom.c \
encaptimev.c \
</xsl:if> 
############################################
#  EEPROM
############################################
<xsl:choose> 
<xsl:when test="//SRS/MEM/EEPROM/DEVICE/@Internal ='Yes'">
#----------------------
# Internal EEPROM
#----------------------
</xsl:when>
<xsl:otherwise>
#----------------------
# External EEPROM
#----------------------
</xsl:otherwise>
</xsl:choose>
bscomeep.c \
beepmana.c \
############################################
#  SPI
############################################
<xsl:if test="//SRS/COM/SPIS/*/@Enable ='Yes'">
bscomspi.c \
bscomspi_cfg.c \
</xsl:if>
############################################
#  CAN
############################################
bxstman.c \
bxstman_nm.c \
bxstman_trcv.c \
#il.c \
#nm_osek.c \
#nm_basic.c \
#nm_par.c \
#nmb_par.c \
#il_par.c \
#can_par.c \
#drv_par.c \
#v_par.c \
sm_1st_cfg.c \
#tpmc.c \
#tp_par.c \
############################################
#  CAN Adaptation
############################################
#vstdlib.c \
#can_drv.c \

############################################
#  IO module
############################################
biostartup.c \
bidigdir.c \
bodigdir.c \
bidigfil.c \
bianadir.c \
bianafil.c \
biotimer.c \
bopwmout.c \
biomanag.c \
<xsl:if test="//SRS/IO/BATMON/@Enable='Yes'">
bibatmon.c \
</xsl:if> 
<xsl:if test="//SRS/IO/GENERAL/@VirtualInputs='Yes'">
bivirpor.c \
</xsl:if>
<xsl:if test="//SRS/IO/MUXOUT/MUXOUT_ATM39/@Number_of_Chip !='0'">
bo_atm39.c \ 
</xsl:if>	
<xsl:if test="//SRS/IO/MUXOUT/MUXOUT_L99MC6/@Number_of_Chip !='0'">
bo_l99mc6.c \
</xsl:if>
<xsl:if test="//SRS/IO/MUXOUT/MUXOUT_TLE7240SL/@Number_of_Chip !='0'">
bo_tle7240sl.c \
</xsl:if>
<xsl:if test="//SRS/IO/MUXIN/MUXIN_MC33972/@Number_of_Chip !='0'">
bi_mc33972.c \
</xsl:if>	
<xsl:if test="//SRS/IO/MUXIN/MUXIN_HC151/@Number_of_Chip !='0'">
bihc151.c \
</xsl:if>	

io_timer.c \
IoHwAb_adc_access_hal.c \
IoHwAb_freq_access.c \
IoHwAb_freq_access_hal.c \
<xsl:if test="//SRS/IO/INSWITCH/DSW/@Enable='Yes'">
bisupply.c \
</xsl:if> 
swp_data.c\
############################################
#  ASC
############################################
<xsl:if test ="//SRS/COM/ASCS/*/@Enable='Yes'">
asc_hal.c  \
</xsl:if>
############################################
#  LIN
############################################
<xsl:if test ="//SRS/COM/ASCS/*[@Usage_Mode='LIN' and @Enable = 'Yes']">	
	<xsl:if test ="//SRS/COM/LIN/*[@LIN_Enable='Yes' and @LIN_ASC_Channel !='']">
lin_1st_cfg.c \
lin_adapt_swp.c \
lin_config_api.c \
lin_core_api.c \
lin_protocol.c \
lin_tp_raw_api.c \
	</xsl:if>
</xsl:if>


############################################
#  Application
############################################
#noseqman.c 
############################################
#  SWP Integration
############################################
zinitswp.c \
zswptask.c 


[step410#p3v7/VJcL/GogIJv7KV6qw]
ASM_SOURCES= \
###########################################
#   OS Kernal: SC1
###########################################
PA_exceptionvectors_booke.s \
#PA_initcache_e200.s \
PA_initram.s \
PA_locking.s \
SWP_interrruptvectors_hw.s \
############################################
# FBL
############################################
bbPA_initram.s

#[step420#EkLBxlwFmdaIjznglSKItw]
XC_SOURCES= 


[step450#3Yk5XCNGAq+d9pnObfXm5g]
LINT_DEBUG=0
QYCHECK_CONTROLS_OFF=1

[step450~S45_header.lh#1B2M2Y8AsgTpgAmY7PhCfg]



[step450~S45_specific.lnt#JVBay05CRtIHsTIWVnyX9w]



+rw(far, __far, near, __near,__dptr, __eptr, __pptr, __rptr, __interrupt)
-esym(950, far, __far, near, __near,__dptr, __eptr, __pptr, __rptr, __interrupt)

+rw(PAGE)			       
-esym(950, PAGE)

+pragma(asm, off)
+pragma(endasm, on)



-d__HC12__=
-d__HCS12X__=
-d__HIWARE__=
-d__ARCHIMEDES__=
-d__MWERKS__=1
-d__STDC__=0
-d__PRODUCT_HICROSS_PLUS__=
-d__PTR_SIZE_2__=
-d__NO_DPAGE__=
-d__NO_EPAGE__=
-d__NO_GPAGE__=
-d__NO_PPAGE__=
-d__NO_RPAGE__=
-d__BIG_ENDIAN__=
-d__LITTLE_ENDIAN__=
-d__SIZE_T_IS_UINT__=
-d__PTRDIFF_T_IS_INT__=
-d__BITFIELD_MSBYTE_FIRST__=
-d__BITFIELD_MSWORD_FIRST__=
-d__PLAIN_BITFIELD_IS_SIGNED__=
-d__CHAR_IS_UNSIGNED__=
-d__CHAR_IS_8BIT__=
-d__SHORT_IS_16BIT__=
-d__INT_IS_16BIT__=
-d__FLOAT_IS_IEEE32__=
-d__DOUBLE_IS_IEEE32__=
-d__LONG_IS_32BIT__=
-d__LONG_DOUBLE_IS_IEEE32__=
-d__LONG_LONG_IS_32BIT__=
-d__LONG_LONG_DOUBLE_IS_IEEE32__=
-d__ENUM_IS_16BIT__=
-d__ENUM_IS_SIGNED__=

-dasm=_to_semi

-dISR=_to_eol

-dSET_SIGNAL_O_BI_RfItAut_=SET_SIGNAL_O_BI_RfItAut_0

-d__asm=_to_brackets 



-sb8				// 8 bits form one byte
-sc1				// sizeof(char)
-ss2				// sizeof(short)
-si4				// sizeof(int), V850ES is 32bit micom
-sl4				// sizeof(long)
-sf4				// sizeof(float)	
-sd4				// sizeof(double)
-sld4				// sizeof(long double)
-sll4				// sizeof(long long int)
-spN2				// sizeof(near *)code and data !
-spF3				// sizeof(far *) code and data !



-$				//enable $

[step450~S45_standard.lnt#3BGuTvMSx7OAvteuElqZFw]

-w3				// warning 레벨지정 : default는 3이며 error, warning, informatiion을 모두 포함한다. 
-idlen(32767)			// Carnes, HC12는 32767개 까지 변수 길이를 지원함
-t4				// 탭수 정의						
+macros
+macros
+macros
+macros

-h1
-width(500,20)
-"format=%f(%l): %t %n: %m"  // 메세지 형식 , %f=파일네임, %l= 라인넘버,  %t=메세지타입, %n=메세지 넘버, %m= 메세지 문자열

-passes(2,,-e796 -e797 -e794 -e613 -e413)

-cwh  // Establishes @ as a one-character identifier
+fba  // Bit Addressability, int a.3가능
+fbu  // Bit fields are Unsigned
+fce  // Continue-on-Error,  #error 문이 나와도 수행 계속함
+fcu  // Char-is-Unsigned, char은 unsigned char로 간주함
-fdr  // Deduce-Return-mode
+fem  // Early Modifiers, type 순서 변경가능
+fep  // Extended Pre-processor variable
+ffn  // Full (file) Name flag
-fkp  // K&amp;R Preprocessor
-fnc  // Nested Comments
-ftg  // TriGraph flag


-rw(*ms)
+rw(interrupt, _to_brackets, _to_eol, _to_semi, asm, _asm, __asm)  // reserved word 로 등록함, 
-esym(950, interrupt, _to_brackets, _to_semi, _to_eol, _gobble, asm, _asm, __asm)

+derrno=errno_violates_MISRA_Rule_119
+doffsetof=offsetof_violates_MISRA_Rule_120

-wlib(1) 			// reduce check of lib headers to severe errors only, library header의 에러만 검사함, 
-elib(14)  			// symbol previously defined, 심볼이 두번 define됨
-elib(515) 			// 함수의 argument의 갯수가 일치하지 않음
-elib(516) 			// 함수의 argument의 타입이 일치하지 않음 
-elib(760)			// suppress message about multiple identical macro defs, MACRO가 중복되어 define 되었음
-elib(762)			// suppress message about multiple identical declarations, 심볼이 여러 파일에서 중복되어 동일하게 declaration 되었음..

+headerwarn(locale.h)		// 등록된 파일이 사용되면 Info 829 메세지가 발생됨
+headerwarn(stdio.h)

+elib(829)			// enable warning for include of forbidden header files, 위의 829메세지가 wlib(1)에 관계없이 나타남

-function(exit, Reset_ECU, bfsyserr_rst)		// function to be used just as return/exit
-function(gets(0),calloc,malloc,realloc,free)
-function(gets(0),setlocale,localeconv)
-function(gets(0),longjmp,setjmp)
-function(gets(0),signal,raise)	          
-function(gets(0),atof,atoi,atol)	   
-function(gets(0),getenv,system)	          
-function(gets(0),time,strftime,clock,difftime,mktime)	 

+libclass(angle)		

+libh(regst7.h, stdtypedef.h, typedef.h, typegene.h, zdsigapi.h, zfscjobs.h, zrshared.h, zbootreq.h)

+libh(basicio.h, bspwm.h, bxecancf.h, bxicancf.h, zdeeprom.h, zdflgdyn.h, zdmsgape.h, zdmsgapi.h, zfscjobs.h, zhecudef.h, zhsysdef.h, zhtimcfg.h, zvect.h)

+libh(os*.h)

+libh(bitram.h, homisc.h, vnmmo.h, ccppar.h, ccp.h, fdappgen.h,  hc08az32.h, zfcandbe.h, zfcansup.h, zhpwmout.h)
+libh(zde2prom.h, n_onmdef.h, zfcandb.h, timerHC12.h, fs_flags.h, mcs912*.h, zdpresen.h,zdlincnf.h,upwalexp.h,diagx*.h)
+libh(appl_fbl.h, can_cfg.h, can_def.h, can_inc.h, dbk_cfg.h, dbk_def.h, diag.h, dagxcfg.h, diaxdef.h, n_onmdef.h, nm_cfg.h)
+libh(tp.h, tp_cfg.h, trdrvcan.h, v_cfg.h, v_def.h, bscntman.h, bxicandr.h, bxecandr.h, referevc.h, definevc.h)
+libh(sc12d*.h, bscomasc.h, eq.h, io7891*.h, in78000.h, reg164.h, bso166.h, can_ls.h, can_hs.h, zdasccom.h, zhtimsrv.h)
+libh(regmlx16.h, osalmapi.h, start08.h, hw_hc08.h)

+libh( 6808*.h, 6812*.h, 68hc*.h, 78k_rtsl.h, __dbg_.h, _malloc.h, algo*.h, allocr.h, assert.h )
+libh( basics.h, bit.h, bitd*.h, bitprims.h, bits*.h, bool.h, builtin.h, bvector.h, c166.h )
+libh( candefs.h, canr_16x.h, ccst*.h, cerrno.h, cheap.h, checksum.h, cinst.h, cmath.h, comp*.h )
+libh( config.h, cstd*.h, cstring.h, ctype.h, dcomplex.h, dconv.h, defalloc.h, defines.h, defns.h )
+libh( deque.h, dl78*.h, dlib*.h, dpage.h, dregs.h, dtor_rec.h, embedded.h, epage.h, errno.h )
+libh( faralloc.h, fcntl.h, fcomplex.h, fdeque.h, fenv.h, fibonacci.h, flist.h, floa*.h, fmap.h )
+libh( fmul*.h, fregs.h, fset.h, fss.h, fstream.h, function.h, gconfig.h, generic.h, ghcxx.h )
+libh( ghs_*.h, hc12a4.h, hc91*.h, hcs908ct16.h, hdeque.h, heap.h, hidef.h, hiware.h, hlist.h )
+libh( hmap.h, hmul*.h, hset.h, hugalloc.h, hvector.h, i812a4.h, i912*.h, iccext.h, iccfloat.h )
+libh( icclbutl.h, ieeemath.h, in78000.h, inline.h, inout.h, int6812.h, int812a4.h, int9*.h, inte*.h )
+libh( intr*.h, io.h, io17801x.h, io78*.h, ioas.h, ioaz.h, iolibio.h, iomanip.h, iost*.h )
+libh( ioxl.h, iso646.h, iterator.h, lbvector.h, ldcomplx.h, ldeque.h, libdefs.h, libi*.h, limits.h )
+libh( list.h, llist.h, lmap.h, lmul*.h, lngalloc.h, locale.h, lset.h, lustart.h, m6808p16.h )
+libh( main.h, malloc.h, map.h, math.h, mc68*.h, mc9s*.h, memory.h, migration.h, milieu.h )
+libh( misra.h, mult*.h, nec.h, neralloc.h, new.h, nmap.h, nmul*.h, nset.h, obstack.h )
+libh( pair.h, predef.h, projectn.h, r812a4.h, r912*.h, reg1*.h, reg2*.h, regc*.h, regex.h )
+libh( regs*.h, regx*.h, rtsh*.h, rtsl*.h, rtsst7.h, runtime.h, rx.h, set.h, setjmp.h )
+libh( sflt*.h, signal.h, simio.h, softfloa.h, st72311.h, stack.h, star*.h, std.h, stdarg.h )
+libh( stdbool.h, stddef.h, stderr.h, stdi*.h, stdlib.h, stdtypes.h, stl.h, stre*.h, strfile.h )
+libh( stri*.h, strs*.h, sysmac.h, system.h, target.h, tempbuf.h, term*.h, time.h, trace.h )
+libh( tree.h, tutor.h, unistd.h, utilities.h, varargs.h, vec_newdel.h, vector.h, vregs.h, vt100.h )
+libh( wchar.h, wctype.h, xalloc.h, xdump.h, xenc*.h, xinstantiate.h, xloc*.h, xmath.h, xmtloc.h )
+libh( xmtx.h, xstate.h, xstdio.h, xstrxfrm.h, xtime.h, xtinfo.h, xtls.h, xwchar.h, xwcsxfrm.h )
+libh( xwstdio.h, xxacos.h, xxasin.h, xxat*.h, xxcctype.h, xxceil.h, xxco*.h, xxdftype.h, xxdi*.h )
+libh( xxdn*.h, xxds*.h, xxdt*.h, xxdu*.h, xxexp.h, xxfabs.h, xxfftype.h, xxfloor.h, xxfmod.h )
+libh( xxfrexp.h, xxldexp.h, xxlftype.h, xxlo*.h, xxmemxfuncs.h, xxmodf.h, xxpow.h, xxsi*.h, xxsqrt.h )
+libh( xxstod.h, xxta*.h, xxtd.h, xxtf.h, xxtl.h, xxtundef.h, xxwctype.h, xxxatan.h, xxxcosh.h )

+libh( ilpar.h, IPM.h )		// CAN GEN 생성파일(Carnes)
+libh( mcureg.h, MemMap.h )		// NEC Micom관련 
+libh( string.h )    // file from NEC compiler 
+libh( CanIf_Types.h, Can_RegStruct.h, Adc_PBTypes.h, EEELibGlobal.h )    // file from NEC MCAL 
+libh( alarm.h, asm.h, callevel.h, constant.h, counter.h, cpu.h, error.h, frame.h, funcno.h, hook.h, io.h, isr.h, kernel.h, oil.h, os.h, product.h, resource.h, service.h, sys.h, task.h, trc.h, types.h )  // header from NEC OSEK  
+libh( SPC560B64_0103.h )		// Bolero MCU 관련
-emacro(723,VALUE)		// suspicious of '='
-efile(*,deframby.h)		// special #pragma file
-efile(*,deframwo.h)		// special #pragma file
-efile(*,defromby.h)		// special #pragma file
-efile(*,defromwo.h)		// special #pragma file
-efile(*,basicprg.h)		// special #pragma file

-efile(766, defr*.h,bitram.h,bmdatend.h,bmr*.h)	// suppress "header file not used" for includes with #pragma directives only

-esym(522,GET_SIGNAL_I_BI_*)
-esym(522,SET_SIGNAL_I_BI_*)
-esym(621,GET_SIGNAL_I_BI_*)
-esym(621,SET_SIGNAL_I_BI_*)
-esym(621, _static_?_*)	

-emacro(10,LEAVE_PROTECTED_SECTION)	
-emacro(19, DEFBIT)
-emacro(42,LEAVE_PROTECTED_SECTION)
-emacro(506, waitus, ON, OFF, TRUE, STOP_COUNT)
-emacro(534, STOP_COUNT)
-emacro(534, DEC_COUNT*)
-emacro(548, LEAVE_PROTECTED_SECTION)	// incomplete if() in MACRO definition (validated)
-emacro(570, STOP_COUNT)		// STOP_COUNT assigns -1 also to unsigned variables
-emacro(570, DEC_COUNT*)
-emacro(621,CAL_SYMB_BYTE)
-emacro(717,TriggerCOP)			// loop counter set to 0 (while(0)); validated
-emacro(773,CAL_SYMB_BYTE)
-emacro(774, waitus)			// unnecessary 'if' inside (bs_)waitus causes this error
-emacro(915, STOP_COUNT)
-emacro(961,CAL_SYMB_WORD)
-emacro(970,CNV_US_TO_CYCLES)

-emacro((923,970), *IC, ???AD0*, ???AD1*, ??AD1*, ?PAGE, _*)
-emacro((923,970), AD*, AD*_REG, ADA*, ADC???_REG, ADDR_P*, ADR?*, ARMCOP, ART*_REG, AS*, ASC*, ATD?*, ATDD1*)
-emacro((923,970), BARD_REG, BCC*, BCR?_REG, BCT*, BDR_REG, BEC, BKP???, BR*, BRK??, BRKCT?, BRKH_REG, BRKSCR_REG)
-emacro((923,970), BRM??_REG, BRR_REG, BSC, BSVR_REG)
-emacro((923,970), C0*, C1*, C2*, C3*, C4*, C?RFLG_REG, C?RIER_REG, C?TCR_REG, C?TFLG_REG, CAN*, CAN*_REG, CB*)
-emacro((923,970), CCC*, CFORC, CFORC_REG, CGTCTL, CGTFLG, CK*, CLKSEL, CLKSEL_REG, CM*, CM*_REG, CO*, CR*, CR*_REG)
-emacro((923,970), CS*, CS*_REG, CTCTL, CTFLG)
-emacro((923,970), DATALO, DBG??, DBG???, DBGX???, DCAN*, DDR?, DDR?_REG, DIRECT, DLCB*, DLCSCR, DLYCT, DR_REG, DWC*)
-emacro((923,970), EADDRHI, EADDRLO, EBICTL, ECLKDIV, ECLKDIV_REG, ECMD, ECMD_REG, ECNFG, ECNFG_REG, EDATAHI, EE?CR_REG)
-emacro((923,970), EEACR_2_REG, EECR_2_REG, EECR_REG, EEDIV?NVR_REG, EEDIV?_2_NVR_REG, EEDIV?_2_REG, EEDIV?_REG)
-emacro((923,970), EEDIV_2 EEDIV_2_NVR, EEMCR, EENVR_2_REG EENVR_REG, EEPCR_REG, EEPRO?, EEPRO?_REG, EETST)
-emacro((923,970), EETST_REG, EG*, EG*_REG, EICR_REG, EIFCTL, EIFCTL_REG, EPROT, EPROT_REG, ESTAT, ESTAT_REG)
-emacro((923,970), F???, F????, F????_REG, F???_REG, FADDRHI, FADDRLO, FCLKDIV, FCLKDIV_REG, FCSR_REG, FDATAHI)
-emacro((923,970), FDATALO, FEE???, FL?BPR_REG, FL?CR_REG, FLBPR_REG, FLCR_REG, FORBYP, FTSTMOD)
-emacro((923,970), GCC*, HPRIO)
-emacro((923,970), I2C*_REG, IB*, ICOVW, ICPAR, ICSYS, ICSYS_REG, IF*, IF*_REG, IIC*, IIC0IC, IICDR0, IMR*, INIT??)
-emacro((923,970), INT*, IOS?, IRQCR, IRQCR_REG, ISCR_REG, ISPR, ISPR?_REG, ITCR, ITEST, ITST?, IVBR, IXS, IXS_REG)
-emacro((923,970), KBICR_REG, KBSCR_REG, KRM, KWI??, KWI??_REG, KWP?, KWP?_REG, LVISR_REG)
-emacro((923,970), MASKC0, MC*, MC*_REG, MEMSIZ?, MISC, MISCR?_REG, MK*, MK*_REG, MO*, MO*_REG, MODE, MODE_REG)
-emacro((923,970), MODRR, MODRR_REG, MOR_REG, MTS??, MTST?)
-emacro((923,970), OC7?, OC7?_REG, OCKS0, OCTL*, OS*, OS*_REG)
-emacro((923,970), P10IC, P?, P??, P?CTL, P?CTL_REG, P?DR_REG, P?DDR_REG, P?IC, P?FLG, P?FLG_REG, P?OR_REG, PA?, PA?H)
-emacro((923,970), PARTID?, PACN?, PAC??, PAC??_REG, PAL?, PB, PB???, PB???_REG, PBR?_REG, PBWC_REG, PC?, PCNT)
-emacro((923,970), PCNT?_REG, PCTL_REG, PCTLCAN?, PDL?, PEAR, PER?, PER?_REG, PERAD*, PF?, PFC3L, PHCMD, PHS, PIC3, PIE?)
-emacro((923,970), PIE?_REG, PIF?, PIF?_REG, PIT*, PL?, PLLCR, PLLCTL, PLLCTL_REG, PLLFLG, PM??, PM???, PMA?, PMA??)
-emacro((923,970), PMC*, PMD*, PMOD?_REG, PORT?, PORT?_REG, PORT??, PORT??_REG, PORTAD*, PORTCAN?, PORTCAN?_REG)
-emacro((923,970), PPAGE, PPG_REG, PPS, PPS_REG, PPS?, PPS?_REG, PSC, PSC_REG, PSM, PSTAT, PPSAD?, PPSAD??, PR*)
-emacro((923,970), PTAD?, PTAD??, PTAD??_REG, PTIAD?, PTIAD??, PTIAD??_REG, PTPSR, PTMCPSR, PUCR, PUCR_REG, PWCLK) 
-emacro((923,970), PWCNT?, PWCTL, PWDTY?, PWEN, PWM*, PWPER?, PWPOL, PWPRES, PWTST, PWSC???, PWSCNT?)
-emacro((923,970), RC*, RC*_REG, RDR?, RDR?_REG, RDRIV, RDRIV_REG, RE*, RMES0, RTICTL, RTICTL_REG, RTIFLG, RX*, R_*)
-emacro((923,970), SBFCR_REG, SBSR_REG, SC0*, SC1*, SC2*, SC3*, SC4*, SC5*, SC??_REG, SELCNT?, SESC0, SI*, SI*_REG)
-emacro((923,970), SICSR_REG, SLOW, SO*, SO*_REG, SP0*, SP1*, SP2*, SP?R_REG, SPI?R_REG, SPSCR_REG, SRSR_REG, SR_REG)
-emacro((923,970), SR_REG, SVA0, SY*, SYNR, SYNR_REG)
-emacro((923,970), T?CH?, T?CH??_REG, T?CNT, T?CNT?_REG, T?MOD, T?MOD?_REG, T?SC?_REG, TASC_REG, TA_*_REG, TB_*_REG)
-emacro((923,970), TC*, TC*_REG, TEC0, TFLG?, TFLG?_REG, TIE, TIMTST, TIOS, TIOS_REG, TIS, TM*, TM*_REG, TMSK1_REG)
-emacro((923,970), TMSK?, TO*, TO*_REG, TP*, TQCR, TSCR, TSCR?, TSCR?_REG, TTOV, TTOV_REG, TX*, T_*)
-emacro((923,970), UA???, UA????, UA?????, UNIMPL?_REG)
-emacro((923,970), VREG*, VREGCTRL, VS*, VS*_REG)
-emacro((923,970), WD*, WD*_REG, WOM?, WOM?_REG, WT* WT*_REG)
-emacro((923,970), XGCCR, XGCCR_REG, XGCHID, XGIF?, XGMCTL, XGMCTL_REG, XGPC, XGR?, XGSEM, XGSWT, XGVBRH, XGVBRL)
-emacro((923,970), XSCTRL, XSCTRL_REG, XSSRLB, XSSRUB, XSXCUB)


-emacro(961,_*,AD*,AS*,BPC,BR*,CAN*,CCC*,CK*,CO*,CR*,CS*,DCAN*,GCC*,IMR*,INT*,ISPR,KRM,MASKC0,MCNT0)
-emacro(961,OCTL*,OSTS,P*,R_*,RE*,RMES0,RX*,SESC0,SI*,SOT*,SY*,T_*,TC*,TEC0,TIS,TM*,TX*,VSWC,WD*,WT*,*IC)


-A(C90)
-e46		// allow int *and* char types for bitfields, 비트 필드의 타입은 unsigned int, int 이어야 한다. (MISRA RULE 6.4)
-e306
-e427		// comment may end in '' (backslash), absorbing the next line into the comment
-e430		// 변수 어드레스 초기화에 사용되는 @문자를 허용한다.
-e506 		// due to constants used as configuration switches, (Misra rule 13.7에 해당됨)
-e537		// repeated include of (header) file, 헤더 파일의 중복 포함..
-e641		// converting enum to int, enum type이 연산에 사용되어 int로 형변환됨.
-e659		// name of newly defined struct/union/enum may be on a new line
-e725		// positive indentation expected
-e749		// unused local enumeration constants are allowed
-e750		// unused local macros are allowed
-e754		// a member of a structwas never used
-e756		// unused typedefs are allowed
-e758		// unused global struct/union/enum tags are allowed
-e759		// allow only once referenced declarations in header files, 선언부분을 헤더파일에서 특정모듈로 옮겨도 된다.(다른 모듈에서 참조하지 않음)
-e760		// redundant macro defined identically (differently defined macros will throw e767), MACRO 가 동일하게 중복 define 되어 있음
-e769		// unused global enumeration constants are allowed, enum 멤버가 프로그램에서 참조되지 않음.
-e774		// due to constants used as configuration switches
-e778		// Constant expression may evaluate to 0
-e783		// line may end without new-line
-e788		// for enums, not all values have to be used within a defaulted switch, switch 문에서 case 라벨에 상수형 심볼이 나타나지 않는다. default 문은 존재한다. 
-e793           // ansi limit of 1024 macros 
/* -e825 */           // problem with falltrought, case/default 사이에 break 문이 없고 fallthrough 문장도 없다. (MISRA RULE 15.2)
-e834  		// we wanna use the same operator a couple of times in the same expression (MISRA RULE 12.1)
-e830           // 미즈라룰에 속하지 않음(Carnes)

+e918		// 포인터의 타입이 변경됨 (MISRA Rule 10.2)
+e923		// 포인터에서 non-pointer로 혹은 반대로 CAST 됨.(MISRA Rule 11.3)
+e937		// 함수의 argument가 type 정보를 가지고 있지 않다. (MISRA Rule 8.1, 16.5)
+e939		// 함수의 리턴타입이 정해지지 않아, default로 int 타입으로 정의되었다. (MISRA Rule 8.2)
+e940		// 초기화에 필요한 괄호가 빠져있다. (MISRA Rule 9.2)
+e946		// 포인터들 사이에 &lt;,&lt;=,>>=,+- 등이 사용되었다. (MISRA Rule 17.3)
+e950		// NON-ANSI reserved word or construct. (MISRA Rule 1.1, 2.2)
-"esym(950,//)"	// allow C++ comment style, //는 950메세지에서 제외한다.
+e957		// 함수가 prototype 선언없이 정의되었다. (MISRA Rule 8.1)
+e960		// MISRA Required Rule에대한 violation 발생
/* Carnes   -esym(960, 54,87,98,110)	*/
-esym(960, 14.3, 19.12)  // MISRA Rule 14.3,19.12,19.14는 제외함 

+e961		// MISRA Advisory Rule에대한 violation 발생
/* Carnes  -esym(961, 44,47)  */
-esym(961, 12.1, 19.1, 19.13) 	// MISRA Rule 12.1, 19.1, 19.3은 제외함

+e970		// (MISRA Rule 6.3)
+e971		// char가 usigned/signed 구별없이 사용됨

/*
    This options file can be used to explicitly activate those
    checks advocated by the Motor Industry Software Reliability
    Association.

    You can use this file directly when linting your programs as in:

    lin  au-misra2  files

    Gimpel Software relies on the document, "MISRA-C:2004
    Guidelines for the use of the C language in critical systems",
    copyright 2004 by MIRA Limited, as the primary source for this
    file.  Gimpel Software makes no warranty as to the completeness
    or applicability of this options file and reserves the right to
    amend or alter the official contents of such at any time.

    "MISRA" is a registered trademark of MIRA Limited, held on
    behalf of the MISRA Consortium.

 */
    -misra(2)  

/* Carnes    +e960     */                 /* enable special MISRA 2 messages */
/* Carnes    +e961     */                 /* enable special MISRA 2 messages */	



/* Rule 1.1 (req) **********************************/

/* Carnes    -A(C90)   */                /* strict ANSI */
/* Carnes    +e950   */                            /* flag non-ANSI word or construct */
    -append(950,[MISRA 2004 Rules 1.1 and 2.2])

/* Rule 1.2 (req) **********************************/

/* Rule 1.3 (req) **********************************/

/* Rule 1.4 (req) **********************************/

/* Carnes    -idlen(31) */  /* flag names identical in the first 31 characters */
  +e621        /* Identifier clash - length set by -idlen */
    -append(621,[MISRA 2004 Rules 1.4 and 5.1])

/* Rule 1.5 (adv) **********************************/

/* Rule 2.1 (req) **********************************/

/* Carnes        -rw( asm, _asm, __asm )   */      /* remove asm built-in's */
        -dasm=_ignore_init              /* define asm as a ... */
        +rw( _ignore_init )             /* function introduction */

/* Rule 2.2 (req) **********************************/

    /* -A(C90) strict ANSI */
    /* +e950 flag non-ANSI word or construct */

/* Rule 2.3 (req) **********************************/

/* Carnes    -fnc */                       /* flag nested comments */
    +e602                       /* comment within comment */
    -append(602,[MISRA 2004 Rule 2.3])

/* Rule 2.4 (adv) **********************************/

/* Rule 3.1 (req) **********************************/

/* Rule 3.2 (req) **********************************/

/* Rule 3.3 (adv) **********************************/

/* Rule 3.4 (req) **********************************/

/* Rule 3.5 (req) **********************************/

/* Rule 3.6 (req) **********************************/

/* Rule 4.1 (req) **********************************/

    +e606                                       /* non-ANSI escape sequence */
    -append(606,[MISRA 2004 Rule 4.1])

/* Rule 4.2 (req) **********************************/

/* Carnes    -ftg  */                      /* inhibit use of trigraphs */
    +e739                       /* activate trigraph in string message */
    -append(739,[MISRA 2004 Rule 4.2])

/* Rule 5.1 (req) **********************************/

    /* -idlen(31) flag names identical in the first 31 characters */
    /* +e621 Identifier clash - length set by -idlen */

/* Rule 5.2 (req) **********************************/

    +e578                         /* enable reports of name hiding */
    -append(578,[MISRA 2004 Rules 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, and 8.8])

/* Rule 5.3 (req) **********************************/

    /* +e578 enable reports of name hiding */
    +e623                /* redefining the storage class of symbol */
    -append(623,[MISRA 2004 Rule 5.3])
    
/* Rule 5.4 (req) **********************************/

    /* +e578 Declaration of Symbol hides Symbol */
    +e14  
    -append(14,[MISRA 2004 Rules 5.4 and 8.9])
    +e15  
    -append(15,[MISRA 2004 Rules 5.4 and 8.4])
    +e64                    /* flag type mismatch */
    -append(64,[MISRA 2004 Rule 5.4])

/* Rule 5.5 (adv) **********************************/

    /* +e578 Declaration of Symbol hides Symbol */
    +e580                           /* enable reports of name hiding */
    -append(580,[MISRA 2004 Rule 5.5, 5.6, and 5.7])

/* Rule 5.6 (adv) **********************************/

    /* +e578 enable reports of name hiding */
    /* +e580 enable reports of name hiding */

/* Rule 5.7 (adv) **********************************/

    /* +e578 enable reports of name hiding */
    /* +e580 enable reports of name hiding */

/* Rule 6.1 (req) **********************************/

    /* no option for this */

/* Rule 6.2 (req) **********************************/

    /* no option for this */

/* Rule 6.3 (adv) **********************************/

/* Carnes     +e970   */            /* flag modifiers used outside of typedefs */
    -append(970,[MISRA 2004 Rule 6.3])

/* Rule 6.4 (req) **********************************/

/* Carnes    +e46  */                      /* field type should be int */
    -append(46,[MISRA 2004 Rule 6.4])

/* Rule 6.5 (req) **********************************/

    +e806               /* small bit field is signed rather than unsigned */
    -append(806,[MISRA 2004 Rule 6.5])

/* Rule 7.1 (req) **********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 7.1, Octal constant or octal escape sequence used */

/* Rule 8.1 (req) **********************************/

    +e718                        /* Symbol undeclared */
    -append(718,[MISRA 2004 Rule 8.1])
    +e746
    -append(746,[MISRA 2004 Rule 8.1])
/* Carnes    +e937    */                 /* old-style function declaration */
    -append(937,[MISRA 2004 Rules 8.1 and 16.5])
/* Carnes    +e957  */
    -append(957,[MISRA 2004 Rule 8.1])

/* Rule 8.2 (req) **********************************/

    +e745                           /* function has no explicit type */
/* Carnes    +e939  */                         /* return type defaults to int */
    -append(745,[MISRA 2004 Rule 8.2])
    -append(939,[MISRA 2004 Rule 8.2])

/* Rule 8.3 (req) **********************************/

    -fvr                          /* varying return mode not allowed */
    +e516                         /* argument type conflict */
    +e532                         /* return mode of symbol inconsistent */

    -append(516,[MISRA 2004 Rule 8.3])
    -append(532,[MISRA 2004 Rule 8.3])

/* Rule 8.4 (req) **********************************/
    +e18                          /* symbol redeclared */
    /* +e15 symbol redeclared */
    -append(18,[MISRA 2004 Rule 8.4])
    
/* Rule 8.5 (req) **********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 8.5, */
    /* no object/function definitions in header files */

/* Rule 8.6 (req) **********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 8.6, */
    /* function not declared at file scope */

/* Rule 8.7 (req) **********************************/

/* Rule 8.8 (req) **********************************/

    /* +e578 Declaration of Symbol hides Symbol */

/* Rule 8.9 (req) **********************************/

/* Rule 8.10 (req) *********************************/

/* - bug of pc-lint - 추가하여야만 기능이 동작함,,, Carnes    +e765 */                       /* symbol could be made static */
    -append(765,[MISRA 2004 Rule 8.10])

/* Rule 8.11 (req) *********************************/

    +e512                        /* symbol previously used as static */
    -append(512,[MISRA 2004 Rule 8.11])

/* Rule 8.12 (req) *********************************/

/* Rule 9.1 (req) **********************************/

    +e644                   /* Symbol may not have been initialized */
    +e771                   /* Symbol conceivably not initialized */
    +e530                   /* Symbol not initialized */
    -append(644,[MISRA 2004 Rule 9.1])
    -append(771,[MISRA 2004 Rule 9.1])
    -append(530,[MISRA 2004 Rule 9.1])

/* Rule 9.2 (req) **********************************/

/* Carnes    +e940   */                /* omitted braces within an initializer */
    -append(940,[MISRA 2004 Rule 9.2])

/* Rule 9.3 (req) **********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 9.3, */
    /* should initialize either all enum members or only the first */

/* Rule 10.1 (req) *********************************/

    +e524                                                   /* loss of precision */
    -append(524,[MISRA 2004 Rule 10.1])
    +e653                                                   /* possible loss of fraction */
    -append(653,[MISRA 2004 Rules 10.1 and 10.4])

/* Rule 10.2 (req) *********************************/

    +e747                       /* significant prototype coercion */
/* Carnes    +e918    */                   /* prototype coercion of pointers */
    -append(747,[MISRA 2004 Rule 10.2])
    -append(918,[MISRA 2004 Rule 10.2])

/* Rule 10.3 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 10.3, */
    /* Prohibited cast of complex integer expression */

/* Rule 10.4 (req) *********************************/

/* Rule 10.5 (req) *********************************/

    +e701                        /* shift left of signed quantity */
    +e702                        /* shift right of signed quantity */
    -append(701,[MISRA 2004 Rule 10.5])
    -append(702,[MISRA 2004 Rule 10.5])

/* Rule 10.6 (req) *********************************/

/* Rule 11.1 (req) *********************************/

/* Rule 11.2 (req) *********************************/

/* Rule 11.3 (adv) *********************************/

/* Carnes    +e923    */                    /* cast pointer/non-pointer */
    -append(923,[MISRA 2004 Rule 11.3])

/* Rule 11.4 (adv) *********************************/

/* Rule 11.5 (req) *********************************/

/* Rule 12.1 (adv) *********************************/

    /* we generate note 961 as below */
    /* Note 961: Violates MISRA 2004 Advisory Rule 12.1, */
    /* dependence placed on C's operator precedence */
/* Carnes    +e834 */ /* confusing operator sequence (same precedence) */
    -append(834,[MISRA 2004 Rule 12.1])

/* Rule 12.2 (req) *********************************/

    +e564                       /* order of evaluation */
    -append(564,[MISRA 2004 Rule 12.2])

/* Rule 12.3 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 12.3, */
    /* 'sizeof' used on expressions with side effect */

/* Rule 12.4 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 12.4,  */
    /* side effects on right hand side of logical operator */

/* Rule 12.5 (req) *********************************/

/* Rule 12.6 (adv) *********************************/

/* Rule 12.7 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 12.7, */
    /* Bitwise operator applied to signed underlying type */

/* Rule 12.8 (req) *********************************/

    +e572                        /* excessive shift value */
    -append(572,[MISRA 2004 Rule 12.8])

/* Rule 12.9 (req) *********************************/

    +e501                        /* expected signed type */
    -append(501,[MISRA 2004 Rule 12.9])

/* Rule 12.10 (req) ********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 42, */
    /* comma operator used */

/* Rule 12.11 (adv) ********************************/

    +e648                        /* overflow in computing constant */
    -append(648,[MISRA 2004 Rule 12.11])

/* Rule 12.12 (req) ********************************/

/* Rule 12.13 (req) ********************************/

/* Rule 13.1 (req) *********************************/

    +e720                         /* Boolean test of assignment */
    -append(720,[MISRA 2004 Rules 13.1 and 13.2])
    +e820
    -append(820,[MISRA 2004 Rule 13.1])

/* Rule 13.2 (adv) *********************************/

    /* +e720 */

/* Rule 13.3 (req) *********************************/

    +e777                        /* testing floats for equality */
    -append(777,[MISRA 2004 Rule 13.3])

/* Rule 13.4 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 13.4, */
    /* floating point variable used as loop counter */

/* Rule 13.5 (req) *********************************/

/* Rule 13.6 (req) *********************************/


/* Rule 13.7 (req) *********************************/

/* Carnes    +e506   */
    -append(506,[MISRA 2004 Rules 13.7 and 14.1])

/* Rule 14.1 (req) *********************************/

    /* +e506 */
    +e527                       /* unreachable */
    -append(527,[MISRA 2004 Rule 14.1])
    +e681
    -append(681,[MISRA 2004 Rule 14.1])
    +e827
    -append(827,[MISRA 2004 Rule 14.1])

/* Rule 14.2 (req) *********************************/

    +e505
    +e522
    -append(505,[MISRA 2004 Rule 14.2])
    -append(522,[MISRA 2004 Rule 14.2])

/* Rule 14.3 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 14.3, */
    /* null statement not in line by itself */

/* Rule 14.4 (req) *********************************/

    +e801
    -append(801,[MISRA 2004 Rule 14.4])

/* Rule 14.5 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 14.5, */
    /* continue statement detected */

/* Rule 14.6 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 14.6, */
    /* more than one 'break' terminates loop */

/* Rule 14.7 (req) *********************************/

/* Rule 14.8 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 14.8, */
    /* left brace expected for switch, for, do and while */

/* Rule 14.9 (req) *********************************/


    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 14.9, */
    /* left brace expected for if, else and else if */

/* Rule 14.10 (req) ********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 14.10, */
    /* no 'else' at end of 'if ... else if' chain */

/* Rule 15.1 (req) *********************************/

/* Rule 15.2 (req) *********************************/

    +e616
    -append(616,[MISRA 2004 Rule 15.2])
/* Carnes    +e825  */
    -append(825,[MISRA 2004 Rule 15.2])

/* Rule 15.3 (req) *********************************/

    +e744                         /* switch statement has no default */
    -append(744,[MISRA 2004 Rule 15.3])

/* Rule 15.4 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 15.4, */
    /* boolean value in switch statement */

/* Rule 15.5 (req) *********************************/

    +e764                         /* switch does not have a case */
    -append(764,[MISRA 2004 Rule 15.5])

/* Rule 16.1 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 16.1, */
    /* function has variable number of arguments */

/* Rule 16.2 (req) *********************************/

/* Rule 16.3 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 16.3, */
    /* all parameters shall have identifiers */

/* Rule 16.4 (req) *********************************/

/* Rule 16.5 (req) *********************************/

    /* +e937 old-style function declaration */

/* Rule 16.6 (req) *********************************/

    +e118               /* too few arguments for prototype */
    +e119               /* too many arguments for prototype */
    -append(118,[MISRA 2004 Rule 16.6])
    -append(119,[MISRA 2004 Rule 16.6])

/* Rule 16.7 (adv) *********************************/

    +e818                       /* use const on paramaters where appropriate */
    -append(818,[MISRA 2004 Rule 16.7])

/* Rule 16.8 (req) *********************************/

    +e533                        /* function should return a value */
    -append(533,[MISRA 2004 Rule 16.8])

/* Rule 16.9 (req) *********************************/

/* Rule 16.10 (req) ********************************/

/* Rule 17.1 (req) *********************************/

/* Rule 17.2 (req) *********************************/

/* Rule 17.3 (req) *********************************/

/* Carnes    +e946 */         /* relational or subtract operator applied to pointers */
    -append(946,[MISRA 2004 Rule 17.3])

/* Rule 17.4 (req) *********************************/
    -append(947,[MISRA 2004 Rule 17.4])
    
/* Rule 17.5 (adv) *********************************/

/* Rule 17.6 (req) *********************************/

    +e733               /* assigning address of auto to outer scope symbol */
    +e789               /* assigning address of auto to static */
    -append(733,[MISRA 2004 Rule 17.6])
    -append(789,[MISRA 2004 Rule 17.6])

/* Rule 18.1 (req) *********************************/

    +e43                         /* vacuous type for variable */
    -append(43,[MISRA 2004 Rule 18.1])

/* Rule 18.2 (req) *********************************/

/* Rule 18.3 (req) *********************************/

/* Rule 18.4 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 18.4, */
    /* unions shall not be used */

/* Rule 19.1 (adv) *********************************/

    /* we generate note 961 as below */
    /* Note 961: Violates MISRA 2004 Advisory Rule 19.1, */
    /* only preprocessor statements and comments before '#include' */

/* Rule 19.2 (adv) *********************************/

    /* we generate note 961 as below */
    /* Note 961: Violates MISRA 2004 Advisory Rule 19.2, */
    /* header file name with non-standard character */

/* Rule 19.3 (req) *********************************/

    +e12                        /* Need &lt; or \ " after #include */
    -append(12,[MISRA 2004 Rule 19.3])

/* Rule 19.4 (req) *********************************/

/* Rule 19.5 (req) *********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 19.5, */
    /* '#define/#undef' used within a block */

/* Rule 19.6 (req) *********************************/

    /* we generate note 961 as below */
    /* Note 961: Violates MISRA 2004 Advisory Rule 19.6, */
    /* use of '#undef' is discouraged */

/* Rule 19.7 (adv) *********************************/

/* Rule 19.8 (req) *********************************/

    +e131                         /* syntax error in call of macro */
    -append(131,[MISRA 2004 Rule 19.8])

/* Rule 19.9 (req) *********************************/
    +e436
    -append(436,[MISRA 2004 Rule 19.9])

/* Rule 19.10 (req) ********************************/

    +e773                      /* expression-like macro not parenthesized */
    -append(773,[MISRA 2004 Rule 19.10])

/* Rule 19.11 (req) ********************************/

    +e553                        /* undefined preprocessor variable */
    -append(553,[MISRA 2004 Rule 19.11])

/* Rule 19.12 (req) ********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 19.12, */
    /* multiple use of '#/##' operators in macro definition */

/* Rule 19.13 (adv) ********************************/

    /* we generate note 961 as below */
    /* Note 961: Violates MISRA 2004 Advisory Rule 19.13, */
    /* '#/##' operators used */

/* Rule 19.14 (req) ********************************/

    /* we generate note 960 as below */
    /* Note 960: Violates MISRA 2004 Required Rule 19.14, */
    /* non-standard use of 'defined' preprocessor statement */

/* Rule 19.15 (req) ********************************/

/* Rule 19.16 (req) ********************************/

/* Rule 19.17 (req) ********************************/

/* Rule 20.1 (req) *********************************/

    +e683             /* complain about #define standard functions */
    -append(683,[MISRA 2004 Rule 20.1])

/* Rule 20.2 (req) *********************************/

/* Rule 20.3 (req) *********************************/

    /* 100 calls to standard library functions are monitored */
    /* users can specify additional constraints for other functions */

/* Rule 20.4 (req) *********************************/

    -deprecate( function, calloc, [MISRA 2004 Rule 20.4] )
    -deprecate( function, malloc, [MISRA 2004 Rule 20.4] )
    -deprecate( function, realloc, [MISRA 2004 Rule 20.4] )
    -deprecate( function, free, [MISRA 2004 Rule 20.4] )

        /* enable message 586 for these functions */

/* Rule 20.5 (req) *********************************/

    -deprecate( variable, errno, [MISRA 2004 Rule 20.5] )

/* Rule 20.6 (req) *********************************/

    -deprecate( macro, offsetof, [MISRA 2004 Rule 20.6] )

/* Rule 20.7 (req) *********************************/

    -deprecate( function, longjmp, [MISRA 2004 Rule 20.7] )
    -deprecate( function, setjmp, [MISRA 2004 Rule 20.7] )

    /* enable message 586 for these functions */

/* Rule 20.8 (req) *********************************/

    -deprecate( function, signal, [MISRA 2004 Rule 20.8] )
    -deprecate( function, raise, [MISRA 2004 Rule 20.8] )

    /* enable message 586 for these functions */

/* Rule 20.9 (req) *********************************/

    -headerwarn(stdio.h)
        /* enable message 829 for stdio.h */
    -append(829(stdio.h), [MISRA 2004 Rule 20.9])

/* Rule 20.10 (req) ********************************/

    -deprecate( function, atof, [MISRA 2004 Rule 20.10] )
    -deprecate( function, atoi, [MISRA 2004 Rule 20.10] )
    -deprecate( function, atol, [MISRA 2004 Rule 20.10] )

    /* enable message 586 for these functions */

/* Rule 20.11 (req) ********************************/

    -deprecate( function, abort, [MISRA 2004 Rule 20.11] )
    -deprecate( function, exit, [MISRA 2004 Rule 20.11] )
    -deprecate( function, getenv, [MISRA 2004 Rule 20.11] )
    -deprecate( function, system, [MISRA 2004 Rule 20.11] )

    /* enable message 586 for these functions */

/* Rule 20.12 (req) ********************************/

    -deprecate( function, time, [MISRA 2004 Rule 20.12] )
    -deprecate( function, strftime, [MISRA 2004 Rule 20.12] )
    -deprecate( function, clock, [MISRA 2004 Rule 20.12] )
    -deprecate( function, difftime, [MISRA 2004 Rule 20.12] )
    -deprecate( function, mktime, [MISRA 2004 Rule 20.12] )

    /* enable message 586 for these functions */

/* Rule 21.1 (req) *********************************/




[step460#1B2M2Y8AsgTpgAmY7PhCfg]

[step460~S46_codecheck.cfg#1B2M2Y8AsgTpgAmY7PhCfg]
#----------------------------------------------------------------------------
# CODE_CHECK.OPT : option file for the code_check tool
#
# Used to disable/enable warnings. 
# 
# Examples :
# --------
# Suppress warning m20
#-w m20
#
# Suppress warnings m20, s12 and s24
#-w m20,s12,s24
#
# Suppress warnings m10 and m133 only for file bschedul.c
#-w (bschedul.c,m10,m133)
#
# Suppress all warnings for file typegene.h
#-w (typegene.h,*)
#
# Check only warnings m23 and m30. Others are not checked (overload -w option)
#-o m23,m30
#
# J.Lelasseux ATBEAS SW PMTQ 02/00
#----------------------------------------------------------------------------

# Put your options below...

[step470#vXaSC+78tI5IxnxKecBJdQ]
QYCHECK_ADVISORY=0
QYCHECK_CODING_OFF=0
#QYCHECK_FILTER_SOURCES= isr_api.h os_api.h os_api_hal.h zfalarms.c zfalarms.h zhwvect.h bidletask.c bspll.c bspll.h oscore.h oscore.c stdtypedef.h mcal_inc.h zhsysdef.h zisrmanag.c zvirvect.h bdebug.c bdebug.h App_MCAL_Defs.h mcal_isr_if.h bstartrtsw.c bvirvect.c isr_api_hal.h bsalarms.c bsalarms.h bswphook.c os_api.c typedef.h power_mng_api.h pm_1st_cfg.h pm_2nd_cfg.c pm_2nd_cfg.h swppm.c swppm.h swppmhal.c swppmhal.h
QYCHECK_FILTER_SOURCES=
S47_CREATEXLS_OFF=0
S47_SHOWXLS_OFF=0

[step470~S47_full.cfg#JRXCGTH17xZBnMNxFFXpPw]
# list of required misra rules
#-----------------------------------------------------
# declaration patterns:
# 		[cm]*:[sml]*{,[sml]*, ...}
#
# with
#
# [cm]* = MISRA Coding Rule number
#  s*   = codecheck message number for siemens rules
#  m*   = codecheck message number for MISRA rules
#  l*   = lint message number
#-----------------------------------------------------
#c4:s1
#c6:s2
#c7:s3
#c12:s4
m1.1:l950
m1.4:l621
m2.2:l950
m2.3:l602
m4.1:l606
m4.2:l739
m5.1:l621
m5.2:l578
m5.3:l578,l623
m5.4:l578,l14,l15,l64
m6.4:l46
m6.5:l806
m7.1:l960
m8.1:l718,l746,l937,l957
m8.2:l745,l939
m8.3:l18,l516,l532
m8.4:l15,l18
m8.5:l960
m8.6:l960
m8.8:l578
m8.9:l14
m8.10:l765
m8.11:l512
m9.1:l644,l771,l530
m9.2:l940
m9.3:l960
m10.1:l524,l653
m10.2:l747,l918
m10.3:l960
m10.5:l701,l702
m12.2:l564
m12.3:l960
m12.4:l960
m12.7:l960
m12.8:l572
m12.9:l501
m12.10:l960
m13.1:l720,l820
m13.3:l777
m13.4:l960
m13.7:l506
m14.1:l527,l681,l827
m14.2:l505,l522
m14.3:l960
m14.4:l801
m14.5:l960
m14.6:l960
m14.8:l960
m14.9:l960
m14.10:l960
m15.2:l616,l825
m15.3:l744
m15.4:l960
m15.5:l764
m16.1:l960
m16.3:l960
m16.5:l937
m16.6:l118,l119
m16.8:l533
m17.3:l946
m17.4:l947
m17.6:l733,l789
m18.1:l43
m18.4:l960
m19.3:l12
m19.5:l960
m19.6:l961
m19.8:l131
m19.9:l436
m19.10:l773
m19.11:l553
m19.12:l960
m19.14:l960
m20.1:l683
m20.4:l586
m20.7:l586
m20.8:l586
m20.9:l829
m20.10:l586
m20.11:l586
m20.12:l586
#c131:s6
#c141:s8


# list of advisory misra rules
#-----------------------------------------------------
# same patterns but with a '_' mark before for
# classifing the MISRA rules in advisory category
#-----------------------------------------------------
_m5.5:l578,l580
_m5.6:l578,l580
_m5.7:l578,l580
_m6.3:l970
_m11.3:l923
_m12.1:l961,l834
_m12.11:l648
_m13.2:l720
_m16.7:l818
_m19.1:l961
_m19.2:l961
_m19.13:l961
#_c136:l564,l666

#List of dangerous lint messages that are not covered by MISRA rules
#-----------------------------------------------------
# declaration patterns:
# 		[se]|[ie]|[fe]|[w]:*;
#
# with
#
# [se] = C syntax errors
# [ie] = Internal errors
# [fe] = Fatal errors
# [w]  = C warnings messages
# [i]  = Informational messages								   
# [n]  = Elective notes
#-----------------------------------------------------
se:l1..l63,l65..l199
ie:l200..l299
fe:l300..l303,l305..399
wm:l404..l409,l412..l426,l428..l502,l505,l514..l516,l532..l538,l540..l544,l547..l549,l557..l562,l565..l568,l575..l601,l604,l606,l617,l621..l623,l628,l631,l646..l650,l653,l662..l666,l681..684
im:l716..l724,l733,l744..746,l748,l764,l767,l773,l775..l777,l779..782,l784..786,l789..791,l795,l799,l801,l809..l813,l818,l821,l826..l829,l834
no:l931,l934,l939


[step530#wmPUzJTuhPZC4+nOJNdwJg]
LINKLIB = 

LINKOBJ= 

[step540#2Y8rcvE4qSdH7MBat+qhRQ]
ILIB=<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_swp_lib.a(bbhwvect.o|breboot.o|bsseedsi.o|ADCDig_LLD.o|Adc.o|Adc_Irq.o|Adc_LLD.o|Adc_NonASR.o|ctu_lld.o|Reg_eSys_ADCDig.o|Dio.o|Siul_LLD_dio.o|EcuM.o|Fee.o|Fls.o|Fls_Ac.o|Gpt.o|Gpt_Irq.o|Gpt_LLD.o|Gpt_NonASR.o|Pit_Gpt_LLD.o|Pit_Gpt_LLD_IRQ.o|Reg_eSys_EMIOS_Gpt.o|Rtc_Gpt_LLD.o|Rtc_Gpt_LLD_IRQ.o|Stm_Gpt_LLD.o|Stm_Gpt_LLD_IRQ.o|eMIOS_Gpt_LLD.o|Icu.o|Icu_LLD.o|Icu_NonASR.o|Reg_eSys_EMIOS_Icu.o|SIUL_Icu_LLD.o|SIUL_Icu_LLD_IRQ.o|WKPU_Icu_LLD.o|WKPU_Icu_LLD_IRQ.o|eMIOS_Icu_LLD.o|eMIOS_Icu_LLD_IRQ.o|Flash_Mcu_LLD.o|Mcu.o|Mcu_Irq.o|Mcu_LLD.o|Reg_eSys_EMIOS.o|Port.o|Siul_LLD.o|Pwm.o|Pwm_Irq.o|Pwm_LLD.o|Pwm_NonASR.o|Reg_eSys_EMIOS_IRQ_PWM.o|Reg_eSys_EMIOS_PWM.o|eMIOS_Pwm_LLD.o|eMIOS_Pwm_LLD_IRQ.o|Dspi_LLD.o|Spi.o|Spi_Irq.o|Swt_LLD.o|Wdg.o|Wdg_Irq.o|Wdg_LLD.o|Dem.o|Det.o|Adc_Cfg.o|Adc_PBcfg.o|Clocks_LLD.o|Dio_Cfg.o|Dio_PBcfg.o|Fee_Cfg.o|Fls_PBcfg.o|Gpt_Cfg.o|Gpt_PBcfg.o|Icu_Cfg.o|Icu_PBcfg.o|Mcu_Cfg.o|Mcu_PBcfg.o|Modes_LLD.o|Monitor_LLD.o|Port_Cfg.o|Port_PBcfg.o|Power_LLD.o|Reset_LLD.o|Wdg_Cfg.o|Wdg_Lcfg.o|Wdg_PBcfg.o|Spi_Cfg.o|Pwm_Cfg.o|Pwm_PBcfg.o|Os_configuration.o|Os_configuration_PA.o|PA_interruptvectors_sw.o|PA_intdisableconditional.o|Os_gen.o|bstartrtsw.o|os_api.o|bsalarms.o|bvirvect.o|bsysstartup.o|oscore.o|bidletask.o|bswphook.o|bspll.o|zfalarms.o|zisrmanag.o|bexception.o|zinitswp.o|zswptask.o|bfasttimer.o|bcinterp.o|bcdivide.o|bcfilter.o|bcmodulo.o|bcmulti.o|bcwait.o|brstmanag.o|bssyserr.o|bswdogmngr.o|bslowtimer.o|evtman.o|swppm.o|swppmhal.o|bsramini.o|bsramctl.o|ctlram_data.o|bcmemuti.o|bcflgman.o|bscomeep.o|beepmana.o|bxstman.o|bxstman_nm.o|bxstman_trcv.o|sm_1st_cfg.o|biostartup.o|bidigdir.o|bodigdir.o|bidigfil.o|bianadir.o|bianafil.o|biotimer.o|bopwmout.o|biomanag.o|io_timer.o|IoHwAb_adc_access_hal.o|IoHwAb_freq_access.o|IoHwAb_freq_access_hal.o|PA_exceptionvectors_booke.o|PA_initram.o|PA_locking.o|SWP_interrruptvectors_hw.o|swp_data.o<xsl:if test="//SRS/CORE/REGMONITOR/@Enable ='ENABLE'">|bswsecur.o|zdsecuri.o</xsl:if><xsl:if test="//SRS/CORE/RANDOM/@Enable ='ENABLE'">|bcrandom.o</xsl:if><xsl:if test="//SRS/CORE/TIMER/@System_time_usage ='ENABLE'">|bsystime.o</xsl:if><xsl:if test="//SRS/OS/DEBUG/@CPULoad ='Yes' or //SRS/OS/DEBUG/@ITLoad ='Yes' or //SRS/OS/DEBUG/@StackDepth ='Yes'">|bdebug.o</xsl:if><xsl:if test="//SRS/IO/GENERAL/@VirtualInputs='Yes'">|bivirpor.o</xsl:if><xsl:if test="//SRS/IO/BATMON/@Enable='Yes'">|bibatmon.o</xsl:if><xsl:if test="//SRS/IO/INSWITCH/DSW/@Enable='Yes'">|bisupply.o</xsl:if><xsl:if test="//SRS/IO/MUXOUT/MUXOUT_ATM39/@Number_of_Chip !='0'">|bo_atm39.o</xsl:if><xsl:if test="//SRS/IO/MUXOUT/MUXOUT_L99MC6/@Number_of_Chip !='0'">|bo_l99mc6.o</xsl:if><xsl:if test="//SRS/IO/MUXIN/MUXIN_MC33972/@Number_of_Chip !='0'">|bi_mc33972.o</xsl:if><xsl:if test="//SRS/IO/MUXIN/MUXIN_HC151/@Number_of_Chip !='0'">|bihc151.o</xsl:if><xsl:if test="//SRS/MEM/CHECK/@Enable ='Yes'">|bsmemchk.o|bsmemchk_hal.o</xsl:if><xsl:if test="//SRS/COM/ASCS/*/@Enable ='Yes'">|asc_hal.o</xsl:if><xsl:if test="//SRS/COM/SPIS/*/@Enable ='Yes'">|bscomspi.o|bscomspi_cfg.o</xsl:if><xsl:if test="//SRS/EOL/@SeedMethod ='RANDOM'">|brandom.o</xsl:if><xsl:if test="//SRS/CORE/UDS/@Usage ='Yes'">|Dcm.o|ComM_Dcm.o|SchM_Dcm.o|Dcm_Cbk.o|Dcm_Dsd.o|Dcm_DsdInternal.o|Dcm_Dsl.o|Dcm_DslInternal.o|Dcm_DspMain.o|Dcm_DspServices.o|Dcm_Ram.o</xsl:if><xsl:if test="//SRS/CORE/KLINE/@Enable ='Yes'">|dpkw2000.o|xsasccom.o|encaptimev.o</xsl:if><xsl:if test ="//SRS/COM/ASCS/*[@Usage_Mode='LIN' and @Enable = 'Yes']"><xsl:if test ="//SRS/COM/LIN/*[@LIN_Enable='Yes' and @LIN_ASC_Channel !='']">|lin_1st_cfg.o|lin_adapt_swp.o|lin_config_api.o|lin_core_api.o|lin_protocol.o|lin_tp_raw_api.o</xsl:if></xsl:if><xsl:if test="//SRS/MCU/SPEC/@Name ='MPC5605B' or //SRS/MCU/SPEC/@Name ='MPC5606B' or //SRS/MCU/SPEC/@Name ='MPC5607B'  or //SRS/MCU/SPEC/@Name ='SPC560B54' or //SRS/MCU/SPEC/@Name ='SPC560B60' or //SRS/MCU/SPEC/@Name ='SPC560B64'"><xsl:if test="//SRS/MCU/SPEC/@Package ='PACKAGE_144' or //SRS/MCU/SPEC/@Package ='PACKAGE_176'">|Dma_LLD.o|Dma_Mcu_LLD.o|Dma_Spi_LLD.o|Dmamux_LLD.o</xsl:if></xsl:if><xsl:if test="//SRS/IO/MUXOUT/MUXOUT_TLE7240SL/@Number_of_Chip !='0'">|bo_tle7240sl.o</xsl:if>)

[step550#V4Il3Sxi8Icktrev9QkZ6w]
<xsl:choose> 
<xsl:when test="//SRS/MCU/SPEC/@IDE_Version ='517'">LNK_OPT=-dwarf2 --prototype_warnings --no_exceptions -sda=0 -Osize -DOS_TOOL=OS_ghs -DOS_ARCH=OS_PA -DOS_CPU=OS_XPC560XB    -DOS_MEMMAP=0 -DOS_PA_VLE=1 -DINIT_SRAM=1 -UOS_USE_API_REMOVAL -g -srec -nostartfiles -Mx -gsize -map -e=Reset_Gen -locatedprogram</xsl:when>
<xsl:when test="//SRS/MCU/SPEC/@IDE_Version ='614_14_mcal_304hf13'">LNK_OPT=-dwarf2 --prototype_warnings --no_exceptions -sda=0 -Osize -DOS_TOOL=OS_ghs -DOS_ARCH=OS_PA -DOS_CPU=OS_XPC560XB    -DOS_MEMMAP=0 -DOS_PA_VLE=1 -DINIT_SRAM=1 -UOS_USE_API_REMOVAL -g -srec -nostartfiles -Mx -gsize -map -e=Reset_Gen -locatedprogram</xsl:when>
<xsl:when test="//SRS/MCU/SPEC/@IDE_Version ='614_14_mcal_305hf3' or //SRS/MCU/SPEC/@IDE_Version ='614_14_mcal_305hf5'">LNK_OPT=-dwarf2 --no_exceptions -sda=0 -DOS_TOOL=OS_ghs -DOS_ARCH=OS_PA -DOS_CPU=OS_XPC560XB    -DOS_MEMMAP=0 -DOS_PA_VLE=1  -g -srec -nostartfiles -Mx -gsize -map -e=Reset_Gen -locatedprogram -keep=bbmcu_ExctTable</xsl:when>
<xsl:when test="//SRS/MCU/SPEC/@IDE_Version ='614_14_mcal_305hf5ts14'">LNK_OPT=-dwarf2 --no_exceptions -sda=0 -DOS_TOOL=OS_ghs -DOS_ARCH=OS_PA -DOS_CPU=OS_XPC560XB    -DOS_MEMMAP=0 -DOS_PA_VLE=1  -g -srec -nostartfiles -Mx -gsize -map -e=Reset_Gen -locatedprogram -keep=bbmcu_ExctTable</xsl:when>
<xsl:otherwise>
<xsl:message  terminate ="yes">
=======================================================================================================================
'Error 		//SRS/MCU/SPEC/@IDE_Version   ->AIS 지원하지 않는 Toolchain Version (누락된 경우 포함)
=======================================================================================================================</xsl:message>  												
</xsl:otherwise>
</xsl:choose>
LOCDSC=<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_swp_lib.loc
OBJECTS_LIST=\
bbstartup.o \
bbplldrv.o \
bbmcuinit.o \
bbtmrdrv.o \
bbwdgdrv.o \
bbcore.o \
bbswmap.o \
bbidentification.o \
trdrv_hal.o \
treolos.o \
bbeoljob.o \
#bbfblpll.o \
#bbhwvect.o \
<xsl:if test="//SRS/EOL/@SeedMethod ='RANDOM'">
bbrandgen.o \
bbeolseedkey.o \
</xsl:if>
<xsl:if test="//SRS/MEM/CHECK/@Enable ='Yes'"> 
bbbaift.o \	
</xsl:if>
<xsl:if test="//SRS/EOL/@Type ='CAN'">
bbcandrv.o \
</xsl:if> 
<xsl:if test="//SRS/EOL/@Type ='KLINE'">
bbasc_hal.o \
bbkwpdrv.o \
bbkwpmngr.o \
</xsl:if> 
<xsl:if test="//SRS/FBL/CORE/@Diag_Job ='Yes'">
bbsiecrc.o \
bbcantp.o \
bbflashtbx.o \
bbflashdrv.o \
bbdiagjob.o \
</xsl:if>
<xsl:if test="//SRS/FBL/CORE/@ECU_Specific_Job ='Yes'">
bbecujob.o \
</xsl:if>
bbPA_initram.o \ 
zdeolos.o




SORT_C_SOURCES=1

[step550~<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_swp_lib.loc#nJUF0QL3RG1SsC/fZXsDaw]

DEFAULTS
{
    BOOT_STACK_SIZE = 0x150   /* 336 bytes for common stack */ 
<xsl:choose>
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='24'">
	BOOT_STACK_BASE = 0x40006000 - BOOT_STACK_SIZE	 /* (RAM SIZE 24K)*/ 
	BOOT_DATA_BASE = 0x40006000 - 0x800  /* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='28'">
	BOOT_STACK_BASE = 0x40007000 - BOOT_STACK_SIZE	 /* (RAM SIZE 28K)*/ 
	BOOT_DATA_BASE = 0x40007000 - 0x800	/* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='32'">
	BOOT_STACK_BASE = 0x40008000 - BOOT_STACK_SIZE	 /* (RAM SIZE 32K)*/ 
	BOOT_DATA_BASE = 0x40008000 - 0x800 /* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='48'">
	BOOT_STACK_BASE = 0x4000C000 - BOOT_STACK_SIZE	 /* (RAM SIZE 48K)*/ 
	BOOT_DATA_BASE = 0x4000C000 - 0x800 /* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='64'">
	BOOT_STACK_BASE = 0x40010000 - BOOT_STACK_SIZE	 /* (RAM SIZE 64K)*/ 
	BOOT_DATA_BASE = 0x40010000 - 0x800 /* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='80'">
	BOOT_STACK_BASE = 0x40014000 - BOOT_STACK_SIZE	 /* (RAM SIZE 80K)*/ 
	BOOT_DATA_BASE = 0x40014000 - 0x800 /* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='96'">
	BOOT_STACK_BASE = 0x40018000 - BOOT_STACK_SIZE	 /* (RAM SIZE 96K)*/ 
	BOOT_DATA_BASE = 0x40018000 - 0x800 /* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='128'">
	BOOT_STACK_BASE = 0x40020000 - BOOT_STACK_SIZE	 /* (RAM SIZE 128K)*/ 
	BOOT_DATA_BASE = 0x40020000 - 0x800 /* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='160'">
	BOOT_STACK_BASE = 0x40028000 - BOOT_STACK_SIZE	 /* (RAM SIZE 160K)*/ 
	BOOT_DATA_BASE = 0x40028000 - 0x800 /* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='192'">
	BOOT_STACK_BASE = 0x40030000 - BOOT_STACK_SIZE	 /* (RAM SIZE 192K)*/ 
	BOOT_DATA_BASE = 0x40030000 - 0x800 /* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:when test="//SRS/MCU/SPEC/@RAM_SIZE ='256'">
	BOOT_STACK_BASE = 0x40040000 - BOOT_STACK_SIZE	 /* (RAM SIZE 256K)*/ 
	BOOT_DATA_BASE = 0x40040000 - 0x800 /* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
	</xsl:when> 
	<xsl:otherwise>
		<xsl:message  terminate ="yes">
=======================================================================================================================
'Error			//SRS/MCU/SPEC/@RAM_SIZE  값이 유효하지 않음
=======================================================================================================================</xsl:message> 
	</xsl:otherwise> 
</xsl:choose>
}

MEMORY
{

<xsl:choose> 	
	<xsl:when test="//SRS/FBL/MAPPINGS/*/@FBL_Section_Select ='1st_section'"> 	
   reset    : org = 0x00000000, len = 0x1000
   exctab     : org = 0x0001000,  len = 0x7000
	</xsl:when> 	
	<xsl:when test="//SRS/FBL/MAPPINGS/*/@FBL_Section_Select ='2nd_section'"> 	
   reset    : org = 0x00008000, len = 0x1000
   exctab     : org = 0x0009000,  len = 0x3000
	</xsl:when> 	
	<xsl:otherwise> 	
	<xsl:message  terminate ="yes">
=======================================================================================================================
'Error 		//SRS/FBL/MAPPINGS/*/@FBL_Section_Select   -> 누락
=======================================================================================================================</xsl:message>  												
	</xsl:otherwise>
</xsl:choose> 	

	mdata    : org = BOOT_DATA_BASE, len = 0x800 - BOOT_STACK_SIZE      /* FBL:decreas bootloader stack size    */
	/* according to Guide line from Jin-suk Park(2015-02-04 14:26), this will be '0x1000', but this setting will make area violation, so change to '0x800' and this setting also match with EOL XML Setting */
    bootstack: org = BOOT_STACK_BASE, len = BOOT_STACK_SIZE         /* FBL:bootloader stack: RAM upper area */
}


SECTIONS
{

<xsl:choose> 	
	<xsl:when test="//SRS/FBL/MAPPINGS/*/@FBL_Section_Select ='1st_section'"> 	
   .SEG_BOOT_RCHW        ALIGN(4)   :>reset     /* FBL Header */
   .SEG_BOOT_IDENT           0x0008    :>.  
   .SEG_BOOT_CRC             0x0014    :>.  
   .SEG_BOOT_BAIFT           0x0028   :>.  
	</xsl:when> 	
	<xsl:when test="//SRS/FBL/MAPPINGS/*/@FBL_Section_Select ='2nd_section'"> 	
   .SEG_BOOT_RCHW        ALIGN(4)   :>reset     /* FBL Header */
   .SEG_BOOT_IDENT           0x8008    :>.  
   .SEG_BOOT_CRC             0x8014    :>.  
   .SEG_BOOT_BAIFT           0x8028   :>.  
	</xsl:when> 	
	<xsl:otherwise> 	
	<xsl:message  terminate ="yes">
=======================================================================================================================
'Error 		//SRS/FBL/MAPPINGS/*/@FBL_Section_Select   -> 누락
=======================================================================================================================</xsl:message>  												
	</xsl:otherwise>
</xsl:choose> 	
	.SEG_BOOT_TEXT        ALIGN(4)   :>.

   .rodata               ALIGN(4)   :>.         /* FBL Constant */
   .ROMBYTE                         :>.
   .ROMWORD                         :>.
   .ROMLONG                         :>.
   .SEG_ENCRYPTED_INFO              :>.
   .ROM.data     ROM(.data)    ALIGN(16)  :{}>.
   .ROM.sdabase  ROM(.sdabase) ALIGN(16)  :{}>.
   .ROM.sdata    ROM(.sdata)              :{}>.
   .ROMend                                :{}>.


   .TOOLBOX               ALIGN(4) :>.	       /* FBL Code 1 */

   .SEG_BOOT_EXCTAB                :>exctab
	.SEG_BOOT_HAL          ALIGN(4) :>.	
	.vletext               ALIGN(4) :>.         /* FBL Code 2 */

   .data                 ALIGN(16) :>mdata     /* Data Sections */
   .RAM_INIT_BYTE                  :>.
   .RAM_INIT_WORD                  :>.
   .RAM_INIT_LONG                  :>.
   .sdabase              ALIGN(16) :>.
   .sdata                          :>.
   .sbss2                          :>.

__DATA_END = .;
__DATA_RAM = ADDR(.data);

__BSS_START = .;
   .sbss                   CLEAR   :>.
   .bss                    CLEAR   :>.
   .RAM_ZERO_BYTE          CLEAR   :>.
   .RAM_ZERO_WORD          CLEAR   :>.
   .RAM_ZERO_LONG          CLEAR   :>.
__BSS_END = .;

   .bootstack : { *(.SEG_BOOT_STACK) } > bootstack	   /* FBL: map the bootloader stack section */
}


[step630#1B2M2Y8AsgTpgAmY7PhCfg]

[step630~S63_burning.bbl#QkkSo2ZSU8FO/UJ8PGOjbg]
format=motorola
origin=0
len=%BURNLEN%

OPENFILE "%DESTFILE%"
SENDBYTE 1 "%SRCFILE%"
CLOSE

[step710#GX1z5yj0e6//Pb4mSj4wHw]
S710_UTIP_ADDITIONAL_INPUTS=
S710_UTIP_FILENAME=<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_boot_utp.utp
S710_UTIP_HEADERFILE=
S710_UTIP_VERSION=UTIP_V2R2



[step710~<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_boot_utp.utp#V4tA8XkM3kQYvouhJ9QVtA]
init -r=0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@start[../@parameter='FBL']"/>-0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@end[../@parameter='FBL']"/>
load %INFILE%

fill skip -r=0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@start[../@parameter='FBL']"/>-0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@end[../@parameter='FBL']"/> -op=0xFF

SECTION 'TEXT'   -r=0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@start[../@parameter='FBL']"/>-0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@SEC_IDT_end[../@parameter='FBL']"/>
SECTION 'CRC'    -r=0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@SEC_CRC_start[../@parameter='FBL']"/>-0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@SEC_CRC_end[../@parameter='FBL']"/>
SECTION 'TEXT'   -r=0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@SEC_CODE_start[../@parameter='FBL']"/>-0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@end[../@parameter='FBL']"/>


# calculate CRC on -w address with init value -i
CRCSUM CRC16 M -r=TEXT -w=0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@SEC_CRC_start[../@parameter='FBL']"/> -i=0x<xsl:value-of select="//SRS/FBL/MAPPINGS/*/@CRC_init_value[../@parameter='FBL']"/>

save 'S71_<xsl:value-of select="//SRS/MCU/SPEC/@project_name"/>_boot_utp'  MOTO16 -r=TEXT, CRC

exit


[step820#/epr2hBL+GzBtJkAHeGJ0Q]
MPV_OUTPUT=
MPV_VERSION=MPV#90

[step830#5fr6ouPv9ErPCUQkRt+HnQ]

#[step034#QQEA5U4fJ78uS7rtd84Gow]
CHECKIN_MODE=
STMTS_VERSION=
STM_COMPONENTS=

#[step140#2H0Mh9XaBIdKZJrsCzrs0g]
DYNFLAG_NAME=
DYNFLAG_OPTIMIZATION=0
DYNFLAG_TYPE=

#[step300#efeIUJtCTAvRLWI2wiM0ng]
ENCRYPTION_KEY=1234567
SC_SOURCES=

#[step310#3ZtM80I/O4YsS36nJORr8w]
ENCRYPTION_KEY=1234567
SH_SOURCES=


#[step430#1xeZjqhZtTnCeD0y3w0a4A]
XASM_SOURCES=

#[step500#e/hr7Lmol2uv4b1tj/XeBQ]
PRIVATE_TOOL_NAME=
PRIVATE_TOOL_PATH=

#[step560#aPgTuhgKygPSeBKBSgK7Jg]
LIB_ASM_EXCLUDE=
LIB_C_EXCLUDE=
LIB_XGATE_ASM_EXCLUDE=
LIB_XGATE_C_EXCLUDE=

#[step590#1B2M2Y8AsgTpgAmY7PhCfg]

#[step620#qPCQ6z3WDEq74+MezaUqfA]
DECOPT_LNK=

#[step640#1B2M2Y8AsgTpgAmY7PhCfg]

#[step700#Q6u2FkINIhzkn9KSkhpXVg]
S70_CFGOUT=
S70_IDCCFG=

#[step730#WiDAexLjrSreY9Y0rDHEdQ]
S73_CKSCFG=
S73_NOSECFILE=

#[step740#/JaMUraYQ3MmHsGOMCDCPg]
S74_HEADERFILE=

#[step740~#1B2M2Y8AsgTpgAmY7PhCfg]

#[step760#Abwi+shTIjpyKHgnwvWSug]
S76_IDCCFG=

#[step770#//TPE8pturN3fEPD9bzIJw]
S77_IDCCFG=

#[step770~#1B2M2Y8AsgTpgAmY7PhCfg]

#[step800#9THgBryZ5RVf46ekX3MrPA]
RSM_VERSION=RSM_V621

</xsl:template> 
</xsl:stylesheet>