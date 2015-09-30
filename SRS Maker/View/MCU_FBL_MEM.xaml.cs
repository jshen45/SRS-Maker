using SRS_Maker.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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

namespace SRS_Maker.View
{
    public partial class MCU_FBL_MEM : UserControl
    {
        public MCU_FBL_MEM()
        {
            InitializeMcuList();
            InitializeExternalE2PRomList();
            InitializeBootAddressList();
            
            DataContext = this;

            InitializeComponent();
        }

        #region combobox_itemsource

        public ObservableCollection<Mcu> mcuList { get; set; }
        private void InitializeMcuList()
        {
            mcuList = new ObservableCollection<Mcu>();

            mcuList.Add(new Mcu("MPC5603", new List<string> { "100 Pin", "144 Pin" }));
            mcuList.Add(new Mcu("MPC5604", new List<string> { "100 Pin" }));
            mcuList.Add(new Mcu("MPC5605", new List<string> { "100 Pin" }));
            mcuList.Add(new Mcu("MPC5606", new List<string> { "100 Pin" }));
            mcuList.Add(new Mcu("MPC5607", new List<string> { "100 Pin" }));
        }

        public ObservableCollection<ExternalE2PRom> externalE2PRomList { get; set; }
        private void InitializeExternalE2PRomList()
        {
            externalE2PRomList = new ObservableCollection<ExternalE2PRom>();

            externalE2PRomList.Add(new ExternalE2PRom() { Name = "NOT Ready", Size = "", Budrate = "", PolPolarityPhase = "" });
        }

        public ObservableCollection<string> BootAddressList { get; set; }
        private void InitializeBootAddressList()
        {
            BootAddressList = new ObservableCollection<string>();

            BootAddressList.Add("0x0000~0x8000");
            BootAddressList.Add("0x8000~0xC000");
        }
      
        
        
        #endregion

        #region combobox_selected_item

        public Mcu selectedMcu { get; set; }
        public ExternalE2PRom selectedExternalE2PRom { get; set; }
        public string selectedBootAddress { get; set; }

        #endregion

        #region component_callback
        private void SelectedMcuUpdate(object sender, SelectionChangedEventArgs e)
        {
            PinCombo.DataContext = selectedMcu;
        }
        #endregion
    }
}
