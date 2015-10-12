using SRS_Maker.Data;
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
        public Pins PinConfig { get; set; }

        public OS_CORE()
        {
            DataContext = this;

            InitializeTaskList();

            InitializeComponent();
        }

        public ObservableCollection<PlatformTask> SwpTaskList { get; set; }
        private void InitializeTaskList()
        {
            PlatformTasks PlatformTasksData = new PlatformTasks();
            SwpTaskList = PlatformTasksData.SwpTaskList;
        }

        private void ComboBox_DropDownOpened(object sender, EventArgs e)
        {
            if (ExternalWatchdogTogglePin.ItemsSource == null)
            {
                ExternalWatchdogTogglePin.ItemsSource = PinConfig.PortNameList;
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
            
            ExternalWatchdogTogglePin.SelectedIndex = -1;
            ExternalWatchdogTogglePin.IsEnabled = false;
        }

    }
}
