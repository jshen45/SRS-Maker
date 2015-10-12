using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace SRS_Maker.Model
{
    public class Pin
    {
        public string Name { get; set; }
        public List<int?> PinNumber { get; set; }
        public List<string> PossibleUsage { get; set; }
        public string SelectedUsage { get; set; }
        public List<EmiosTimer> PossibleEmiosTimer { get; set; }
        public EmiosTimer SelectedEmiosTimer { get; set; }
        public string Note { get; set; }
    }
}
