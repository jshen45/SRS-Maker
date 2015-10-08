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
* %name:              zinitswp_c_auto.xsl %
* %MCU:              SPC560B %											  	 
* %version:           1.0.4 %
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
 - Init Version																  */
/*  1.0.1    | 28/Jan/2014 |			                   | SW Lee           
 - bcrandom_init() removed
 - add swp_config.h include 												  */
/*  1.0.2    | 09/Jul/2014 |			                   | SW Lee           
 - removed 'Spi_Init' Function. 
 - Integration rule Change according to 'Delivery boxes update(cw28_14_a)     */
//  1.0.3    | 08/Dec/2014 |			                   | SW Lee           
// - add 'SWP_TaskMon' function in case of using 'TASK_MONITORING' into all of 'TASK'
//  1.0.4    | 26/Aug/2015 |			                   | SW Lee           
// - remove 'bibatmon_Init' function in StartupHook, Because it's already called in 'biomanag_Init' function.
 /*----------------------------------------------------------------------------*/
/*============================================================================*/
/* Generated on: <xsl:value-of select="date:new()"/> 						 */
/*===========================================================================*/
/* Common declarations */
/* ------------------- */
#include "typedef.h" 
#include "mcureg.h"
#include "Compiler.h"
#include "zhsysdef.h"

/* MCAL API */
/* -------- */
#include "icu.h"
#include "gpt.h"

/* SW Platform API */
/* --------------- */
#include "Os.h"
#include "os_api.h" 
#include "oscore.h"
#include "bsalarms.h"
#include "zfalarms.h"


#if defined(XENON_IO_USE)
 #include "biomanag.h"           /* IO initialization */
 #include "bidigfil.h"           /* IO initialization */
 #include "biotimer.h"           /* Timer initilization */
 #include "swp_config.h"         /* IO General Define */
#endif  /* XENON_IO_USE */

#if defined(XENON_CORE_USE)
 #include "evtman.h"             /* Event initialization */
 #include "Wdg.h"
 #ifdef  INTEGRATE_RANDOM
	#include "bcrandom.h"           /* bcrandom_init() */
 #endif //INTEGRATE_RANDOM 
#endif  /* XENON_CORE_USE */

#if defined(XENON_EEPROM_USE)
 #include "nvm_api.h"
#endif  /* XENON_EEPROM_USE */

#if defined(XENON_EOL_USE)
 #include "breboot.h"
#endif  /* XENON_EOL_USE */

#if defined(XENON_PM_USE)
	#ifdef INTEGRATE_SYSTEM_TIME
#include "bsystime.h"           /* System Time...     */
	#endif //INTEGRATE_SYSTEM_TIME
	
 #include "swppm.h"
#endif  /* XENON_PM_USE */

#if defined(XENON_CAN_USE)
 #include "bxstman.h"
#endif  /* XENON_CAN_USE */

#if defined(XENON_SPI_USE)
 #include "Spi.h"
#endif  /* XENON_SPI_USE */

#if defined(XENON_DIAG_KWP_USE)
 #include "xsasccom_s.h"         /* diagnostic */
 #include "dpkw2000_s.h"         /* diagnostic */
#endif  /* XENON_DIAG_KWP_USE */

#if defined(XENON_CCP_USE)
 #include "ccp_api.h"
#endif  /* XENON_CCP_USE */

#if defined(XENON_DIAG_UDS_USE)
 #include "Dcm.h"
#endif  /* XENON_DIAG_UDS_USE */




/* Used interfaces */
/* --------------- */
/* for platform internal interfaces */
/* for generated config files */
/* for external interaction */

#if defined(CPU_LOAD) || defined(IT_LOAD)
 #include "bdebug.h"
#endif  /* CPU_LOAD or IT_LOAD */

/* Some header files are used to define memory sections for external declarations and definition of variables. */
    /*lint --e{766} suppress "Include of header file FileName not used in module String" for complete block*/


#include "bswdt.h"              /* Watchdog initialization */
#ifdef INTEGRATE_MEMCHECK
#include "bsmemchk.h"			/* memory check manager*/
#endif //INTEGRATE_MEMCHECK
#ifdef INTEGRATE_BATMON
#include "bibatmon.h"     /* First acquisition of battery monitoring */
#endif //INTEGRATE_BATMON
#include "io_timer.h"           /* ... initialization  */
#include "bopwmout.h"




/* Provide interface */
/* ----------------- */
/* eventually provide config files */

/* Declarations OSEK */
/* ----------------- */

/* Tasks declaration */


/* Private functions macros, constants, types and datas */
/* ---------------------------------------------------- */
/* Functions macros */

/*======================================================*/
/* Definition of ROM constants                          */
/*======================================================*/
/* BYTE constants */
/*#include "bmrodefb.h"*/

/* WORD constants */
/*#include "bmrodefw.h"*/

/* LONG and STRUCTURE constants */
/*#include "bmrodefl.h"*/


/*======================================================*/
/* Definition of RAM variables                          */
/*======================================================*/

/*---------------------------------------*/
/* initialized and cleared RAM (default) */
/*---------------------------------------*/
/* BYTES */
//#include "bmradefb.h"

/* WORDS */
/*#include "bmradefw.h"*/

/* LONGS and STRUCTURES */
/*#include "bmradefl.h"*/

/*---------------------------------------*/
/* non initialized RAM                   */
/*---------------------------------------*/
/* non initialized BYTES */
/*#include "bmranoib.h"*/

/* non initialized WORDS */
/*#include "bmranoiw.h"*/

/* non initialized LONGS and STRUCTURES */
/*#include "bmranoil.h"*/

/*-----------------------------*/
/* controlled RAM              */
/*-----------------------------*/
/* controlled RAM BYTES */
/*#include "bmractlb.h"*/

/* controlled RAM WORDS */
/*#include "bmractlw.h"*/

/* controlled RAM LONGS */
/*#include "bmractll.h"*/

/* controlled RAM STRUCTURES */
/*#include "bmractls.h"*/

/* Instrumentation variables */

/*======================================================*/
/* close variable declaration sections                  */
/*======================================================*/
#include "bmdatend.h"

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
FAR_FCT void zinitapp_1 (void);
FAR_FCT void zinitapp_2 (void);
FAR_FCT void zinitapp_3 (void);

/* Inline functions */
/* ---------------- */

/* Private functions */
/* ----------------- */

/* Exported functions */
/* ------------------ */



extern void systimer_Startup(void);        

#if defined(CPU_LOAD) || defined(IT_LOAD)
extern void dbgtimer_Startup(void);
#endif  /* CPU_LOAD or IT_LOAD */


/**************************************************************
 *  Name                 : StartupHook
 *  TAG                  : TAG_C_6_01_004 Covers_TAG_D_6_01_004
 *  Description          : used for SW initialization with interrupts disabled:
 *                         The software platform initialization (former zinitbsw)
 *                         The application software initialization pre-eeprom initialization
 *                         The EEPROM initialization
 *                         The application software initialization post-eeprom initialization
 *  Parameters           : void
 *  Return               : void
 *  Critical/explanation : 
 **************************************************************/
void StartupHook(void)
{
    /* SW platform initialization (interrupts protected) */

#if defined(XENON_MEMCHK_USE)
    /* Memory RAM &amp; ROM check initialization - part a */
    bsmemchk_CPURegChk();
#endif  /* XENON_MEMCHK_USE */

#if defined(XENON_CORE_USE)
    /* Watchdog initialization */
    Watchdog_Initialization(); 
#endif  /* XENON_CORE_USE */

#if defined(XENON_SPI_USE)
    /* SPI initialization */
    // Spi_Init(NULL_PTR);
	// removed 'Spi_Init' Function. Integration rule Change according to 'Delivery boxes update(cw28_14_a)' (2014-07-08 3:20)
#endif  /* XENON_SPI_USE */

#if defined(XENON_IO_USE)
    /* first sample of digital inputs acquisition and filtering */
    bidigfil_Init1();
  
    /* IO timer configuration and initialization */
    biotimer_ConfigAllTimers();

    /* Initialisation of IO functions first part, start switched battery */
    biomanag_Init();
#endif  /* XENON_IO_USE */

#if defined(XENON_CORE_USE)
    /* Platform events management initialization */
    InitEvent();
#endif  /* XENON_CORE_USE */

#if defined(XENON_PM_USE)
    /* some more calls of SWP here ... */
    /* Power management initialization */
    LowPower_Init();
#endif  /* XENON_PM_USE */

    /* ASW initialization pre-EEPROM initialization (that can be very long) */
    zinitapp_1();

    /* Memory RAM &amp; ROM check initialization - part b */
#if defined(XENON_MEMCHK_USE)
    bsmemchk_SelfTest();
#endif  /* XENON_MEMCHK_USE */


#if defined(CPU_LOAD)
    CPULoad_Start();
#endif  /* CPU_LOAD */

#if defined(IT_LOAD)
    ITLoad_Start();
#endif  /* IT_LOAD */

#if defined(CPU_LOAD) || defined(IT_LOAD)
    Debug_Init();
#endif  /*  CPU_LOAD or IT_LOAD */

#if defined(XENON_IO_USE)   
    /* the second sample of digital inputs acquisition and filtering  */
    biomanag_digin_Sample();
#endif  /* XENON_IO_USE */
  
#if defined(XENON_EEPROM_USE)
    /* Here EEPROM initialization */
    (void) beepmana_Init();
#endif  /* XENON_EEPROM_USE */
  
#if defined(XENON_IO_USE)
    /* the third sample of digital inputs acquisition and filtering  */
    biomanag_digin_Sample();

    //* initialise debounce function for all digital inputs
    //* (fast, slow, matrix, mux, virtual)
    bidigfil_Init2();
#endif  /* XENON_IO_USE */
    
    /* ASW initialization post-EEPROM initialization */
    zinitapp_2();

    /* Memory RAM &amp; ROM check initialization - part c */
#if defined(XENON_MEMCHK_USE)
    bsmemchk_MemInitChk();
#endif  /* XENON_MEMCHK_USE */


#if defined(XENON_CAN_USE)
    /* CAN station manager Init. */
    bxstman_Init();
#endif  /* XENON_CAN_USE */

#if defined(XENON_DIAG_KWP_USE)
    /* DIAG manager Init. */
    xsasccom_Init();
    dpkw2000_Init();
#endif  /* XENON_DIAG_KWP_USE */

#if defined(XENON_CCP_USE)
    MEM_BMemAccess_Initialize();
    CCP_Init();
    CCP_CopyRom();
#endif  /* XENON_CCP_USE */

#if defined(XENON_DIAG_UDS_USE)
    Dcm_Init(DCM_POWERON_RESET);
#endif  /* XENON_DIAG_UDS_USE */

    //* !! NO USER CODE BELOW THIS LIMIT !!
    //* Now, the OSEK OS will run again, initialize the timers and start the scheduling
    //activity. Next user entry point is Task_SWP_Init
    //* Reset the IT Level because OSEK will enable IT soon
    RESET_IT_LEVEL();
}


/**************************************************************
 *  Name                 : Task_SWP_Init
 *  TAG                  : TAG_C_6_01_006 Covers_TAG_D_6_01_006
 *  Description          : Autostart task : It is automatically
 *                         started by the scheduler after start-up.
 *                         Use to initialize SW with interrupts
 *                         enabled as well as OSEK cyclic alarms
 *  Parameters           : none
 *  Return               : none
 *  Critical/explanation : no
 **************************************************************/
TASK(Task_SWP_Init)
{
    // Interrupts are enabled
#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_Init, SWP_TASK_ENTER);
#endif
	    
    // start cyclic HP alarms with offset
    InitializeAlarms((T_InitAlarmTable*) cauw_InitAlarm_HP);
    systimer_Startup();

#if defined(XENON_IO_USE)
    
	#ifdef INTEGRATE_BATMON
	/* First acquisition battery monitoring input */
	bibatmon(); 
	#endif
#endif  /* XENON_IO_USE */

#if defined(XENON_PM_USE)
	#ifdef INTEGRATE_SYSTEM_TIME
	/* system time initialization */
	SystemTime_Increment(CompareTimer_timerRead(TIMER_TS));
	#endif //INTEGRATE_SYSTEM_TIME
#endif  /* XENON_PM_USE */

#if defined(XENON_CORE_USE)
	#ifdef  INTEGRATE_RANDOM
	/* Random init */
	// removed 14.07.04 (14.04.22 Delivery update)
	// bcrandom_init();
	#endif
#endif  /* XENON_CORE_USE */

#if defined(XENON_EOL_USE)
    // EOL initialization
    breboot_Init();
#endif  /* XENON_EOL_USE */

#if defined(XENON_SRX_USE)
    // SRX initialization
    bxsrxbus_Init(SRXBUS_SRX_9600);
#endif  /* XENON_SRX_USE */

    // ASW initialization 3rd part for activate tasks, start alarms,...
    zinitapp_3();

	
#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_Init, SWP_TASK_LEAVE);
#endif
	
    //***end user code*****
    // OK - No return to call level in standard status.
    //*lint --e{534} suppress "Ignoring return value of function 'Symbol'" for complete block
    TerminateTask();
}








</xsl:template> 
</xsl:stylesheet>
