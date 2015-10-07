using SRS_Maker.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
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
using MahApps.Metro.Controls.Dialogs;

namespace SRS_Maker.View
{
    public partial class MCU_FBL_MEM : UserControl, INotifyPropertyChanged
    {
        public Pins Ports { get; set; }
        public Mcu Mcu { get; set; }
        public ObservableCollection<ExternalE2PRom> externalE2PRomList { get; set; }
        public ObservableCollection<string> BootAddressList { get; set; }
        public ObservableCollection<string> ClockOutput_Divider_List { get; set; }
        
        public MCU_FBL_MEM()
        {
            InitializeBootAddressList();
            Initialize_ClockOutput_Divider_List();
            
            DataContext = this;

            InitializeComponent();
        }

        #region combobox_itemsource
        
        private void InitializeBootAddressList()
        {
            BootAddressList = new ObservableCollection<string>();

            BootAddressList.Add("0x0000~0x8000");
            BootAddressList.Add("0x8000~0xC000");
        }
        
        private void Initialize_ClockOutput_Divider_List()
        {
            ClockOutput_Divider_List = new ObservableCollection<string>();

            ClockOutput_Divider_List.Add("1");
            ClockOutput_Divider_List.Add("2");
            ClockOutput_Divider_List.Add("4");
            ClockOutput_Divider_List.Add("8");
        }

        #endregion

        #region combobox_selected_item

        public string selectedBootAddress { get; set; }

        #endregion

        #region component_callback
        private void SelectedMcuUpdate(object sender, SelectionChangedEventArgs e)
        {
            Mcu.SelectedMcu = (Mcu)ComboBox_McuModel.SelectedItem; ;
            ComboBox_PinPackage.DataContext = Mcu.SelectedMcu;
        }
        #endregion

        private void ComboBox_MCU_DropDownOpened(object sender, EventArgs e)
        {
            if (ComboBox_McuModel.ItemsSource == null)
            {
                ComboBox_McuModel.ItemsSource = Mcu.McuList;
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(name));
            }
        }

        private void RadioBtn_ExternalE2PRom_Checked(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Not supported yet.");

            RadioButton_InternalEEPRom.IsChecked = true;
        }

        private void RadioButton_FblBuildDate_Auto_Checked(object sender, RoutedEventArgs e)
        {
            if (DatePicker_FBL_BuildDate_Manual != null)
            {
                DatePicker_FBL_BuildDate_Manual.IsEnabled = false;
            }
        }

        private void RadioButton_FblBuildDate_Manual_Checked(object sender, RoutedEventArgs e)
        {
            DatePicker_FBL_BuildDate_Manual.IsEnabled = true;
        }

        private void CheckBox_ClockOutput_Checked(object sender, RoutedEventArgs e)
        {
            RadioButton_ClockOutput_FXOSC.IsEnabled = true;
            RadioButton_ClockOutput_FMPLL.IsEnabled = true;
            RadioButton_ClockOutput_FIRC.IsEnabled  = true;
            ComboBox_ClockOutput_Divider.IsEnabled  = true;

            RadioButton_ClockOutput_FXOSC.IsChecked = true;

            ComboBox_ClockOutput_Divider.IsEnabled  =  true;
            ComboBox_ClockOutput_Divider.SelectedIndex = 0;

        }

        private void CheckBox_ClockOutput_Unchecked(object sender, RoutedEventArgs e)
        {
            RadioButton_ClockOutput_FXOSC.IsEnabled = false;
            RadioButton_ClockOutput_FMPLL.IsEnabled = false;
            RadioButton_ClockOutput_FIRC.IsEnabled  = false;
            

            RadioButton_ClockOutput_FXOSC.IsChecked = false;
            RadioButton_ClockOutput_FMPLL.IsChecked = false;
            RadioButton_ClockOutput_FIRC.IsChecked  = false;
            
            ComboBox_ClockOutput_Divider.IsEnabled  = false;
            ComboBox_ClockOutput_Divider.SelectedIndex = -1;
        }

    }
}
