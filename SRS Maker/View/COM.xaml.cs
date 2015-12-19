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
using System.Globalization;
using System.ComponentModel;
using MahApps.Metro.Controls.Dialogs;
using MahApps.Metro.Controls;

namespace SRS_Maker.View
{
    public partial class COM : UserControl
    {
        public Pins PinConfig { get; set; }

        public ObservableCollection<Can> CanConfig { get; set; }
        public ObservableCollection<string> CanChannelNum { get; set; }
        public ObservableCollection<string> CanClock { get; set; }
        public ObservableCollection<int> CanPhysicalChannel { get; set; }
        public ObservableCollection<string> CanUsage { get; set; }
        public ObservableCollection<string> CanIC { get; set; }
        public ObservableCollection<string> CanControllType { get; set; }
        public ObservableCollection<string> CanNmType { get; set; }
        public ObservableCollection<string> CanRate { get; set; }
        public ObservableCollection<int> CanNBT { get; set; }
        public ObservableCollection<int> CanSP { get; set; }
        public ObservableCollection<int> CanSJW { get; set; }
                
        public ObservableCollection<Asc> AscConfig { get; set; }
        public ObservableCollection<string> AscChannelNum { get; set; }
        public ObservableCollection<string> AscPhyChannel { get; set; }
        public ObservableCollection<string> AscUsage { get; set; }
        public ObservableCollection<string> AscLinRate { get; set; }

        public COM()
        {
            DataContext = this;

            CanConfig = new ObservableCollection<Can>();

            CanChannelNum = new ObservableCollection<string>();
            CanChannelNum.Add("NO USE");
            CanChannelNum.Add("1");
            CanChannelNum.Add("2");
            CanChannelNum.Add("3");
            CanChannelNum.Add("4");
            CanChannelNum.Add("5");

            CanClock = new ObservableCollection<string>();
            CanClock.Add("Oscilator");
            CanClock.Add("Periperal");

            CanPhysicalChannel = new ObservableCollection<int>();
            CanPhysicalChannel.Add(1);
            CanPhysicalChannel.Add(2);
            CanPhysicalChannel.Add(3);
            CanPhysicalChannel.Add(4);
            CanPhysicalChannel.Add(5);

            CanUsage = new ObservableCollection<string>();
            CanUsage.Add("BCAN");
            CanUsage.Add("CCAN");
            CanUsage.Add("DCAN");
            CanUsage.Add("MCAN");

            CanIC = new ObservableCollection<string>();
            CanIC.Add("TJA1040");
            CanIC.Add("TJA1043");
            CanIC.Add("TJA1051");
            CanIC.Add("TJA1055");
            CanIC.Add("TLE6250");
            CanIC.Add("TLE6254");

            CanControllType = new ObservableCollection<string>();
            CanControllType.Add("1Pin Auto");
            CanControllType.Add("2Pin Auto");
            CanControllType.Add("Manual");

            CanNmType = new ObservableCollection<string>();
            CanNmType.Add("NM OSEK");
            CanNmType.Add("NM BASIC");

            CanRate = new ObservableCollection<string>();
            CanRate.Add("100K");
            CanRate.Add("125K");
            CanRate.Add("500K");

            CanNBT = new ObservableCollection<int>();
            CanNBT.Add(10);
            CanNBT.Add(11);
            CanNBT.Add(12);
            CanNBT.Add(13);
            CanNBT.Add(14);
            CanNBT.Add(15);
            CanNBT.Add(16);
            CanNBT.Add(17);
            CanNBT.Add(18);
            CanNBT.Add(19);
            CanNBT.Add(20);
            CanNBT.Add(21);
            CanNBT.Add(22);
            CanNBT.Add(23);
            CanNBT.Add(24);

            CanSP = new ObservableCollection<int>();
            CanSP.Add(75);
            CanSP.Add(76);
            CanSP.Add(77);
            CanSP.Add(78);
            CanSP.Add(79);
            CanSP.Add(80);
            CanSP.Add(81);
            CanSP.Add(82);

            CanSJW = new ObservableCollection<int>();
            CanSJW.Add(2);
            CanSJW.Add(3);

            AscConfig = new ObservableCollection<Asc>();

            AscChannelNum = new ObservableCollection<string>();
            AscChannelNum.Add("NO USE");
            AscChannelNum.Add("1");
            AscChannelNum.Add("2");
            AscChannelNum.Add("3");
            AscChannelNum.Add("4");

            AscPhyChannel = new ObservableCollection<string>();
            AscPhyChannel.Add("1");
            AscPhyChannel.Add("2");
            AscPhyChannel.Add("3");
            AscPhyChannel.Add("4");

            AscUsage = new ObservableCollection<string>();
            AscUsage.Add("User");
            AscUsage.Add("LIN");

            AscLinRate = new ObservableCollection<string>();
            AscLinRate.Add("9600");
            AscLinRate.Add("19200");
            AscLinRate.Add("38400");
            AscLinRate.Add("57600");
            AscLinRate.Add("115200");

            InitializeComponent();
        }

        private void SomeSelectionChanged(object sender, DataGridCellEditEndingEventArgs e)
        {
            
        }

        private void comboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var comboBox = sender as ComboBox;

            if (comboBox.SelectedIndex > CanConfig.Count)
            {
                int LoopCount = comboBox.SelectedIndex - CanConfig.Count;
                for (int i = 0; i < LoopCount; i++)
                {
                    CanConfig.Add(new Can());
                }
            }
            else
            {
                int LoopCount = CanConfig.Count - comboBox.SelectedIndex;
                for (int i = 0; i < LoopCount; i++)
                {
                    CanConfig.RemoveAt(CanConfig.Count-1);
                }
            }
        }

        private void comboBox_Asc_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var comboBox = sender as ComboBox;
            
            if (comboBox.SelectedIndex > AscConfig.Count)
            {
                int LoopCount = comboBox.SelectedIndex - AscConfig.Count;
                for (int i = 0; i < LoopCount; i++)
                {
                    AscConfig.Add(new Asc());
                }
            }
            else
            {
                int LoopCount = AscConfig.Count - comboBox.SelectedIndex;
                for (int i = 0; i < LoopCount; i++)
                {
                    AscConfig.RemoveAt(AscConfig.Count - 1);
                }
            }
        }

        private async void DataGridComboBoxColumn_NewUsage_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ComboBox ComboboxObj = sender as ComboBox;
            Can TargetCanObj = ComboboxObj.DataContext as Can;
            
            foreach (var Obj in this.CanConfig.Select((x, i) => new { Value = x, Index = i }))
            {
                Can RefCanObj = Obj.Value as Can;
                int RefCanObjIndex = Obj.Index;
                
                if (RefCanObjIndex != (TargetCanObj.Driver - 1) && RefCanObj.Usage == TargetCanObj.Usage && TargetCanObj.Usage != null)
                {
                    MessageDialogResult result = await DialogManager.ShowMessageAsync((MetroWindow)Window.GetWindow(this), "External EEPROM setting!", "Not supported yet in SRS Maker.\nSRS Marker에서 아직 정식지원되지 않는 기능입니다.");
                    ComboboxObj.SelectedValue = null;
                    break;
                }
            }
        }

        private async void DataGridComboBoxColumn_Phy_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ComboBox ComboboxObj = sender as ComboBox;
            Can TargetCanObj = ComboboxObj.DataContext as Can;
            
            foreach (var Obj in this.CanConfig.Select((x, i) => new { Value = x, Index = i }))
            {
                Can RefCanObj = Obj.Value as Can;
                int RefCanObjIndex = Obj.Index;
                
                if (RefCanObjIndex != (TargetCanObj.Driver - 1) && RefCanObj.Phy == TargetCanObj.Phy && TargetCanObj.Phy != null)
                {
                    MessageDialogResult result = await DialogManager.ShowMessageAsync((MetroWindow)Window.GetWindow(this), "External EEPROM setting!", "Not supported yet in SRS Maker.\nSRS Marker에서 아직 정식지원되지 않는 기능입니다.");
                    ComboboxObj.SelectedValue = null;
                    break;
                }
            }
        }
    }

    internal class RowToIndexConv : IMultiValueConverter
    {
        public object Convert(object[] value, Type targetType, object parameter, CultureInfo culture)
        {
            DataGridRow row = value[0] as DataGridRow;
            ObservableCollection<Can>  Canconfigs = value[1] as ObservableCollection<Can>;
            Canconfigs[row.GetIndex()].Driver = row.GetIndex() + 1;
            return Canconfigs[row.GetIndex()].Driver.ToString();
        }

        public object[] ConvertBack(object value, Type[] targetType, object parameter, CultureInfo culture)
        {
            return null;
        }
    }

    internal class TestConverter : IMultiValueConverter
    {
        public ObservableCollection<string> CanUsage { get; set; }

        public ObservableCollection<string> CanUsage2 { get; set; }

        public TestConverter()
        {
            CanUsage = new ObservableCollection<string>();
            CanUsage.Add("BCAN");
            CanUsage.Add("CCAN");
            CanUsage.Add("DCAN");
            CanUsage.Add("MCAN");
            CanUsage.Add("UCAN");

            CanUsage2 = new ObservableCollection<string>();
            CanUsage2.Add("BCAN");
            CanUsage2.Add("CCAN");
            CanUsage2.Add("DCAN");
            
        }

        public object Convert(object[] value, Type targetType, object parameter, CultureInfo culture)
        {
            DataGridRow row = value[0] as DataGridRow;

            if (row.GetIndex() == 1)
                return CanUsage2;

            return CanUsage;

        }

        public object[] ConvertBack(object value, Type[] targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
