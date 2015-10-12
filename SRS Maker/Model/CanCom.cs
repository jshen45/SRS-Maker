using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Model
{
    public List<int> DriverIndex = new List<int>(new int[] {1, 2, 4 });

    public class CanCom
    {
    	public int Driver { get; set; }
		public int Phy { get; set; }
		public string Usage { get; set; }
		public string IC { get; set; }
		public string Tx { get; set; }
		public string Rx { get; set; }
		public string Control { get; set; }
		public string EN { get; set; }
		public string STN { get; set; }
		public string Err { get; set; }
		public string Buadrate { get; set; }
    }
}
