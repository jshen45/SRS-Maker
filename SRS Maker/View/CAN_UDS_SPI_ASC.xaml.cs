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
    /// Interaction logic for CAN_UDS_SPI_ASC.xaml
    /// </summary>
    public partial class CAN_UDS_SPI_ASC : UserControl
    {
        public List<string> CanRxPinList { get; set; }

        public CAN_UDS_SPI_ASC()
        {
            DataContext = this;

            InitializeCanRxPinList();

            InitializeComponent();
        }

        private void InitializeCanRxPinList()
        {
            Pins _CanPinList = new Pins();
            CanRxPinList = _CanPinList.CanRxPinList;
        }

    }
}
