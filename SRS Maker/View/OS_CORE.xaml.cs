using SRS_Maker.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace SRS_Maker.View
{
    public partial class OS_CORE : UserControl
    {
        public Pins Ports { get; set; }
        public OS_CORE()
        {
            InitializeTaskList();

            DataContext = this;
            
            InitializeComponent();
        }

        public ObservableCollection<SwpTask> SwpTaskList { get; set; }
        private void InitializeTaskList()
        {
            SwpTaskList = new ObservableCollection<SwpTask>();

            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_Init", Priority = 250, Preemptive = false, AutoStart = true });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_System_Idle", Priority = 1, Preemptive = true, AutoStart = true });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_FG1_EventManager", Priority = 180, Preemptive = true, AutoStart = true });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_FG1_biomanag", Priority = 195, Preemptive = true, AutoStart = false });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_FG2_biomanag", Priority = 230, Preemptive = true, AutoStart = false });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_FG1_Watchdog_Mngr", Priority = 165, Preemptive = true, AutoStart = false });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_FG2_LPM", Priority = 255, Preemptive = true, AutoStart = false });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_FG1_5ms", Priority = 199, Preemptive = true, AutoStart = false, AlarmOffset = 1, AlarmCycle = 2 });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_FG1_10ms", Priority = 190, Preemptive = true, AutoStart = false, AlarmOffset = 2, AlarmCycle = 4 });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_FG1_20ms", Priority = 170, Preemptive = true, AutoStart = false, AlarmOffset = 4, AlarmCycle = 8 });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_FG1_100ms", Priority = 120, Preemptive = true, AutoStart = false, AlarmOffset = 8, AlarmCycle = 40 });
            SwpTaskList.Add(new SwpTask() { Name = "Task_SWP_FG1_1s", Priority = 107, Preemptive = true, AutoStart = false, AlarmOffset = 40, AlarmCycle = 400 });
        }

        private void ComboBox_DropDownOpened(object sender, EventArgs e)
        {
            if (ExternalWatchdogTogglePin.ItemsSource == null)
            {
                ExternalWatchdogTogglePin.ItemsSource = Ports.PortNameList;
            }
        }

        private void CheckBox_InternalWatchDog_Checked(object sender, RoutedEventArgs e)
        {
            TextBox_InternalWatchDogTimeOut.IsEnabled = true;
        }

        private void CheckBox_InternalWatchDog_Unchecked(object sender, RoutedEventArgs e)
        {
            TextBox_InternalWatchDogTimeOut.IsEnabled = false;
        }

        private void CheckBox_ExternalWatchDog_Checked(object sender, RoutedEventArgs e)
        {
            TextBox_ExternalWatchDogTimeOut.IsEnabled = true;
            ExternalWatchdogTogglePin.IsEnabled = true;
        }

        private void CheckBox_ExternalWatchDog_Unchecked(object sender, RoutedEventArgs e)
        {
            TextBox_ExternalWatchDogTimeOut.Text = "";
            TextBox_ExternalWatchDogTimeOut.IsEnabled = false;

            ExternalWatchdogTogglePin.IsEnabled = false;
            ExternalWatchdogTogglePin.SelectedIndex = -1;
        }

    }
}
