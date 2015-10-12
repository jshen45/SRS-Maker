using SRS_Maker.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Data
{
    public class Mcus
    {
        public ObservableCollection<Mcu> McuList { get; set; }

        public Mcu SelectedMcu { get; set; }

        public Mcus()
        {
            McuList = new ObservableCollection<Mcu>();
            McuList.Add(new Mcu("Bolero", "MPC5605", new List<string> { "100 Pin", "144 Pin", "176 Pin" },
                                "0x0000_0000", "0x000B_FFFF",
                                "0x0080_0000", "0x0080_FFFF",
                                "0x4000_0000", "0x4001_3FFF"));
            McuList.Add(new Mcu("Bolero", "MPC5606", new List<string> { "144 Pin", "176 Pin" },
                                "0x0000_0000", "0x000F_FFFF",
                                "0x0080_0000", "0x0080_FFFF",
                                "0x4000_0000", "0x4001_3FFF"));
        }
    }
}
