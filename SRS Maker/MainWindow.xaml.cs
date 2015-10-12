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
using MahApps.Metro.Controls;

using SRS_Maker.Model;
using SRS_Maker.View;
using SRS_Maker.Data;

namespace SRS_Maker
{
    public partial class MainWindow : MetroWindow
    {
        private XmlGenerator xmlGenerator { get; set; }

        public Pins PinObj;
        public Mcus McuObj;

        public MainWindow()
        {
            PinObj = new Pins("144 Pin");
            McuObj = new Mcus();
            
            InitializeComponent();

            general_tab.PinConfig = this.PinObj;
            general_tab.McuConfig = this.McuObj;
            
            os_tab.PinConfig = PinObj;

            com2_tab.PinConfig = this.PinObj;
        }

        private void XmlGenerate(object sender, RoutedEventArgs e)
        {
            xmlGenerator = new XmlGenerator(general_tab, os_tab, io_tab, com_tab);
        }
    }
}
