using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Model
{
    public class Mcu
    {
        public ObservableCollection<Mcu> McuList { get; set; }

        public Mcu SelectedMcu { get; set; }

        public string Classification { get; set; }
        public string Name { get; set; }
        public List<string> PinPackage { get; set; }
        public string PflashStartAddress { get; set; }
        public string PflashEndAddress { get; set; }
        public string DflashStartAddress { get; set; }
        public string DflashEndAddress { get; set; }
        public string RamStartAddress { get; set; }
        public string RamEndAddress { get; set; } 
        
        public Mcu()
        {
            McuList = new ObservableCollection<Mcu>();
            SelectedMcu = new Mcu("SelectedMcu");

            McuList.Add(new Mcu("Bolero", "MPC5605", new List<string> { "100 Pin", "144 Pin", "176 Pin" },
                                "0x0000_0000", "0x000B_FFFF",
                                "0x0080_0000", "0x0080_FFFF",
                                "0x4000_0000", "0x4001_3FFF"));
            McuList.Add(new Mcu("Bolero", "MPC5606", new List<string> { "144 Pin", "176 Pin" } ,
                                "0x0000_0000", "0x000F_FFFF",
                                "0x0080_0000", "0x0080_FFFF",
                                "0x4000_0000", "0x4001_3FFF"));
        }
        public Mcu(string selcectedMcu)
        {
        }

        private Mcu(string name, List<string> pinPackage)
        {
            this.Classification = "";
            this.Name = name;
            this.PinPackage = pinPackage;
            this.PflashStartAddress = "";
            this.PflashEndAddress = "";
            this.DflashStartAddress = "";
            this.DflashEndAddress = "";
            this.RamStartAddress = "";
            this.RamEndAddress = "";
        }

        private Mcu(string classification, string name, List<string> pinPackage, string pflashStartAddress, string pflashEndAddress, string dflashStartAddress, string dflashEndAddress, string ramStartAddress, string ramEndAddress)
        {
            this.Classification = classification;
            this.Name = name;
            this.PinPackage = pinPackage;
            this.PflashStartAddress = pflashStartAddress;
            this.PflashEndAddress = pflashEndAddress;
            this.DflashStartAddress = dflashStartAddress;
            this.DflashEndAddress = dflashEndAddress;
            this.RamStartAddress = ramStartAddress;
            this.RamEndAddress = ramEndAddress;
        }
    }
}
