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
    public partial class COM : UserControl
    {
        public Pins PinConfig { get; set; }

        public ObservableCollection<Can> CanConfig { get; set; }

        public ObservableCollection<int> DriverIndex { get; set; }

        

        public COM()
        {
            DataContext = this;
            DriverIndex = new ObservableCollection<int>();

            

            

            DriverIndex.Add(1);
            DriverIndex.Add(2);
            DriverIndex.Add(3);
            DriverIndex.Add(4);
            DriverIndex.Add(5);

            InitializeTaskList();

            InitializeComponent();

            //DataGridComboBoxColumn_Driver.ItemsSource = DriverIndex;
            }

        private void InitializeTaskList()
        {
            CanConfig = new ObservableCollection<Can>();
            CanConfig.Add(new Can() { Driver = 1});
            
        }

        private void DataGrid_CAN_BeginningEdit(object sender, DataGridBeginningEditEventArgs e)
        {
            int i;
            i = 1;
        }
    }
}
