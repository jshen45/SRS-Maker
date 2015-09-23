using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Model
{
    public class mcu
    {
        private string name;
        private string classification;
        private string pflashStartAddress;
        private string pflashEndAddress;
        private string dflashStartAddress;
        private string dflashEndAddress;
        private string ramStartAddress;
        private string ramEndAddress;

        public mcu(string name)
        {
            this.name = name;
            this.classification = "";
            this.pflashStartAddress = "";
            this.pflashEndAddress = "";
            this.dflashStartAddress = "";
            this.dflashEndAddress = "";
            this.ramStartAddress = "";
            this.ramEndAddress = "";
        }

        public mcu(string name, string classification, string pflashStartAddress, string pflashEndAddress, string dflashStartAddress, string dflashEndAddress, string ramStartAddress, string ramEndAddress)
        {
            this.name = name;
            this.classification = classification;
            this.pflashStartAddress = pflashStartAddress;
            this.pflashEndAddress = pflashEndAddress;
            this.dflashStartAddress = dflashStartAddress;
            this.dflashEndAddress = dflashEndAddress;
            this.ramStartAddress = ramStartAddress;
            this.ramEndAddress = ramEndAddress;
        }
        
        public string Name{get; set;} 
        public string Classification{get; set;} 
        public string PflashStartAddress{get; set;} 
        public string PflashEndAddress{get; set;} 
        public string DflashStartAddress{get; set;} 
        public string DflashEndAddress{get; set;} 
        public string RamStartAddress{get; set;} 
        public string RamEndAddress{get; set;} 
        
     }
}
