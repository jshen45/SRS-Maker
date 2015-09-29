using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Model
{
    public class Mcu
    {
        public Mcu(string name)
        {
            this.Name = name;
            this.Classification = "";
            this.PinPackage = null;
            this.PflashStartAddress = "";
            this.PflashEndAddress = "";
            this.DflashStartAddress = "";
            this.DflashEndAddress = "";
            this.RamStartAddress = "";
            this.RamEndAddress = "";
        }

        public Mcu(string name, List<string> pinPackage)
        {
            this.Name = name;
            this.Classification = "";
            this.PinPackage = pinPackage;
            this.PflashStartAddress = "";
            this.PflashEndAddress = "";
            this.DflashStartAddress = "";
            this.DflashEndAddress = "";
            this.RamStartAddress = "";
            this.RamEndAddress = "";
        }

        public Mcu(string name, string classification, List<string> pinPackage,  string pflashStartAddress, string pflashEndAddress, string dflashStartAddress, string dflashEndAddress, string ramStartAddress, string ramEndAddress)
        {
            this.Name = name;
            this.Classification = classification;
            this.PinPackage = pinPackage;
            this.PflashStartAddress = pflashStartAddress;
            this.PflashEndAddress = pflashEndAddress;
            this.DflashStartAddress = dflashStartAddress;
            this.DflashEndAddress = dflashEndAddress;
            this.RamStartAddress = ramStartAddress;
            this.RamEndAddress = ramEndAddress;
        }
        
        public string Name { get; set; } 
        public string Classification { get; set; } 
        public List<string> PinPackage { get; set; }
        public string PflashStartAddress { get; set; } 
        public string PflashEndAddress { get; set; } 
        public string DflashStartAddress { get; set; } 
        public string DflashEndAddress { get; set; } 
        public string RamStartAddress { get; set; } 
        public string RamEndAddress { get; set; } 
        
     }
}
