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
using MahApps.Metro.Controls;
using MahApps.Metro.Controls.Dialogs;

using SRS_Maker.Data;

namespace SRS_Maker.View
{
    public partial class MCU_FBL_MEM : UserControl, INotifyPropertyChanged
    {
        public Pins PinConfig { get; set; }
        public Mcus McuConfig { get; set; }
        public ObservableCollection<ExternalEeprom> externalE2PRomList { get; set; }
        public ObservableCollection<string> BootAddressList { get; set; }
        public string selectedBootAddress { get; set; }
        public ObservableCollection<int> ClockOutput_Divider_List { get; set; }
        
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
            ClockOutput_Divider_List = new ObservableCollection<int>();

            ClockOutput_Divider_List.Add(1);
            ClockOutput_Divider_List.Add(2);
            ClockOutput_Divider_List.Add(4);
            ClockOutput_Divider_List.Add(8);
        }

        #endregion

        #region combobox_selected_item

        

        #endregion


        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(name));
            }
        }

        private async void RadioBtn_ExternalE2PRom_Checked(object sender, RoutedEventArgs e)
        {


            // This demo runs on .Net 4.0, but we're using the Microsoft.Bcl.Async package so we have async/await support
            // The package is only used by the demo and not a dependency of the library!
            var mySettings = new MetroDialogSettings()
            {
                AffirmativeButtonText = "OK",
            };
            
            MessageDialogResult result = await DialogManager.ShowMessageAsync((MetroWindow)Window.GetWindow(this), "External EEPROM setting!", "Not supported yet in SRS Maker.\nSRS Marker에서 아직 정식지원되지 않는 기능입니다.", MessageDialogStyle.AffirmativeAndNegativeAndSingleAuxiliary, mySettings);

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
