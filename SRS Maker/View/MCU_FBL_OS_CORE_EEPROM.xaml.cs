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
    public partial class MCU_FBL_OS_CORE_EEPROM : UserControl
    {
        public List<string> mcuname_list
        {
            get
            {
                //return mcu_list.OfType<string>().ToList();
                return mcu_list.
            }
            
        }

        private List<mcuName> mcu_list;
       
        public MCU_FBL_OS_CORE_EEPROM()
        {
            InitializeComponent();

            this.mcu_list = new List<mcuName>();

            mcu_list.Add(new mcuName("MPC5603"));
            mcu_list.Add(new mcuName("MPC5604"));
            mcu_list.Add(new mcuName("MPC5605"));
            mcu_list.Add(new mcuName("MPC5606"));
            mcu_list.Add(new mcuName("MPC5607"));

            DataContext = this;
        }
    }

    public class mcuName
    {
        public string name
        {
            get;
            set;
        }
    }
}
