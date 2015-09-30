using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Model
{
    public class SwpTask
    {
        public string Name { get; set; }
        public int Priority { get; set; }
        public bool Preemptive { get; set; }
        public bool AutoStart { get; set; }
        public int? AlarmOffset { get; set; }
        public int? AlarmCycle { get; set; }
    }
}
