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

namespace SRS_Maker.View
{
    public partial class COM : UserControl
    {
        public Pins PinConfig { get; set; }

        public ObservableCollection<Can> CanConfig { get; set; }

        public ObservableCollection<int> CanPhysicalChannel { get; set; }
        public ObservableCollection<string> CanUsage { get; set; }
        public ObservableCollection<string> CanIC { get; set; }

        public ObservableCollection<string> CanChannelNum { get; set; }
        public ObservableCollection<string> CanClock { get; set; }

        public ObservableCollection<string> AscChannelNum { get; set; }

        public COM()
        {
            DataContext = this;
            
            CanConfig = new ObservableCollection<Can>();

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

            AscChannelNum = new ObservableCollection<string>();
            AscChannelNum.Add("No Use");
            AscChannelNum.Add("1");
            AscChannelNum.Add("2");
            AscChannelNum.Add("3");
            AscChannelNum.Add("4");



            InitializeComponent();

            

        }

        private void SomeSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            
        }

        private void comboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var comboBox = sender as ComboBox;

            if (comboBox.SelectedIndex > CanConfig.Count)
            {
                int LoopNum = comboBox.SelectedIndex - CanConfig.Count;

                for(int i = 0; i < LoopNum; i++)
                {
                    CanConfig.Add(new Can());
                }
            }
            else
            {
                int LoopNum = CanConfig.Count - comboBox.SelectedIndex;

                for (int i = 0; i < LoopNum; i++)
                {
                    CanConfig.RemoveAt(CanConfig.Count-1);
                }
            }
        }
    }

    internal class RowToIndexConv : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            DataGridRow row = value as DataGridRow;
            if (row == null)
                throw new InvalidOperationException("This converter class can only be used with DataGridRow elements.");

            if (row.DataContext.ToString() == "{NewItemPlaceholder}")
            {
                return null;
            }
            else
            {
                int driverNum = row.GetIndex() + 1;
                return driverNum;
            }
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return null;
            
        }
    }

}
