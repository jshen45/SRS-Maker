using SRS_Maker.Model;
using System;
using System.Collections.Generic;
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
    /// <summary>
    /// Interaction logic for IO.xaml
    /// </summary>
    public partial class IO : UserControl
    {
        public List<string> PortList { get; set; }
        public List<Pins> Ports { get; set; }
        public Pins SelectedPort { get; set; }
        
        public IO()
        {
            InitializePortList();

            InitializeComponent();

            DataContext = this;
        }

        private void InitializePortList()
        {
            Ports = new List<Pins>();
            PortList = new List<string>();
            Pins port = new Pins("144 Pin");
            Ports = port.PinList;
            PortList = port.PortNameList;
        }

        private void SelectedItemChanged(object sender, SelectionChangedEventArgs e)
        {
            UsageCombo.DataContext = SelectedPort;
        }
    }
}
