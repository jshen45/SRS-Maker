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

        List<Item> items = new List<Item>();

        public ObservableCollection<Can> CanConfig { get; set; }

        public ObservableCollection<int> CanDriverIndex { get; set; }
        public ObservableCollection<int> CanPhysicalChannel { get; set; }
        public ObservableCollection<string> CanUsage { get; set; }
        public ObservableCollection<string> CanIC { get; set; }

        public COM()
        {
            DataContext = this;
            
            CanConfig = new ObservableCollection<Can>();
            CanConfig.Add(new Can() { Driver = 1 });

            CanDriverIndex = new ObservableCollection<int>();
            CanDriverIndex.Add(1);

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

            InitializeComponent();

        }
        void test(object sender, EventArgs e)
        {
         
        }

        private void TextBlock_Loaded(object sender, RoutedEventArgs e)
        {
            var block = sender as TextBlock;
            var item = block.Tag as Item;
            block.Text = items.IndexOf(item).ToString();
        }
    }

    public class Item
    {
        public string Name { get; set; }
    }
}
