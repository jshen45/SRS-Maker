/* Common declarations */
/* ------------------- */
#include "mcureg.h" 
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
 #include "bslowtimer.h"
 #include "brstmanag.h"
 #include "bswdt.h"
#endif

#if defined(XENON_MEM_USE)
 #include "mem_utility_api.h"
#endif

#if defined(XENON_EEPROM_USE)
 #include "nvm_api.h"
#endif
   
#if defined(XENON_CAN_USE)
 #include "bxstman.h" 
#endif

#if defined(XENON_IO_USE)
 #include "io_process.h"
 #include "biomanag.h"
#endif

#if defined(XENON_DIAG_KWP_USE)
 #include "dpkw2000_s.h"
#endif

#if defined(XENON_EOL_USE)
 #include "breboot.h"
#endif

#if defined(XENON_CCP_USE)
 #include "ccp_api.h"\
#endif

#if defined(XENON_DIAG_UDS_USE)
 #include "Dcm.h" 
#endif

#if defined(XENON_PM_USE)
 #include "bsystime.h"
#endif

#if defined(CPU_LOAD) || defined(IT_LOAD)
 #include "bdebug.h"
#endif

#if defined(INTEGRATE_BATMON)
#include "bibatmon.h"
#endif

#if defined(INTEGRATE_REGMONITOR) 
#include "bswsecur.h"        
#endif

#if defined(INTEGRATE_SRX) 
#include "srxbus_api.h"
#endif

/* Used interfaces */
/* --------------- */
/* for platform internal interfaces */
/* for generated config files */
/* for external interaction */

/* Exported functions */
/* ------------------ */
extern void bsmodechk_SafeMode(void);

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

<SrsMaker:UdsTiming_5ms>

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

<SrsMaker:UdsTiming_10ms>
	
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

<SrsMaker:UdsTiming_20ms>

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

<SrsMaker:UdsTiming_100ms>

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
    beepmana_DataRetentionSurvey(); 
#endif  /* XENON_EEPROM_USE */

#if defined(TASK_MONITORING)
	SWP_TaskMon(Task_SWP_FG1_1s, SWP_TASK_LEAVE);
#endif

    /****end user code******/
    /*OK - No return to call level in standard status.*/
    /*lint --e{534} suppress "Ignoring return value of function 'Symbol'" for complete block*/
    TerminateTask();
}