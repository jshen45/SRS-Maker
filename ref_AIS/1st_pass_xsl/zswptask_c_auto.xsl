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
* %name:              zswptask_c_auto.xsl %
* %version:           1.0.4 %
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
/*  1.0.0    | 28/jan/2014 |                               | SW Lee           
  - init version															  */
/*  1.0.1    | 21/Oct/2014 |                               | SW Lee           
  - add "brstmanag.h", "bswdt.h" file.											  */  
//  1.0.2    | 08/Dec/2014 |			                   | SW Lee           
// - add 'SWP_TaskMon' function in case of using 'TASK_MONITORING' into all of 'TASK'  
// - change 'LPTask_IO_MANAGE_LP' as a comment
//  1.0.3    | 01/Jun/2015 |			                   | SW Lee           
// - add function call "bsmodechk_SafeMode();" when use upper version of "b_pf_os_st_spc560xb-3.3"
//  1.0.4    | 02/Jun/2015 |			                   | SW Lee           
// - add definition "extern void bsmodechk_SafeMode(void);" (Error fix)
/*----------------------------------------------------------------------------*/
/*============================================================================*/
/* Common declarations */
/* ------------------- */
#include "mcureg.h" /* only authorized in HAL module */
#include "typedef.h" 
#include "zhsysdef.h" 

/* SW platform API */
/* --------------- */
#include "Os.h"
#include "os_api.h" 
#include "oscore.h"

#if defined(XENON_CORE_USE)
 #include "core_services_api.h"
 #include "math_utility_api.h"
 #include "bslowtimer.h"      /* Slow timer interfaces */
 #include "brstmanag.h"
 #include "bswdt.h"
#endif  /* XENON_CORE_USE */

#if defined(XENON_MEM_USE)
 #include "mem_utility_api.h"
#endif  /* XENON_MEM_USE */

#if defined(XENON_EEPROM_USE)
 #include "nvm_api.h"
#endif  /* XENON_EEPROM_USE */
   
#if defined(XENON_CAN_USE)
 #include "bxstman.h"         /* bxstman_CyclicTask()  */
#endif  /* XENON_CAN_USE */

#if defined(XENON_IO_USE)
 #include "io_process.h"
 #include "biomanag.h"
#endif  /* XENON_IO_USE */

#if defined(XENON_DIAG_KWP_USE)
 #include "dpkw2000_s.h"      /* diagnostic */
#endif  /* XENON_DIAG_KWP_USE */

#if defined(XENON_EOL_USE)
 #include "breboot.h"
#endif  /* XENON_EOL_USE */

#if defined(XENON_CCP_USE)
 #include "ccp_api.h"         /* calibration: CCP */
#endif  /* XENON_CCP_USE */

#if defined(XENON_DIAG_UDS_USE)
 #include "Dcm.h"             /* diagnostic: UDS */
#endif  /* XENON_DIAG_UDS_USE */

#if defined(XENON_PM_USE)
 #include "bsystime.h"
#endif  /* XENON_PM_USE */

#if defined(CPU_LOAD) || defined(IT_LOAD)
 #include "bdebug.h"
#endif  /* CPU_LOAD or IT_LOAD */

/* Used interfaces */
/* --------------- */
/* for platform internal interfaces */
/* for generated config files */
/* for external interaction */

#ifdef INTEGRATE_BATMON
#include "bibatmon.h"
#endif //INTEGRATE_BATMON
#ifdef INTEGRATE_REGMONITOR
#include "bswsecur.h"        
#endif //INTEGRATE_REGMONITOR
#ifdef INTEGRATE_SRX
#include "srxbus_api.h"
#endif //INTEGRATE_SRX
#include "bswdt.h"           /* Watchdog interfaces */

/* Private defines */

/* Private functions prototypes */
/* ---------------------------- */

/* Exported functions macros, constants, types and datas */
/* ----------------------------------------------------- */
/* Functions macros */

/* Constants definition */
/* BYTE constants */

/* WORD constants */

/* Variables definition */
/* BYTE variables */

/* WORD variables */

/* Instrumentation variables */

/* Exported functions prototypes */
/* ----------------------------- */
/* Inline functions */
/* ---------------- */

/* Private functions */
/* ----------------- */


/* Exported functions */
/* ------------------ */
extern void bsmodechk_SafeMode(void);
//#include "dio.h"


/**************************************************************
 *  Name                 : Task_SWP_FG1_5ms
 *  TAG                  : TAG_C_6_03_026 Covers_TAG_D_6_03_001
 *  Description          : 
 *  Parameters           : none
 *  Return               : none
 *  Critical/explanation : no
 **************************************************************/
TASK(Task_SWP_FG1_5ms)
{
      /****start user code******/
#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_5ms, SWP_TASK_ENTER);
#endif
	  
#if defined(XENON_IO_USE)
    /* 5 ms IO function */
    biomanag_IO_5ms();
#endif  /* XENON_IO_USE */


#if defined(XENON_DIAG_KWP_USE)
    /* diag protocol */
    dpkw2000_Manager();
#endif  /* XENON_DIAG_KWP_USE */

#if defined(XENON_EEPROM_USE)
    /* Cyclic update task of EEPROM manager */
    //    (void) beepmana_Save();  // move to 20ms task 13.06.03
#endif  /* XENON_EEPROM_USE */

<xsl:if test = "//SRS/CORE/UDS/@Usage ='Yes'">
<xsl:if test = "//SRS/CORE/UDS/@Task_Timing ='5'">
#if defined(XENON_DIAG_UDS_USE)
	/* UDS */
	Dcm_Cyclic_Task();
#endif  /* XENON_DIAG_UDS_USE */
</xsl:if>
</xsl:if>


#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_5ms, SWP_TASK_LEAVE);
#endif

     /****end user code******/
    /*OK - No return to call level in standard status.*/
    /*lint --e{534} suppress "Ignoring return value of function 'Symbol'" for complete block*/
    TerminateTask(); 
}


/**************************************************************
 *  Name                 : Task_SWP_FG1_10ms
 *  TAG                  : TAG_C_6_03_025 Covers_TAG_D_6_03_001
 *  Description          : 
 *  Parameters           : none
 *  Return               : none
 *  Critical/explanation : no
 **************************************************************/
TASK(Task_SWP_FG1_10ms)
{
   
   /****start user code******/
#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_10ms, SWP_TASK_ENTER);
#endif

#if defined(XENON_CORE_USE)
    SlowTimer_Processing(cau_slow_timsrv_10ms_event, raub_slow_timsrv_10ms_counter, cub_nb_slow_timsrv_10ms);
#endif  /* XENON_CORE_USE */


#if defined(XENON_CORE_USE)
		/* Trigger the watchdog timer */
		Watchdog_Trigger();
#endif  /* XENON_CORE_USE */



#if defined(XENON_IO_USE)
    biomanag_IO_10ms();
#endif  /* XENON_IO_USE */

#if defined(XENON_SRX_USE)
    /* SRX bus cyclic task */
    bxsrxbus_Task();
#endif  /* XENON_SRX_USE */

#if defined(XENON_CAN_USE)
    /* CAN Station Management */
    bxstman_CyclicTask();
#endif  /* XENON_CAN_USE */

#if defined(XENON_CCP_USE)
    CCP_Command_Task();
    CCP_DAQ_Task();
    MEM_BMemAccess_Periodic();
#endif  /* XENON_CCP_USE */


<xsl:if test = "//SRS/CORE/UDS/@Usage ='Yes'">
<xsl:if test = "//SRS/CORE/UDS/@Task_Timing ='10'">
#if defined(XENON_DIAG_UDS_USE)
	/* UDS */
	Dcm_Cyclic_Task();
#endif  /* XENON_DIAG_UDS_USE */
</xsl:if>
</xsl:if>
	
#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_10ms, SWP_TASK_LEAVE);
#endif
	
     /****end user code******/
    /*OK - No return to call level in standard status.*/
    /*lint --e{534} suppress "Ignoring return value of function 'Symbol'" for complete block*/
    TerminateTask();
}


/**************************************************************
 *  Name                 : Task_SWP_FG1_20ms
 *  TAG                  : TAG_C_6_03_024 Covers_TAG_D_6_03_001
 *  Description          : 
 *  Parameters           : none
 *  Return               : none
 *  Critical/explanation : no
 **************************************************************/
TASK(Task_SWP_FG1_20ms)
{
    /****start user code******/
#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_20ms, SWP_TASK_ENTER);
#endif
	
#if defined(XENON_EEPROM_USE)
	(void)beepmana_Save();
    (void)beepmana_SuspendMng();
#endif  /* XENON_EEPROM_USE */

#if defined(XENON_EOL_USE)
    /* EOL Activation */
    breboot_Periodic();
#endif  /* XENON_EOL_USE */

#if defined(XENON_CCP_USE)
    CCP_GetCheckSum();
    CCP_FlashSaving();
#endif  /* XENON_CCP_USE */

<xsl:if test = "//SRS/CORE/UDS/@Usage ='Yes'">
<xsl:if test = "//SRS/CORE/UDS/@Task_Timing ='20'">
#if defined(XENON_DIAG_UDS_USE)
	/* UDS */
	Dcm_Cyclic_Task();
#endif  /* XENON_DIAG_UDS_USE */
</xsl:if>
</xsl:if>

#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_20ms, SWP_TASK_LEAVE);
#endif

    /****end user code******/
    /*OK - No return to call level in standard status.*/
    /*lint --e{534} suppress "Ignoring return value of function 'Symbol'" for complete block*/
    TerminateTask();
}


/**************************************************************
 *  Name                 : Task_SWP_FG1_100ms
 *  TAG                  : TAG_C_6_03_023 Covers_TAG_D_6_03_001
 *  Description          : 
 *  Parameters           : none
 *  Return               : none
 *  Critical/explanation : no
 **************************************************************/
TASK(Task_SWP_FG1_100ms)
{
    /****start user code******/
#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_100ms, SWP_TASK_ENTER);
#endif

	bsmodechk_SafeMode(); // Need to use upper version of "b_pf_os_st_spc560xb-3.3"
	
#if defined(XENON_CORE_USE)
    SlowTimer_Processing(cau_slow_timsrv_100ms_event, raub_slow_timsrv_100ms_counter, cub_nb_slow_timsrv_100ms);
#endif  /* XENON_CORE_USE */


#if defined(XENON_MEM_USE)
    /* Controlled RAM check */
    bsramctl_security();
#endif  /* XENON_MEM_USE */

<xsl:if test = "//SRS/CORE/UDS/@Usage ='Yes'">
<xsl:if test = "//SRS/CORE/UDS/@Task_Timing ='100'">
#if defined(XENON_DIAG_UDS_USE)
	/* UDS */
	Dcm_Cyclic_Task();
#endif  /* XENON_DIAG_UDS_USE */
</xsl:if>
</xsl:if>

#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_100ms, SWP_TASK_LEAVE);
#endif

    /****end user code******/
    /*OK - No return to call level in standard status.*/
    /*lint --e{534} suppress "Ignoring return value of function 'Symbol'" for complete block*/
    TerminateTask();
}


/**************************************************************
 *  Name                 : Task_SWP_FG1_1s
 *  TAG                  : TAG_C_6_03_022 Covers_TAG_D_6_03_001
 *  Description          : 
 *  Parameters           : none
 *  Return               : none
 *  Critical/explanation : no
 **************************************************************/
TASK(Task_SWP_FG1_1s)
{
    /****start user code******/
#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_1s, SWP_TASK_ENTER);
#endif

	
#ifdef 	INTEGRATE_REGMONITOR
	RegMonitoring();    
#endif

	
#if defined(XENON_CORE_USE)
    WarmResetCounter_Clear();

    SlowTimer_Processing(cau_slow_timsrv_1s_event, raub_slow_timsrv_1s_counter, cub_nb_slow_timsrv_1s);
#endif  /* XENON_CORE_USE */

#if defined(XENON_EEPROM_USE)
    /* EEPROM manager data retention survey */
    (void) beepmana_DataRetentionSurvey(); 
#endif  /* XENON_EEPROM_USE */
 
    //RegMonitoring();

#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_1s, SWP_TASK_LEAVE);
#endif

    /****end user code******/
    /*OK - No return to call level in standard status.*/
    /*lint --e{534} suppress "Ignoring return value of function 'Symbol'" for complete block*/
    TerminateTask();
}





/**********************************************************************************
Background level 
***********************************************************************************/

/**********************************************************************************
Low Power level 
***********************************************************************************/
<xsl:if test = "//SRS/PM/@IO_managed_by_SWP ='Yes'">
/* This function is not used in SPC560 BOLERO PROJECT
FAR_FCT void LPTask_IO_MANAGE_LP(void)
{
	biomanag_IO_Inputs_LP();
	biomanag_IO_Outputs_LP();
}
*/
</xsl:if>

</xsl:template> 
</xsl:stylesheet>