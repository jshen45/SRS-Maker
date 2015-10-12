using SRS_Maker.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Data
{
    
    class PlatformTasks
    {
        private ObservableCollection<PlatformTask> _SwpTaskList { get; set; }
        public ObservableCollection<PlatformTask> SwpTaskList
        {
            get
            {
                return _SwpTaskList;
            }
            set
            {
                _SwpTaskList = value;
            }
        }

        public PlatformTasks()
        {
            _SwpTaskList = new ObservableCollection<PlatformTask>();

            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_Init", Priority = 250, Preemptive = false, AutoStart = true });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_System_Idle", Priority = 1, Preemptive = true, AutoStart = true });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_FG1_EventManager", Priority = 180, Preemptive = true, AutoStart = true });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_FG1_biomanag", Priority = 195, Preemptive = true, AutoStart = false });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_FG2_biomanag", Priority = 230, Preemptive = true, AutoStart = false });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_FG1_Watchdog_Mngr", Priority = 165, Preemptive = true, AutoStart = false });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_FG2_LPM", Priority = 255, Preemptive = true, AutoStart = false });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_FG1_5ms", Priority = 199, Preemptive = true, AutoStart = false, AlarmOffset = 1, AlarmCycle = 2 });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_FG1_10ms", Priority = 190, Preemptive = true, AutoStart = false, AlarmOffset = 2, AlarmCycle = 4 });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_FG1_20ms", Priority = 170, Preemptive = true, AutoStart = false, AlarmOffset = 4, AlarmCycle = 8 });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_FG1_100ms", Priority = 120, Preemptive = true, AutoStart = false, AlarmOffset = 8, AlarmCycle = 40 });
            _SwpTaskList.Add(new PlatformTask() { Name = "Task_SWP_FG1_1s", Priority = 107, Preemptive = true, AutoStart = false, AlarmOffset = 40, AlarmCycle = 400 });
        }
    }
}
