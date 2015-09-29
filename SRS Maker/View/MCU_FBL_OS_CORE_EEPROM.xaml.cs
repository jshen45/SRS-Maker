using SRS_Maker.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
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
    public partial class MCU_FBL_OS_CORE_EEPROM : UserControl
    {
        public ObservableCollection<Mcu> mcuList { get; set; }
        public Mcu selectedMcu { get; set; }

        public ObservableCollection<ExternalE2PRom> externalE2PRomList { get; set; }
        public ExternalE2PRom selectedExternalE2PRom { get; set; }

        public ObservableCollection<string> BootAddressList { get; set; }
        public string selectedBootAddress { get; set; }

        public ObservableCollection<SwpTask> SwpTaskList {get; set;}
        
        public MCU_FBL_OS_CORE_EEPROM()
        {
            InitializeComponent();

            InitializeMcuList();
            InitializeExternalE2PRomList();
            InitializeBootAddressList();

            DataContext = this;
        }

        private void InitializeMcuList()
        {
            mcuList = new ObservableCollection<Mcu>();

            mcuList.Add(new Mcu("MPC5603", new List<string> { "100 Pin", "144 Pin" }));
            mcuList.Add(new Mcu("MPC5604", new List<string> { "100 Pin" }));
            mcuList.Add(new Mcu("MPC5605", new List<string> { "100 Pin" }));
            mcuList.Add(new Mcu("MPC5606", new List<string> { "100 Pin" }));
            mcuList.Add(new Mcu("MPC5607", new List<string> { "100 Pin" }));
        }

        private void InitializeExternalE2PRomList()
        {
            externalE2PRomList = new ObservableCollection<ExternalE2PRom>();

            externalE2PRomList.Add(new ExternalE2PRom() { Name = "EEPROM Chip1", Size = "", Budrate = "", PolPolarityPhase = "" });
            externalE2PRomList.Add(new ExternalE2PRom() { Name = "EEPROM Chip2", Size = "", Budrate = "", PolPolarityPhase = "" });
        }

        private void InitializeBootAddressList()
        {
            BootAddressList = new ObservableCollection<string>();

            BootAddressList.Add("0x0000~0x8000");
            BootAddressList.Add("0x8000~0xC000");
        }

        private void InitializeTaskList()
        {
            SwpTaskList = new ObservableCollection<SwpTask>();

            SwpTaskList.Add(new SwpTask() { Name = "SWP10ms", AlarmCycle = 10, AlarmName = "SWP10msAlarm", AutoStart = false, IsSelected = true, AlarmOffset = 1, Preemptive = false, Priority = 100 });
            SwpTaskList.Add(new SwpTask() { Name = "SWP20ms", AlarmCycle = 15, AlarmName = "SWP20msAlarm", AutoStart = false, IsSelected = true, AlarmOffset = 2, Preemptive = false, Priority = 150 });
            SwpTaskList.Add(new SwpTask() { Name = "SWP100ms", AlarmCycle = 20, AlarmName = "SWP100msAlarm", AutoStart = false, IsSelected = true, AlarmOffset = 3, Preemptive = false, Priority = 101 });
        }

        private void SelectedMcuUpdate(object sender, SelectionChangedEventArgs e)
        {
            PinCombo.DataContext = selectedMcu;
        }
    }
}
