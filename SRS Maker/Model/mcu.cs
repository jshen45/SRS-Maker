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
        
        public string Name
        {
            get{ return name;  }
            set{ name = value; } 
        }
        public string Classification
        {
            get{ return classification;  }
            set{ classification = value; }
        } 
        public string PflashStartAddress
        {
            get{ return pflashStartAddress;  }
            set{ pflashStartAddress = value; }
        } 
        public string PflashEndAddress
        {
            get{ return pflashEndAddress;  }
            set{ pflashEndAddress = value; }
        } 
        public string DflashStartAddress
        {
            get{ return dflashStartAddress;  }
            set{ dflashStartAddress = value; }
        } 
        public string DflashEndAddress
        {
            get{ return dflashEndAddress;  }
            set{ dflashEndAddress = value; }
        } 
        public string RamStartAddress
        {
            get{ return ramStartAddress;  }
            set{ ramStartAddress = value; }
        } 
        public string RamEndAddress
        {
            get{ return ramEndAddress;  }
            set{ ramEndAddress = value; }
        } 
    }
}
