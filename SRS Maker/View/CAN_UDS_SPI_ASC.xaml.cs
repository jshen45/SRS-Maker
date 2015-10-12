using SRS_Maker.Data;
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
    public partial class CAN_UDS_SPI_ASC : UserControl
    {
        public List<Pin> PinConfig { get; set; }
        public List<string> CanRxPinList { get; set; }

        public CAN_UDS_SPI_ASC()
        {
            DataContext = this;

            InitializeCanRxPinList();

            InitializeComponent();
        }

        private void InitializeCanRxPinList()
        {
            Pins _CanPinList = new Pins("144 Pin");
            CanRxPinList = _CanPinList.Can0RxPinList;
        }
    }
}
